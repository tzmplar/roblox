local c = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Text"}
local d = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Image"}
local e = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Line"}
local f = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Square"}
local g = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Circle"}
local g = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Triangle"}
local h = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Circle"}
local i = {__index = function(a, b)
        if b == "Remove" then
            return function()
                DesOB(rawget(a, "OBJC_"))
            end
        end
        return RetOB(rawget(a, "OBJC_"), b)
    end, __newindex = function(a, b, c)
        return SetOB(rawget(a, "OBJC_"), b, c)
    end, __gc = function(a)
        return DesOB(rawget(a, "OBJC_"))
    end, __type = "Quad"}
local c = {new = function(a)
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
    end, clear = function()
        return ClrOB()
    end}
_G.Drawing = c

local Vector2 = {}
Vector2.__index = Vector2

-- Constructors
function Vector2.new(x, y)
    return setmetatable({X = x or 0, Y = y or 0}, Vector2)
end

-- Constants
Vector2.zero = Vector2.new(0, 0)
Vector2.one = Vector2.new(1, 1)
Vector2.xAxis = Vector2.new(1, 0)
Vector2.yAxis = Vector2.new(0, 1)

-- Properties
function Vector2:Magnitude()
    return math.sqrt(self.X^2 + self.Y^2)
end

function Vector2:Unit()
    local m = self:Magnitude()
    if m > 0 then
        return Vector2.new(self.X / m, self.Y / m)
    end
    return Vector2.zero
end

-- Methods
function Vector2:Dot(v)
    return self.X * v.X + self.Y * v.Y
end

function Vector2:Cross(v)
    return self.X * v.Y - self.Y * v.X
end

function Vector2:Angle(v, isSigned)
    local dot = self:Dot(v)
    local magProduct = self:Magnitude() * v:Magnitude()
    local angle = math.acos(math.clamp(dot / magProduct, -1, 1))
    if isSigned then
        return angle * (self:Cross(v) < 0 and -1 or 1)
    end
    return angle
end

function Vector2:Lerp(v, alpha)
    return Vector2.new(
        self.X + (v.X - self.X) * alpha,
        self.Y + (v.Y - self.Y) * alpha
    )
end

function Vector2:Abs()
    return Vector2.new(math.abs(self.X), math.abs(self.Y))
end

function Vector2:Ceil()
    return Vector2.new(math.ceil(self.X), math.ceil(self.Y))
end

function Vector2:Floor()
    return Vector2.new(math.floor(self.X), math.floor(self.Y))
end

function Vector2:Sign()
    local sign = function(v) return v > 0 and 1 or (v < 0 and -1 or 0) end
    return Vector2.new(sign(self.X), sign(self.Y))
end

function Vector2:Max(...)
    local args = {...}
    local maxX, maxY = self.X, self.Y
    for _, v in ipairs(args) do
        maxX = math.max(maxX, v.X)
        maxY = math.max(maxY, v.Y)
    end
    return Vector2.new(maxX, maxY)
end

function Vector2:Min(...)
    local args = {...}
    local minX, minY = self.X, self.Y
    for _, v in ipairs(args) do
        minX = math.min(minX, v.X)
        minY = math.min(minY, v.Y)
    end
    return Vector2.new(minX, minY)
end

function Vector2:FuzzyEq(v, epsilon)
    epsilon = epsilon or 1e-5
    return math.abs(self.X - v.X) < epsilon and math.abs(self.Y - v.Y) < epsilon
end

-- Operators
function Vector2:__add(v)
    return Vector2.new(self.X + v.X, self.Y + v.Y)
end

function Vector2:__sub(v)
    return Vector2.new(self.X - v.X, self.Y - v.Y)
end

function Vector2:__mul(v)
    if type(v) == "number" then
        return Vector2.new(self.X * v, self.Y * v)
    elseif getmetatable(v) == Vector2 then
        return Vector2.new(self.X * v.X, self.Y * v.Y)
    end
end

function Vector2:__div(v)
    if type(v) == "number" then
        return Vector2.new(self.X / v, self.Y / v)
    elseif getmetatable(v) == Vector2 then
        return Vector2.new(self.X / v.X, self.Y / v.Y)
    end
