## Title: C_XMLUtil.GetTemplateInfo

**Content:**
Returns information about a defined XML template.
`info = C_XMLUtil.GetTemplateInfo(name)`

**Parameters:**
- `name`
  - *string* - The name of the template to query.

**Returns:**
- `info`
  - *XMLTemplateInfo?* - Information about the queried template if found, or nil if the template does not exist.
    - `Field`
    - `Type`
    - `Description`
    - `type`
      - *string* - The frame type ("Frame", "Button", etc.) of the XML template.
    - `width`
      - *number* - The statically defined width present in a `<Size>` element on the template. If no width is defined, this will be zero.
    - `height`
      - *number* - The statically defined height present in a `<Size>` element on the template. If no height is defined, this will be zero.
    - `inherits`
      - *string?* - A comma-delimited string of inherited templates, matching the inherits XML attribute. If no templates are inherited, this will be nil.
    - `keyValues`
      - *XMLTemplateKeyValue* - A list of defined key/value pairs defined within a `<KeyValues>` element on the template. If no key/values pairs are defined, this will be an empty table.
        - `XMLTemplateKeyValue`
          - `Field`
          - `Type`
          - `Description`
          - `key`
            - *string* - The value used as the key when this template is instantiated. This will be the string as-supplied in the key attribute on the `<KeyValue>` element itself and not the actual Lua value.
          - `keyType`
            - *string* - The type of the defined key.
          - `type`
            - *string* - The type of the defined value.
          - `value`
            - *string* - The value assigned to the key when this template is instantiated. This will be the string as-supplied in the value attribute on the `<KeyValue>` element itself and not the actual Lua value.