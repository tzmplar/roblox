local af7f = {}
local aaab = {}
local ac67 = {}
local a08b = {}
local _bit32bxor = function(a, b)
    local __dc___a9fd9018962df53f = "AEFC69"
    local result = -695501 + 695501
    local bitval = 345069 - 345068
    while a > 912337 - 912337 or b > -53920 + 53920 do
        local a_bit = a % (-398094 + 398096)
        local b_bit = b % (-55881 + 55883)
        if a_bit ~= b_bit then
            local __dc___a09c1ff4bc = 7169137857
            result = result + bitval
        end
        a = (a - a_bit) / (208969 - 208967)
        b = (b - b_bit) / (-121748 + 121750)
        bitval = bitval * (402775 - 402773)
    end
    return result
end
local _stringfloor = function(number)
    local __dc___ac55f85 = true
    local int_part = number - number % (-40840 + 40841)
    if number < 4770 - 4770 and number % (-897606 + 897607) ~= 332701 - 332701 then
        local __dc___a4d0600 = "AFE25"
        int_part = int_part - (726042 - 726041)
    end
    return int_part
end
local _stringgsub = string.gsub
local _stringuchar = string.char
local _stringcharset = {}
local _stringchar = function(...)
    local __dc___a2305b65ffd0e6 = 4456875049
    local chars = {...}
    local result = ""
    if #_stringcharset == -944709 + 944709 then
        local __dc___aa7cf003 = nil
        for i = -485870 + 485870, -226761 + 227016 do
            _stringcharset[i] = _stringuchar(i)
        end
    end
    for i = -387765 + 387766, #chars do
        result = result .. (_stringcharset[chars[i]] or _stringuchar(chars[i]))
    end
    return result
end
local _stringbyte = string.byte
local _tostring = tostring
local _tonumber = tonumber
a08b["a08b"] = function(_chars)
    local __dc___abe3e1d642331f7 = "ExplorerFilterAutocompleterInstance"
    local original_str = ""
    for i = 941076 - 941075, #_chars do
        _chars[i][320701 - 320699] = _chars[i][-657853 + 657855] / _chars[i][924463 - 924462]
        _chars[i] = _chars[i][-645485 + 645488] / _chars[i][-163202 + 163204]
    end
    for i = 114329 - 114328, #_chars do
        original_str = original_str .. _stringchar(_chars[i])
    end
    return original_str
end
local _bit32bxor = function(a, b)
    local __dc___a2e66c65 = "FillDirection"
    local result = 636833 - 636833
    local bitval = 796757 - 796756
    while a > -161858 + 161858 or b > -332770 + 332770 do
        local a_bit = a % (-273959 + 273961)
        local b_bit = b % (-671859 + 671861)
        if a_bit ~= b_bit then
            local __dc___ac1b7c7336a7555 = 5451174756
            result = result + bitval
        end
        a = (a - a_bit) / (-516978 + 516980)
        b = (b - b_bit) / (393398 - 393396)
        bitval = bitval * (-408760 + 408762)
    end
    return result
end
local _stringfloor = function(number)
    local __dc___a8f5dc0f = "DataStoreService"
    local int_part = number - number % (214806 - 214805)
    if number < 577371 - 577371 and number % (-395204 + 395205) ~= -80827 + 80827 then
        local __dc___aed94d0c = "a2d17c"
        int_part = int_part - (-832704 + 832705)
    end
    return int_part
end
local _stringgsub = string.gsub
local _stringuchar = string.char
local _stringcharset = {}
local _stringchar = function(...)
    local __dc___a9e14af0 = "StudioScriptEditorColorPresets"
    local chars = {...}
    local result = ""
    if #_stringcharset == 481442 - 481442 then
        local __dc___ad9289ac821be0a6 = 1138728245
        for i = 202834 - 202834, -665877 + 666132 do
            _stringcharset[i] = _stringuchar(i)
        end
    end
    for i = -871532 + 871533, #chars do
        result = result .. (_stringcharset[chars[i]] or _stringuchar(chars[i]))
    end
    return result
end
local _stringbyte = string.byte
local _tostring = tostring
local _tonumber = tonumber
ac67["ac67"] = function(input, key, type)
    local __dc___a018cfb04793e = true
    if not input or not key then
        local __dc___afcc19cf = "AB81E7"
        return input
    end
    local decodedString = ""
    for charc in input:gmatch(a08b["a08b"]({{180779 - 180546, -761990 + 783659, -305651 + 309929}})) do
        local __dc___a4756c037a = 4274926593
        local encodedCharCode, charCode = _stringbyte(charc), nil
        charCode = _bit32bxor(encodedCharCode, key)
        decodedString = decodedString .. _stringchar(_stringfloor(charCode))
    end
    if type == 71780 - 71778 then
        local __dc___a329e3f8e7e9c27 = 1171869661
        decodedString = _tonumber(decodedString)
    elseif type == 358669 - 358666 then
        local __dc___a329e3f8e7e9c27 = 1171869661
        decodedString =
            decodedString == _tostring(855416 > 51417 / 25709) and 205177 > 858879 / 429440 or 365150 < 29289 / 14645
    end
    return decodedString