end

function Vector2:__floordiv(v)
    if type(v) == "number" then
        return Vector2.new(math.floor(self.X / v), math.floor(self.Y / v))
    elseif getmetatable(v) == Vector2 then
        return Vector2.new(math.floor(self.X / v.X), math.floor(self.Y / v.Y))
    end
end

function Vector2:__unm()
    return Vector2.new(-self.X, -self.Y)
end

function Vector2:__tostring()
    return string.format("Vector2.new(%.3f, %.3f)", self.X, self.Y)
end

-- Clamp fallback
math.clamp = math.clamp or function(x, min, max)
    return math.max(min, math.min(max, x))
end

-- Global binding (optional)
_G.Vector2 = Vector2

local Vector3 = {}
Vector3.__index = Vector3

-- Enums for normal and axis
local Enum = {
    NormalId = {
        Top = "Top", Bottom = "Bottom", Left = "Left",
        Right = "Right", Front = "Front", Back = "Back"
    },
    Axis = {
        X = "X", Y = "Y", Z = "Z"
    }
}

-- Constructor
function Vector3.new(x, y, z)
    return setmetatable({X = x or 0, Y = y or 0, Z = z or 0}, Vector3)
end

-- FromNormalId
function Vector3.FromNormalId(normal)
    local map = {
        [Enum.NormalId.Top] = Vector3.new(0, 1, 0),
        [Enum.NormalId.Bottom] = Vector3.new(0, -1, 0),
        [Enum.NormalId.Left] = Vector3.new(-1, 0, 0),
        [Enum.NormalId.Right] = Vector3.new(1, 0, 0),
        [Enum.NormalId.Front] = Vector3.new(0, 0, -1),
        [Enum.NormalId.Back] = Vector3.new(0, 0, 1),
    }
    return map[normal] or Vector3.zero
end

-- FromAxis
function Vector3.FromAxis(axis)
    local map = {
        [Enum.Axis.X] = Vector3.new(1, 0, 0),
        [Enum.Axis.Y] = Vector3.new(0, 1, 0),
        [Enum.Axis.Z] = Vector3.new(0, 0, 1),
    }
    return map[axis] or Vector3.zero
end

-- Properties
Vector3.zero = Vector3.new(0, 0, 0)
Vector3.one = Vector3.new(1, 1, 1)
Vector3.xAxis = Vector3.new(1, 0, 0)
Vector3.yAxis = Vector3.new(0, 1, 0)
Vector3.zAxis = Vector3.new(0, 0, 1)

function Vector3:Magnitude()
    return math.sqrt(self.X^2 + self.Y^2 + self.Z^2)
end

function Vector3:Unit()
    local m = self:Magnitude()
    if m > 0 then
        return Vector3.new(self.X / m, self.Y / m, self.Z / m)
    end
    return Vector3.zero
end

-- Methods
function Vector3:Abs()
    return Vector3.new(math.abs(self.X), math.abs(self.Y), math.abs(self.Z))
end

function Vector3:Ceil()
    return Vector3.new(math.ceil(self.X), math.ceil(self.Y), math.ceil(self.Z))
end

function Vector3:Floor()
    return Vector3.new(math.floor(self.X), math.floor(self.Y), math.floor(self.Z))
end

function Vector3:Sign()
    local sign = function(v) return v > 0 and 1 or (v < 0 and -1 or 0) end
    return Vector3.new(sign(self.X), sign(self.Y), sign(self.Z))
end

function Vector3:Cross(v)
    return Vector3.new(
        self.Y * v.Z - self.Z * v.Y,
        self.Z * v.X - self.X * v.Z,
        self.X * v.Y - self.Y * v.X
    )
end

function Vector3:Angle(v, axis)
    local dot = self:Dot(v)
    local magProduct = self:Magnitude() * v:Magnitude()
    local angle = math.acos(math.clamp(dot / magProduct, -1, 1))
    if axis then
        return angle * (self:Cross(v):Dot(axis) < 0 and -1 or 1)
    end
    return angle
end

