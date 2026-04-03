local TOKEN_TYPE = require("TOKEN_TYPE")
local std = require("standard")

---dispatches from the dict
---@param dict {[string]: {type: number, value: string|number}[]}
local dispatch = function(dict, entry, data_stack)
    if not dict[entry] then
        return
    end

    local call_stack = {
        { tokens = dict[entry], ip = 1 }
    }
    local data_stack = {}

    while #call_stack > 0 do
        local cur_frame = call_stack[#call_stack]
        local cur_token = cur_frame.tokens[cur_frame.ip]

        cur_frame.ip = cur_frame.ip + 1

        if not cur_token then
            table.remove(call_stack)
            goto continue
        end

        if cur_token.type == TOKEN_TYPE.NUMBER or cur_token.type == TOKEN_TYPE.TEXT or cur_token.type == TOKEN_TYPE.BLOCK then
            table.insert(data_stack, cur_token.value)
        elseif cur_token.type == TOKEN_TYPE.IDENTIFIER then
            local identifier = cur_token.value
            if std[identifier] then
                std[identifier](data_stack, call_stack, dict)
            else
                table.insert(data_stack, identifier)
            end
        elseif cur_token.type == TOKEN_TYPE.EXECUTE then
            local identifier = table.remove(data_stack)
            if type(identifier) == "table" then
                table.insert(call_stack, { tokens = identifier, ip = 1 })
            elseif dict[identifier] then
                table.insert(call_stack, { tokens = dict[identifier], ip = 1 })
            end
        end

        ::continue::
    end
end

return dispatch
