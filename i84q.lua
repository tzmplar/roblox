---- functions ----

local function merge(a, b)
    if not a then return b elseif not b then return a end

    for k, v in pairs(b) do 
        a[k] = v 
    end

    return a
end

local function map(t, f)
    local result = {}

    for k, v in t do
        result[k] = f(v, k)
    end

    return result
end

---- classes ----

local Instance = {}; do
    --- constants ---

    local declarations = { global = {} }

    --- constructor ---

    local function constructor(userdata: any)
        userdata = "userdata" == type(userdata) and userdata or "table" == type(userdata) and rawget(userdata, "Data")
        assert("userdata" == type(userdata), `Instance.new: userdata must be a userdata, got {type(userdata)}`)

        return setmetatable( { ClassName = getclassname(userdata), Data = userdata }, { __index = Instance.__index } )
    end

    --- functions ---

    Instance.new = constructor

    function Instance.declare<T>(value: "property" | "method", class: string | { string }, name: string, definition: T | (self: typeof(Instance)) -> any)
        -- assertions --

        assert("string" == type(name), `Instance.declare: name must be a string, got {type(name)}`)
        assert("property" == value or "method" == value, `Instance.declare: value must be "property" or "method", got {value}`)
        assert("table" == type(class) or "string" == type(class), `Instance.declare: class must be a string or a table of strings, got {type(class)}`)

        -- declaration --

        if "string" == type(class) then
            declarations[class] = merge(declarations[class], {
                [name] = {
                    [value] = definition
                }
            })
        else
            for index, class in class do
                declarations[class] = merge(declarations[class], {
                    [name] = {
                        [value] = definition
                    }
                })
            end
        end
    end

    --- metatables ---

    function Instance:__index(key: string)
        assert("string" == type(key), `Instance:__index: key must be a string, got {type(key)}`)
        
        do
            local class = self.ClassName
            local declaration = declarations.global[key] or (declarations[class] and declarations[class][key])

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
            constructor(findfirstchild(self.Data, key)) or
            Instance[key]
    end
end

---- declarations ----

local constructor = Instance.new

do
    --- properties ---

    Instance.declare("property", "global", "Name", {
        getter = function(self)
            return getname(self.Data)
        end
    })

    Instance.declare("property", "global", "Parent", {
        getter = function(self)
            return constructor(getparent(self.Data))
        end
    })

    --- methods ---

    Instance.declare("method", "global", "GetChildren", function(self)
        return map(getchildren(self.Data), constructor)
    end)

    Instance.declare("method", "global", "GetDescendants", function(self)
        return map(getdescendants(self.Data), constructor)
    end)

    do
        local generate = function(f)
            return function(self, ...)
                print(self, ...)
                return constructor(f(self.Data, ...))
            end
        end

        Instance.declare("method", "global", "FindFirstChild", generate(findfirstchild))
        Instance.declare("method", "global", "FindFirstAncestor", generate(findfirstancestor))
        Instance.declare("method", "global", "FindFirstChildOfClass", generate(findfirstchildofclass))
        Instance.declare("method", "global", "FindFirstAncestorOfClass", generate(findfirstancestorofclass))
        Instance.declare("method", "global", "WaitForChild", generate(waitforchild))
    end

    do
        local generate = function(f)
            return function(self, ...)
                return f(self.Data, ...)
            end
        end

        Instance.declare("method", "global", "SetMemoryValue", generate(setmemoryvalue))
        Instance.declare("method", "global", "GetMemoryValue", generate(getmemoryvalue))
        Instance.declare("method", "global", "Read", generate(getmemoryvalue))
        Instance.declare("method", "global", "Write", generate(setmemoryvalue))
    end

    Instance.declare("method", "global", "IsA", function(self, class: string)
        assert("string" == type(class), `Instance:IsA: class must be a string, got {type(class)}`)

        return self.ClassName == class
    end)

    Instance.declare("method", "global", "IsAncestorOf", function(self, other)
        assert("userdata" == type(other) or type(other) == "table" and other.Data, `Instance:IsAncestorOf: other must be a userdata or an Instance, got {type(other)}`)

        return isancestorof(self.Data, type(other) == "userdata" and other or other.Data)
    end)

    Instance.declare("method", "global", "IsDescendantOf", function(self, other)
        assert("userdata" == type(other) or type(other) == "table" and other.Data, `Instance:IsDescendantOf: other must be a userdata or an Instance, got {type(other)}`)

        return isdescendantof(self.Data, type(other) == "userdata" and other or other.Data)
    end)
    
    Instance.declare("method", "global", "Destroy", function(self)
        return destroy(self.Data)
    end)
