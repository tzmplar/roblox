local Vector3 = {}

local _ = { __index = Vector3 }

-----------------------
----| Metamethods |----
-----------------------

function _.__add(a, b)
	return Vector3.new(a.x + b.x, a.y + b.y, a.z + b.z)
end

function _.__sub(a, b)
	return Vector3.new(a.x - b.x, a.y - b.y, a.z - b.z)
end

function _:__unm()
	return Vector3.new(-self.x, -self.y, -self.z)
end

function _.__eq(a, b)
	if a.x == b.x and a.y == b.y and a.z == b.z then
		return true
	else
		return false
	end
end

function _:__tostring()
	return "(" .. self.x .. ", " .. self.y .. ", " .. self.z .. ")"
end

function _.__concat(a, b)
	return tostring(a) .. tostring(b)
end

function _.__mul(a, b)
	if type(b) == "number" then
		return Vector3.new(a.x * b, a.y * b, a.z * b)
	end

	return Vector3.new(a.x * b.x, a.y * b.y, a.z * b.z)
end

function _.__div(a, b) -- Unsure if useful but kept just in case.
	if type(b) == "number" then
		if b == 0 then
			print("Attempted to divide by zero. Returning nil")
			return nil
		end

		return Vector3.new(a.x / b, a.y / b, a.z / b)
	end

	if b.x == 0 or b.y == 0 or b.z == 0 then
		print("Attempted to divide by zero. Returning nil.")
		return nil
	end

	return Vector3.new(a.x / b.x, a.y / b.y, a.z / b.z)
end

---------------------------
----| Vector3 Methods |----
---------------------------

function Vector3.new(x, y, z)
	return setmetatable({
		x = x or 0,
		y = y or 0,
		z = z or 0,
	}, _)
end

function Vector3.lerp(start, finish, ratio)
	return Vector3.new(
		start.x + (finish.x - start.x) * ratio,
		start.y + (finish.y - start.y) * ratio,
		start.z + (finish.z - start.z) * ratio
	)
end

function Vector3:distance(other)
	return math.sqrt((self.x - other.x) ^ 2 + (self.y - other.y) ^ 2 + (self.z - other.z) ^ 2)
end

function Vector3:magnitude()
	return math.sqrt(self.x ^ 2 + self.y ^ 2 + self.z ^ 2)
end

function Vector3:normalized()
	local magnitude = self:magnitude()

	if magnitude == 0 then
		return Vector3.new()
	end

	return Vector3.new(self.x / magnitude, self.y / magnitude, self.z / magnitude)
end

function Vector3:dot(other)
	return ((self.x * other.x) + (self.y * other.y) + (self.z * other.z))
end

function Vector3:cross(other)
	local result = Vector3.new(
		(self.y * other.z) - (self.z * other.y),
		(self.z * other.x) - (self.x * other.z),
		(self.x * other.y) - (self.y * other.x)
	)

	-- Doing some workarounds to avoid '-0' in Lua.
	if result.x == 0 then
		result.x = 0
	end
	if result.y == 0 then
		result.y = 0
	end
	if result.z == 0 then
		result.z = 0
	end

	return result
end

function Vector3:tostring()
	return tostring(self)
end

---- Vector3 Fields ----
Vector3.zero = Vector3.new(0, 0, 0)
Vector3.up = Vector3.new(0, 1, 0)
Vector3.down = Vector3.new(0, -1, 0)
Vector3.left = Vector3.new(-1, 0, 0)
Vector3.right = Vector3.new(1, 0, 0)
Vector3.forward = Vector3.new(0, 0, 1)
Vector3.back = Vector3.new(0, 0, -1)

return Vector3
