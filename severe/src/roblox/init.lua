---- environment ---

local map    = require("@external/functions/map")
local memory = require("@external/modules/memory")

---- declarations ----

local Vector3 = require("@roblox/classes/vector3")
local Vector2 = require("@roblox/classes/vector2")
local CFrame  = require("@roblox/classes/cframe")

local Instance = require("@roblox/classes/instance"); do
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
                local userdata: any = getparent(self.Data)
                return userdata and constructor(userdata)
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
                    local userdata: any = f(self.Data, ...)

                    return userdata and constructor(userdata)
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

            Instance.declare("method", "global", "SetMemoryValue", generate(memory.write))
            Instance.declare("method", "global", "GetMemoryValue", generate(memory.read))
            Instance.declare("method", "global", "Read", generate(memory.read))
            Instance.declare("method", "global", "Write", generate(memory.write))
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
            for index, service in getchildren(self.Data) do
                if getclassname(service) == name then
                    return constructor(service)
                end
            end

            return nil
        end)

        Instance.declare("method", "DataModel", "FindService", function(self, name: string)
            local userdata: any = findservice(self.Data, name)
            return userdata and constructor(userdata)
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

        Instance.declare("property", { "BoolValue", "IntValue", "FloatValue", "ObjectValue", "StringValue", "Vector3Value", "ValueBase", "BrickColorValue", "Color3Value", "CFrameValue", "DoubleConstrainedValue", "IntConstrainedValue" }, "Value", {
            getter = function(self)
                return getvalue(self.Data)
            end,

            setter = function(self, value: any)
                setvalue(self.Data, value)
            end
        })
    end

    do
        --- properties ---

        Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part" }, "Size", {
            getter = function(self)
                local size = getsize(self.Data)

                return Vector3.new(size.x, size.y, size.z)
            end
        })

        Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part", "Camera" }, "Position", {
            getter = function(self)
                local position = getposition(self.Data)

                return Vector3.new(position.x, position.y, position.z)
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

                return CFrame.new(
                    tonumber(position.x),     tonumber(position.y),   tonumber(position.z),
                    tonumber(right_vector.x), tonumber(up_vector.x), -tonumber(look_vector.x) :: number,
                    tonumber(right_vector.y), tonumber(up_vector.y), -tonumber(look_vector.y) :: number,
                    tonumber(right_vector.z), tonumber(up_vector.z), -tonumber(look_vector.z) :: number
                )
            end,

            setter = function(self, value: any)
                setcframe(self.Data, value)
            end
        })

        Instance.declare("property", { "UnionOperation", "MeshPart", "TrussPart", "Part" }, "Rotation", {
            getter = function(self)
                local up_vector = getupvector(self.Data)
                local right_vector = getrightvector(self.Data)
                local look_vector = getlookvector(self.Data)

                local cf = CFrame.fromMatrix(
                    Vector3.zero,
                    Vector3.new(right_vector.x, right_vector.y, right_vector.z),
                    Vector3.new(up_vector.x, up_vector.y, up_vector.z),
                    -Vector3.new(look_vector.x, look_vector.y, look_vector.z)
                )

                local rx, ry, rz = cf:ToEulerAnglesXYZ()
                return Vector3.new(math.deg(rx), math.deg(ry), math.deg(rz))
            end,

            setter = function(self, value: any)
                assert(type(value) == "table" and getmetatable(value) == "Vector3", `Instance.Rotation: value must be a Vector3`)

                local rx = math.rad(value.x)
                local ry = math.rad(value.y)
                local rz = math.rad(value.z)

                local rot = CFrame.fromEulerAnglesXYZ(rx, ry, rz)

                local right = Vector3.new(rot.r00, rot.r10, rot.r20)
                local up    = Vector3.new(rot.r01, rot.r11, rot.r21)
                local look  = Vector3.new(-rot.r02, -rot.r12, -rot.r22)

                setrightvector(self.Data, right)
                setupvector(self.Data, up)
                setlookvector(self.Data, look)
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
                local userdata: any = findfirstchildofclass(self.Data, "Camera")
                return userdata and constructor(userdata)
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

                return Vector3.new(velocity.x, velocity.y, velocity.z)
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
                local userdata: any = getprimarypart(self.Data)
                return userdata and constructor(userdata)
            end
        })
    end

    do
        --- properties ---

        Instance.declare("property", "BillboardGui", "Adornee", {
            getter = function(self)
                local userdata: any = getadornee(self.Data)
                return userdata and constructor(userdata)
            end
        })
    end

    do
        --- methods ---

        Instance.declare("property", "Players", "LocalPlayer", {
            getter = function(self)
                local userdata: any = getlocalplayer()
                return userdata and constructor(userdata)
            end
        })
    end

    do
        --- methods ---

        Instance.declare("method", "MouseService", "GetMousePosition", function(self)
            local position = getmouseposition()
            return Vector2.new(position.x, position.y)
        end)

        Instance.declare("method", "MouseService", "GetMouseLocation", function(self)
            local location = getmouselocation(self.Data)
            return Vector2.new(location.x, location.y)
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
            return Vector2.new(result.x, result.y)
        end)

        Instance.declare("method", "MouseService", "SmoothMouseLinear", function(self, origin, point, sensitivity, smoothness)
            assert("table" == type(origin) and #origin >= 2, `MouseService:SmoothMouseLinear: origin must be a table with at least 2 numbers, got {type(origin)}`)
            assert("table" == type(point) and #point >= 2, `MouseService:SmoothMouseLinear: point must be a table with at least 2 numbers, got {type(point)}`)
            assert("number" == type(sensitivity), `MouseService:SmoothMouseLinear: sensitivity must be a number, got {type(sensitivity)}`)
            assert("number" == type(smoothness), `MouseService:SmoothMouseLinear: smoothness must be a number, got {type(smoothness)}`)
            
            local result = smoothmouse_linear(origin, point, sensitivity, smoothness)
            return Vector2.new(result.x, result.y)
        end)
    end
end

---- globalization ----

_G.Instance = Instance

_G.workspace = Instance.new(Workspace)
_G.game = Instance.new(Game)

---- exports ----

return Instance