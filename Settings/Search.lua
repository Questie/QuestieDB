---@class LibQuestieDB
---@field QuestieDBSettings QuestieDBSettings
local LibQuestieDB = select(2, ...)

if Is_CLI then
  return
end

--*---- Create Module --------

---@class QuestieDBSettings
local QuestieDBSettings = LibQuestieDB.QuestieDBSettings

QuestieDBSettings.QuestieDB_SearchFrame = CreateFrame("Frame", "QuestieDB_SearchFrame", UIParent, BackdropTemplateMixin and "BackdropTemplate")

---@param t table|nil
local function tableToString(t, indent)
  if type(t) ~= "table" then return tostring(t) end
  indent = indent or 0
  local pad = string.rep("  ", indent)
  local s = "{\n"
  for k, v in pairs(t) do
    s = s .. pad .. "  [" .. tostring(k) .. "] = "
    if type(v) == "table" then
      s = s .. tableToString(v, indent + 1)
    else
      s = s .. tostring(v)
    end
    s = s .. ",\n"
  end
  return s .. pad .. "}"
end

-- UI Search Frame for QuestieDB
local function CreateSearchUI()
  local f = QuestieDBSettings.QuestieDB_SearchFrame
  -- f:SetSize(840, 640)
  f:SetPoint("CENTER")
  f:SetFrameStrata("DIALOG")
  -- f:SetMovable(true)
  -- f:EnableMouse(true)
  -- f:RegisterForDrag("LeftButton")
  -- f:SetScript("OnDragStart", f.StartMoving)
  -- f:SetScript("OnDragStop", f.StopMovingOrSizing)
  -- f:SetBackdrop({ bgFile = "Interface/Tooltips/UI-Tooltip-Background", edgeFile = "Interface/Tooltips/UI-Tooltip-Border", tile = true, tileSize = 16, edgeSize = 16, insets = { left = 4, right = 4, top = 4, bottom = 4, }, })
  -- f:SetBackdropColor(0, 0, 0, 0.85)
  -- f:SetClampedToScreen(true)

  -- Close button
  local close = CreateFrame("Button", nil, f, "UIPanelCloseButton")
  close:SetPoint("TOPRIGHT", f, "TOPRIGHT", -4, -4)
  close:SetScript("OnClick", function() f:Hide() end)

  -- Title
  local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
  title:SetPoint("TOPLEFT", f, "TOPLEFT", 16, -16)
  title:SetText("QuestieDB Search")

  -- Dropdown for type
  local typeLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  typeLabel:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -16)
  typeLabel:SetText("Type:")

  local typeDropdown = CreateFrame("Frame", "QuestieDB_SearchTypeDropdown", f, "UIDropDownMenuTemplate")
  typeDropdown:SetPoint("LEFT", typeLabel, "RIGHT", 8, 2)
  local searchTypes = { { text = "Quest", value = "Quest", }, { text = "Item", value = "Item", }, { text = "Object", value = "Object", }, { text = "Npc", value = "Npc", }, }
  local selectedType = "Quest"
  UIDropDownMenu_SetWidth(typeDropdown, 100)
  UIDropDownMenu_SetText(typeDropdown, "Quest")
  UIDropDownMenu_Initialize(typeDropdown, function(self, level, menuList)
    for _, v in ipairs(searchTypes) do
      local info = UIDropDownMenu_CreateInfo()
      info.text = v.text
      info.value = v.value
      info.func = function()
        selectedType = v.value
        UIDropDownMenu_SetText(typeDropdown, v.text)
      end
      UIDropDownMenu_AddButton(info)
    end
  end)

  -- EditBox for ID
  local idLabel = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
  idLabel:SetPoint("TOPLEFT", typeLabel, "BOTTOMLEFT", 0, -24)
  idLabel:SetText("ID:")
  local idBox = CreateFrame("EditBox", nil, f, "InputBoxTemplate")
  idBox:SetSize(120, 24)
  idBox:SetPoint("LEFT", idLabel, "RIGHT", 8, 0)
  idBox:SetAutoFocus(false)
  idBox:SetNumeric(true)

  -- Search button
  local searchBtn = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
  searchBtn:SetSize(80, 24)
  searchBtn:SetPoint("LEFT", idBox, "RIGHT", 12, 0)
  searchBtn:SetText("Search")

  -- ScrollFrame for output
  local scrollFrame = CreateFrame("ScrollFrame", nil, f, "UIPanelScrollFrameTemplate")
  scrollFrame:SetPoint("TOPLEFT", idLabel, "BOTTOMLEFT", 0, -32)
  scrollFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -32, 16)
  local output = CreateFrame("EditBox", nil, scrollFrame)
  output:SetMultiLine(true)
  output:SetFontObject(ChatFontNormal)
  output:SetWidth(f:GetParent():GetWidth() * 0.8) -- Adjust width to fit the frame
  output:SetAutoFocus(false)
  scrollFrame:SetScrollChild(output)
  output:SetScript("OnEscapePressed", function() output:ClearFocus() end)

  -- ! This is a really good example, kept for reference
  -- local scrollFrame = CreateFrame("ScrollFrame", "QuestieDB_ResultScrollFrame", f, "UIPanelScrollFrameTemplate")
  -- scrollFrame:SetPoint("TOPLEFT", idLabel, "BOTTOMLEFT", 0, -32)
  -- scrollFrame:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", -32, 16)

  -- -- This is the scroll child, a simple frame that will contain our result lines
  -- local scrollChild = CreateFrame("Frame", nil, scrollFrame)
  -- scrollChild:SetSize(scrollFrame:GetWidth(), 1) -- Width of scrollframe, height will be dynamic
  -- scrollFrame:SetScrollChild(scrollChild)

  -- -- Create a pool of reusable frames (lines)
  -- local resultLinesPool = {}
  -- ---@param index number
  -- local function CreateResultLine(index)
  --   local line = CreateFrame("Button", nil, scrollChild)
  --   line:SetSize(scrollChild:GetWidth(), 20) -- Full width, 20 height
  --   line:SetHighlightTexture("Interface/QuestFrame/UI-QuestTitleHighlight")
  --   line:GetHighlightTexture():SetBlendMode("ADD")

  --   local text = line:CreateFontString(nil, "ARTWORK", "GameFontNormal")
  --   text:SetPoint("LEFT", line, "LEFT", 5, 0)
  --   text:SetJustifyH("LEFT")
  --   line.text = text -- Store reference

  --   line:SetScript("OnClick", function()
  --     -- You could make clicking a line do something, e.g., copy text
  --     print("Clicked result:", line.text:GetText())
  --   end)

  --   return line
  -- end

  -- -- Function to render results using the pool
  -- ---@param results string[]
  -- local function renderResultWithPool(results)
  --   local lineHeight = 20
  --   local lineY = 0

  --   for i, resultText in ipairs(results) do
  --     local line = resultLinesPool[i]
  --     if not line then
  --       -- If we run out of pooled frames, create a new one
  --       line = CreateResultLine(i)
  --       resultLinesPool[i] = line
  --     end

  --     line.text:SetText(resultText)
  --     line:ClearAllPoints()
  --     line:SetPoint("TOPLEFT", scrollChild, "TOPLEFT", 0, lineY)
  --     line:Show()

  --     lineY = lineY - lineHeight
  --   end

  --   -- Hide any unused pooled frames
  --   for i = #results + 1, #resultLinesPool do
  --     resultLinesPool[i]:Hide()
  --   end

  --   -- Update the height of the scrollable area
  --   scrollChild:SetHeight(math.max(1, #results * lineHeight))
  -- end

  local metaMap = {
    Quest  = { meta = LibQuestieDB.Meta.QuestMeta, api = function() return LibQuestieDB.PublicLibQuestieDB.Quest end, },
    Item   = { meta = LibQuestieDB.Meta.ItemMeta, api = function() return LibQuestieDB.PublicLibQuestieDB.Item end, },
    Object = { meta = LibQuestieDB.Meta.ObjectMeta, api = function() return LibQuestieDB.PublicLibQuestieDB.Object end, },
    Npc    = { meta = LibQuestieDB.Meta.NpcMeta, api = function() return LibQuestieDB.PublicLibQuestieDB.Npc end, },
  }

  local function renderResult(typeName, id)
    local meta = metaMap[typeName].meta
    local api = metaMap[typeName].api()
    local keys = meta and meta[typeName:lower() .. "Keys"] or nil
    local dumpFuncs = meta and meta.dumpFuncs or nil
    if not keys or not dumpFuncs then
      -- renderResultWithPool({ "Meta information or dump functions missing for type: " .. tostring(typeName) })
      output:SetText("Meta information or dump functions missing for type: " .. tostring(typeName))
      return
    end
    local resultLines = {}
    for key, idx in pairs(keys or {}) do
      local func = api[key]
      if type(func) == "function" then
        local ok, value = pcall(func, id)
        if ok and value ~= nil then
          local dumpFunc = dumpFuncs[key]
          if type(dumpFunc) == "function" then
            local ok2, formatted = pcall(dumpFunc, value)
            if ok2 and formatted ~= nil and formatted ~= "nil" and formatted ~= "" then
              table.insert(resultLines, key .. " = " .. tostring(formatted))
            end
          end
        end
      end
    end
    if #resultLines == 0 then
      -- renderResultWithPool({ "No data found for ID " .. tostring(id) .. "." })
      output:SetText("No data found for ID " .. tostring(id) .. ".")
    else
      -- renderResultWithPool(resultLines)
      output:SetText(table.concat(resultLines, "\n"))
    end
    -- Comment out these lines to use the pooled rendering
    output:HighlightText(0, 0)
    output:SetCursorPosition(0)
  end

  searchBtn:SetScript("OnClick", function()
    local id = tonumber(idBox:GetText())
    if not id then
      -- renderResultWithPool({ "Please enter a valid numeric ID." })
      output:SetText("Please enter a valid numeric ID.")
      return
    end
    renderResult(selectedType, id)
    -- Comment out this line to use the pooled rendering
    output:ClearFocus()
    idBox:ClearFocus()
  end)

  idBox:SetScript("OnEnterPressed", function()
    searchBtn:Click()
  end)

  -- Resize Grip Button
  local resizeGrip = CreateFrame("Button", nil, f)
  resizeGrip:SetSize(16, 16)
  resizeGrip:SetPoint("BOTTOMRIGHT", f, "BOTTOMRIGHT", 0, 0)

  -- Set textures for the grip to make it visible
  resizeGrip:SetNormalTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Up")
  resizeGrip:SetPushedTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Down")
  resizeGrip:SetHighlightTexture("Interface/ChatFrame/UI-ChatIM-SizeGrabber-Highlight")

  -- Make it resizable
  f:SetResizable(true)
  -- Set min/max dimensions to prevent the user from making it too small/large
  f:SetResizeBounds(400, 300, 1200, 900)

  resizeGrip:SetScript("OnMouseDown", function()
    f:StartSizing("BOTTOMRIGHT")
  end)
  resizeGrip:SetScript("OnMouseUp", function()
    f:StopMovingOrSizing()
    -- Optional: You could save the new size in a SavedVariables file here
  end)

  f:Show()
  QuestieDBSettings.category, QuestieDBSettings.layout = Settings.RegisterCanvasLayoutCategory(f, "QuestieDB")
  Settings.RegisterAddOnCategory(QuestieDBSettings.category)
end

C_Timer.After(0.1, function()
  CreateSearchUI()
end)
