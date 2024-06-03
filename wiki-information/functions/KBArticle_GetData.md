## Title: KBArticle_GetData

**Content:**
Returns data for the current article.
`id, subject, subjectAlt, text, keywords, languageId, isHot = KBArticle_GetData()`

**Parameters:**
- `()`

**Returns:**
- `id`
  - *number* - The article id
- `subject`
  - *string* - The localized title.
- `subjectAlt`
  - *string* - The English title.
- `text`
  - *string* - The article itself
- `keywords`
  - *string* - Some keywords for the article. May be nil.
- `languageId`
  - *number* - The language ID for the article.
- `isHot`
  - *boolean* - Flag for the "hot" status.

**Description:**
Only works if `KBArticle_IsLoaded()` returns true.