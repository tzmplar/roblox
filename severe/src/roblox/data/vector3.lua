---- environment ----

local abs, ceil, floor, sign = math.abs, math.ceil, math.floor, math.sign
local max, min               = math.max, math.min

---- module ----

local Vector3 = {}; do
	--- constructor ---

	local function constructor(x: number, y: number, z: number)
		assert("number" == type(x), `Vector3.new: expected a number for x, got {type(x)}`)
		assert("number" == type(y), `Vector3.new: expected a number for y, got {type(y)}`)
		assert("number" == type(z), `Vector3.new: expected a number for z, got {type(z)}`)

		return setmetatable({
			x = x,
			y = y,
			z = z,
		}, Vector3)
	end

	--- functions ---

	Vector3.new = constructor

	--- methods ---

	function Vector3:abs()
		return constructor(abs(self.x), abs(self.y), abs(self.z))
	end

	function Vector3:cross(other)
		assert("table" == type(other) and getmetatable(other) == "Vector3", `Vector3.cross: expected a Vector3, got {type(other)}`)

		-- exports --

		return constructor(
			self.y * other.z - self.z * other.y,
			self.z * other.x - self.x * other.z,
			self.x * other.y - self.y * other.x
		)
	end

	function Vector3:ceil()
		return constructor(ceil(self.x), ceil(self.y), ceil(self.z))
	end

	function Vector3:floor()
		return constructor(floor(self.x), floor(self.y), floor(self.z))
	end

	function Vector3:sign()
		return constructor(sign(self.x), sign(self.y), sign(self.z))
	end

	function Vector3:angle(other, signed: boolean?)
		assert("table" == type(other) and getmetatable(other) == "Vector3", `Vector3.angle: expected a Vector3, got {type(other)}`)

		local dot = self:dot(other)
		local product = self.magnitude * other.magnitude
		if product == 0 then return 0 end

		local angle = math.acos(dot / product)
		if signed then
			local cross = self:cross(other).z
			if cross < 0 then
				angle = -angle
			end
		end

		-- exports --

		return angle
	end

	function Vector3:dot(other)
		assert("table" == type(other) and getmetatable(other) == "Vector3", `Vector3.dot: expected a Vector3, got {type(other)}`)

		-- exports --

		return self.x * other.x + self.y * other.y + self.z * other.z
	end

	function Vector3:lerp(other, alpha: number)
		assert("table" == type(other) and getmetatable(other) == "Vector3", `Vector3.lerp: expected a Vector3, got {type(other)}`)
		assert("number" == type(alpha), 					   				`Vector3.lerp: expected a number for alpha, got {type(alpha)}`)

		-- exports --

		return constructor(
			self.x + (other.x - self.x) * alpha,
			self.y + (other.y - self.y) * alpha,
			self.z + (other.z - self.z) * alpha
		)
	end

	function Vector3:max(...)
		for index, vector in { ... } do
			assert("table" == type(vector) and getmetatable(vector) == "Vector3", `Vector3.max: expected a Vector3, got {type(vector)}`)

			self = constructor(
				max(self.x, vector.x),
				max(self.y, vector.y),
				max(self.z, vector.z)
			)
		end

		-- exports --

		return self
	end

	function Vector3:min(...)
		for index, vector in { ... } do
			assert("table" == type(vector) and getmetatable(vector) == "Vector3", `Vector3.min: expected a Vector3, got {type(vector)}`)

			self = constructor(
				min(self.x, vector.x),
				min(self.y, vector.y),
				min(self.z, vector.z)
			)
		end

		-- exports --

		return self
	end

	function Vector3:fuzzyeq(other, epsilon: number?)
		assert("table" == type(other) and getmetatable(other) == "Vector3", `Vector3.fuzzyeq: expected a Vector3, got {type(other)}`)
		assert("number" == type(epsilon) or "nil" == type(epsilon), `Vector3.fuzzyeq: expected a number for epsilon, got {type(epsilon)}`)

		epsilon = epsilon or 0.0001

		return abs(self.x - other.x) <= epsilon and
		       abs(self.y - other.y) <= epsilon and
		       abs(self.z - other.z) <= epsilon
	end

	--- properties ---

	Vector3.zero  		= constructor(0, 0, 0)
	Vector3.one   		= constructor(1, 1, 1)
	Vector3.xAxis 		= constructor(1, 0, 0)
	Vector3.yAxis 		= constructor(0, 1, 0)
	Vector3.zAxis 		= constructor(0, 0, 1)
	Vector3.__metatable = "Vector3"

	--- metatables ---

	function Vector3:__add(other)
		if "number" == type(other) then
			return constructor(self.x + other, self.y + other, self.z + other)
		end

		-- exports --

		return constructor(self.x + other.x, self.y + other.y, self.z + other.z)
	end

	function Vector3:__sub(other)
		if "number" == type(other) then
			return constructor(self.x - other, self.y - other, self.z - other)
		end

		-- exports --

		return constructor(self.x - other.x, self.y - other.y, self.z - other.z)
	end

	function Vector3:__mul(other)
		if "number" == type(other) then
			return constructor(self.x * other, self.y * other, self.z * other)
		end

		-- exports --

		return constructor(self.x * other.x, self.y * other.y, self.z * other.z)
	end

	function Vector3:__div(other)
		if "number" == type(other) then
			return constructor(self.x / other, self.y / other, self.z / other)
		end

		-- exports --

		return constructor(self.x / other.x, self.y / other.y, self.z / other.z)
	end

	function Vector3:__idiv(other)
		if "number" == type(other) then
			return constructor(floor(self.x // other), floor(self.y // other), floor(self.z // other))
		end

		-- exports --

		return constructor(floor(self.x // other.x), floor(self.y // other.y), floor(self.z // other.z))
	end

	function Vector3:__index(index)
		index = string.lower(index)
		if "magnitude" == index then
			return math.sqrt(self.x * self.x + self.y * self.y + self.z * self.z)
		end

		if "unit" == index then
			local magnitude = self.magnitude
			return magnitude ~= 0 and constructor(self.x / magnitude, self.y / magnitude, self.z / magnitude) or self
		end

		-- exports --

		return rawget(Vector3, index) or self[index]
	end

	function Vector3:__tostring()
		return `{self.x}, {self.y}, {self.z}`
	end
end

---- exports ----

return table.freeze(Vector3)