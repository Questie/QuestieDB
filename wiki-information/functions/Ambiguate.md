## Title: Ambiguate

**Content:**
Returns a version of a character-realm string suitable for use in a given context.
`name = Ambiguate(fullName, context)`

**Parameters:**
- `fullName`
  - *string* - character-realm for a character, e.g. "Shion-DieAldor"
- `context`
  - *string* - context the name will be used in, one of: "all", "guild", "mail", "none", or "short".

**Returns:**
- `name`
  - *string* - character or character-realm name combination that would be equivalent to fullName in the specified context.
  - **Context**
    - **Same Realm**
    - **Different Realm**
    - **Same Guild**
    - **Other Guild**
    - **Same Guild**
    - **Other Guild**
    - `all`
      - character
      - character
      - character
      - character-realm
    - `guild`
      - character
      - character
      - character
      - character-realm
    - `mail`
      - character-realm
      - character-realm
      - character-realm
      - character-realm
    - `none`
      - character
      - character
      - character-realm
      - character-realm
    - `short`
      - character
      - character
      - character
      - character

**Description:**
If this is used on a character in the "guild" context, it will return in the character-realm format if there is another character in the same guild with the same name, but on a different realm.