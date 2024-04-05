import os
import re
import tiktoken

model = "gpt-3.5-turbo-1106"

file_ending = ".llm.txt"
output_filename = "QuestieDB.llm.txt"


# Get the tokenizer corresponding to the model in the OpenAI API
enc = tiktoken.encoding_for_model(model)

# Create .llm-output folder if it doesn't exist
if not os.path.exists(".llm-output"):
  os.makedirs(".llm-output")

# Remove all json files in the .llm-output folder
for file in os.listdir(".llm-output"):
  if file.endswith("llm.lua"):
    print(f"Removing {file}")
    os.remove(os.path.join(".llm-output", file))

big_file = open(f".llm-output/_{output_filename}", "w", encoding="utf-8")

data = {}

for root, dirs, files in os.walk("."):
  if root.startswith(".\\."):
    continue
  if "cli" in root:
    continue
  if ".wowhead" in root:
    continue
  if ".git" in root:
    continue
  if ".vscode" in root:
    continue
  if ".generate_database" in root:
    continue
  for file in files:
    if "_s.lua" in file:
      continue
    if file.endswith(".test.lua"):
      continue
    if file.endswith(".lua"):
      if file.endswith("Fixes.lua"):
        continue
      print(file)
      filepath = os.path.join(root, file).replace("\\", "/")
      filedata = ""

      filedata += "--- File metadata  ---\n"
      filedata += f"--- Path: {filepath} ---\n"
      filedata += "--- File metadata end ---\n\n"
      with open(filepath, "r", encoding="utf-8") as f:
        filedata += f.read()
        filedata += "\n\n"

      data[filepath] = filedata
      big_file.write(filedata)

big_file.close()

all_file = open(f".llm-output/_All-{output_filename}", "w", encoding="utf-8")
big_file = open(f".llm-output/_{output_filename}", "w", encoding="utf-8")
type_file = open(f".llm-output/_Types-{output_filename}", "w", encoding="utf-8")
# Put files under Database/<DATATYPE> into their own files
for filename, filedata in data.items():
  all_file.write(filedata)
  if "Database/" in filename and ".t.lua" not in filename:
    datatype = filename.split("Database/")[1].split("/")[0]
    if not datatype.endswith(".lua"):
      text = ""
      # Remove the file from the big file
      if os.path.exists(f".llm-output/_{datatype}-{output_filename}"):
        with open(f".llm-output/_{datatype}-{output_filename}", "r", encoding="utf-8") as f:
          text = f.read()
      text += filedata
      with open(f".llm-output/_{datatype}-{output_filename}", "w", encoding="utf-8") as f:
        f.write(text)
  elif ".t.lua" in filename:
    type_file.write(filedata)
  else:
    big_file.write(filedata)

big_file.close()
type_file.close()

# Replace indentation with tabs
for root, dirs, files in os.walk(".llm-output"):
  for file in files:
    if file.endswith(file_ending):
      filepath = os.path.join(root, file)
      with open(filepath, "r", encoding="utf-8") as f:
        text = f.read()
        # Replace indentation spaces with tabs
        text = re.sub(r"  ", "\t", text)
        text = re.sub(r"\t ", "\t", text)
      with open(filepath, "w", encoding="utf-8") as f:
        f.write(text)
# 28734
# 31886

all_file_token = 0
tokens = 0
for root, dirs, files in os.walk(".llm-output"):
  for file in files:
    if file.startswith("_All-"):
      with open(os.path.join(root, file), "r", encoding="utf-8") as f:
        text = f.read()
        all_file_token += len(enc.encode(text))
    if file.endswith(file_ending) and not file.startswith("_All-"):
      with open(os.path.join(root, file), "r", encoding="utf-8") as f:
        text = f.read()
        tokens += len(enc.encode(text))
print(tokens)
print(all_file_token)