end

do
    --- properties ---

    Instance.declare("property", "DataModel", "PlaceId", {
        getter = function(self)
            return getplaceid()
        end
    })

    Instance.declare("property", "DataModel", "GameId", {
        getter = function(self)
            return getgameid()
        end
    })

    --- methods ---

    Instance.declare("method", "DataModel", "GetService", function(self, name: string)
        return constructor(findservice(self.Data, name))
    end)

    Instance.declare("method", "DataModel", "FindService", function(self, name: string)
        return constructor(findservice(self.Data, name))
    end)

    Instance.declare("method", "DataModel", "HttpGet", function(self, url: string)
        assert("string" == type(url), `DataModel:HttpGet: url must be a string, got {type(url)}`)

        return httpget(url)
    end)

    Instance.declare("method", "DataModel", "HttpPost", function(self, url: string, data: string, ...)
        assert("string" == type(url), `DataModel:HttpPost: url must be a string, got {type(url)}`)
        assert("string" == type(data), `DataModel:HttpPost: data must be a string, got {type(data)}`)

        return httppost(url, data, ...)
    end)
end

do
    --- methods ---

    Instance.declare("method", "HttpService", "JSONEncode", function(self, value: any)
        assert("table" == type(value), `HttpService:JSONEncode: value must be a table, got {type(value)}`)

        return JSONEncode(value)
    end)

    Instance.declare("method", "HttpService", "JSONDecode", function(self, value: string)
        assert("string" == type(value), `HttpService:JSONDecode: value must be a string, got {type(value)}`)

        return JSONDecode(value)
    end)
end

do
    --- properties ---

    Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part" }, "Size", {
        getter = function(self)
            local size = getsize(self.Data)

            return vector.create(size.x, size.y, size.z)
        end
    })

    Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part", "Camera" }, "Position", {
        getter = function(self)
            local position = getposition(self.Data)

            return vector.create(position.x, position.y, position.z)
        end,

        setter = function(self, value: vector | { x: number, y: number, z: number })
            assert("table" == type(value) and value.x and value.y and value.z, `Instance:Position: value must be a Vector3, got {type(value)}`)

            setposition(self.Data, value)
        end
    })

    Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part", "Camera" }, "CFrame", {
        getter = function(self)
            local position = getposition(self.Data)
            local up_vector = getupvector(self.Data)
            local right_vector = getrightvector(self.Data)
            local look_vector = getlookvector(self.Data)

            return {
                Position = vector.create(position.x, position.y, position.z),
                UpVector = vector.create(up_vector.x, up_vector.y, up_vector.z),
                RightVector = vector.create(right_vector.x, right_vector.y, right_vector.z),
                LookVector = vector.create(look_vector.x, look_vector.y, look_vector.z)
            }
        end,

        setter = function(self, value: any)
            setcframe(self.Data, value)
        end
    })

    Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part" }, "Transparency", {
        getter = function(self)
            return gettransparency(self.Data)
        end,

        setter = function(self, value: number)
            settransparency(self.Data, value)
        end
    })
end

