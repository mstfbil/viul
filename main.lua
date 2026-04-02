local tokenize = require("tokenize")
local parse    = require("parse")
local dispatch = require("dispatch")

local handle   = io.open("./test.viul", "r")
if not handle then return end

local tokens = tokenize(handle:read("a"))
handle:close()
local dict = parse(tokens)
dispatch(dict, "main")
