--[[
GoofyLuaUglifier - @mopsfl

ugl_alg: QXiIXZi1WdO1mcvZ2cuFmcUJCLiknZp5WatJyW
]]
local c = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Text"
}
local d = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Image"
}
local e = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Line"
}
local f = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Square"
}
local g = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Circle"
}
local g = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Triangle"
}
local h = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Circle"
}
local i = {
    __index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end,
    __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end,
    __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end,
    __type = "Quad"
}
local c = {
    new = function(a)
        if a == "Text" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, c)
        end
        if a == "Image" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, d)
        end
        if a == "Line" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, e)
        end
        if a == "Square" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, f)
        end
        if a == "Circle" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, h)
        end
        if a == "Triangle" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, g)
        end
        if a == "Quad" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, i)
        end
        error('invalid method: "' .. tostring(a) .. '"')
    end,
    clear = function()
        return ClrOB()
    end
}
_G.Drawing = c
a = {}
a.__index = a
function a.new(b, c)
    local a = setmetatable({}, a)
    a.X = b or -58454 + 58454
    a.Y = c or 800551 - 800551
    return a
end
a.zero = a.new(-161991 + 161991, 640716 - 640716)
a.one = a.new(-329926 + 329927, -747061 + 747062)
a.xAxis = a.new(-290028 + 290029, -562765 + 562765)
a.yAxis = a.new(-825807 + 825807, 503678 - 503677)
function a:__add(b)
    return a.new(self.X + b.X, self.Y + b.Y)
end
function a:__sub(b)
    return a.new(self.X - b.X, self.Y - b.Y)
end
function a:__mul(b)
    if type(b) == "number" then
        return a.new(self.X * b, self.Y * b)
    else
        return a.new(self.X * b.X, self.Y * b.Y)
    end
end
function a:__div(b)
    return a.new(self.X / b.X, self.Y / b.Y)
end
function a:Magnitude()
    return math.sqrt(self.X ^ (884740 - 884738) + self.Y ^ (922550 - 922548))
end
function a:Unit()
    local b = self:Magnitude()
    return a.new(self.X / b, self.Y / b)
end
function a:Dot(a)
    return self.X * a.X + self.Y * a.Y
end
function a:Lerp(b, c)
    return a.new(self.X + (b.X - self.X) * c, self.Y + (b.Y - self.Y) * c)
end
function a:Normalize()
    local b = math.sqrt(self.x ^ (-343880 + 343882) + self.y ^ (112702 - 112700))
    if b > 763957 - 763957 then
        return a.new(self.x / b, self.y / b)
    end
    return a.new(-967828 + 967828, 429236 - 429236, -141472 + 141472)
end
function a:Abs()
    return a.new(math.abs(self.X), math.abs(self.Y))
end
function a:Max(b)
    return a.new(math.max(self.X, b.X), math.max(self.Y, b.Y))
end
function a:Min(b)
    return a.new(math.min(self.X, b.X), math.min(self.Y, b.Y))
end
function a:Cross(a)
    return self.X * a.Y - self.Y * a.X
end
function a:Angle(a, b)
    local c = self:Dot(a)
    local c = math.acos(c / (self:Magnitude() * a:Magnitude()))
    if b then
        return c * (self:Cross(a) < -64988 + 64988 and -(992905 - 992904) or -786103 + 786104)
    end
    return c
end
_G.Vector2 = a
b = {}
b.__index = b
b.zero = setmetatable({x = 997238 - 997238, y = -408413 + 408413, z = -864538 + 864538}, b)
b.one = setmetatable({x = -866863 + 866864, y = 504147 - 504146, z = -309314 + 309315}, b)
b.xAxis = setmetatable({x = 61260 - 61259, y = 948178 - 948178, z = 123587 - 123587}, b)
b.yAxis = setmetatable({x = -301910 + 301910, y = -43509 + 43510, z = -758792 + 758792}, b)
b.zAxis = setmetatable({x = 790703 - 790703, y = 245895 - 245895, z = 464128 - 464127}, b)
function b.new(a, c, d)
    return setmetatable({x = a or 774086 - 774086, y = c or 352716 - 352716, z = d or 442284 - 442284}, b)
