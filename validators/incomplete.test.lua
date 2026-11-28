return function(check, equal)
  local incomplete = dofile("validators/incomplete.lua")
  local zone = 7

  local function unresolved(ids, alliance, horde)
    local result = {}
    for _, item in ipairs(incomplete.unresolved(ids, { Alliance = alliance, Horde = horde }, zone)) do
      result[#result + 1] = item.id .. ":" .. table.concat(item.factions, ",")
    end
    return table.concat(result, " ")
  end

  check("should report a quest no Dynamic Correction touches for both factions", function()
    equal(unresolved({ 1 }, {}, {}), "1:Alliance,Horde")
  end)

  check("should skip a quest whose zone is set for both factions", function()
    equal(unresolved({ 1 }, { [1] = { [zone] = 17 } }, { [1] = { [zone] = 331 } }), "")
  end)

  check("should report the faction that is still missing a zone", function()
    equal(unresolved({ 1 }, {}, { [1] = { [zone] = 17 } }), "1:Alliance")
  end)

  check("should treat a zero zone from a Dynamic Correction as missing", function()
    equal(unresolved({ 1 }, { [1] = { [zone] = 0 } }, { [1] = { [zone] = 17 } }), "1:Alliance")
  end)
end
