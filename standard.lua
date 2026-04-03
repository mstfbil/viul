-- viul standard vocabulary

local TOKEN_TYPE = require("TOKEN_TYPE")

local std = {}

local function pop(stack, n)
    local popped = {}
    for i = 1, n do
        local m = table.remove(stack)
        if not m then
            break
        end
        table.insert(popped, m)
    end
    return popped
end

std["+"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, s[2] + s[1])
end

std["++"] = function(stack)
    local a = table.remove(stack)
    table.insert(stack, a + 1)
end

std["-"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, s[2] - s[1])
end

std["--"] = function(stack)
    local a = table.remove(stack)
    table.insert(stack, a - 1)
end

std["*"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, s[2] * s[1])
end

std["/"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, s[2] / s[1])
end

std["."] = function(stack)
    print(table.remove(stack))
end

std["="] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, (s[2] == s[1]) and 1 or 0)
end

std["<"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, (s[2] < s[1]) and 1 or 0)
end

std[">"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, (s[2] > s[1]) and 1 or 0)
end

std["<="] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, (s[2] <= s[1]) and 1 or 0)
end

std[">="] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, (s[2] >= s[1]) and 1 or 0)
end

std["&"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, ((s[2] == 1) and (s[1] == 1)) and 1 or 0)
end

std["|"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, ((s[2] == 1) or (s[1] == 1)) and 1 or 0)
end

std["^"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, ((s[2] == 1) and (s[1] == 0) or (s[2] == 0) and (s[1] == 1)) and 1 or 0)
end

std["~"] = function(stack)
    local a = table.remove(stack)
    table.insert(stack, (a == 0) and 1 or 0)
end

std["?"] = function(stack)
    local s = pop(stack, 2)

    if s[2] ~= 0 then
        table.insert(stack, s[1])
    end
end

std["??"] = function(stack)
    local s = pop(stack, 3)

    local block = (s[3] ~= 0) and s[2] or s[1]
    table.insert(stack, block)
end

std["->"] = function(stack, call_stack, dict)
    local a = table.remove(stack)
    if dict[a] then
        call_stack[#call_stack] = { tokens = dict[a], ip = 1 }
    end
end

std[".."] = function(stack)
    local a = stack[#stack]
    if a then
        table.insert(stack, a)
    end
end

std["!"] = function(stack)
    table.remove(stack)
end

std["%"] = function(stack)
    local s = pop(stack, 2)
    table.insert(stack, s[1])
    table.insert(stack, s[2])
end

return std