end
function b:GetMagnitude()
    return math.sqrt(self.x ^ (467749 - 467747) + self.y ^ (-252932 + 252934) + self.z ^ (-867633 + 867635))
end
function b:GetUnit()
    local a = self:GetMagnitude()
    if a > 99918 - 99918 then
        return b.new(self.x / a, self.y / a, self.z / a)
    end
    return b.zero
end
function b:Normalize()
    local a = math.sqrt(self.x ^ (-980950 + 980952) + self.y ^ (759951 - 759949) + self.z ^ (935378 - 935376))
    if a > -764240 + 764240 then
        return b.new(self.x / a, self.y / a, self.z / a)
    end
    return b.new(727663 - 727663, -64794 + 64794, -562063 + 562063)
end
function b:Abs()
    return b.new(math.abs(self.x), math.abs(self.y), math.abs(self.z))
end
function b:Ceil()
    return b.new(math.ceil(self.x), math.ceil(self.y), math.ceil(self.z))
end
function b:Floor()
    return b.new(math.floor(self.x), math.floor(self.y), math.floor(self.z))
end
function b:Sign()
    return b.new(
        self.x > 617111 - 617111 and -406124 + 406125 or
            (self.x < -760927 + 760927 and -(-902349 + 902350) or 723363 - 723363),
        self.y > -703867 + 703867 and 843518 - 843517 or
            (self.y < -201033 + 201033 and -(871531 - 871530) or -107068 + 107068),
        self.z > -744436 + 744436 and 942545 - 942544 or
            (self.z < 466703 - 466703 and -(-104313 + 104314) or 897831 - 897831)
    )
end
function b:Cross(a)
    return b.new(self.y * a.z - self.z * a.y, self.z * a.x - self.x * a.z, self.x * a.y - self.y * a.x)
end
function b:Dot(a)
    return self.x * a.x + self.y * a.y + self.z * a.z
end
function b:FuzzyEq(a, b)
    b = b or 479454.00001 - 479454
    return math.abs(self.x - a.x) < b and math.abs(self.y - a.y) < b and math.abs(self.z - a.z) < b
end
function b:__add(a)
    return b.new(self.x + a.x, self.y + a.y, self.z + a.z)
end
function b:__sub(a)
    return b.new(self.x - a.x, self.y - a.y, self.z - a.z)
end
function b:__mul(a)
    if type(a) == "number" then
        return b.new(self.x * a, self.y * a, self.z * a)
    else
        return self:Dot(a)
    end
end
function b:__div(a)
    return b.new(self.x / a, self.y / a, self.z / a)