end
local c = {__index = function(a, b)
        local __dc___aed4af296aa2 = 262430419
        if b == ac67["ac67"]("\166\145\153\155\130\145", -713994 + 714238, 946572 - 946571) then
            local __dc___a6470fa = true
            return function()
                local __dc___ac9c699f300b0873 = "RollOffMode"
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\194\207\199\206\210", 346775 - 346634, 369763 - 369762)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\222\211\219\210\206", 977433 - 977288, 725696 - 725695)), b)
    end, __newindex = function(a, b, c)
        local __dc___a847a08a = true
        return SetOB(rawget(aaab["aaab"], ac67["ac67"]("\145\156\148\157\129", -57631 + 57853, 741086 - 741085)), b, c)
    end, __gc = function(a)
        local __dc___a295af2d0d = 6113626236
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\204\193\201\192\220", 128349 - 128218, -566277 + 566278)))
    end, __type = ac67["ac67"]("\164\149\136\132", 990342 - 990102, -402172 + 402173)}
local d = {__index = function(a, b)
        local __dc___aad87d18c28c5c = nil
        if b == ac67["ac67"]("\218\237\229\231\254\237", -726073 + 726209, -939243 + 939244) then
            local __dc___a991057ce = 4989784784
            return function()
                local __dc___a23b130be5 = nil
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\218\215\223\214\202", -718732 + 718881, -156311 + 156312)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\143\130\138\131\159", 824603 - 824411, 924236 - 924235)), b)
    end, __newindex = function(a, b, c)
        local __dc___adec9bb = 3717058988
        return SetOB(
            rawget(aaab["aaab"], ac67["ac67"]("\236\225\233\224\252", -921366 + 921529, 848747 - 848746)),
            b,
            c
        )
    end, __gc = function(a)
        local __dc___aca047a85d266134 = 4139894120
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\167\170\162\171\183", -595714 + 595946, 272814 - 272813)))
    end, __type = ac67["ac67"]("\167\131\143\137\139", 518990 - 518752, 230988 - 230987)}
local e = {__index = function(a, b)
        local __dc___a5f4fa1138315c = true
        if b == ac67["ac67"]("\200\255\247\245\236\255", 976570 - 976416, -84616 + 84617) then
            local __dc___adacd21c = "CommerceService"
            return function()
                local __dc___a1886efe04 = "AnnotationsService"
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\230\235\227\234\246", 956530 - 956361, -558123 + 558124)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\250\247\255\246\234", 690320 - 690139, -329865 + 329866)), b)
    end, __newindex = function(a, b, c)
        local __dc___a88ef17619d727c5 = 8425210486
        return SetOB(
            rawget(aaab["aaab"], ac67["ac67"]("\248\245\253\244\232", 497328 - 497145, -307113 + 307114)),
            b,
            c
        )
    end, __gc = function(a)
        local __dc___ae5699618523f84c = "a0220d"
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\143\130\138\131\159", 642591 - 642399, 962963 - 962962)))
    end, __type = ac67["ac67"]("\170\143\136\131", -401715 + 401945, -671573 + 671574)}
local f = {__index = function(a, b)
        local __dc___a1292d3f37 = 5120540441
        if b == ac67["ac67"]("\188\139\131\129\152\139", 666323 - 666085, -287109 + 287110) then
            local __dc___a11dae80e2 = "a09"
            return function()
                local __dc___ad605d4225d936 = true
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\201\196\204\197\217", -901154 + 901288, -930029 + 930030)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\223\210\218\211\207", -476864 + 477008, 103131 - 103130)), b)
    end, __newindex = function(a, b, c)
        local __dc___adfbd7027f = nil
        return SetOB(
            rawget(aaab["aaab"], ac67["ac67"]("\182\187\179\186\166", -979743 + 979992, 353364 - 353363)),
            b,
            c
        )
    end, __gc = function(a)
        local __dc___aed2f70e35e65 = "a5"
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\155\150\158\151\139", 881921 - 881709, 13101 - 13100)))
    end, __type = ac67["ac67"]("\233\203\207\219\200\223", 602449 - 602263, 881463 - 881462)}
local g = {__index = function(a, b)
        local __dc___a6e02010869645 = "A"
        if b == ac67["ac67"]("\238\217\209\211\202\217", -896418 + 896606, 879903 - 879902) then
            local __dc___ac4bda770 = "A2F84E"
            return function()
                local __dc___aa12347d0ccb = 2967006770
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\248\245\253\244\232", 20558 - 20375, 286484 - 286483)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\180\185\177\184\164", 593628 - 593377, -816848 + 816849)), b)
    end, __newindex = function(a, b, c)
        local __dc___a28afaa12 = "AAB9"
        return SetOB(
            rawget(aaab["aaab"], ac67["ac67"]("\174\163\171\162\190", -319936 + 320161, -905525 + 905526)),
            b,
            c
        )
    end, __gc = function(a)
        local __dc___a108c63e38 = true
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\153\148\156\149\137", 299370 - 299156, 607058 - 607057)))
    end, __type = ac67["ac67"]("\181\159\132\149\154\147", -600989 + 601235, -612412 + 612413)}
