#https://stackoverflow.com/questions/39838489/converting-lua-table-to-a-python-dictionary
#https://github.com/SirAnthony/slpp
#pip install git+https://github.com/SirAnthony/slpp
from slpp import slpp as lua
import os
import concurrent.futures
import math
from pathlib import Path

expansions = ["Era", "Tbc", "Wotlk"]
range_size = 50

# Both are in number of characters
max_file_size = 45000
max_p_size = 4000

# Contains the lua data for each expansion
expansion_data = {}


def find_addon_name():
    # Addon folder name
    current_dir = Path.cwd()  # Get current directory
    previous_dir = None
    addon_dir = None

    # Go up the directory tree until we find the Addons folder
    max_level = 20
    level = 0
    while level < max_level:  # Stop if we reach the root directory
        if current_dir.name.lower() == "addons" and current_dir.parent.name.lower() == "interface":
            addon_dir = previous_dir
            break
        else:
            previous_dir = current_dir.name
            current_dir = current_dir.parent
            level += 1

    if addon_dir is None:
        print("Could not find the Addons folder")
        exit()
    else:
        print("Found Addons folder: {}".format(addon_dir))

    return addon_dir

# Addon directory
addon_dir = find_addon_name()

# Reads the data from the lua files into a string
def read_expansion_data(expansion):
    path = "Database\\Item\\" + expansion
    print("Reading {} lua item data".format(expansion))
    #Read the entire fil "ItemData.lua-table" into a string
    with open(path + "\\ItemData.lua-table", 'r') as itemdata_file:
        itemdata = itemdata_file.read()

    # 9 items has &, fuck it let's just replace it with "and"
    itemdata = itemdata.replace("&", "and")
    itemdata = itemdata.replace("<", "|")
    itemdata = itemdata.replace(">", "|")
    expansion_data[expansion] = itemdata

