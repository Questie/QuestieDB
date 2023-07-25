local _,
---@class QuestieSDB
QuestieSDB = ...

--- Colorize a string with a color code
---@param color "red"|"gray"|"purple"|"blue"|"lightBlue"|"reputationBlue"|"yellow"|"orange"|"green"|"white"|"gold"|string
---@param ... string
function QuestieSDB.ColorizePrint(color, ...)
  local c = "|cFF" .. color;

  if color == "red" then
    c = "|cFFff0000";
  elseif color == "gray" then
    c = "|cFFa6a6a6";
  elseif color == "purple" then
    c = "|cFFB900FF";
  elseif color == "blue" then
    c = "|cB900FFFF";
  elseif color == "lightBlue" then
    c = "|cB900FFFF";
  elseif color == "reputationBlue" then
    c = "|cFF8080ff";
  elseif color == "yellow" then
    c = "|cFFffff00";
  elseif color == "orange" then
    c = "|cFFFF6F22";
  elseif color == "green" then
    c = "|cFF00ff00";
  elseif color == "white" then
    c = "|cFFffffff";
  elseif color == "gold" then
    c = "|cFFffd100"     -- this is the default game font
  end

  print(c, ...)
end