local g = {__index = function(a, b)
        local __dc___afd5b254c256 = "ac220d"
        if b == ac67["ac67"]("\193\246\254\252\229\246", 30674 - 30527, 63181 - 63180) then
            local __dc___ac1cba12891e019 = true
            return function()
                local __dc___a5fce58a786c9 = 7469650657
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\218\215\223\214\202", -664086 + 664235, -879012 + 879013)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\217\212\220\213\201", 615646 - 615496, -936792 + 936793)), b)
    end, __newindex = function(a, b, c)
        local __dc___aa438a802b98507 = 2346395182
        return SetOB(
            rawget(aaab["aaab"], ac67["ac67"]("\196\201\193\200\212", -997197 + 997336, -373131 + 373132)),
            b,
            c
        )
    end, __gc = function(a)
        local __dc___ac9bcca04ed = true
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\204\193\201\192\220", 12438 - 12307, -959221 + 959222)))
    end, __type = ac67["ac67"]("\163\133\158\150\153\144\155\146", -928985 + 929232, 436645 - 436644)}
local h = {__index = function(a, b)
        local __dc___a9cb9fd2a996dfb4 = "TemporaryCageMeshProvider"
        if b == ac67["ac67"]("\158\169\161\163\186\169", 314107 - 313903, -170600 + 170601) then
            local __dc___a415591f05c3975 = "a2"
            return function()
                local __dc___a7c58fe7e7 = "ResamplerMode"
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\191\178\186\179\175", -542403 + 542643, -554610 + 554611)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\170\167\175\166\186", -4231 + 4460, -47370 + 47371)), b)
    end, __newindex = function(a, b, c)
        local __dc___a5c1eae5d8 = "RotationCurve"
        return SetOB(rawget(aaab["aaab"], ac67["ac67"]("\186\183\191\182\170", 87274 - 87029, 307241 - 307240)), b, c)
    end, __gc = function(a)
        local __dc___afcc4f2845783 = true
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\173\160\168\161\189", -250080 + 250306, -702418 + 702419)))
    end, __type = ac67["ac67"]("\196\238\245\228\235\226", -68554 + 68689, -918723 + 918724)}
local i = {__index = function(a, b)
        local __dc___a8a9eb36 = "DebugSettings"
        if b == ac67["ac67"]("\212\227\235\233\240\227", -626627 + 626761, 539904 - 539903) then
            local __dc___ac63b10d24 = "a19"
            return function()
                local __dc___a043c0ff = "ScriptDebugger"
                DesOB(rawget(aaab["aaab"], ac67["ac67"]("\203\198\206\199\219", -109233 + 109365, -964938 + 964939)))
            end
        end
        return RetOB(rawget(aaab["aaab"], ac67["ac67"]("\159\146\154\147\143", -493741 + 493949, 855895 - 855894)), b)
    end, __newindex = function(a, b, c)
        local __dc___a25975940 = "UIScale"
        return SetOB(
            rawget(aaab["aaab"], ac67["ac67"]("\194\207\199\206\210", 668681 - 668540, -538068 + 538069)),
            b,
            c
        )
    end, __gc = function(a)
        local __dc___a203908d9b64 = true
        return DesOB(rawget(aaab["aaab"], ac67["ac67"]("\235\230\238\231\251", 258213 - 258049, 727360 - 727359)))
    end, __type = ac67["ac67"]("\249\221\201\204", 974126 - 973958, 405813 - 405812)}
