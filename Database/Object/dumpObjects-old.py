#https://stackoverflow.com/questions/39838489/converting-lua-table-to-a-python-dictionary
#https://github.com/SirAnthony/slpp
#pip install git+https://github.com/SirAnthony/slpp
from slpp import slpp as lua
import os
objectdata = ""

#Era, Tbc, Wotlk
expansions = ["Era", "Tbc", "Wotlk"]
# Number of entries per file
range_size = 50
# Total number of objectdata entries
total_entries = 6

for expansion in expansions:
  print("Dumping objects for " + expansion)
  path = "Database\\Object\\"+expansion

  # Create the _data folder if it doesn't exist
  if not os.path.exists(path + '\\_data'):
    os.makedirs(path + '\\_data')

  #Read the entire fil "objectdata.txt" into a string
  with open(path + "\\ObjectData.lua-table", 'r') as objectdata_file:
    objectdata = objectdata_file.read()

  # 9 objects has &, fuck it let's just replace it with and
  objectdata = objectdata.replace("&", "and")
  objectdata = objectdata.replace("<", "|")
  objectdata = objectdata.replace(">", "|")

  # Remove unnecessary data
  for i in range(1, 30):
    objectdata = objectdata.replace(",}", "}")
    objectdata = objectdata.replace("nil}", "}")

  lua.newline = ""
  lua.tab = ""


  py_data = lua.decode(objectdata)
  #Get biggest objectId
  biggest_dataId = 0
  for dataId in py_data:
      if int(dataId) > biggest_dataId:
          biggest_dataId = int(dataId)

  range_end = range_size

  # The .xml file that imports all the data files.
  embed_file = open(path + "\\ObjectsCombined.xml", 'w')
  embed_file.write('<Ui xsi:schemaLocation="http://www.blizzard.com/wow/ui/ ..\\FrameXML\\UI.xsd">\n')


  while range_end < biggest_dataId+range_size:
    output_file_name = path + '\\_data\\{}-{}.html'.format(range_end-range_size+1, range_end)
    # The string that contains the data that will be written for the current object.
    output_data = ""

    # The string that contains the index -> ObjectId convertion data printed at the top of each file.
    lookup_data = "<!-- Index to Id table -->\n" + "<p>"

    # The indexes of the data that we have written to the file e.g 1 = name, 2 startedBy etc
    writtenDataIndexes = []

    # The last dataId that we wrote to the file
    lastDataId = 0
    
    # Written ids is used to check if we have any data to write to the file
    writtenIds = 0
    for dataId in py_data:
        lastDataId = dataId
        if int(dataId) > range_end:  # check if dataId is outside the current range  
          # Only write the file if we have any data to write
          if writtenIds != 0:
            # Remove the last comma
            lookup_data = lookup_data[:-1] + "</p>"
            # Write the data file
            output_file = open(output_file_name, 'w')
            output_file.write("<html><body>\n" + lookup_data + "\n" + output_data + "</body></html>")
            output_file.close()

            # Write the embed file
            embed_file_string = '<SimpleHTML'
            embed_file_string += ' name="ObjectData{}-{}"'.format(str(range_end-range_size+1), str(range_end))
            embed_file_string += ' file="Interface\\AddOns\\QuestieDB\\Database\\Object\\{}\\_data\\{}-{}.html"'.format(expansion, range_end-range_size+1, range_end)
            embed_file_string += ' virtual="true"'
            embed_file_string += ' font="GameFontNormal"'
            #? Save these, we can instead of running it in code run it here, i haven't seen any pro of doing it here though.
            # embed_file_string += '<Scripts>'
            # embed_file_string += '<OnLoad>'
            # embed_file_string += 'self:SetScript("OnUpdate", nil) '
            # embed_file_string += 'self:Hide() '
            # embed_file_string += 'self:UnregisterAllEvents() '
            # embed_file_string += '</OnLoad>'
            # embed_file_string += '</Scripts>'
            # embed_file_string += '</SimpleHTML>\n'
            embed_file_string += '/>\n'
            embed_file.write(embed_file_string)

          range_end += range_size
          break
        else:
          if int(dataId) > range_end-range_size:
            print("ObjectId: {}".format(dataId))
            object_data = py_data[dataId]
            # Add None to the missing entries up to total_entries
            for i in range(len(object_data), total_entries):
                object_data.append(None)
            writtenIds += 1
    
            lookup_data += str(dataId) + ","

            output_data_local = ""
            objectDataIndex = 1
            for line in object_data:
                encoded_line = lua.encode(line)
                encoded_line = encoded_line.replace("\\n", "<br>")
                #Trim " from start and end of string
                encoded_line = encoded_line.strip('"')

                if encoded_line != "nil":
                  output_data_local += "<p>"
                  output_data_local += encoded_line
                  writtenDataIndexes.append(objectDataIndex)
                  output_data_local += "</p>"
                  # output_data_local += "<!-- {} -->".format(objectDataIndex)
                  output_data_local += "\n"
                objectDataIndex += 1
            output_data += "<!-- {} -->\n".format(dataId)
            output_data += "<p>" + ",".join(str(x) for x in writtenDataIndexes) + "</p>\n"
            writtenDataIndexes.clear()
            output_data += output_data_local
    if lastDataId == biggest_dataId:
      break

  embed_file.write('</Ui>')
  embed_file.close()


print("Done!")
