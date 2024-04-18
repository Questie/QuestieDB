LibStub = {
  NewLibrary = _EmptyDummyFunction,
  GetLibrary = _TableDummyFunction,
}
setmetatable(LibStub, {
  __call = function(_, ...)
    return { NewAddon = _TableDummyFunction, New = _TableDummyFunction, }
  end,
})