do
    --- properties ---

    Instance.declare("property", "Player", "Character", {
        getter = function(self)
            return constructor(getcharacter(self.Data))
        end
    })

    Instance.declare("property", "Player", "Team", {
        getter = function(self)
            return constructor(getteam(self.Data))
        end
    })

    Instance.declare("property", "Player", "DisplayName", {
        getter = function(self)
            return getdisplayname(self.Data)
        end
    })

    Instance.declare("property", "Player", "UserId", {
        getter = function(self)
            return getuserid(self.Data)
        end
    })
end

do
    --- properties ---

    Instance.declare("property", "Workspace", "CurrentCamera", {
        getter = function(self)
            return constructor(findfirstchildofclass(self.Data, "Camera"))
        end
    })
end

do
    --- properties ---

    Instance.declare("property", "Camera", "FieldOfView", {
        getter = function(self)
            return getcamerafov(self.Data)
        end
    })

    Instance.declare("method", "Camera", "SetCameraSubject", function(self, subject)
        assert(type(subject) == "table" and subject.Data, `Camera:SetCameraSubject: subject must be an Instance, got {type(subject)}`)
        
        return setcamerasubject(subject.Data)
    end)
end

do
    --- properties ---

    Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part" }, "CanCollide", {
        getter = function(self)
            return getcancollide(self.Data)
        end,

        setter = function(self, value: boolean)
            assert(type(value) == "boolean", `Instance:CanCollide: value must be a boolean, got {type(value)}`)

            setcancollide(self.Data, value)
        end
    })

    Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part" }, "Velocity", {
        getter = function(self)
            local velocity = getvelocity(self.Data)

            return vector.create(velocity.x, velocity.y, velocity.z)
        end,

        setter = function(self, value: vector | { x: number, y: number, z: number })
            assert("table" == type(value) and value.x and value.y and value.z, `Instance:Velocity: value must be a Vector3, got {type(value)}`)

            setvelocity(self.Data, value)
        end
    })
end

do
    --- properties ---

    Instance.declare("property", "MeshPart", "TextureID", {
        getter = function(self)
            return gettextureid(self.Data)
        end
    })

    Instance.declare("property", "MeshPart", "MeshID", {
        getter = function(self)
            return getmeshid(self.Data)
        end
    })
end

do
    --- properties ---

    Instance.declare("property", "Humanoid", "Health", {
        getter = function(self)
            return gethealth(self.Data)
        end
    })

    Instance.declare("property", "Humanoid", "MaxHealth", {
        getter = function(self)
            return getmaxhealth(self.Data)
        end
    })
end

do
    --- properties ---

    Instance.declare("property", "Model", "PrimaryPart", {
        getter = function(self)
            return constructor(getprimarypart(self.Data))
        end
    })
end

do
    --- properties ---

    Instance.declare("property", "BillboardGui", "Adornee", {
        getter = function(self)
            return constructor(getadornee(self.Data))
        end
    })
end

do
    --- methods ---

    Instance.declare("property", "Players", "LocalPlayer", {
        getter = function(self)
            return constructor(getlocalplayer())
        end
    })
end

