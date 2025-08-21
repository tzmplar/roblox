local Color3 = {} do
    --- constructor ---

    local function constructor(red: number, green: number, blue: number)
        assert("number" == type(red),   `Color3.new: red must be a number, got {type(red)}`)
        assert("number" == type(green), `Color3.new: green must be a number, got {type(green)}`)
        assert("number" == type(blue),  `Color3.new: blue must be a number, got {type(blue)}`)
    
        return setmetatable( {
            red, green, blue
        }, { __index = Color3.__index, __tostring = Color3.__tostring } )
    end

    --- methods ---

    function Color3:toHSV()
        -- constants --

        local r, g, b = self[1] / 255, self[2] / 255, self[3] / 255
        local max, min = math.max(r, g, b), math.min(r, g, b)
        local h, s, v
        
        v = max

        -- conversion --
        
        local delta = max - min
        if max ~= 0 then
            s = delta / max
        else
            s = 0
            h = 0
            return h, s, v
        end

        -- hue --
        
        if r == max then
            h = (g - b) / delta
        elseif g == max then
            h = 2 + (b - r) / delta
        else
            h = 4 + (r - g) / delta
        end
        
        h = h * 60
        if h < 0 then
            h = h + 360
        end

        -- exports --
        
        return h, s, v
    end

    function Color3:toHex()
        -- constants --

        local r = string.format("%02X", math.floor(self[1]))
        local g = string.format("%02X", math.floor(self[2]))
        local b = string.format("%02X", math.floor(self[3]))

        -- exports --
        
        return `{r}{g}{b}`
    end

    --- functions ---
    
    function Color3.new(red: number, green: number, blue: number): Color3
        assert("number" == type(red),   `Color3.new: red must be a number, got {type(red)}`)
        assert("number" == type(green), `Color3.new: green must be a number, got {type(green)}`)
        assert("number" == type(blue),  `Color3.new: blue must be a number, got {type(blue)}`)

        -- exports --

        return constructor(red * 255, green * 255, blue * 255)
    end

    function Color3.fromRGB(red: number, green: number, blue: number): Color3
        assert("number" == type(red),   `Color3.fromRGB: red must be a number, got {type(red)}`)
        assert("number" == type(green), `Color3.fromRGB: green must be a number, got {type(green)}`)
        assert("number" == type(blue),  `Color3.fromRGB: blue must be a number, got {type(blue)}`)

        -- exports --

        return constructor(red, green, blue)
    end

    do
        local fromRGB = Color3.fromRGB

        function Color3.fromHex(data: string)
            assert("string" == type(data), `Color3.fromHex: data must be a string, got {type(data)}`)

            -- constants --

            local red   = tonumber(data:sub(1, 2), 16)
            local green = tonumber(data:sub(3, 4), 16)
            local blue  = tonumber(data:sub(5, 6), 16)

            -- exports --

            return fromRGB(red, green, blue)
        end

        function Color3.fromHSV(H, S, V)
            assert(type(H) == "number" and type(S) == "number" and type(V) == "number", "HSV values must be numbers")

            -- constants --

            H = math.clamp(H, 0, 360)
            S = math.clamp(S, 0, 1)
            V = math.clamp(V, 0, 1)

            -- conversion --

            local C = V * S
            local X = C * (1 - math.abs((H / 60) % 2 - 1))
            local m = V - C

            -- hue --

            local r, g, b
            if H < 60 then
                r, g, b = C, X, 0
            elseif H < 120 then
                r, g, b = X, C, 0
            elseif H < 180 then
                r, g, b = 0, C, X
            elseif H < 240 then
                r, g, b = 0, X, C
            elseif H < 300 then
                r, g, b = X, 0, C
            else
                r, g, b = C, 0, X
            end

            -- exports --

            return fromRGB(math.floor((r + m) * 255), math.floor((g + m) * 255), math.floor((b + m) * 255))
        end
    end

    function Color3.buffer(value: buffer | typeof(Color3))
        -- assertions --

        assert("buffer" == type(value) or "table" == type(value), `Color3.buffer: value must be a buffer or Color3, got {type(value)}`)

        -- exports --

        if "buffer" == type(value) then
            local red   = buffer.readi8(value, 0)
            local green = buffer.readi8(value, 1)
            local blue  = buffer.readi16(value, 2)

            return Color3.fromRGB(red, green, blue)
        else
            local data = buffer.create(8)

            buffer.writei8(data, 0, value[1])
            buffer.writei8(data, 1, value[2])
            buffer.writei16(data, 2, value[3])

            return data
        end
    end

    function Color3.dword(value: number | typeof(Color3))
        -- assertions --

        assert("number" == type(value) or "table" == type(value), `Color3.dword: value must be a number or Color3, got {type(value)}`)

        -- exports --

        if "number" == type(value) then
            return Color3.fromRGB(bit32.band(value, 0xFF), bit32.band(bit32.rshift(value, 8), 0xFF), bit32.band(bit32.rshift(value, 16), 0xFF))
        else
            return bit32.bor(value[1], bit32.lshift(value[2], 8), bit32.lshift(value[3], 16))
        end
    end

    --- metatables ---

    function Color3:__index(key: string)
        if key:lower() == "r" then
            return self[1]
        elseif key:lower() == "g" then
            return self[2]
        elseif key:lower() == "b" then
            return self[3]
        end

        -- exports --

        return rawget(self, key) or Color3[key]
    end

    function Color3:__newindex(key: string, value: any)
        if key:lower() == "r" then
            self[1] = value
        elseif key:lower() == "g" then
            self[2] = value
        elseif key:lower() == "b" then
            self[3] = value
        else
            rawset(self, key, value)
        end
    end

    function Color3:__eq(other) return self[1] == other[1] and self[2] == other[2] and self[3] == other[3] end
    function Color3:__tostring() return `Color3.fromRGB({self[1]}, {self[2]}, {self[3]})` end