function Vector3:Dot(v)
    return self.X * v.X + self.Y * v.Y + self.Z * v.Z
end

function Vector3:FuzzyEq(v, epsilon)
    epsilon = epsilon or 1e-5
    local diffSq = (self - v):Magnitude()^2
    return diffSq <= epsilon^2 * math.max(self:Magnitude()^2, v:Magnitude()^2, 1)
end

function Vector3:Lerp(v, alpha)
    return Vector3.new(
        self.X + (v.X - self.X) * alpha,
        self.Y + (v.Y - self.Y) * alpha,
        self.Z + (v.Z - self.Z) * alpha
    )
end

function Vector3:Max(v)
    return Vector3.new(
        math.max(self.X, v.X),
        math.max(self.Y, v.Y),
        math.max(self.Z, v.Z)
    )
end

function Vector3:Min(v)
    return Vector3.new(
        math.min(self.X, v.X),
        math.min(self.Y, v.Y),
        math.min(self.Z, v.Z)
    )
end

-- Math Operations
function Vector3:__add(v)
    return Vector3.new(self.X + v.X, self.Y + v.Y, self.Z + v.Z)
end

function Vector3:__sub(v)
    return Vector3.new(self.X - v.X, self.Y - v.Y, self.Z - v.Z)
end

function Vector3:__mul(v)
    if type(v) == "number" then
        return Vector3.new(self.X * v, self.Y * v, self.Z * v)
    elseif getmetatable(v) == Vector3 then
        return Vector3.new(self.X * v.X, self.Y * v.Y, self.Z * v.Z)
    end
end

function Vector3:__div(v)
    if type(v) == "number" then
        return Vector3.new(self.X / v, self.Y / v, self.Z / v)
    elseif getmetatable(v) == Vector3 then
        return Vector3.new(self.X / v.X, self.Y / v.Y, self.Z / v.Z)
    end
end

function Vector3:__mod(v)
    return Vector3.new(self.X % v.X, self.Y % v.Y, self.Z % v.Z)
end

function Vector3:__floordiv(v)
    if type(v) == "number" then
        return Vector3.new(math.floor(self.X / v), math.floor(self.Y / v), math.floor(self.Z / v))
    elseif getmetatable(v) == Vector3 then
        return Vector3.new(math.floor(self.X / v.X), math.floor(self.Y / v.Y), math.floor(self.Z / v.Z))
    end
end

function Vector3:__unm()
    return Vector3.new(-self.X, -self.Y, -self.Z)
end

function Vector3:__tostring()
    return string.format("Vector3.new(%.3f, %.3f, %.3f)", self.X, self.Y, self.Z)
end

-- Clamp fallback for Lua environments
math.clamp = math.clamp or function(x, min, max)
    return math.max(min, math.min(max, x))
end

-- Register to global if needed
_G.Vector3 = Vector3
_G.Enum = Enum

