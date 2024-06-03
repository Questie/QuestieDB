## Title: AcceptTrade

**Content:**
Accepts the current trade offer.
`AcceptTrade()`

**Reference:**
- `TRADE_ACCEPT_UPDATE`
- `TRADE_CLOSED`
- `TRADE_MONEY_CHANGED`
- `TRADE_PLAYER_ITEM_CHANGED`
- `TRADE_REPLACE_ENCHANT`
- `TRADE_REQUEST`
- `TRADE_REQUEST_CANCEL`

**Example Usage:**
This function can be used in a custom addon to automate the acceptance of trade offers. For instance, if you are developing an addon that facilitates quick trading between players, you can call `AcceptTrade()` to programmatically accept a trade once certain conditions are met.

**Addons Using This Function:**
Many trading addons, such as TradeSkillMaster, use this function to streamline the trading process by automatically accepting trades that meet predefined criteria.