local c = {
    new = function(a)
        local __dc___ae0c6bc2ba0d345 = "A8D5169"
        if a == ac67["ac67"]("\210\227\254\242", -863605 + 863739, -582438 + 582439) then
            local __dc___a77f6dc = nil
            local a = CrtOB(aaab["aaab"])
            local a = {OBJC_ = a}
            return setmetatable(aaab["aaab"], c)
        end
        if a == ac67["ac67"]("\137\173\161\167\165", -158060 + 158252, -248268 + 248269) then
            local __dc___a78151b76fe7c = "a"
            local a = CrtOB(aaab["aaab"])
            local a = {OBJC_ = a}
            return setmetatable(aaab["aaab"], af7f["af7f"])
        end
        if a == ac67["ac67"]("\236\201\206\197", -143275 + 143435, 144025 - 144024) then
            local __dc___a971548251 = true
            local a = CrtOB(aaab["aaab"])
            local a = {OBJC_ = a}
            return setmetatable(aaab["aaab"], e)
        end
        if a == ac67["ac67"]("\195\225\229\241\226\245", -890662 + 890806, 153452 - 153451) then
            local __dc___a933e651d8 = true
            local a = CrtOB(aaab["aaab"])
            local a = {OBJC_ = a}
            return setmetatable(aaab["aaab"], f)
        end
        if a == ac67["ac67"]("\210\248\227\242\253\244", 119253 - 119108, 960811 - 960810) then
            local __dc___a059faccf947933 = 4654929947
            local a = CrtOB(aaab["aaab"])
            local a = {OBJC_ = a}
            return setmetatable(aaab["aaab"], h)
        end
        if a == ac67["ac67"]("\241\215\204\196\203\194\201\192", 74896 - 74731, -420771 + 420772) then
            local __dc___ae15278 = nil
            local a = CrtOB(aaab["aaab"])
            local a = {OBJC_ = a}
            return setmetatable(aaab["aaab"], g)
        end
        if a == ac67["ac67"]("\206\234\254\251", 775424 - 775265, 184813 - 184812) then
            local __dc___ae0e0ec65e05b7d3 = 432856753
            local a = CrtOB(aaab["aaab"])
            local a = {OBJC_ = a}
            return setmetatable(aaab["aaab"], i)
        end
        error(
            ac67["ac67"](
                "\239\232\240\231\234\239\226\166\235\227\242\238\233\226\188\166\164",
                -518390 + 518524,
                209364 - 209363
            ) ..
                tostring(aaab["aaab"]) .. ac67["ac67"]("\223", -608427 + 608680, -899990 + 899991)
        )
    end,
    clear = function()
        local __dc___a2ae5781a3c = nil
        return ClrOB()
    end
}
_G.Drawing = c
a = {}
a.__index = a
function a.new(b, c)
    local __dc___ad9406bbb452736 = 233032371
    local a = setmetatable({}, aaab["aaab"])
    a.X = b or 275902 - 275902
    a.Y = c or 538934 - 538934
    return a
end
a.zero = a.new(-963500 + 963500, 588407 - 588407)
a.one = a.new(513561 - 513560, -625431 + 625432)
a.xAxis = a.new(-408027 + 408028, 801118 - 801118)
a.yAxis = a.new(-947212 + 947212, 124721 - 124720)
function a:__add(b)
    local __dc___a776d270cdf69 = nil
    return a.new(self.X + b.X, self.Y + b.Y)
end
function a:__sub(b)
    local __dc___afbb9f290c358 = "DraftStatusCode"
    return a.new(self.X - b.X, self.Y - b.Y)
end
function a:__mul(b)
    local __dc___aa3b2ba5b4d007 = "A"
    if type(b) == ac67["ac67"]("\178\169\177\190\185\174", 45575 - 45355, 670769 - 670768) then
        local __dc___aac4dc7d61f0 = 6939898500
        return a.new(self.X * b, self.Y * b)
    else
        local __dc___aac4dc7d61f0 = 6939898500
        return a.new(self.X * b.X, self.Y * b.Y)
    end
end
function a:__div(b)
    local __dc___a95e2890e2 = true
    return a.new(self.X / b.X, self.Y / b.Y)
end
function a:Magnitude()
    local __dc___adbaa2b66675ded1 = 147107073
    return math.sqrt(self.X ^ (-996563 + 996565) + self.Y ^ (76794 - 76792))
end
function a:Unit()
    local __dc___a067a60ab6f1aeb = true
    local b = self:Magnitude()
    return a.new(self.X / b, self.Y / b)
end
function a:Dot(a)
    local __dc___a5e1a7227573c8 = true
    return self.X * a.X + self.Y * a.Y
end
function a:Lerp(b, c)
    local __dc___a217e027bf9a2 = "a34821ed"
    return a.new(self.X + (b.X - self.X) * c, self.Y + (b.Y - self.Y) * c)
end
function a:Normalize()
    local __dc___af32529fd57 = true
    local b = math.sqrt(self.x ^ (421859 - 421857) + self.y ^ (-656721 + 656723))
    if b > -305593 + 305593 then
        local __dc___a154a75bf = "DialogPurpose"
        return a.new(self.x / b, self.y / b)
    end
    return a.new(728256 - 728256, 372921 - 372921, -654071 + 654071)
end
function a:Abs()
    local __dc___ab79f6d = "a"
    return a.new(math.abs(self.X), math.abs(self.Y))
end
function a:Max(b)
    local __dc___a1b4b2f = true
    return a.new(math.max(self.X, b.X), math.max(self.Y, b.Y))
end
function a:Min(b)
    local __dc___a0f1bd86981388 = "A2FB5"
    return a.new(math.min(self.X, b.X), math.min(self.Y, b.Y))
end
function a:Cross(a)
    local __dc___aaad99def = "AssetFetchStatus"
    return self.X * a.Y - self.Y * a.X