_G.lua_cache = {}
local function a(b)
    if type(b) ~= "userdata" then
        return nil
    end

    -- Check if the object is already cached and return it if so
    if lua_cache[b] then
        return lua_cache[b]
    end
        
    local c = {}
    local d = getclassname(b)
    local function e(b, ...)
        local b = b(...)
        return b and a(b) or nil
    end
    local f = {Data = function()
            return b
        end, Parent = function()
            return a(getparent(b))
        end, Name = function()
            return getname(b)
        end, ClassName = function()
            return d
        end}
    local g = {
        Part = {
            CFrame = function()
                local a = getcframe(b)
                local b = a.position
                local c = a.lookvector
                local d = a.rightvector
                local e = a.upvector
                return {
                    Matrix = a,
                    Position = Vector3.new(b.x, b.y, b.z),
                    LookVector = Vector3.new(c.x, c.y, c.z),
                    RightVector = Vector3.new(d.x, d.y, d.z),
                    UpVector = Vector3.new(e.x, e.y, e.z)
                }
            end,
            Size = function()
                return getsize(b)
            end,
            Velocity = function()
                return getvelocity(b)
            end
        },
        MeshPart = {
            CFrame = function()
                local a = getcframe(b)
                local b = a.position
                local c = a.lookvector
                local d = a.rightvector
                local e = a.upvector
                return {
                    Matrix = a,
                    Position = Vector3.new(b.x, b.y, b.z),
                    LookVector = Vector3.new(c.x, c.y, c.z),
                    RightVector = Vector3.new(d.x, d.y, d.z),
                    UpVector = Vector3.new(e.x, e.y, e.z)
                }
            end,
            Size = function()
                return getsize(b)
            end,
            Velocity = function()
                return getvelocity(b)
            end,
            MeshId = function()
                return getmeshid(b)
            end,
            TextureId = function()
                return gettextureid(b)
            end
        },
        UnionOperation = {
            CFrame = function()
                local a = getcframe(b)
                local b = a.position
                local c = a.lookvector
                local d = a.rightvector
                local e = a.upvector
                return {
                    Matrix = a,
                    Position = Vector3.new(b.x, b.y, b.z),
                    LookVector = Vector3.new(c.x, c.y, c.z),
                    RightVector = Vector3.new(d.x, d.y, d.z),
                    UpVector = Vector3.new(e.x, e.y, e.z)
                }
            end,
            Size = function()
                return getsize(b)
            end,
            Velocity = function()
                return getvelocity(b)
            end
        },
        Players = {localPlayer = function()
                return e(getlocalplayer)
            end},
        Model = {PrimaryPart = function()
                return e(getprimarypart, b)
            end},
        Humanoid = {Health = function()
                return gethealth(b)
            end, MaxHealth = function()
                return getmaxhealth(b)
            end},
        BillboardGui = {Adornee = function()
                return e(getadornee, b)
            end},
        Player = {Character = function()
                return e(getcharacter, b)
            end, UserId = function()
                return getuserid(b)
            end, Team = function()
                return getteam(b)
            end, DisplayName = function()
                return getdisplayname(b)
            end},
        Camera = {FieldOfView = function()
                return getcamerafov(b)
            end,  CFrame = function()
                local a = getcframe(b)
                local b = a.position
                local c = a.lookvector
                local d = a.rightvector
                local e = a.upvector
                return {
                    Matrix = a,
                    Position = Vector3.new(b.x, b.y, b.z),
                    LookVector = Vector3.new(c.x, c.y, c.z),
                    RightVector = Vector3.new(d.x, d.y, d.z),
                    UpVector = Vector3.new(e.x, e.y, e.z)
                }
            end},
        UserInputService = {MouseBehavior = function()
                return getmousebehavior(findservice(Game, "MouseService"))
            end, MouseIconEnabled = function()
                return ismouseiconenabled(findservice(Game, "MouseService"))
            end, MouseDeltaSensitivity = function()
                return getmousedeltasensitivity(findservice(Game, "MouseService"))
            end},
        Workspace = {CurrentCamera = function()
                return e(findfirstchildofclass, findservice(Game, "Workspace"), "Camera")
            end}
    }
    setmetatable(
        c,
        {
            __index = function(h, h)
                if f[h] then
                    return f[h]()
                end
                if g[d] and g[d][h] then
                    return g[d][h]()
                end
                if
                    d == "BoolValue" or d == "IntValue" or d == "NumberValue" or d == "Vector3Value" or
                        d == "ObjectValue" or d == "StringValue"
                 then
                    if h == "Value" then
                        if d == "ObjectValue" then
                            return e(getvalue, b)
                        end
                        return getvalue(b)
                    end
                    if h == "SetValue" then
                        return function(a, b)
                            assert(a == c, "SetValue must be called with ':' not '.'")
                            setvalue(a.Data, b)
                        end
                    end
                end
                if d == "Camera" then
                    if h == "WorldToScreenPoint" then
                        return function(a, b)
                            assert(a == c, "WorldToScreenPoint must be called with ':' not '.'")
                            return worldtoscreenpoint({b.x, b.y, b.z})
                        end
                    end
                    if h == "SetCameraSubject" then
                        return function(a, b)
                            assert(a == c, "SetCameraSubject must be called with ':' not '.'")
                            setcamerasubject(a.Data, b)
                        end
                    end
                end
                if d == "Part" or d == "MeshPart" or d == "Camera" or d == "UnionOperation" then
                    if h == "SetCFrame" then
                        return function(a, b)
                            assert(a == c, "SetCFrame must be called with ':' not '.'")
                            setcframe(
                                a.Data,
                                {
                                    position = b.Position,
                                    lookvector = b.LookVector,
                                    upvector = b.UpVector,
                                    rightvector = b.RightVector
                                }
                            )
                        end
                    end
                    if h == "SetPosition" then
                        return function(a, b)
                            assert(a == c, "SetPosition must be called with ':' not '.'")
                            setposition(a.Data, {b.x, b.y, b.z})
                        end
                    end
                    if h == "SetVelocity" then
                        return function(a, b)
                            assert(a == c, "SetVelocity must be called with ':' not '.'")
                            setvelocity(a.Data, {b.x, b.y, b.z})
                        end
                    end
                    if h == "SetLookVector" then
                        return function(a, b)
                            assert(a == c, "SetLookVector must be called with ':' not '.'")
                            setlookvector(a.Data, {b.x, b.y, b.z})
                        end
                    end
                    if h == "SetUpVector" then
                        return function(a, b)
                            assert(a == c, "SetUpVector must be called with ':' not '.'")
                            setupvector(a.Data, {b.x, b.y, b.z})
                        end
                    end
                    if h == "SetRightVector" then
                        return function(a, b)
                            assert(a == c, "SetRightVector must be called with ':' not '.'")
                            setrightvector(a.Data, {b.x, b.y, b.z})
                        end
                    end
                end
                if d == "UserInputService" then
                    if h == "GetMouseLocation" then
                        return function(a)
                            assert(a == c, "GetMouseLocation must be called with ':' not '.'")
                            return getmouselocation(findservice(Game, "MouseService"))
                        end
                    end
                    if h == "SetMouseLocation" then
                        return function(a, k, l)
                            assert(a == c, "SetMouseLocation must be called with ':' not '.'")
                            setmouselocation(findservice(Game, "MouseService"), k, l)
                        end
                    end
                    if h == "SetMouseIconEnabled" then
                        return function(a, b)
                            assert(a == c, "SetMouseIconEnabled must be called with ':' not '.'")
                            setmouseiconenabled(a.Data, b)
                        end
                    end
                    if h == "SetMouseBehavior" then
                        return function(a, b)
                            assert(a == c, "SetMouseBehavior must be called with ':' not '.'")
                            setmousebehavior(a.Data, b)
                        end
                    end
                    if h == "SetMouseDeltaSensitivity" then
                        return function(a, b)
                            assert(a == c, "SetMouseDeltaSensitivity must be called with ':' not '.'")
                            SetMouseDeltaSensitivity(a.Data, b)
                        end
                    end
                end
                 if d == "HttpService" then
                    if h == "JSONDecode" then
                        return function(a, b)
                            assert(a == c, "JSONDecode must be called with ':' not '.'")
                            return JSONDecode(b)
                        end
                    end 
                    if h == "JSONEncode" then
                        return function(a, b)
                            assert(a == c, "JSONEncode must be called with ':' not '.'")
                            return JSONEncode(b)
                        end
                    end 
                end            
                if d == "DataModel" then
                    if h == "FindService" then
                        return function(a, b)
                            assert(a == c, "FindService must be called with ':' not '.'")
                            return e(findservice, a.Data, b)
                        end
                    end
                    if h == "GetService" then
                        return function(a, b)
                            assert(a == c, "GetService must be called with ':' not '.'")
                            return e(findservice, a.Data, b)
                        end
                    end
                    if h == "HttpGet" then
                        return function(a, b)
                            assert(a == c, "HttpGet must be called with ':' not '.'")
                            return httpget(b)
                        end
                    end
                    if h == "HttpPost" then
                        return function(a, b, d, e, f, ...)
                            assert(a == c, "HttpPost must be called with ':' not '.'")
                            return httppost(b, d, e, f, ...)
                        end
                    end
                end
                if h == "GetChildren" then
                    return function(d)
                        assert(d == c, "GetChildren must be called with ':' not '.'")
                        local b = getchildren(b)
                        local c = {}
                        for b, b in ipairs(b) do
                            table.insert(c, a(b))
                        end
                        return c
                    end
                end
                if h == "GetDescendants" then
                    return function(d)
                        assert(d == c, "GetDescendants must be called with ':' not '.'")
                        local b = getdescendants(b)
                        local c = {}
                        for b, b in ipairs(b) do
                            table.insert(c, a(b))
                        end
                        return c
                    end
                end
                if h == "FindFirstChild" then
                    return function(a, b)
                        assert(a == c, "FindFirstChild must be called with ':' not '.'")
                        return e(findfirstchild, a.Data, b)
                    end
                end
                if h == "FindFirstChildOfClass" then
                    return function(a, b)
                        assert(a == c, "FindFirstChildOfClass must be called with ':' not '.'")
                        return e(findfirstchildofclass, a.Data, b)
                    end
                end
                if h == "FindFirstAncestorOfClass" then
                    return function(a, b)
                        assert(a == c, "FindFirstAncestorOfClass must be called with ':' not '.'")
                        return e(findfirstancestorofclass, a.Data, b)
                    end
                end
                if h == "FindFirstDescendant" then
                    return function(a, b)
                        assert(a == c, "FindFirstDescendant must be called with ':' not '.'")
                        return e(findfirstdescendant, a.Data, b)
                    end
                end
                if h == "FindFirstAncestor" then
                    return function(a, b)
                        assert(a == c, "FindFirstAncestor must be called with ':' not '.'")
                        return e(findfirstancestor, a.Data, b)
                    end
                end
                if h == "WaitForChild" then
                    return function(a, b, d)
                        assert(a == c, "WaitForChild must be called with ':' not '.'")
                        return e(waitforchild, a.Data, b, d)
                    end
                end
                if h == "IsAncestorOf" then
                    return function(a, b)
                        assert(a == c, "IsAncestorOf must be called with ':' not '.'")
                        return e(isancestorof, a.Data, b)
                    end
                end
                if h == "IsDescendantOf" then
                    return function(a, b)
                        assert(a == c, "IsDescendantOf must be called with ':' not '.'")
                        return e(isdescendantof, a.Data, b)
                    end
                end
                if h == "Destroy" then
                    return function(a, b)
                        assert(a == c, "Destroy must be called with ':' not '.'")
                        destroy(a.Data)
                    end
                end
                if h == "GetMemoryValue" then
                    return function(a, b, g)
                        assert(a == c, "GetMemoryValue must be called with ':' not '.'")
                        return getmemoryvalue(a.Data, b, g)
                    end
                end
                if h == "SetMemoryValue" then
                    return function(a, b, g, d)
                        assert(a == c, "SetMemoryValue must be called with ':' not '.'")
                        setmemoryvalue(a.Data, b, g, d)
                    end
                end           
                return a(findfirstchild(b, h))
            end
        }
    )
     -- Cache the object before returning it
    lua_cache[b] = c
    return c
end
_G.game = a(Game)
_G.workspace = a(Workspace)
_G.pointer_to_table_data = function(n)
   return a(pointer_to_user_data(n))
end
_G.print = function(...)
    local a, b = {...}, select("#", ...)
    local c = ""
    for b = 1, b do
        if type(a[b]) == "table" then
            if a[b].Name and a[b].Data then
                c = c .. "" .. a[b].Name .. " | "
            end
        end
        if type(a[b]) == "userdata" then
            c = c .. "" .. getname(a[b]) .. " | "
        end
        local a = tostring(a[b])
        c = c .. a .. " "
    end
    return print(c)
end
_G.warn = function(...)
    local a, b = {...}, select("#", ...)
    local c = ""
    for b = 1, b do
        if type(a[b]) == "table" then
            if a[b].Name and a[b].Data then
                c = c .. "" .. a[b].Name .. " | "
            end
        end
        if type(a[b]) == "userdata" then
            c = c .. "" .. getname(a[b]) .. " | "
        end
        local a = tostring(a[b])
        c = c .. a .. " "
    end
    return warn(c)
end