do
    --- methods ---

    Instance.declare("method", "MouseService", "GetMousePosition", function(self)
        local position = getmouseposition()
        return vector.create(position.x, position.y)
    end)

    Instance.declare("method", "MouseService", "GetMouseLocation", function(self)
        local location = getmouselocation(self.Data)
        return vector.create(location.x, location.y)
    end)

    Instance.declare("method", "MouseService", "GetMouseBehavior", function(self)
        return getmousebehavior(self.Data)
    end)

    Instance.declare("method", "MouseService", "GetMouseDeltaSensitivity", function(self)
        return getmousedeltasensitivity(self.Data)
    end)

    Instance.declare("method", "MouseService", "IsMouseIconEnabled", function(self)
        return ismouseiconenabled(self.Data)
    end)

    Instance.declare("method", "MouseService", "SetMouseLocation", function(self, x, y)
        assert("number" == type(x), `MouseService:SetMouseLocation: x must be a number, got {type(x)}`)
        assert("number" == type(y), `MouseService:SetMouseLocation: y must be a number, got {type(y)}`)
        
        setmouselocation(self.Data, x, y)
    end)

    Instance.declare("method", "MouseService", "SetMouseIconEnabled", function(self, enabled)
        assert("boolean" == type(enabled), `MouseService:SetMouseIconEnabled: enabled must be a boolean, got {type(enabled)}`)
        
        setmouseiconenabled(self.Data, enabled)
    end)

    Instance.declare("method", "MouseService", "SetMouseBehavior", function(self, behavior)
        assert("number" == type(behavior), `MouseService:SetMouseBehavior: behavior must be a number, got {type(behavior)}`)
        
        setmousebehaviour(self.Data, behavior)
    end)

    Instance.declare("method", "MouseService", "SetMouseDeltaSensitivity", function(self, sensitivity)
        assert("number" == type(sensitivity), `MouseService:SetMouseDeltaSensitivity: sensitivity must be a number, got {type(sensitivity)}`)
        
        setmousedeltasensitivity(self.Data, sensitivity)
    end)
    
    Instance.declare("method", "MouseService", "SmoothMouseExponential", function(self, origin, point, speed)
        assert("table" == type(origin) and #origin >= 2, `MouseService:SmoothMouseExponential: origin must be a table with at least 2 numbers, got {type(origin)}`)
        assert("table" == type(point) and #point >= 2, `MouseService:SmoothMouseExponential: point must be a table with at least 2 numbers, got {type(point)}`)
        assert("number" == type(speed), `MouseService:SmoothMouseExponential: speed must be a number, got {type(speed)}`)
        
        local result = smoothmouse_exponential(origin, point, speed)
        return vector.create(result.x, result.y)
    end)

    Instance.declare("method", "MouseService", "SmoothMouseLinear", function(self, origin, point, sensitivity, smoothness)
        assert("table" == type(origin) and #origin >= 2, `MouseService:SmoothMouseLinear: origin must be a table with at least 2 numbers, got {type(origin)}`)
        assert("table" == type(point) and #point >= 2, `MouseService:SmoothMouseLinear: point must be a table with at least 2 numbers, got {type(point)}`)
        assert("number" == type(sensitivity), `MouseService:SmoothMouseLinear: sensitivity must be a number, got {type(sensitivity)}`)
        assert("number" == type(smoothness), `MouseService:SmoothMouseLinear: smoothness must be a number, got {type(smoothness)}`)
        
        local result = smoothmouse_linear(origin, point, sensitivity, smoothness)
        return vector.create(result.x, result.y)
    end)
end

_G.game = Instance.new(Game)
_G.workspace = Instance.new(Workspace)

function _G.pointer_to_table_data(n)
    assert("number" == type(n), `pointer_to_table_data: n must be a number, got {type(n)}`)

    local data = pointer_to_user_data(n)
    return data and Instance.new(data) or nil
end

---- to rewrite ----

do
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

    _G.print = function(...)
        local args, count = {...}, select("#", ...)
        local output = ""

        for i = 1, count do
            local v = args[i]

            if type(v) == "table" then
                if v.Name and v.Data then
                    output = output .. v.Name .. " | "
                end
            elseif type(v) == "userdata" then
                output = output .. getname(v) .. " | "
            end

            local str = tostring(v)
            if type(str) ~= "string" then
                error("'tostring' must return a string - print function")
            end

            output = output .. str .. " "
        end

        return print(output)
    end

    _G.warn = function(...)
        local args, count = {...}, select("#", ...)
        local output = ""

        for i = 1, count do
            local v = args[i]

            if type(v) == "table" then
                if v.Name and v.Data then
                    output = output .. v.Name .. " | "
                end
            elseif type(v) == "userdata" then
                output = output .. getname(v) .. " | "
            end

            local str = tostring(v)
            if type(str) ~= "string" then
                error("'tostring' must return a string - warn function")
            end

            output = output .. str .. " "
        end

        return warn(output)
    end
end