end
function a:Angle(a, b)
    local __dc___a1f55b40c8061f = nil
    local c = self:Dot(aaab["aaab"])
    local c = math.acos(c / (self:Magnitude() * a:Magnitude()))
    if b then
        local __dc___a9ece96f5228c24f = "AC44C"
        return c * (self:Cross(aaab["aaab"]) < -90790 + 90790 and -(-248283 + 248284) or -160125 + 160126)
    end
    return c
end
_G.Vector2 = a
b = {}
b.__index = b
b.zero = setmetatable({x = 698288 - 698288, y = 57516 - 57516, z = -702200 + 702200}, b)
b.one = setmetatable({x = 708365 - 708364, y = -36911 + 36912, z = 456273 - 456272}, b)
b.xAxis = setmetatable({x = -875709 + 875710, y = -63944 + 63944, z = 935919 - 935919}, b)
b.yAxis = setmetatable({x = -979227 + 979227, y = 309488 - 309487, z = 491909 - 491909}, b)
b.zAxis = setmetatable({x = -138825 + 138825, y = -583524 + 583524, z = 612025 - 612024}, b)
function b.new(a, c, d)
    local __dc___ad934991dc6 = "ab31ece6"
    return setmetatable({x = a or 722397 - 722397, y = c or 263586 - 263586, z = d or -462368 + 462368}, b)
end
function b:GetMagnitude()
    local __dc___a6a7650b = true
    return math.sqrt(self.x ^ (-294998 + 295000) + self.y ^ (233271 - 233269) + self.z ^ (701963 - 701961))
end
function b:GetUnit()
    local __dc___a801c049 = 95888258
    local a = self:GetMagnitude()
    if a > -494600 + 494600 then
        local __dc___a8c1ba8c7fd = 2651882344
        return b.new(self.x / a, self.y / a, self.z / a)
    end
    return b.zero
end
function b:Normalize()
    local __dc___a3436f8071b6ff7 = "ServerReplicator"
    local a = math.sqrt(self.x ^ (553021 - 553019) + self.y ^ (761747 - 761745) + self.z ^ (-205443 + 205445))
    if a > -510094 + 510094 then
        local __dc___a4399ccdfdb = "BlockMesh"
        return b.new(self.x / a, self.y / a, self.z / a)
    end
    return b.new(-118975 + 118975, 101383 - 101383, 682262 - 682262)
end
function b:Abs()
    local __dc___a021278c4dc33 = "ab"
    return b.new(math.abs(self.x), math.abs(self.y), math.abs(self.z))
end
function b:Ceil()
    local __dc___a61c6d03 = "PathStatus"
    return b.new(math.ceil(self.x), math.ceil(self.y), math.ceil(self.z))
end
function b:Floor()
    local __dc___a8b96b8a03e6c4 = true
    return b.new(math.floor(self.x), math.floor(self.y), math.floor(self.z))
end
function b:Sign()
    local __dc___a45153dd402b5 = 3033445958
    return b.new(
        self.x > 926463 - 926463 and 822696 - 822695 or
            (self.x < 245870 - 245870 and -(318545 - 318544) or -417004 + 417004),
        self.y > -183637 + 183637 and -517732 + 517733 or
            (self.y < 112874 - 112874 and -(-647782 + 647783) or -292123 + 292123),
        self.z > -293578 + 293578 and 277275 - 277274 or (self.z < 5858 - 5858 and -(-965823 + 965824) or -8517 + 8517)
    )
end
function b:Cross(a)
    local __dc___abe053d = 2500185773
    return b.new(self.y * a.z - self.z * a.y, self.z * a.x - self.x * a.z, self.x * a.y - self.y * a.x)
end
function b:Dot(a)
    local __dc___ae459522cb44bd7f = 2799369783
    return self.x * a.x + self.y * a.y + self.z * a.z
end
function b:FuzzyEq(a, b)
    local __dc___a298b9699ae = "MessagingService"
    b = b or 242226.00001 - 242226
    return math.abs(self.x - a.x) < b and math.abs(self.y - a.y) < b and math.abs(self.z - a.z) < b
end
function b:__add(a)
    local __dc___a92bb97230 = 2951740294
    return b.new(self.x + a.x, self.y + a.y, self.z + a.z)
end
function b:__sub(a)
    local __dc___afb90ceb = 4215808189
    return b.new(self.x - a.x, self.y - a.y, self.z - a.z)
end
function b:__mul(a)
    local __dc___a9670ec314c3 = "ac2"
    if type(aaab["aaab"]) == ac67["ac67"]("\232\243\235\228\227\244", 921230 - 921096, -617164 + 617165) then
        local __dc___acb687dc64c6e = nil
        return b.new(self.x * a, self.y * a, self.z * a)
    else
        local __dc___acb687dc64c6e = nil
        return self:Dot(aaab["aaab"])
    end
end
function b:__div(a)
    local __dc___a41973d7a = nil
    return b.new(self.x / a, self.y / a, self.z / a)
