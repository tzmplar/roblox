local c = {}
local d = {}
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
    __type = "Text"
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
    __type = "Image"
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
    __type = "Line"
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
    __type = "Square"
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
    __type = "Triangle"
}
local j = {
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
local k = {
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
local e = {
    new = function(a)
        if a == "Text" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, e)
        end
        if a == "Image" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, f)
        end
        if a == "Line" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, g)
        end
        if a == "Square" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, h)
        end
        if a == "Circle" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, j)
        end
        if a == "Triangle" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, i)
        end
        if a == "Quad" then
            local a = CrtOB(a)
            local a = {OBJC_ = a}
            return setmetatable(a, k)
        end
        error('invalid method: "' .. tostring(a) .. '"')
    end,
    clear = function()
        return ClrOB()
    end
}
_G.Drawing = e
a = {}
a.__index = a
function a.new(b, c)
    local a = setmetatable({}, a)
    a.X = b or -279043 + 279043
    a.Y = c or 509864 - 509864
    return a
end
a.zero = a.new(-636247 + 636247, -262827 + 262827)
a.one = a.new(924007 - 924006, -27208 + 27209)
a.xAxis = a.new(814917 - 814916, 783004 - 783004)
a.yAxis = a.new(-727288 + 727288, 111729 - 111728)
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
    return math.sqrt(self.X ^ (571382 - 571380) + self.Y ^ (-680392 + 680394))
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
    local b = math.sqrt(self.x ^ (-330291 + 330293) + self.y ^ (483287 - 483285))
    if b > 857752 - 857752 then
        return a.new(self.x / b, self.y / b)
    end
    return a.new(36761 - 36761, 68023 - 68023, -927895 + 927895)
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
        return c * (self:Cross(a) < -520231 + 520231 and -(-349332 + 349333) or -197297 + 197298)
    end
    return c
end
_G.Vector2 = a
b = {}
b.__index = b
b.zero = setmetatable({x = 66438 - 66438, y = -251933 + 251933, z = -594802 + 594802}, b)
b.one = setmetatable({x = 356371 - 356370, y = -878405 + 878406, z = 432385 - 432384}, b)
b.xAxis = setmetatable({x = 249891 - 249890, y = 393735 - 393735, z = 415610 - 415610}, b)
b.yAxis = setmetatable({x = -205767 + 205767, y = 404460 - 404459, z = 260837 - 260837}, b)
b.zAxis = setmetatable({x = 885872 - 885872, y = -906717 + 906717, z = 377362 - 377361}, b)
function b.new(a, c, d)
    return setmetatable({x = a or -819106 + 819106, y = c or -48409 + 48409, z = d or 35837 - 35837}, b)
end
function b:GetMagnitude()
    return math.sqrt(self.x ^ (940404 - 940402) + self.y ^ (-230531 + 230533) + self.z ^ (810330 - 810328))
end
function b:GetUnit()
    local a = self:GetMagnitude()
    if a > -246731 + 246731 then
        return b.new(self.x / a, self.y / a, self.z / a)
    end
    return b.zero
end
function b:Normalize()
    local a = math.sqrt(self.x ^ (210761 - 210759) + self.y ^ (143963 - 143961) + self.z ^ (908575 - 908573))
    if a > -797985 + 797985 then
        return b.new(self.x / a, self.y / a, self.z / a)
    end
    return b.new(4929 - 4929, 808605 - 808605, 477393 - 477393)
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
        self.x > 714375 - 714375 and -131267 + 131268 or
            (self.x < -896704 + 896704 and -(360914 - 360913) or 16087 - 16087),
        self.y > -872410 + 872410 and -306624 + 306625 or
            (self.y < -567653 + 567653 and -(297506 - 297505) or -888052 + 888052),
        self.z > 430298 - 430298 and -115010 + 115011 or
            (self.z < 200287 - 200287 and -(-816263 + 816264) or 697923 - 697923)
    )
end
function b:Cross(a)
    return b.new(self.y * a.z - self.z * a.y, self.z * a.x - self.x * a.z, self.x * a.y - self.y * a.x)
end
function b:Dot(a)
    return self.x * a.x + self.y * a.y + self.z * a.z
