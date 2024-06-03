## Event: PARTY_INVITE_REQUEST

**Title:** PARTY INVITE REQUEST

**Content:**
Fires when a player invite you to party.
`PARTY_INVITE_REQUEST: name, isTank, isHealer, isDamage, isNativeRealm, allowMultipleRoles, inviterGUID, questSessionActive`

**Payload:**
- `name`
  - *string* - The player that invited you.
- `isTank`
  - *boolean*
- `isHealer`
  - *boolean*
- `isDamage`
  - *boolean*
- `isNativeRealm`
  - *boolean* - Whether the invite is cross realm
- `allowMultipleRoles`
  - *boolean*
- `inviterGUID`
  - *string*
- `questSessionActive`
  - *boolean*