end
_G.Vector3 = b
local function a(b)
    if type(b) == "userdata" then
        local c = {Data = b, Name = getname(b), ClassName = getclassname(b), Parent = getparent(b)}
        local d = {
            Part = function()
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
                c.localPlayer = a(getlocalplayer())
            end,
            Model = function()
                c.PrimaryPart = a(getprimarypart(b))
            end,
            Humanoid = function()
                c.Health = gethealth(b)
                c.MaxHealth = getmaxhealth(b)
            end,
            BillboardGui = function()
                c.Adornee = a(getadornee(b))
            end,
            Player = function()
                c.Character = a(getcharacter(b))
                c.UserId = getuserid(b)
                c.Team = getteam(b)
                c.DisplayName = getdisplayname(b)
            end,
            Camera = function()
                c.FieldOfView = getcamerafov(b)
            end,
            UserInputService = function()
                local a = findservice(Game, "MouseService")
                c.MouseBehavior = getmousebehavior(a)
                c.MouseIconEnabled = ismouseiconenabled(a)
                c.MouseDeltaSensitivity = getmousedeltasensitivity(a)
            end,
            Workspace = function()
                c.CurrentCamera = a(findfirstchildofclass(findservice(Game, "Workspace"), "Camera"))
            end
        }
        if d[c.ClassName] then
            d[c.ClassName]()
        end
        function c:GetChildren()
            local c = {}
            for b, b in ipairs(getchildren(b)) do
                table.insert(c, a(b))
            end
            return c
        end
        function c:GetDescendants()
            local c = {}
            for b, b in ipairs(getdescendants(b)) do
                table.insert(c, a(b))
            end
            return c
        end
        local function d(c, ...)
            local b = c(b, ...)
            return b and a(b) or nil
        end
        if string.find(c.ClassName, "Value") then
            c.Value = getvalue(b)
            c.SetValue = function(a, a)
                return d(setvalue, a)
            end
        end
        if c.ClassName == "DataModel" then
            c.FindService = function(a, a)
                return d(findservice, a)
            end
            c.GetService = c.FindService
            c.HttpGet = function(a)
                return httpget(a)
            end
            c.HttpPost = function(a, b, c, d, ...)
                return httppost(a, b, c, d, ...)
            end
        end
        if c.ClassName == "UserInputService" then
            c.GetMouseLocation = function(a)
                return getmouselocation(findservice(Game, "MouseService"))
            end
            c.SetMouseIconEnabled = function(a, a)
                d(setmouseiconenabled, a)
            end
            c.SetMouseBehavior = function(a, a)
                d(setmousebehavior, a)
            end
            c.SetMouseDeltaSensitivity = function(a, a)
                d(setmousedeltasensitivity, a)
            end
        end
        if c.ClassName == "Camera" then
            c.WorldToScreenPoint = function(a, a)
                return worldtoscreenpoint({a.x, a.y, a.z})
            end
            c.SetCameraSubject = function(a, a)
                d(setcamerasubject, a)
            end
        end
        if c.ClassName == "Part" or c.ClassName == "MeshPart" then
            c.SetCFrame = function(a, a)
                return d(
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
                d(setposition, {a.x, a.y, a.z})
            end
            c.SetVelocity = function(a, a)
                d(setvelocity, {a.x, a.y, a.z})
            end
            c.SetLookVector = function(a, a)
                d(setlookvector, {a.x, a.y, a.z})
            end
            c.SetUpVector = function(a, a)
                d(setupvector, {a.x, a.y, a.z})
            end
            c.SetRightVector = function(a, a)
                d(setrightvector, {a.x, a.y, a.z})
            end
        end
        c.FindFirstChild = function(a, a)
            return d(findfirstchild, a)
        end
        c.FindFirstChildOfClass = function(a, a)
            return d(findfirstchildofclass, a)
        end
        c.FindFirstAncestorOfClass = function(a, a)
            return d(FindFirstAncestorOfClass, a)
        end
        c.FindFirstDescendant = function(a, a)
            return d(FindFirstDescendant, a)
        end
        c.FindFirstAncestor = function(a, a)
            return d(FindFirstAncestor, a)
        end
        c.WaitForChild = function(a, a, b)
            return d(WaitForChild, a, b)
        end
        c.IsAncestorOf = function(a, a)
            return d(IsAncestorOf, a)
        end
        c.IsDescendantOf = function(a, a)
            return d(IsDescendantOf, a)
        end
        c.Destroy = function()
            return Destroy(b)
        end
        setmetatable(
            c,
            {
                __index = function(c, c)
                    for b, b in ipairs(getchildren(b)) do
                        if getname(b) == c then
                            return a(b)
                        end
                    end
                    return nil
                end
            }
        )
        return c
    end
end
_G.game = a(Game)
_G.print = function(...)
    local a, b = {...}, select("#", ...)
    local c = ""
    for b = -76510 + 76511, b do
        if type(a[b]) == "table" then
            if a[b].Name and a[b].Data then
                c = c .. "" .. a[b].Name .. " | "
            end
        end
        if type(a[b]) == "userdata" then
            c = c .. "" .. getname(a[b]) .. " | "
        end
        local a = tostring(a[b])
        if type(a) ~= "string" then
            error("'tostring' must return a string - print function")
        end
        c = c .. a .. " | "
    end
    return print(c)
end
_G.warn = function(...)
    local a, b = {...}, select("#", ...)
    local c = ""
    for b = -895246 + 895247, b do
        if type(a[b]) == "table" then
            if a[b].Name and a[b].Data then
                c = c .. "" .. a[b].Name .. " | "
            end
        end
        if type(a[b]) == "userdata" then
            c = c .. "" .. getname(a[b]) .. " | "
        end
        local a = tostring(a[b])
        if type(a) ~= "string" then
            error("'tostring' must return a string - warn function")
        end
        c = c .. a .. " | "
    end
    return warn(c)
end
