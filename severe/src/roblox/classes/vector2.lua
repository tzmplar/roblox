local Vector2 = {}
local sqrt = math.sqrt

function Vector2.new(x, y)
	assert(tonumber(x) or (x == nil), "Vector2 coordinates can only be numbers")
	assert(tonumber(x) or (x == nil), "Vector2 coordinates can only be numbers")
	local vec2 = {}
	setmetatable(vec2, Vector2)
	vec2.x = x or 0
	vec2.y = y or 0
	vec2.Type = "Vector2"
	return vec2
end

function Vector2.__index(self, index)
	if index == "magnitude" then
		local x, y = rawget(self, "x"), rawget(self, "y")
		return sqrt(x * x + y * y)
	elseif index == "unit" then
		local x, y = rawget(self, "x"), rawget(self, "y")
		local len = sqrt(x * x + y * y)
		if len == 0 then
			return self
		end
		return Vector2.new(x / len, y / len)
	end
	return rawget(Vector2, index)
end

function Vector2:__tostring()
	return self.x .. ", " .. self.y
end

function Vector2.__eq(lhs, rhs)
	assert(rhs.Type == "Vector2", "Cannot compare Vector2 with " .. tostring(rhs))
	if lhs.x == rhs.x and lhs.y == rhs.y then
		return true
	end
	return false
end

function Vector2.__add(lhs, rhs)
	if type(rhs) == "number" then
		return Vector2.new(lhs.x + rhs, lhs.y + rhs)
	end
	return Vector2.new(lhs.x + rhs.x, lhs.y + rhs.y)
end

function Vector2.__mul(lhs, rhs)
	if type(rhs) == "number" then
		return Vector2.new(lhs.x * rhs, lhs.y * rhs)
	end
	return Vector2.new(lhs.x * rhs.x, lhs.y * rhs.y)
end

function Vector2.__div(lhs, rhs)
	if type(rhs) == "number" then
		return Vector2.new(lhs.x / rhs, lhs.y / rhs)
	end
	return Vector2.new(lhs.x / rhs.x, lhs.y / rhs.y)
end

function Vector2.__sub(lhs, rhs)
	if type(rhs) == "number" then
		return Vector2.new(lhs.x - rhs, lhs.y - rhs)
	end
	return Vector2.new(lhs.x - rhs.x, lhs.y - rhs.y)
end

return Vector2
