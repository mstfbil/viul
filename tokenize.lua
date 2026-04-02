local TOKEN_TYPE = require("TOKEN_TYPE")

---tokenizes the input viul code
---@param source string
local function tokenize(source)
    local i = 1
    local tokens = {}

    while i <= #source do
        -- skip whitespace
        do
            local s, e = source:find("^%s+", i)
            if s then
                i = e + 1
                if i > #source then break end
            end
        end

        local char = source:sub(i, i)
        local token_value, token_type

        if char == "\"" then
            local next_quote_index = source:find("\"", i + 1)
            token_value = source:sub(i + 1, next_quote_index - 1)
            token_type = TOKEN_TYPE.TEXT
            i = next_quote_index + 1
        elseif char == "(" then
            local paran_close_index = source:find(")", i + 1)
            i = paran_close_index + 1
        elseif char == "{" then
            local brace_close_index = source:find("}", i + 1)
            local block_source = source:sub(i + 1, brace_close_index - 1)
            token_value = tokenize(block_source)
            token_type = TOKEN_TYPE.BLOCK
            i = brace_close_index + 1
        elseif char == ":" then
            token_value = ":"
            token_type = TOKEN_TYPE.PROCEDURE_MARKER
            i = i + 1
        elseif char == ";" then
            token_value = ";"
            token_type = TOKEN_TYPE.EXECUTE
            i = i + 1
        else
            local next_break = source:find("[%s:;\"]", i) or (#source + 1)
            token_value = source:sub(i, next_break - 1)

            if tonumber(token_value) then
                token_value = tonumber(token_value)
                token_type = TOKEN_TYPE.NUMBER
            else
                token_type = TOKEN_TYPE.IDENTIFIER
            end

            i = next_break
        end

        if token_type then
            table.insert(tokens, { type = token_type, value = token_value })
        end
    end

    return tokens
end

return tokenize
