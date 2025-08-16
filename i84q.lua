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

_G.Instance = Instance
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

---- color3 ----

local Color3 = {} do
    function Color3.new(R, G, B)
        assert(type(R) == "number" and type(G) == "number" and type(B) == "number", "can't construct color with non-numeric arguments")

        local This = setmetatable({
            math.clamp(math.floor(R), 0, 255),
            math.clamp(math.floor(G), 0, 255),
             math.clamp(math.floor(B), 0, 255)
        }, Color3); do
            function This.unpack(This) return { This[1], This[2], This[3] } end
            function This.lerp(This, Target, T) return This + (Target - This) * T end
            function This.distance(This, Other) return math.sqrt((This[1] - Other[1]) ^ 2 + (This[2] - Other[2]) ^ 2 + (This[3] - Other[3]) ^ 2) end
            function This.dword(This) return bit32.bor(This[1], bit32.lshift(This[2], 8), bit32.lshift(This[3], 16)) end
        end

        return This
    end

    function Color3.fromRGB(R, G, B)
        assert(type(R) == "number" and type(G) == "number" and type(B) == "number", "can't construct color with non-numeric arguments")

        return Color3.new(R * 255, G * 255, B * 255)
    end

    function Color3.dword(This, value) return Color3.fromRGB(bit32.band(value, 0xFF), bit32.band(bit32.rshift(value, 8), 0xFF), bit32.band(bit32.rshift(value, 16), 0xFF)) end
    function Color3.__newindex(This, Key, Value) if Key == "R" or Key == "G" or Key == "B" then rawset(This, Key, math.clamp(math.floor(Value), 0, 255)) else rawset(This, Key, Value) end end
    function Color3.__eq(This, Other) return This.R == Other.R and This.G == Other.G and This.B == Other.B end
    function Color3.__tostring(This) return `Color.new({This.R}, {This.G}, {This.B})` end

    function Color3.__add(This, Other) if type(Other) == "table" and Other.R and Other.G and Other.B then return Color3.fromRGB(This[1] + Other[1], This[2] + Other[2], This[3] + Other[3]) end return error(`can't add {type(Other)} to Color`) end
    function Color3.__sub(This, Other) if type(Other) == "table" and Other.R and Other.G and Other.B then return Color3.fromRGB(This[1] - Other[1], This[2] - Other[2], This[3] - Other[3]) end return error(`can't subtract {type(Other)} from Color`) end
    function Color3.__mul(This, Other) if type(Other) == "table" and Other.R and Other.G and Other.B then return Color3.fromRGB(This[1] * Other[1], This[2] * Other[2], This[3] * Other[3]) elseif type(Other) == "number" then return Color3.fromRGB(This[1] * Other, This[2] * Other, This[3] * Other) end return error(`can't multiply {type(Other)} with Color`) end
    function Color3.__div(This, Other) if type(Other) == "table" and Other.R and Other.G and Other.B then return Color3.fromRGB(This[1] / Other[1], This[2] / Other[2], This[3] / Other[3]) elseif type(Other) == "number" then return Color3.fromRGB(This[1] / Other, This[2] / Other, This[3] / Other) end return error(`can't divide {type(Other)} from Color`) end

    Color3.__index = Color3
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
            if not Argument.R or not Argument.G or not Argument.B then
                error(`can't initialize BrickColor, invalid Color`)
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
