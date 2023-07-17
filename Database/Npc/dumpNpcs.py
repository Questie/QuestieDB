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
    path = "Database\\Npc\\" + expansion
    print("Reading {} lua npc data".format(expansion))
    #Read the entire fil "NpcData.lua-table" into a string
    with open(path + "\\NpcData.lua-table", 'r') as npcdata_file:
        npcdata = npcdata_file.read()

    # 9 npcs has &, fuck it let's just replace it with "and"
    npcdata = npcdata.replace("&", "and")
    npcdata = npcdata.replace("<", "|")
    npcdata = npcdata.replace(">", "|")
    expansion_data[expansion] = npcdata

# The main logic function, it uses the decoded data to create HTML files.
def process_expansion(expansion):
    npcdata = expansion_data[expansion]
    # A variable to keep track of how many entries have been written
    entries_written = 0
    # Variables to keep track of the lowest and highest id
    lowest_id, highest_id = float('inf'), -float('inf')


    print("Dumping npcs for " + expansion)
    path = "Database\\Npc\\" + expansion

    if not os.path.exists(path + '\\_data'):
        print("Creating npc _data folder")
        os.makedirs(path + '\\_data')
    else:
        #Delete html files in _data folder
        print("Deleting old npc html _data files")
        for file in os.listdir(path + '\\_data'):
            if file.endswith(".html"):
                os.remove(path + '\\_data\\' + file)

    lua.newline = ""
    lua.tab = ""

    # The .xml file that imports all the data files through the toc.
    embed_file_string = '<Ui xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\\FrameXML\\UI.xsd">\n'
    embed_file_string += '<SimpleHTML name="NpcDataFiles" file="Interface\\AddOns\\{}\\Database\\Npc\\{}\\NpcDataTemplates.html" virtual="true" font="GameFontNormal"/>\n'.format(addon_dir, expansion)


    output_data = ""
    # The string that contains the index -> NpcId convertion data printed at the top of each file.
    lookup_data = "<!-- Index to Id table -->\n" + "<p>"
    # Contains all the filenames for the files that are generated, used to create the frames later
    filename_data = ""
    # The indexes of the data that we have written to the file e.g 1 = name, 2 startedBy etc
    writtenDataIndexes = []

    # Keep track of the entry index so we can check if we have reached the end of the dict
    entryIndex = 0
    for dataId in npcdata:
        entryIndex += 1

        lowest_id = min(lowest_id, int(dataId))
        highest_id = max(highest_id, int(dataId))

        npc_data = npcdata[dataId]

        lookup_data += str(dataId) + ","

        output_data_local = ""
        npcDataIndex = 1
        for line in npc_data:
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
                    writtenDataIndexes.append(npcDataIndex)
                    output_data_local += "</p>"
                    output_data_local += "\n"
                else:
                    # If the line is too long, we split it into multiple lines
                    output_data_local += "<!-- Segment start: {} -->\n".format(npcDataIndex)
                    # Calculate how many segments we need
                    segments = len(encoded_line) / max_p_size
                    segments = math.ceil(segments)

                    # Write each segment as a new tag, ending with e
                    for i in range(segments):
                        if i != segments - 1:
                            writtenDataIndexes.append("{}-{}".format(npcDataIndex, i + 1)) # The segment means multiple lines, add one because lua indexes start at 1
                        else:
                            # e as in end
                            writtenDataIndexes.append("{}-{}".format(npcDataIndex, "e")) # The segment ends at the last line, so we use e to indicate that
                        output_data_local += "<p>"
                        output_data_local += encoded_line[i*max_p_size:min(len(encoded_line), (i+1)*max_p_size)]
                        output_data_local += "</p>\n"
                    output_data_local += "<!-- Segment end: {} -->\n".format(npcDataIndex)
            npcDataIndex += 1

        output_data += "<!-- {} -->\n".format(dataId)
        output_data += "<p>" + ",".join(str(x) for x in writtenDataIndexes) + "</p>\n"
        writtenDataIndexes.clear()
        output_data += output_data_local

        entries_written += 1

        # If we have written the maximum amount of entries, or if we have reached the dict
        if entries_written == range_size or entryIndex == len(npcdata):# or len(lookup_data) + len(output_data) > max_file_size:
            lookup_data = lookup_data[:-1] + "</p>"
            output_file_name = path + '\\_data\\{}-{}.html'.format(lowest_id, highest_id)
            # if len(lookup_data) + len(output_data) > max_file_size:
            #     print("Warning: File size exceeded for {}-{}.html".format(lowest_id, highest_id))
            #     print(output_file_name)

            output_file = open(output_file_name, 'w')
            output_file.write("<html><body>\n" + lookup_data + "\n" + output_data + "</body></html>")
            output_file.close()

            embed_file_string += '<SimpleHTML'
            embed_file_string += ' name="NpcData{}-{}"'.format(str(lowest_id), str(highest_id))
            embed_file_string += ' file="Interface\\AddOns\\{}\\Database\\Npc\\{}\\_data\\{}-{}.html"'.format(addon_dir, expansion, lowest_id, highest_id)
            embed_file_string += ' virtual="true"'
            embed_file_string += ' font="GameFontNormal"'
            embed_file_string += '/>\n'

            filename_data += "{}-{},".format(str(lowest_id), str(highest_id))

            # Reset variables for the next file
            entries_written = 0
            lowest_id, highest_id = float('inf'), -float('inf')
            output_data = ""
            lookup_data = "<!-- Index to Id table -->\n" + "<p>"

        if entryIndex == len(npcdata) or entryIndex % 1000 == 0:
          print("Processed {}/{} {} npcs".format(entryIndex, len(npcdata), expansion))

    embed_file = open(path + "\\NpcDataFiles.xml", 'w')
    embed_file.write(embed_file_string)
    embed_file.write('</Ui>')
    embed_file.close()
    filename_file = open(path + "\\NpcDataTemplates.html", 'w')
    filename_file.write("<!-- This contains all the ranges for the files that are generated -->\n")
    filename_file.write("<html><body>\n")
    filename_file.write("<p>{}</p>\n".format(filename_data[:len(filename_data)//2]))
    filename_file.write("<p>{}</p>".format(filename_data[len(filename_data)//2:-1]))
    filename_file.write("\n</body></html>")
    filename_file.close()
    print("Finished dumping npcs for " + expansion)

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
    print("Decoding {} lua npc data to python npc".format(expansion))
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

print("Npcs Done!")