end
function b:FuzzyEq(a, b)
    b = b or -901307.99999 + 901308
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
d["ac2a"] = function(a)
    if type(a) == "userdata" then
        local b = {Data = a, Name = getname(a), ClassName = getclassname(a), Parent = getparent(a)}
        local e = {
            Part = function()
                local c = getcframe(a)
                local d = c.position
                local e = c.lookvector
                local f = c.rightvector
                local g = c.upvector
                b.CFrame = {
                    Matrix = c,
                    Position = Vector3.new(d.x, d.y, d.z),
                    LookVector = Vector3.new(e.x, e.y, e.z),
                    RightVector = Vector3.new(f.x, f.y, f.z),
                    UpVector = Vector3.new(g.x, g.y, g.z)
                }
                b.Size = getsize(a)
                b.Velocity = getvelocity(a)
            end,
            MeshPart = function()
                local c = getcframe(a)
                local d = c.position
                local e = c.lookvector
                local f = c.rightvector
                local g = c.upvector
                b.CFrame = {
                    Matrix = c,
                    Position = Vector3.new(d.x, d.y, d.z),
                    LookVector = Vector3.new(e.x, e.y, e.z),
                    RightVector = Vector3.new(f.x, f.y, f.z),
                    UpVector = Vector3.new(g.x, g.y, g.z)
                }
                b.Size = getsize(a)
                b.Velocity = getvelocity(a)
                b.MeshId = getmeshid(a)
                b.TextureId = gettextureid(a)
            end,
            Players = function()
                b.localPlayer = d["ac2a"](getlocalplayer())
            end,
            Model = function()
                b.PrimaryPart = d["ac2a"](getprimarypart(a))
            end,
            Humanoid = function()
                b.Health = gethealth(a)
                b.MaxHealth = getmaxhealth(a)
            end,
            BillboardGui = function()
                b.Adornee = d["ac2a"](getadornee(a))
            end,
            Player = function()
                b.Character = d["ac2a"](getcharacter(a))
                b.UserId = getuserid(a)
                b.Team = getteam(a)
                b.DisplayName = getdisplayname(a)
            end,
            Camera = function()
                b.FieldOfView = getcamerafov(a)
            end,
            UserInputService = function()
                local a = findservice(Game, "MouseService")
                b.MouseBehavior = getmousebehavior(a)
                b.MouseIconEnabled = ismouseiconenabled(a)
                b.MouseDeltaSensitivity = getmousedeltasensitivity(a)
            end,
            Workspace = function()
                b.CurrentCamera = d["ac2a"](findfirstchildofclass(findservice(Game, "Workspace"), "Camera"))
            end
        }
        if e[b.ClassName] then
            e[b.ClassName]()
        end
        function b:GetChildren()
            local b = {}
            for a, a in ipairs(getchildren(a)) do
                table.insert(b, d["ac2a"](a))
            end
            return b
        end
        function b:GetDescendants()
            local b = {}
            for a, a in ipairs(getdescendants(a)) do
                table.insert(b, d["ac2a"](a))
            end
            return b
        end
        c["a98b"] = function(b, ...)
            local a = b(a, ...)
            return a and d["ac2a"](a) or nil
        end
        if
            b.ClassName == "BoolValue" or b.ClassName == "IntValue" or b.ClassName == "NumberValue" or
                b.ClassName == "Vector3Value" or
                b.ClassName == "ObjectValue"
         then
            b.Value = getvalue(a)
            b.SetValue = function(a, a)
                return c["a98b"](setvalue, a)
            end
        end
        if b.ClassName == "DataModel" then
            b.FindService = function(a, a)
                return c["a98b"](findservice, a)
            end
            b.GetService = b.FindService
            b.HttpGet = function(a)
                return httpget(a)
            end
            b.HttpPost = function(a, b, c, d, ...)
                return httppost(a, b, c, d, ...)
            end
        end
        if b.ClassName == "UserInputService" then
            b.GetMouseLocation = function(a)
                return getmouselocation(findservice(Game, "MouseService"))
            end
            b.SetMouseIconEnabled = function(a, a)
                c["a98b"](setmouseiconenabled, a)
            end
            b.SetMouseBehavior = function(a, a)
                c["a98b"](setmousebehavior, a)
            end
            b.SetMouseDeltaSensitivity = function(a, a)
                c["a98b"](setmousedeltasensitivity, a)
            end
        end
        if b.ClassName == "Camera" then
            b.WorldToScreenPoint = function(a, a)
                return worldtoscreenpoint({a.x, a.y, a.z})
            end
            b.SetCameraSubject = function(a, a)
                c["a98b"](setcamerasubject, a)
            end
        end
        if b.ClassName == "Part" or b.ClassName == "MeshPart" then
            b.SetCFrame = function(a, a)
                return c["a98b"](
                    setcframe,
                    {
                        position = a.Position,
                        lookvector = a.LookVector,
                        upvector = a.UpVector,
                        rightvector = a.RightVector
                    }
                )
            end
            b.SetPosition = function(a, a)
                c["a98b"](setposition, {a.x, a.y, a.z})
            end
            b.SetVelocity = function(a, a)
                c["a98b"](setvelocity, {a.x, a.y, a.z})
            end
            b.SetLookVector = function(a, a)
                c["a98b"](setlookvector, {a.x, a.y, a.z})
            end
            b.SetUpVector = function(a, a)
                c["a98b"](setupvector, {a.x, a.y, a.z})
            end
            b.SetRightVector = function(a, a)
                c["a98b"](setrightvector, {a.x, a.y, a.z})
            end
        end
        b.FindFirstChild = function(a, a)
            return c["a98b"](findfirstchild, a)
        end
        b.FindFirstChildOfClass = function(a, a)
            return c["a98b"](findfirstchildofclass, a)
        end
        b.FindFirstAncestorOfClass = function(a, a)
            return c["a98b"](FindFirstAncestorOfClass, a)
        end
        b.FindFirstDescendant = function(a, a)
            return c["a98b"](FindFirstDescendant, a)
        end
        b.FindFirstAncestor = function(a, a)
            return c["a98b"](FindFirstAncestor, a)
        end
        b.WaitForChild = function(a, a, b)
            return c["a98b"](WaitForChild, a, b)
        end
        b.IsAncestorOf = function(a, a)
            return c["a98b"](IsAncestorOf, a)
        end
        b.IsDescendantOf = function(a, a)
            return c["a98b"](IsDescendantOf, a)
        end
        b.Destroy = function()
            return Destroy(a)
        end
        setmetatable(
            b,
            {
                __index = function(b, b)
                    for a, a in ipairs(getchildren(a)) do
                        if getname(a) == b then
                            return d["ac2a"](a)
                        end
                    end
                    return nil
                end
            }
        )
        return b
    end
end
_G.game = d["ac2a"](Game)
_G.workspace = d["ac2a"](Workspace)
_G.print = function(...)
    local a, b = {...}, select("#", ...)
    local c = ""
    for b = 21909 - 21908, b do
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
    for b = 273539 - 273538, b do
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