end

local BrickColor = {
    Palette = {
        [1032] = { Name = "Hot pink", Color = Color3.fromRGB(255, 0, 191) },
        [1031] = { Name = "Royal purple", Color = Color3.fromRGB(98, 37, 209) },
        [1030] = { Name = "Pastel brown", Color = Color3.fromRGB(255, 204, 153) },
        [1029] = { Name = "Pastel yellow", Color = Color3.fromRGB(255, 255, 204) },
        [1028] = { Name = "Pastel green", Color = Color3.fromRGB(204, 255, 204) },
        [1027] = { Name = "Pastel blue-green", Color = Color3.fromRGB(159, 243, 233) },
        [1026] = { Name = "Pastel violet", Color = Color3.fromRGB(177, 167, 255) },
        [1025] = { Name = "Pastel orange", Color = Color3.fromRGB(255, 201, 201) },
        [1024] = { Name = "Pastel light blue", Color = Color3.fromRGB(175, 221, 255) },
        [1023] = { Name = "Lavender", Color = Color3.fromRGB(140, 91, 159) },
        [1022] = { Name = "Grime", Color = Color3.fromRGB(127, 142, 100) },
        [1021] = { Name = "Camo", Color = Color3.fromRGB(58, 125, 21) },
        [1020] = { Name = "Lime green", Color = Color3.fromRGB(0, 255, 0) },
        [1019] = { Name = "Toothpaste", Color = Color3.fromRGB(0, 255, 255) },
        [1018] = { Name = "Teal", Color = Color3.fromRGB(18, 238, 212) },
        [1017] = { Name = "Deep orange", Color = Color3.fromRGB(255, 175, 0) },
        [1016] = { Name = "Pink", Color = Color3.fromRGB(255, 102, 204) },
        [1015] = { Name = "Magenta", Color = Color3.fromRGB(170, 0, 170) },
        [1014] = { Name = "CGA brown", Color = Color3.fromRGB(170, 85, 0) },
        [1013] = { Name = "Cyan", Color = Color3.fromRGB(4, 175, 236) },
        [1012] = { Name = "Deep blue", Color = Color3.fromRGB(33, 84, 185) },
        [1011] = { Name = "Navy blue", Color = Color3.fromRGB(0, 32, 96) },
        [1010] = { Name = "Really blue", Color = Color3.fromRGB(0, 0, 255) },
        [1009] = { Name = "New Yeller", Color = Color3.fromRGB(255, 255, 0) },
        [1008] = { Name = "Olive", Color = Color3.fromRGB(193, 190, 66) },
        [1007] = { Name = "Dusty Rose", Color = Color3.fromRGB(163, 75, 75) },
        [1006] = { Name = "Alder", Color = Color3.fromRGB(180, 128, 255) },
        [1005] = { Name = "Deep orange", Color = Color3.fromRGB(255, 176, 0) },
        [1004] = { Name = "Really red", Color = Color3.fromRGB(255, 0, 0) },
        [1003] = { Name = "Really black", Color = Color3.fromRGB(17, 17, 17) },
        [1002] = { Name = "Mid gray", Color = Color3.fromRGB(205, 205, 205) },
        [1001] = { Name = "Institutional white", Color = Color3.fromRGB(248, 248, 248) },
        [365] = { Name = "Burnt Sienna", Color = Color3.fromRGB(106, 57, 9) },
        [364] = { Name = "Dark taupe", Color = Color3.fromRGB(90, 76, 66) },
        [363] = { Name = "Flint", Color = Color3.fromRGB(105, 102, 92) },
        [362] = { Name = "Bronze", Color = Color3.fromRGB(126, 104, 63) },
        [361] = { Name = "Medium brown", Color = Color3.fromRGB(86, 66, 54) },
        [360] = { Name = "Copper", Color = Color3.fromRGB(150, 103, 102) },
        [359] = { Name = "Linen", Color = Color3.fromRGB(175, 148, 131) },
        [358] = { Name = "Cloudy grey", Color = Color3.fromRGB(171, 168, 158) },
        [357] = { Name = "Hurricane grey", Color = Color3.fromRGB(149, 137, 136) },
        [356] = { Name = "Fawn brown", Color = Color3.fromRGB(160, 132, 79) },
        [355] = { Name = "Pine Cone", Color = Color3.fromRGB(108, 88, 75) },
        [354] = { Name = "Oyster", Color = Color3.fromRGB(187, 179, 178) },
        [353] = { Name = "Beige", Color = Color3.fromRGB(202, 191, 163) },
        [352] = { Name = "Burlap", Color = Color3.fromRGB(199, 172, 120) },
        [351] = { Name = "Cork", Color = Color3.fromRGB(188, 155, 93) },
        [350] = { Name = "Burgundy", Color = Color3.fromRGB(136, 62, 62) },
        [349] = { Name = "Seashell", Color = Color3.fromRGB(233, 218, 218) },
        [348] = { Name = "Lily white", Color = Color3.fromRGB(237, 234, 234) },
        [347] = { Name = "Khaki", Color = Color3.fromRGB(226, 220, 188) },
        [346] = { Name = "Cashmere", Color = Color3.fromRGB(211, 190, 150) },
        [345] = { Name = "Rust", Color = Color3.fromRGB(143, 76, 42) },
        [344] = { Name = "Tawny", Color = Color3.fromRGB(150, 85, 85) },
        [343] = { Name = "Sunrise", Color = Color3.fromRGB(212, 144, 189) },
        [342] = { Name = "Mauve", Color = Color3.fromRGB(224, 178, 208) },
        [341] = { Name = "Buttermilk", Color = Color3.fromRGB(254, 243, 187) },
        [340] = { Name = "Wheat", Color = Color3.fromRGB(241, 231, 199) },
        [339] = { Name = "Cocoa", Color = Color3.fromRGB(86, 36, 36) },
        [338] = { Name = "Terra Cotta", Color = Color3.fromRGB(190, 104, 98) },
        [337] = { Name = "Salmon", Color = Color3.fromRGB(255, 148, 148) },
        [336] = { Name = "Fog", Color = Color3.fromRGB(199, 212, 228) },
        [335] = { Name = "Pearl", Color = Color3.fromRGB(231, 231, 236) },
        [334] = { Name = "Daisy orange", Color = Color3.fromRGB(248, 217, 109) },
        [333] = { Name = "Gold", Color = Color3.fromRGB(239, 184, 56) },
        [332] = { Name = "Maroon", Color = Color3.fromRGB(117, 0, 0) },
        [331] = { Name = "Persimmon", Color = Color3.fromRGB(255, 89, 89) },
        [330] = { Name = "Carnation pink", Color = Color3.fromRGB(255, 152, 220) },
        [329] = { Name = "Baby blue", Color = Color3.fromRGB(152, 194, 219) },
        [328] = { Name = "Mint", Color = Color3.fromRGB(177, 229, 166) },
        [327] = { Name = "Crimson", Color = Color3.fromRGB(151, 0, 0) },
        [325] = { Name = "Quill grey", Color = Color3.fromRGB(223, 223, 222) },
        [324] = { Name = "Laurel green", Color = Color3.fromRGB(168, 189, 153) },
        [323] = { Name = "Olivine", Color = Color3.fromRGB(148, 190, 129) },
        [322] = { Name = "Plum", Color = Color3.fromRGB(123, 47, 123) },
        [321] = { Name = "Lilac", Color = Color3.fromRGB(167, 94, 155) },
        [320] = { Name = "Ghost grey", Color = Color3.fromRGB(202, 203, 209) },
        [319] = { Name = "Sage green", Color = Color3.fromRGB(185, 196, 177) },
        [318] = { Name = "Artichoke", Color = Color3.fromRGB(138, 171, 133) },
        [317] = { Name = "Moss", Color = Color3.fromRGB(124, 156, 107) },
        [316] = { Name = "Eggplant", Color = Color3.fromRGB(123, 0, 123) },
        [315] = { Name = "Electric blue", Color = Color3.fromRGB(9, 137, 207) },
        [314] = { Name = "Cadet blue", Color = Color3.fromRGB(159, 173, 192) },
        [313] = { Name = "Forest green", Color = Color3.fromRGB(31, 128, 29) },
        [312] = { Name = "Mulberry", Color = Color3.fromRGB(89, 34, 89) },
        [311] = { Name = "Fossil", Color = Color3.fromRGB(159, 161, 172) },
        [310] = { Name = "Shamrock", Color = Color3.fromRGB(91, 154, 76) },
        [309] = { Name = "Sea green", Color = Color3.fromRGB(52, 142, 64) },
        [308] = { Name = "Dark indigo", Color = Color3.fromRGB(61, 21, 133) },
        [307] = { Name = "Lapis", Color = Color3.fromRGB(16, 42, 220) },
        [306] = { Name = "Storm blue", Color = Color3.fromRGB(51, 88, 130) },
        [305] = { Name = "Steel blue", Color = Color3.fromRGB(82, 124, 174) },
        [304] = { Name = "Parsley green", Color = Color3.fromRGB(44, 101, 29) },
        [303] = { Name = "Dark blue", Color = Color3.fromRGB(0, 16, 176) },
        [302] = { Name = "Smoky grey", Color = Color3.fromRGB(91, 93, 105) },
        [301] = { Name = "Slime green", Color = Color3.fromRGB(80, 109, 84) },
        [268] = { Name = "Medium lilac", Color = Color3.fromRGB(52, 43, 117) },
        [232] = { Name = "Dove blue", Color = Color3.fromRGB(125, 187, 221) },
        [226] = { Name = "Cool yellow", Color = Color3.fromRGB(253, 234, 141) },
        [225] = { Name = "Warm yellowish orange", Color = Color3.fromRGB(235, 184, 127) },
        [224] = { Name = "Light brick yellow", Color = Color3.fromRGB(240, 213, 160) },
        [223] = { Name = "Light pink", Color = Color3.fromRGB(220, 144, 149) },
        [222] = { Name = "Light purple", Color = Color3.fromRGB(228, 173, 200) },
        [221] = { Name = "Bright purple", Color = Color3.fromRGB(205, 98, 152) },
        [220] = { Name = "Light lilac", Color = Color3.fromRGB(167, 169, 206) },
        [219] = { Name = "Lilac", Color = Color3.fromRGB(107, 98, 155) },
        [218] = { Name = "Reddish lilac", Color = Color3.fromRGB(150, 112, 159) },
        [217] = { Name = "Brown", Color = Color3.fromRGB(124, 92, 70) },
        [216] = { Name = "Rust", Color = Color3.fromRGB(144, 76, 42) },
        [213] = { Name = "Medium Royal blue", Color = Color3.fromRGB(108, 129, 183) },
        [212] = { Name = "Light Royal blue", Color = Color3.fromRGB(159, 195, 233) },
        [211] = { Name = "Turquoise", Color = Color3.fromRGB(121, 181, 181) },
        [210] = { Name = "Faded green", Color = Color3.fromRGB(112, 149, 120) },
        [209] = { Name = "Dark Curry", Color = Color3.fromRGB(176, 142, 68) },
        [208] = { Name = "Light stone grey", Color = Color3.fromRGB(229, 228, 223) },
        [200] = { Name = "Lemon metalic", Color = Color3.fromRGB(130, 138, 93) },
        [199] = { Name = "Dark stone grey", Color = Color3.fromRGB(99, 95, 98) },
        [198] = { Name = "Bright reddish lilac", Color = Color3.fromRGB(142, 66, 133) },
        [196] = { Name = "Dark Royal blue", Color = Color3.fromRGB(35, 71, 139) },
        [195] = { Name = "Royal blue", Color = Color3.fromRGB(70, 103, 164) },
        [193] = { Name = "Flame reddish orange", Color = Color3.fromRGB(207, 96, 36) },
        [192] = { Name = "Reddish brown", Color = Color3.fromRGB(105, 64, 40) },
        [191] = { Name = "Flame yellowish orange", Color = Color3.fromRGB(232, 171, 45) },
        [190] = { Name = "Fire Yellow", Color = Color3.fromRGB(249, 214, 46) },
        [180] = { Name = "Curry", Color = Color3.fromRGB(215, 169, 75) },
        [179] = { Name = "Silver flip/flop", Color = Color3.fromRGB(137, 135, 136) },
        [178] = { Name = "Yellow flip/flop", Color = Color3.fromRGB(180, 132, 85) },
        [176] = { Name = "Red flip/flop", Color = Color3.fromRGB(151, 105, 91) },
        [168] = { Name = "Gun metallic", Color = Color3.fromRGB(117, 108, 98) },
        [158] = { Name = "Tr. Flu. Red", Color = Color3.fromRGB(225, 164, 194) },
        [157] = { Name = "Tr. Flu. Yellow", Color = Color3.fromRGB(255, 246, 123) },
        [154] = { Name = "Dark red", Color = Color3.fromRGB(123, 46, 47) },
        [153] = { Name = "Sand red", Color = Color3.fromRGB(149, 121, 119) },
        [151] = { Name = "Sand green", Color = Color3.fromRGB(120, 144, 130) },
        [150] = { Name = "Light grey metallic", Color = Color3.fromRGB(171, 173, 172) },
        [149] = { Name = "Black metallic", Color = Color3.fromRGB(22, 29, 50) },
        [148] = { Name = "Dark grey metallic", Color = Color3.fromRGB(87, 88, 87) },
        [147] = { Name = "Sand yellow metallic", Color = Color3.fromRGB(147, 135, 103) },
        [146] = { Name = "Sand violet metallic", Color = Color3.fromRGB(149, 142, 163) },
        [145] = { Name = "Sand blue metallic", Color = Color3.fromRGB(121, 136, 161) },
        [143] = { Name = "Tr. Flu. Blue", Color = Color3.fromRGB(207, 226, 247) },
        [141] = { Name = "Earth green", Color = Color3.fromRGB(39, 70, 45) },
        [140] = { Name = "Earth blue", Color = Color3.fromRGB(32, 58, 86) },
        [138] = { Name = "Sand yellow", Color = Color3.fromRGB(149, 138, 115) },
        [137] = { Name = "Medium orange", Color = Color3.fromRGB(224, 152, 100) },
        [136] = { Name = "Sand violet", Color = Color3.fromRGB(135, 124, 144) },
        [135] = { Name = "Sand blue", Color = Color3.fromRGB(116, 134, 157) },
        [134] = { Name = "Neon green", Color = Color3.fromRGB(216, 221, 86) },
        [133] = { Name = "Neon orange", Color = Color3.fromRGB(213, 115, 61) },
        [131] = { Name = "Silver", Color = Color3.fromRGB(156, 163, 168) },
        [128] = { Name = "Dark nougat", Color = Color3.fromRGB(174, 122, 89) },
        [127] = { Name = "Gold", Color = Color3.fromRGB(220, 188, 129) },
        [126] = { Name = "Tr. Bright bluish violet", Color = Color3.fromRGB(165, 165, 203) },
        [125] = { Name = "Light orange", Color = Color3.fromRGB(234, 184, 146) },
        [124] = { Name = "Bright reddish violet", Color = Color3.fromRGB(146, 57, 120) },
        [123] = { Name = "Br. reddish orange", Color = Color3.fromRGB(211, 111, 76) },
        [121] = { Name = "Med. yellowish orange", Color = Color3.fromRGB(231, 172, 88) },
        [120] = { Name = "Lig. yellowish green", Color = Color3.fromRGB(217, 228, 167) },
        [119] = { Name = "Br. yellowish green", Color = Color3.fromRGB(164, 189, 71) },
        [118] = { Name = "Light bluish green", Color = Color3.fromRGB(183, 215, 213) },
        [116] = { Name = "Med. bluish green", Color = Color3.fromRGB(85, 165, 175) },
        [115] = { Name = "Med. yellowish green", Color = Color3.fromRGB(199, 210, 60) },
        [113] = { Name = "Tr. Medi. reddish violet", Color = Color3.fromRGB(229, 173, 200) },
        [112] = { Name = "Medium bluish violet", Color = Color3.fromRGB(104, 116, 172) },
        [111] = { Name = "Tr. Brown", Color = Color3.fromRGB(191, 183, 177) },
        [110] = { Name = "Bright bluish violet", Color = Color3.fromRGB(67, 84, 147) },
        [108] = { Name = "Earth yellow", Color = Color3.fromRGB(104, 92, 67) },
        [107] = { Name = "Bright bluish green", Color = Color3.fromRGB(0, 143, 156) },
        [106] = { Name = "Bright orange", Color = Color3.fromRGB(218, 133, 65) },
        [105] = { Name = "Br. yellowish orange", Color = Color3.fromRGB(226, 155, 64) },
        [104] = { Name = "Bright violet", Color = Color3.fromRGB(107, 50, 124) },
        [103] = { Name = "Light grey", Color = Color3.fromRGB(199, 193, 183) },
        [102] = { Name = "Medium blue", Color = Color3.fromRGB(110, 153, 202) },
        [101] = { Name = "Medium red", Color = Color3.fromRGB(218, 134, 122) },
        [100] = { Name = "Light red", Color = Color3.fromRGB(238, 196, 182) },
        [50] = { Name = "Phosph. White", Color = Color3.fromRGB(236, 232, 222) },
        [49] = { Name = "Tr. Flu. Green", Color = Color3.fromRGB(248, 241, 132) },
        [48] = { Name = "Tr. Green", Color = Color3.fromRGB(132, 182, 141) },
        [47] = { Name = "Tr. Flu. Reddish orange", Color = Color3.fromRGB(217, 133, 108) },
        [45] = { Name = "Light blue", Color = Color3.fromRGB(180, 210, 228) },
        [44] = { Name = "Tr. Yellow", Color = Color3.fromRGB(247, 241, 141) },
        [43] = { Name = "Tr. Blue", Color = Color3.fromRGB(123, 182, 232) },
        [42] = { Name = "Tr. Lg blue", Color = Color3.fromRGB(193, 223, 240) },
        [41] = { Name = "Tr. Red", Color = Color3.fromRGB(205, 84, 75) },
        [40] = { Name = "Transparent", Color = Color3.fromRGB(236, 236, 236) },
        [39] = { Name = "Light bluish violet", Color = Color3.fromRGB(193, 202, 222) },
        [38] = { Name = "Dark orange", Color = Color3.fromRGB(160, 95, 53) },
        [37] = { Name = "Bright green", Color = Color3.fromRGB(75, 151, 75) },
        [36] = { Name = "Lig. Yellowich orange", Color = Color3.fromRGB(243, 207, 155) },
        [29] = { Name = "Medium green", Color = Color3.fromRGB(161, 196, 140) },
        [28] = { Name = "Dark green", Color = Color3.fromRGB(40, 127, 71) },
        [27] = { Name = "Dark grey", Color = Color3.fromRGB(109, 110, 108) },
        [26] = { Name = "Black", Color = Color3.fromRGB(27, 42, 53) },
        [25] = { Name = "Earth orange", Color = Color3.fromRGB(98, 71, 50) },
        [24] = { Name = "Bright yellow", Color = Color3.fromRGB(245, 205, 48) },
        [23] = { Name = "Bright blue", Color = Color3.fromRGB(13, 105, 172) },
        [22] = { Name = "Med. reddish violet", Color = Color3.fromRGB(196, 112, 160) },
        [21] = { Name = "Bright red", Color = Color3.fromRGB(196, 40, 28) },
        [18] = { Name = "Nougat", Color = Color3.fromRGB(204, 142, 105) },
        [12] = { Name = "Light orange brown", Color = Color3.fromRGB(203, 132, 66) },
        [11] = { Name = "Pastel Blue", Color = Color3.fromRGB(128, 187, 219) },
        [9] = { Name = "Light reddish violet", Color = Color3.fromRGB(232, 186, 200) },
        [6] = { Name = "Light green (Mint)", Color = Color3.fromRGB(194, 218, 184) },
        [5] = { Name = "Brick yellow", Color = Color3.fromRGB(215, 197, 154) },
        [4] = { Name = "Medium stone grey", Color = Color3.fromRGB(163, 162, 165) },
        [3] = { Name = "Light yellow", Color = Color3.fromRGB(249, 233, 153) },
        [2] = { Name = "Grey", Color = Color3.fromRGB(161, 165, 162) },
        [1] = { Name = "White", Color = Color3.fromRGB(242, 243, 243) }
    }
} do
    local Lookup = {} do for Index, Object in pairs(BrickColor.Palette) do Lookup[Object.Name:lower()] = Index end end
    local Indices = {} do for Index in BrickColor.Palette do table.insert(Indices, Index) end end

    function BrickColor.new(Argument)
        local This = setmetatable({}, BrickColor)

        if type(Argument) == "number" then
            local Object = BrickColor.Palette[Argument] or BrickColor.Palette[4]

            This.Name = Object.Name
            This.Color = Object.Color
            This.Index = Argument
        elseif type(Argument) == "string" then
            local Index = Lookup[Argument:lower()]

            if Index then
                local Object = BrickColor.Palette[Index]

                This.Index = Index
                This.Color = Object.Color
                This.Name = Object.Name
            else
                error(`invalid BrickColor: {Argument}`)
            end
        elseif type(Argument) == "table" then
            if not Argument[1] or not Argument[2] or not Argument[3] then
                error(`BrickColor.new: can't initialize BrickColor, invalid Color3`)
            end

            local Closest, Distance = nil, math.huge

            for Index, Object in BrickColor.Palette do
                local Magnitude = Object.Color:distance(Argument)

                if Distance > Magnitude then
                    Closest = Object
                    Distance = Magnitude
                end
            end

            return BrickColor.new(Closest.Name)
        end

        return This
    end

    function BrickColor.random()
        return BrickColor.new(Indices[math.random(1, #Indices)])
    end

    function BrickColor.__tostring(This)
        return This.Name
    end

    BrickColor.__index = BrickColor
end

_G.BrickColor = BrickColor
return Color3