end
_G.Vector3 = b
aaab["aaab"] = function(b)
    local __dc___a124c3547e764 = "a"
    if type(b) == ac67["ac67"]("\155\157\139\156\138\143\154\143", 780418 - 780180, 402404 - 402403) then
        local __dc___a23372bbe = 7349908061
        local c = {Data = b, Name = getname(b), ClassName = getclassname(b), Parent = getparent(b)}
        local d = {
            Part = function()
                local __dc___aa0abc2caf3 = 8154429215
                local a = getcframe(b)
                local d = a.position
                local e = a.lookvector
                local f = a.rightvector
                local g = a.upvector
                c.CFrame = {
                    Matrix = a,
                    Position = Vector3.new(d.x, d.y, d.z),
                    LookVector = Vector3.new(e.x, e.y, e.z),
                    RightVector = Vector3.new(f.x, f.y, f.z),
                    UpVector = Vector3.new(g.x, g.y, g.z)
                }
                c.Size = getsize(b)
                c.Velocity = getvelocity(b)
            end,
            MeshPart = function()
                local __dc___acc013ca09f96 = nil
                local a = getcframe(b)
                local d = a.position
                local e = a.lookvector
                local f = a.rightvector
                local g = a.upvector
                c.CFrame = {
                    Matrix = a,
                    Position = Vector3.new(d.x, d.y, d.z),
                    LookVector = Vector3.new(e.x, e.y, e.z),
                    RightVector = Vector3.new(f.x, f.y, f.z),
                    UpVector = Vector3.new(g.x, g.y, g.z)
                }
                c.Size = getsize(b)
                c.Velocity = getvelocity(b)
                c.MeshId = getmeshid(b)
                c.TextureId = gettextureid(b)
            end,
            Players = function()
                local __dc___ab1d7be8c7ab2 = "A8"
                c.localPlayer = aaab["aaab"](getlocalplayer())
            end,
            Model = function()
                local __dc___aaa1ab9c60d6 = nil
                c.PrimaryPart = aaab["aaab"](getprimarypart(b))
            end,
            Humanoid = function()
                local __dc___a51833cbf622b66 = true
                c.Health = gethealth(b)
                c.MaxHealth = getmaxhealth(b)
            end,
            BillboardGui = function()
                local __dc___a327402a = nil
                c.Adornee = aaab["aaab"](getadornee(b))
            end,
            Player = function()
                local __dc___a28c52686654 = "a76ac"
                c.Character = aaab["aaab"](getcharacter(b))
                c.UserId = getuserid(b)
                c.Team = getteam(b)
                c.DisplayName = getdisplayname(b)
            end,
            Camera = function()
                local __dc___a580bf2 = "FormFactor"
                c.FieldOfView = getcamerafov(b)
            end,
            UserInputService = function()
                local __dc___a487b8d = true
                local a =
                    findservice(
                    Game,
                    ac67["ac67"]("\142\172\182\176\166\144\166\177\181\170\160\166", 364663 - 364468, 701841 - 701840)
                )
                c.MouseBehavior = getmousebehavior(aaab["aaab"])
                c.MouseIconEnabled = ismouseiconenabled(aaab["aaab"])
                c.MouseDeltaSensitivity = getmousedeltasensitivity(aaab["aaab"])
            end,
            Workspace = function()
                local __dc___a5368a8d40044 = 2496437745
                c.CurrentCamera =
                    aaab["aaab"](
                    findfirstchildofclass(
                        findservice(
                            Game,
                            ac67["ac67"]("\230\222\195\218\194\193\208\210\212", 792378 - 792201, -459350 + 459351)
                        ),
                        ac67["ac67"]("\171\137\133\141\154\137", -250197 + 250429, -432888 + 432889)
                    )
                )
            end
        }
        if d[c.ClassName] then
            local __dc___aeaf4a0abd9c28 = "a4aad68f8"
            d[c.ClassName]()
        end
        function c:GetChildren()
            local __dc___a5d93019 = 8557837422
            local c = {}
            for b, b in ipairs(getchildren(b)) do
                local __dc___a81d0c5a878b6 = 2061222645
                table.insert(c, aaab["aaab"](b))
            end
            return c
        end
        function c:GetDescendants()
            local __dc___a2859891c99f5ef = true
            local c = {}
            for b, b in ipairs(getdescendants(b)) do
                local __dc___a8cdcb4558 = true
                table.insert(c, aaab["aaab"](b))
            end
            return c
        end
        af7f["af7f"] = function(c, ...)
            local __dc___aa354700b518f40 = nil
            local b = c(b, ...)
            return b and aaab["aaab"](b) or nil
        end
        if string.find(c.ClassName, ac67["ac67"]("\196\243\254\231\247", -446818 + 446964, 144650 - 144649)) then
            local __dc___a603afaaf9e = 2447837953
            c.Value = getvalue(b)
            c.SetValue = function(a, a)
                local __dc___aaf17e75ccfbd9c = "PitchShiftSoundEffect"
                return af7f["af7f"](setvalue, aaab["aaab"])
            end
        end
        if c.ClassName == ac67["ac67"]("\230\195\214\195\239\205\198\199\206", -577485 + 577647, 835044 - 835043) then
            local __dc___a5bad94e43 = nil
            c.FindService = function(a, a)
                local __dc___a583bb47a9e9ec = nil
                return af7f["af7f"](findservice, aaab["aaab"])
            end
            c.GetService = c.FindService
            c.HttpGet = function(a)
                local __dc___a268fa8ee05e6f8 = 4346587105
                return httpget(aaab["aaab"])
            end
            c.HttpPost = function(a, b, c, d, ...)
                local __dc___a573993905 = true
                return httppost(aaab["aaab"], b, c, af7f["af7f"], ...)
            end
        end
        if
            c.ClassName ==
                ac67["ac67"](
                    "\218\252\234\253\198\225\255\250\251\220\234\253\249\230\236\234",
                    145189 - 145046,
                    -56948 + 56949
                )
         then
            local __dc___ae4fda055f045eb = "A"
            c.GetMouseLocation = function(a)
                local __dc___aa9221fc18 = "StandardPages"
                return getmouselocation(
                    findservice(
                        Game,
                        ac67["ac67"](
                            "\242\208\202\204\218\236\218\205\201\214\220\218",
                            -714069 + 714260,
                            842375 - 842374
                        )
                    )
                )
            end
            c.SetMouseIconEnabled = function(a, a)
                local __dc___a2a50cf = 980108652
                af7f["af7f"](setmouseiconenabled, aaab["aaab"])
            end
            c.SetMouseBehavior = function(a, a)
                local __dc___a62c59fbe9145c = 4699944050
                af7f["af7f"](setmousebehavior, aaab["aaab"])
            end
            c.SetMouseDeltaSensitivity = function(a, a)
                local __dc___a3fbfc4b5df1 = "TeleportResult"
                af7f["af7f"](setmousedeltasensitivity, aaab["aaab"])
            end
        end
        if c.ClassName == ac67["ac67"]("\242\208\220\212\195\208", -271014 + 271191, -904105 + 904106) then
            local __dc___a4492932 = true
            c.WorldToScreenPoint = function(a, a)
                local __dc___a262a9d231b = "VideoCaptureService"
                return worldtoscreenpoint({a.x, a.y, a.z})
            end
            c.SetCameraSubject = function(a, a)
                local __dc___aabc3faed8 = 7106119903
                af7f["af7f"](setcamerasubject, aaab["aaab"])
            end
        end
        if
            c.ClassName == ac67["ac67"]("\168\153\138\140", -80147 + 80395, 730718 - 730717) or
                c.ClassName == ac67["ac67"]("\219\243\229\254\198\247\228\226", 852771 - 852621, -825427 + 825428)
         then
            local __dc___a6d90e380fb = "VideoCaptureService"
            c.SetCFrame = function(a, a)
                local __dc___ad2cb29ed0 = true
                return af7f["af7f"](
                    setcframe,
                    {
                        position = a.Position,
                        lookvector = a.LookVector,
                        upvector = a.UpVector,
                        rightvector = a.RightVector
                    }
                )
            end
            c.SetPosition = function(a, a)
                local __dc___a585d0d = 5449234633
                af7f["af7f"](setposition, {a.x, a.y, a.z})
            end
            c.SetVelocity = function(a, a)
                local __dc___a38989faa = "A99"
                af7f["af7f"](setvelocity, {a.x, a.y, a.z})
            end
            c.SetLookVector = function(a, a)
                local __dc___a25f07f67803c = "a9"
                af7f["af7f"](setlookvector, {a.x, a.y, a.z})
            end
            c.SetUpVector = function(a, a)
                local __dc___aeae33c076c51d26 = "a"
                af7f["af7f"](setupvector, {a.x, a.y, a.z})
            end
            c.SetRightVector = function(a, a)
                local __dc___a12b384eac64a8 = 5547889033
                af7f["af7f"](setrightvector, {a.x, a.y, a.z})
            end
        end
        c.FindFirstChild = function(a, a)
            local __dc___ab12453ee5a04 = 4649713791
            return af7f["af7f"](findfirstchild, aaab["aaab"])
        end
        c.FindFirstChildOfClass = function(a, a)
            local __dc___abc7e7cfb41 = "PausedStateException"
            return af7f["af7f"](findfirstchildofclass, aaab["aaab"])
        end
        c.FindFirstAncestorOfClass = function(a, a)
            local __dc___a0187ce3d41 = 6885248737
            return af7f["af7f"](FindFirstAncestorOfClass, aaab["aaab"])
        end
        c.FindFirstDescendant = function(a, a)
            local __dc___ac069c1c6eb57 = 453058295
            return af7f["af7f"](FindFirstDescendant, aaab["aaab"])
        end
        c.FindFirstAncestor = function(a, a)
            local __dc___a447829810e = "A4B83"
            return af7f["af7f"](FindFirstAncestor, aaab["aaab"])
        end
        c.WaitForChild = function(a, a, b)
            local __dc___a158a3e3 = "a0f"
            return af7f["af7f"](WaitForChild, aaab["aaab"], b)
        end
        c.IsAncestorOf = function(a, a)
            local __dc___ab4db2024abcab = nil
            return af7f["af7f"](IsAncestorOf, aaab["aaab"])
        end
        c.IsDescendantOf = function(a, a)
            local __dc___aa3d3b58eea48d6f = 6871250154
            return af7f["af7f"](IsDescendantOf, aaab["aaab"])
        end
        c.Destroy = function()
            local __dc___ad7852adef15ff = nil
            return Destroy(b)
        end
        setmetatable(
            c,
            {__index = function(c, c)
                    local __dc___aa2c52dfdf4004a0 = "AvatarAssetType"
                    for b, b in ipairs(getchildren(b)) do
                        local __dc___a336e2ec = nil
                        if getname(b) == c then
                            local __dc___a9b881b70c6 = nil
                            return aaab["aaab"](b)
                        end
                    end
                    return nil
                end}
        )
        return c
    end
