local TOKEN_TYPE = require("TOKEN_TYPE")

---parses the tokens
---@param tokens {type: number, value: string|number}[]
local parse = function(tokens)
    local dictionary = { main = {} }
    local cur_procedure = dictionary["main"]
    local markers = {}
    local i = 1
    while i <= #tokens do
        local cur_token = tokens[i]
        local next_token = tokens[i + 1]

        if cur_token.type == TOKEN_TYPE.IDENTIFIER and next_token and next_token.type == TOKEN_TYPE.PROCEDURE_MARKER then
            local new_procedure = {}
            dictionary[cur_token.value] = new_procedure
            cur_procedure = new_procedure
            i = i + 2
        elseif cur_token.type == TOKEN_TYPE.MARKER then
            local marker_location = #cur_procedure + 1
            table.insert(markers, { procedure = cur_procedure, location = marker_location })
            i = i + 1
        else
            table.insert(cur_procedure, cur_token)
            i = i + 1
        end
    end

    return dictionary, markers
end

return parse
