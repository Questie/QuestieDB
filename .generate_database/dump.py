#https://stackoverflow.com/questions/39838489/converting-lua-table-to-a-python-dictionary
#https://github.com/SirAnthony/slpp
#pip install git+https://github.com/SirAnthony/slpp
import os
import concurrent.futures
import math
from helpers import find_addon_name, read_expansion_data, get_project_dir_path, get_data_dir_path

addon_dir = find_addon_name()
print(f"Addon dir: {addon_dir}")
print(f"Project dir: {get_project_dir_path()}")

entity_types = ["Quest", "Item", "Object", "Npc"]

expansions = ["Era", "Tbc", "Wotlk"]
range_size = 50

# Both are in number of characters
max_file_size = 45000
max_p_size = 4000

# @dataclass
# class Quest:
#   asdf: int = 0


# The main logic function, it uses the decoded data to create HTML files.
def process_expansion(expansion_name: str, entity_type: str, expansion_data: dict[int, list[str]]):
    from slpp import slpp as lua
    entity_type_lower = entity_type.lower()
    entity_type_plural = entity_type_lower + "s"
    entity_type_capitalized = entity_type.capitalize()
    # A variable to keep track of how many entries have been written
    entries_written = 0
    # Variables to keep track of the lowest and highest id
    lowest_id, highest_id = float('inf'), -float('inf')

    print(f"Processing {expansion_name} python {entity_type_lower} data")


    print(f"Dumping {entity_type_plural} for {expansion_name}")
    path = get_data_dir_path(entity_type, expansion_name)
    data_dir_path= f"Interface\\AddOns\\{addon_dir}\\Database\\{entity_type_capitalized}\\{expansion_name.capitalize()}"

    if not os.path.exists(path + '\\_data'):
        print(f"Creating {entity_type_lower} _data folder")
        os.makedirs(path + '\\_data')
    else:
        #Delete html files in _data folder
        print(f"Deleting old {entity_type_lower} html _data files")
        for file in os.listdir(path + '\\_data'):
            if file.endswith(".html"):
                os.remove(path + '\\_data\\' + file)

    lua.newline = ""
    lua.tab = ""

    # The .xml file that imports all the data files through the toc.
    embed_file_strings = []
    embed_file_strings.append(f'<SimpleHTML name="{entity_type_capitalized}DataFiles" file="{data_dir_path}\\{entity_type_capitalized}DataTemplates.html" virtual="true" font="GameFontNormal"/>\n')


    output_data = ""
    lookup_data_start = "<!-- Index to Id table -->\n" + "<p>"
    # The string that contains the index -> EntityId convertion data printed at the top of each file.
    lookup_data = lookup_data_start
    # Contains all the filenames for the files that are generated, used to create the frames later
    filename_data = ""
    # The indexes of the data that we have written to the file e.g 1 = name, 2 startedBy etc
    writtenDataIndexes = []

    # Keep track of the entry index so we can check if we have reached the end of the dict
    entryIndex = 0
    for dataId in expansion_data:
        entryIndex += 1

        lowest_id = min(lowest_id, int(dataId))
        highest_id = max(highest_id, int(dataId))

        entity_data = expansion_data[dataId]

        output_data_local = ""
        entityDataIndex = 1
        for line in entity_data:
            encoded_line = lua.encode(line)
            encoded_line = encoded_line.replace("\\n", "<br>")
            encoded_line = encoded_line.strip('"')
            #Trim the last comma if it exists
            if encoded_line.endswith(","):
                encoded_line = encoded_line[:-1]
            # Clean up the data
            for i in range(10):
              encoded_line = encoded_line.replace(",}", "}")
              encoded_line = encoded_line.replace("nil}", "}")
            encoded_line = encoded_line.replace(" = ", "=")

            # No reason to print empty lines or nil values
            if encoded_line != "nil" and len(encoded_line) > 0:
                # If the line is too long, we split it into multiple lines
                # We split it at the after max_p_size characters
                if len(encoded_line) < max_p_size:
                    output_data_local += "<p>"
                    output_data_local += encoded_line
                    writtenDataIndexes.append(entityDataIndex)
                    output_data_local += "</p>"
                    output_data_local += "\n"
                else:
                    # If the line is too long, we split it into multiple lines
                    output_data_local += f"<!-- Segment start: {entityDataIndex} -->\n"
                    # Calculate how many segments we need
                    segments = len(encoded_line) / max_p_size
                    segments = math.ceil(segments)

                    # Write each segment as a new tag, ending with e
                    for i in range(segments):
                        if i != segments - 1:
                            writtenDataIndexes.append(f"{entityDataIndex}-{i+1}") # The segment means multiple lines, add one because lua indexes start at 1
                        else:
                            # e as in end
                            writtenDataIndexes.append(f"{entityDataIndex}-{'e'}") # The segment ends at the last line, so we use e to indicate that
                        output_data_local += "<p>"
                        output_data_local += encoded_line[i*max_p_size:min(len(encoded_line), (i+1)*max_p_size)]
                        output_data_local += "</p>\n"
                    output_data_local += "<!-- Segment end: {} -->\n".format(entityDataIndex)
            entityDataIndex += 1

        # Skip the if the entitry is empty
        if len(writtenDataIndexes) > 0:
          lookup_data += f"{dataId},"
          output_data += f"<!-- {dataId} -->\n"
          output_data += "<p>" + ",".join(str(x) for x in writtenDataIndexes) + "</p>\n"
          writtenDataIndexes.clear()
          output_data += output_data_local

          entries_written += 1

        # If we have written the maximum amount of entries, or if we have reached the dict
        if entries_written == range_size or entryIndex == len(expansion_data):# or len(lookup_data) + len(output_data) > max_file_size:
            lookup_data = lookup_data[:-1] + "</p>"
            output_file_name = f"{path}\\_data\\{lowest_id}-{highest_id}.html"
            # if len(lookup_data) + len(output_data) > max_file_size:
            #     print("Warning: File size exceeded for {}-{}.html".format(lowest_id, highest_id))
            #     print(output_file_name)

            output_file = open(output_file_name, 'w', encoding="utf-8")
            output_file.write(f"<html><body>\n{lookup_data}\n{output_data}</body></html>")
            output_file.close()

            embed_file_string = '<SimpleHTML'
            embed_file_string += f' name="{entity_type_capitalized}Data{lowest_id}-{highest_id}"'
            embed_file_string += f' file="{data_dir_path}\\_data\\{lowest_id}-{highest_id}.html"'
            embed_file_string += ' virtual="true"'
            embed_file_string += ' font="GameFontNormal"'
            embed_file_string += '/>\n'
            embed_file_strings.append(embed_file_string)


            filename_data += f"{entity_type_capitalized}Data{lowest_id}-{highest_id},"

            # Reset variables for the next file
            entries_written = 0
            lowest_id, highest_id = float('inf'), -float('inf')
            output_data = ""
            lookup_data = lookup_data_start

        if entryIndex == len(expansion_data) or entryIndex % 1000 == 0:
          print(f"Processed {entryIndex}/{len(expansion_data)} {expansion} {entity_type_plural}")

    # Write out all EntityIds to a file
    with open(f"{path}\\{entity_type_capitalized}DataIds.html", 'w', encoding="utf-8") as entity_id_lookup_file:
      # Write all Ids to a file
      printData = []
      temp = ""
      for Id in expansion_data:
        if len(temp) + len(str(Id)) < max_p_size:
          temp += str(Id) + ","
        else:
          printData.append(temp)
          temp = str(Id) + ","
      printData.append(temp)
      # Remove the last comma in last line
      printData[-1] = printData[-1][:-1]
      entity_id_lookup_file.write(f"<!-- This contains all the ids for {entity_type_plural} -->\n")
      entity_id_lookup_file.write("<html><body>\n")
      for data in printData:
        entity_id_lookup_file.write("<p>" + data + "</p>\n")
      entity_id_lookup_file.write("</body></html>")

    # Add Id lookup file at the start of the embed file
    embed_file_strings.insert(0, f'<SimpleHTML name="{entity_type_capitalized}DataIds" file="{data_dir_path}\\{entity_type_capitalized}DataIds.html" virtual="true" font="GameFontNormal"/>\n')

    with open(f"{path}\\{entity_type_capitalized}DataFiles.xml", 'w', encoding="utf-8") as embed_file:
      embed_file.write('<Ui xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\\FrameXML\\UI.xsd">\n')
      for embed_file_string in embed_file_strings:
        embed_file.write(embed_file_string)
      embed_file.write('</Ui>')

    with open(f"{path}\\{entity_type_capitalized}DataTemplates.html", 'w', encoding="utf-8") as filename_file:
      filename_file.write("<!-- This contains all the ranges for the files that are generated -->\n")
      filename_file.write("<html><body>\n")
      #Trim the last comma if it exists
      if filename_data.endswith(","):
          filename_data = filename_data[:-1]
      segments = len(filename_data) / max_p_size
      segments = math.ceil(segments)

      # Write each segment as a new tag, ending with e
      for i in range(segments):
          filename_file.write("<p>")
          filename_file.write(filename_data[i*max_p_size:min(len(filename_data), (i+1)*max_p_size)])
          filename_file.write("</p>\n")
      filename_file.write("</body></html>")

    print(f"Finished dumping {entity_type}s for {expansion_name}")

# Load the data for all expansions
# The decoding with lua is not thread safe, so we do it here
all_expansion_data = {}
for expansion in expansions:
    all_expansion_data[expansion] = {}
    for entity_type in entity_types:
        from slpp import slpp as lua
        print(f"Reading {expansion} lua {entity_type.lower()} data")
        raw_expansion_data = read_expansion_data(expansion, entity_type)
        print(f"Decoding {expansion} lua {entity_type.lower()} data to python {entity_type.lower()}")
        all_expansion_data[expansion][entity_type] = lua.decode(raw_expansion_data)

# Process all expansions in separate threads
with concurrent.futures.ThreadPoolExecutor() as executor:
    futures = [executor.submit(process_expansion, expansion, entity_type, all_expansion_data[expansion][entity_type]) for expansion in expansions for entity_type in entity_types]

    # Wait for all threads to complete
    for future in concurrent.futures.as_completed(futures):
        try:
            future.result()
        except Exception as e:
            print(f"An error occurred in a thread: {e}")