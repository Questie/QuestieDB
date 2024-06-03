## Title: C_XMLUtil.GetTemplates

**Content:**
Returns a list of all registered XML templates.
`templates = C_XMLUtil.GetTemplates()`

**Returns:**
- `templates`
  - *XMLTemplateListInfo* - An array of tables for each registered XML template.
    - `Field`
    - `Type`
    - `Description`
    - `name`
      - *string* - The name of the XML template.
    - `type`
      - *string* - The frame type ("Frame", "Button", etc.) of the XML template.

**Usage:**
The following snippet will print all the names and frame types of registered XML templates.
```lua
for _, template in ipairs(C_XMLUtil.GetTemplates()) do
  print(template.name, template.type)
end
```