# The main logic function, it uses the decoded data to create HTML files.
def process_expansion(expansion):
    itemdata = expansion_data[expansion]
    # A variable to keep track of how many entries have been written
    entries_written = 0
    # Variables to keep track of the lowest and highest id
    lowest_id, highest_id = float('inf'), -float('inf')


    print("Dumping items for " + expansion)
    path = "Database\\Item\\" + expansion

    if not os.path.exists(path + '\\_data'):
        print("Creating item _data folder")
        os.makedirs(path + '\\_data')
    else:
        #Delete html files in _data folder
        print("Deleting old item html _data files")
        for file in os.listdir(path + '\\_data'):
            if file.endswith(".html"):
                os.remove(path + '\\_data\\' + file)

    lua.newline = ""
    lua.tab = ""

    # The .xml file that imports all the data files through the toc.
    embed_file_string = '<Ui xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\\FrameXML\\UI.xsd">\n'
    embed_file_string += '<SimpleHTML name="ItemDataFiles" file="Interface\\AddOns\\{}\\Database\\Item\\{}\\ItemDataTemplates.html" virtual="true" font="GameFontNormal"/>\n'.format(addon_dir, expansion)


    output_data = ""
    # The string that contains the index -> ItemId convertion data printed at the top of each file.
    lookup_data = "<!-- Index to Id table -->\n" + "<p>"
    # Contains all the filenames for the files that are generated, used to create the frames later
    filename_data = ""
    # The indexes of the data that we have written to the file e.g 1 = name, 2 startedBy etc
    writtenDataIndexes = []

    # Keep track of the entry index so we can check if we have reached the end of the dict
    entryIndex = 0
    for dataId in itemdata:
        entryIndex += 1

        lowest_id = min(lowest_id, int(dataId))
        highest_id = max(highest_id, int(dataId))

        item_data = itemdata[dataId]

        lookup_data += str(dataId) + ","

        output_data_local = ""
        itemDataIndex = 1
        for line in item_data:
            encoded_line = lua.encode(line)
            encoded_line = encoded_line.replace("\\n", "<br>")
            encoded_line = encoded_line.strip('"')

            # No reason to print empty lines or nil values
            if encoded_line != "nil" and len(encoded_line) > 0:
                # If the line is too long, we split it into multiple lines
                # We split it at the after max_p_size characters
                if len(encoded_line) < max_p_size:
                    output_data_local += "<p>"
                    output_data_local += encoded_line
                    writtenDataIndexes.append(itemDataIndex)
                    output_data_local += "</p>"
                    output_data_local += "\n"
                else:
                    # If the line is too long, we split it into multiple lines
                    output_data_local += "<!-- Segment start: {} -->\n".format(itemDataIndex)
                    # Calculate how many segments we need
                    segments = len(encoded_line) / max_p_size
                    segments = math.ceil(segments)

                    # Write each segment as a new tag, ending with e
                    for i in range(segments):
                        if i != segments - 1:
                            writtenDataIndexes.append("{}-{}".format(itemDataIndex, i + 1)) # The segment means multiple lines, add one because lua indexes start at 1
                        else:
                            # e as in end
                            writtenDataIndexes.append("{}-{}".format(itemDataIndex, "e")) # The segment ends at the last line, so we use e to indicate that
                        output_data_local += "<p>"
                        output_data_local += encoded_line[i*max_p_size:min(len(encoded_line), (i+1)*max_p_size)]
                        output_data_local += "</p>\n"
                    output_data_local += "<!-- Segment end: {} -->\n".format(itemDataIndex)
            itemDataIndex += 1

        output_data += "<!-- {} -->\n".format(dataId)
        output_data += "<p>" + ",".join(str(x) for x in writtenDataIndexes) + "</p>\n"
        writtenDataIndexes.clear()
        output_data += output_data_local

        entries_written += 1

        # If we have written the maximum amount of entries, or if we have reached the dict
        if entries_written == range_size or entryIndex == len(itemdata):# or len(lookup_data) + len(output_data) > max_file_size:
            lookup_data = lookup_data[:-1] + "</p>"
            output_file_name = path + '\\_data\\{}-{}.html'.format(lowest_id, highest_id)
            # if len(lookup_data) + len(output_data) > max_file_size:
            #     print("Warning: File size exceeded for {}-{}.html".format(lowest_id, highest_id))
            #     print(output_file_name)

            output_file = open(output_file_name, 'w')
            output_file.write("<html><body>\n" + lookup_data + "\n" + output_data + "</body></html>")
            output_file.close()

            embed_file_string += '<SimpleHTML'
            embed_file_string += ' name="ItemData{}-{}"'.format(str(lowest_id), str(highest_id))
            embed_file_string += ' file="Interface\\AddOns\\{}\\Database\\Item\\{}\\_data\\{}-{}.html"'.format(addon_dir, expansion, lowest_id, highest_id)
            embed_file_string += ' virtual="true"'
            embed_file_string += ' font="GameFontNormal"'
            embed_file_string += '/>\n'

            filename_data += "{}-{},".format(str(lowest_id), str(highest_id))

            # Reset variables for the next file
            entries_written = 0
            lowest_id, highest_id = float('inf'), -float('inf')
            output_data = ""
            lookup_data = "<!-- Index to Id table -->\n" + "<p>"

        if entryIndex == len(itemdata) or entryIndex % 1000 == 0:
          print("Processed {}/{} {} items".format(entryIndex, len(itemdata), expansion))

    embed_file = open(path + "\\ItemDataFiles.xml", 'w')
    embed_file.write(embed_file_string)
    embed_file.write('</Ui>')
    embed_file.close()
    filename_file = open(path + "\\ItemDataTemplates.html", 'w')
    filename_file.write("<!-- This contains all the ranges for the files that are generated -->\n")
    filename_file.write("<html><body>\n")
    filename_file.write("<p>{}</p>\n".format(filename_data[:len(filename_data)//2]))
    filename_file.write("<p>{}</p>".format(filename_data[len(filename_data)//2:-1]))
    filename_file.write("\n</body></html>")
    filename_file.close()
    print("Finished dumping items for " + expansion)

# Read all expansion files in separate threads
with concurrent.futures.ThreadPoolExecutor() as executor:
    futures = [executor.submit(read_expansion_data, expansion) for expansion in expansions]

    # Wait for all threads to complete
    for future in concurrent.futures.as_completed(futures):
        try:
            future.result()
        except Exception as e:
            print(f"An error occurred in a thread: {e}")

# This is not threadsafe for some reason... doing it in a single thread.
for expansion in expansions:
    print("Decoding {} lua item data to python item".format(expansion))
    py_data = lua.decode(expansion_data[expansion])

    expansion_data[expansion] = py_data

# Process all expansions in separate threads
with concurrent.futures.ThreadPoolExecutor() as executor:
    futures = [executor.submit(process_expansion, expansion) for expansion in expansions]

    # Wait for all threads to complete
    for future in concurrent.futures.as_completed(futures):
        try:
            future.result()
        except Exception as e:
            print(f"An error occurred in a thread: {e}")

print("Items Done!")