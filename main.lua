local tokenize = require("tokenize")
local parse    = require("parse")

local handle   = io.open("./test.viul", "r")
if not handle then return end

local tokens = tokenize(handle:read("a"))
handle:close()
local dict = parse(tokens)
for name, procedure in pairs(dict) do
    print(name)
    for _, token in ipairs(procedure) do
        print("    ", token.value)
    end
end