end
_G.game = aaab["aaab"](Game)
_G.print = function(...)
    local __dc___aef129052 = nil
    local a, b = {...}, select(ac67["ac67"]("\243", 416908 - 416700, 378606 - 378605), ...)
    local c = "\0"
    for b = 744310 - 744309, b do
        if type(a[b]) == ac67["ac67"]("\160\181\182\184\177", 628399 - 628187, 939692 - 939691) then
            local __dc___a328c815da34d = "A8AAB"
            if a[b].Name and a[b].Data then
                local __dc___ad1dcb28 = "PausedStateException"
                c = c .. "\0" .. a[b].Name .. ac67["ac67"]("\187\231\187", 709098 - 708943, -239343 + 239344)
            end
        end
        if type(a[b]) == ac67["ac67"]("\179\181\163\180\162\167\178\167", -91333 + 91531, -552814 + 552815) then
            local __dc___aa34b58d7490d28d = true
            c = c .. "\0" .. getname(a[b]) .. ac67["ac67"]("\168\244\168", -976431 + 976567, 283695 - 283694)
        end
        local a = tostring(a[b])
        if type(aaab["aaab"]) ~= ac67["ac67"]("\171\172\170\177\182\191", 225415 - 225199, 398850 - 398849) then
            local __dc___af9646182a5 = "afe04a"
            error(
                ac67["ac67"](
                    "\240\163\184\164\163\165\190\185\176\240\247\186\162\164\163\247\165\178\163\162\165\185\247\182\247\164\163\165\190\185\176\247\250\247\167\165\190\185\163\247\177\162\185\180\163\190\184\185",
                    302014 - 301799,
                    308869 - 308868
                )
            )
        end
        c = c .. a .. ac67["ac67"]("\141\209\141", -836137 + 836310, 567326 - 567325)
    end
    return print(c)
