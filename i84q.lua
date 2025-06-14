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
        if type(a) ~= "string" then
            error("'tostring' must return a string - print function")
        end
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
        if type(a) ~= "string" then
            error("'tostring' must return a string - warn function")
        end
        c = c .. a .. " "
    end
    return warn(c)
end
