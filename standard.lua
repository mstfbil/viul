-- viul standard vocabulary

local std = {}

std["+"] = function(stack)
    local b = table.remove(stack)
    local a = table.remove(stack)
    table.insert(stack, a + b)
end

std["-"] = function(stack)
    local b = table.remove(stack)
    local a = table.remove(stack)
    table.insert(stack, a - b)
end

std["*"] = function(stack)
    local b = table.remove(stack)
    local a = table.remove(stack)
    table.insert(stack, a * b)
end

std["/"] = function(stack)
    local b = table.remove(stack)
    local a = table.remove(stack)
    table.insert(stack, a / b)
end

std[">"] = function(stack)
    print(table.remove(stack))
end

std[".."] = function(stack)
    local a = stack[#stack]
    if a then
        table.insert(stack, a)
    end
end

return std
