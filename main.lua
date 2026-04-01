local tokenize = require("tokenize")

local handle = io.open("./test.viul", "r")
if not handle then return end

local tokens = tokenize(handle:read("a"))
handle:close()
