local TOKEN_TYPE = require("TOKEN_TYPE")

---dispatches from the dict
---@param dict {[string]: {type: number, value: string|number}[]}
local dispatch = function(dict, entry)
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

        if not cur_token then
            table.remove(call_stack)
            goto continue
        end

        if cur_token.type == TOKEN_TYPE.NUMBER or cur_token.type == TOKEN_TYPE.TEXT then
            table.insert(data_stack, cur_token.value)
        elseif cur_token.type == TOKEN_TYPE.IDENTIFIER then
            if dict[cur_token.value] then
                table.insert(data_stack, cur_token.value)
            end
        end

        cur_frame.ip = cur_frame.ip + 1

        ::continue::
    end
end

return dispatch
