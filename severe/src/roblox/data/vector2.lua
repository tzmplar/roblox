---- environment ----

local abs, ceil, floor, sign = math.abs, math.ceil, math.floor, math.sign
local max, min 				 = math.max, math.min

---- module ----

local Vector2 = {}; do
	--- constructor ---

	local function constructor(x: number, y: number)
		assert("number" == type(x), `Vector2.new: expected a number for x, got {type(x)}`)
		assert("number" == type(y), `Vector2.new: expected a number for y, got {type(y)}`)

		return setmetatable( {
			x = x,
			y = y,
		}, Vector2 )
	end

	--- functions ---

	Vector2.new = constructor

	--- methods ---

	function Vector2:abs()
		return constructor(abs(self.x), abs(self.y))
	end

	function Vector2:cross(other)
		assert("table" == type(other) and getmetatable(other) == "Vector2", `Vector2.cross: expected a Vector2, got {type(other)}`)

		return self.x * other.y - self.y * other.x
	end

	function Vector2:ceil()
		return constructor(ceil(self.x), ceil(self.y))
	end

	function Vector2:floor()
		return constructor(floor(self.x), floor(self.y))
	end

	function Vector2:sign()
		return constructor(sign(self.x), sign(self.y))
	end

	function Vector2:angle(other, signed: boolean?)
		assert("table" == type(other) and getmetatable(other) == "Vector2", `Vector2.angle: expected a Vector2, got {type(other)}`)

		local dot = self:dot(other)
		local product = self.magnitude * other.magnitude
		if product == 0 then return 0 end

		local angle = math.acos(dot / product)
		if signed then
			local cross = self:cross(other)

			if cross < 0 then
				angle = -angle
			end
		end

		return angle
	end

	function Vector2:dot(other)
		assert("table" == type(other) and getmetatable(other) == "Vector2", `Vector2.dot: expected a Vector2, got {type(other)}`)

		return self.x * other.x + self.y * other.y
	end

	function Vector2:lerp(other, alpha: number)
		assert("table" == type(other) and getmetatable(other) == "Vector2", `Vector2.lerp: expected a Vector2, got {type(other)}`)
		assert("number" == type(alpha), 					   				`Vector2.lerp: expected a number for alpha, got {type(alpha)}`)

		return constructor(
			self.x + (other.x - self.x) * alpha,
			self.y + (other.y - self.y) * alpha
		)
	end

	function Vector2:max(...)
		for index, vector in { ... } do
			assert("table" == type(vector) and getmetatable(vector) == "Vector2", `Vector2.max: expected a Vector2, got {type(vector)}`)

			self = constructor(
				max(self.x, vector.x),
				max(self.y, vector.y)
			)
		end

		return self
	end

	function Vector2:min(...)
		for index, vector in { ... } do
			assert("table" == type(vector) and getmetatable(vector) == "Vector2", `Vector2.min: expected a Vector2, got {type(vector)}`)

			self = constructor(
				min(self.x, vector.x),
				min(self.y, vector.y)
			)
		end

		return self
	end

	--- properties ---

	Vector2.zero  = constructor(0, 0)
	Vector2.one   = constructor(1, 1)
	Vector2.xAxis = constructor(1, 0)
	Vector2.yAxis = constructor(0, 1)
	Vector2.__metatable = "Vector2"

	--- metatables ---

	function Vector2:__add(other)
		if "number" == type(other) then
			return constructor(self.x + other, self.y + other)
		end

		return constructor(self.x + other.x, self.y + other.y)
	end

	function Vector2:__sub(other)
		if "number" == type(other) then
			return constructor(self.x - other, self.y - other)
		end

		return constructor(self.x - other.x, self.y - other.y)
	end

	function Vector2:__mul(other)
		if "number" == type(other) then
			return constructor(self.x * other, self.y * other)
		end

		return constructor(self.x * other.x, self.y * other.y)
	end

	function Vector2:__div(other)
		if "number" == type(other) then
			return constructor(self.x / other, self.y / other)
		end

		return constructor(self.x / other.x, self.y / other.y)
	end

	function Vector2:__index(index)
		index = string.lower(index)
		if "magnitude" == index then
			return math.sqrt(self.x * self.x + self.y * self.y)
		end

		if "unit" == index then
			local magnitude = self.magnitude

			return magnitude ~= 0 and constructor(self.x / magnitude, self.y / magnitude) or self
		end

		return rawget(Vector2, index) or self[index]
	end

	function Vector2:__tostring()
		return `{self.x}, {self.y}`
	end
end

---- exports ----

return table.freeze(Vector2)
