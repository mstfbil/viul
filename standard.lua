-- viul standard vocabulary

local std = {}

local function popTwo(stack)
    local b = table.remove(stack)
    local a = table.remove(stack)
    return a, b
end

std["+"] = function(stack)
    local a, b = popTwo(stack)
    table.insert(stack, a + b)
end

std["-"] = function(stack)
    local a, b = popTwo(stack)
    table.insert(stack, a - b)
end

std["*"] = function(stack)
    local a, b = popTwo(stack)
    table.insert(stack, a * b)
end

std["/"] = function(stack)
    local a, b = popTwo(stack)
    table.insert(stack, a / b)
end

std["."] = function(stack)
    print(table.remove(stack))
end

std["="] = function(stack)
    local a, b = popTwo(stack)
    table.insert(stack, (a == b) and 1 or 0)
end

std["<"] = function(stack)
    local a, b = popTwo(stack)
    table.insert(stack, (a < b) and 1 or 0)
end

std[">"] = function(stack)
    local a, b = popTwo(stack)
    table.insert(stack, (a > b) and 1 or 0)
end

std["~"] = function(stack)
    local a = table.remove(stack)
    table.insert(stack, (a == 0) and 1 or 0)
end

std["?"] = function(stack, call_stack)
    local condition, block = popTwo(stack)

    if condition ~= 0 then
        table.insert(stack, block)
    end
end

std["??"] = function(stack, call_stack)
    local false_block = table.remove(stack)
    local true_block = table.remove(stack)
    local condition = table.remove(stack)

    local block = (condition ~= 0) and true_block or false_block
    table.insert(stack, block)
end

std[".."] = function(stack)
    local a = stack[#stack]
    if a then
        table.insert(stack, a)
    end
end

return std
