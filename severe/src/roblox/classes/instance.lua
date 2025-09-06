---- environment ---

local merge = require("@external/functions/merge")

---- functions ----

local function normalize(key: string)
    return string.lower(key):gsub("_", "")
end

---- module ----

local Instance = {}; do
    --- constants ---

    local declarations = { global = {} }

    --- constructor ---

    local function constructor(userdata: any)
        -- assertions --

        userdata = "userdata" == type(userdata) and userdata or "table" == type(userdata) and rawget(userdata, "Data")
        assert("userdata" == type(userdata), `Instance.new: userdata must be a userdata, got {type(userdata)}`)

        -- exports --

        return setmetatable( { ClassName = getclassname(userdata), Data = userdata }, { __index = Instance.__index, __newindex = Instance.__newindex } )
    end

    --- functions ---

    Instance.new = constructor

    function Instance.declare<T>(value: "property" | "method", class: string | { string }, name: string, definition: T | (self: typeof(Instance)) -> any)
        -- assertions --
        
        assert("string" == type(name), `Instance.declare: name must be a string, got {type(name)}`)
        assert("property" == value or "method" == value, `Instance.declare: value must be "property" or "method", got {value}`)
        assert("table" == type(class) or "string" == type(class), `Instance.declare: class must be a string or a table of strings, got {type(class)}`)

        -- declaration --

        local normalized = normalize(name)
        if "string" == type(class) then
            declarations[class] = merge(declarations[class], {
                [normalized] = {
                    [value] = definition
                }
            })
        else
            for index, class in class do
                declarations[class] = merge(declarations[class], {
                    [normalized] = {
                        [value] = definition
                    }
                })
            end
        end
    end

    --- metatables ---

    function Instance:__index(key: string)
        -- assertions --

        assert("string" == type(key), `Instance:__index: key must be a string, got {type(key)}`)

        -- exports --
        
        do
            local normalized = normalize(key)

            local class = self.ClassName
            local declaration = declarations.global[normalized] or (declarations[class] and declarations[class][normalized])

            if declaration then
                local property = declaration.property
                local method = declaration.method

                if property and property.getter then
                    return property.getter(self)
                elseif method then
                    return method
                end
            end
        end

        return rawget(self, key) or rawget(self, "Data") and
            self:FindFirstChild(key) or
            Instance[key]
    end

    function Instance:__newindex(key: string, value: any)
        -- assertions --

        assert("string" == type(key), `Instance:__newindex: key must be a string, got {type(key)}`)

        -- exports --

        do
            key = string.lower(key)

            local class = self.ClassName
            local declaration = declarations.global[key] or (declarations[class] and declarations[class][key])

            if declaration and declaration.property and declaration.property.setter then
                return declaration.property.setter(self, value)
            end
        end

        return rawset(self, key, value)
    end
end

---- exports ----

return Instance