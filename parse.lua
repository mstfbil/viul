local TOKEN_TYPE = require("TOKEN_TYPE")

local type_name = {}
for key, value in pairs(TOKEN_TYPE) do
    type_name[value] = key
end

---parses the tokens
---@param tokens {type: number, value: string}[]
local parse = function(tokens)
    local dictionary = {}
    local cur_procedure
    local i = 1
    while i <= #tokens do
        local cur_token = tokens[i]
        local next_token = tokens[i + 1]

        if cur_token.type == TOKEN_TYPE.IDENTIFIER and next_token and next_token.type == TOKEN_TYPE.PROCEDURE_MARKER then
            local new_procedure = {}
            dictionary[cur_token.value] = new_procedure
            cur_procedure = new_procedure
            i = i + 2
        else
            table.insert(cur_procedure, cur_token)
            i = i + 1
        end
    end

    return dictionary
end

return parse