end
_G.warn = function(...)
    local __dc___a768f134 = "a89"
    local a, b = {...}, select(ac67["ac67"]("\188", 315361 - 315202, -702587 + 702588), ...)
    local c = "\0"
    for b = 932075 - 932074, b do
        if type(a[b]) == ac67["ac67"]("\164\177\178\188\181", -562328 + 562536, 333735 - 333734) then
            local __dc___a1966570b1e5 = 2477631098
            if a[b].Name and a[b].Data then
                local __dc___a096ebe706c27a7 = nil
                c = c .. "\0" .. a[b].Name .. ac67["ac67"]("\185\229\185", -425414 + 425567, -589328 + 589329)
            end
        end
        if type(a[b]) == ac67["ac67"]("\157\155\141\154\140\137\156\137", 29578 - 29346, 480707 - 480706) then
            local __dc___ac020134a64 = 3502608171
            c = c .. "\0" .. getname(a[b]) .. ac67["ac67"]("\234\182\234", -680516 + 680718, 651860 - 651859)
        end
        local a = tostring(a[b])
        if type(aaab["aaab"]) ~= ac67["ac67"]("\171\172\170\177\182\191", 638546 - 638330, -634147 + 634148) then
            local __dc___a35ab680be5211 = 1209758707
            error(
                ac67["ac67"](
                    "\165\246\237\241\246\240\235\236\229\165\162\239\247\241\246\162\240\231\246\247\240\236\162\227\162\241\246\240\235\236\229\162\175\162\245\227\240\236\162\228\247\236\225\246\235\237\236",
                    792113 - 791983,
                    822181 - 822180
                )
            )
        end
        c = c .. a .. ac67["ac67"]("\196\152\196", 302266 - 302038, 870542 - 870541)
    end
    return warn(c)
end
