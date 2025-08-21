---- environment ----

local Vector3             = require("@roblox/classes/vector3")
local abs, sqrt, sin, cos = math.abs, math.sqrt, math.sin, math.cos
local acos, atan, clamp   = math.acos, math.atan2, math.clamp

---- functions ----

local function isVector3(v) return "table" == type(v) and getmetatable(v) == "Vector3" end
local function isCFrame(v) return "table" == type(v) and getmetatable(v) == "CFrame" end

---- module ----

local CFrame = {}
do
	--- constructor ---

	local function constructor(
		x: number, y: number, z: number,
		r00: number?, r01: number?, r02: number?,
		r10: number?, r11: number?, r12: number?,
		r20: number?, r21: number?, r22: number?
	)
		assert("number" == type(x), `CFrame.new: expected a number for x, got {type(x)}`)
		assert("number" == type(y), `CFrame.new: expected a number for y, got {type(y)}`)
		assert("number" == type(z), `CFrame.new: expected a number for z, got {type(z)}`)

		r00 = r00 or 1
        r01 = r01 or 0
        r02 = r02 or 0
		r10 = r10 or 0
        r11 = r11 or 1
        r12 = r12 or 0
		r20 = r20 or 0
        r21 = r21 or 0
        r22 = r22 or 1

		return setmetatable({
			x = x, y = y, z = z,
			r00 = r00, r01 = r01, r02 = r02,
			r10 = r10, r11 = r11, r12 = r12,
			r20 = r20, r21 = r21, r22 = r22,
		}, CFrame)
	end

    --- private functions ---

	local function fromQuaternion(x, y, z, qx, qy, qz, qw)
		local len = sqrt(qx*qx + qy*qy + qz*qz + qw*qw)
		if len == 0 then
			return constructor(x, y, z)
		end
		qx, qy, qz, qw = qx/len, qy/len, qz/len, qw/len

		local xx, yy, zz = qx*qx, qy*qy, qz*qz
		local xy, xz, yz = qx*qy, qx*qz, qy*qz
		local wx, wy, wz = qw*qx, qw*qy, qw*qz

		local r00 = 1 - 2*(yy + zz)
		local r01 = 2*(xy + wz)
		local r02 = 2*(xz - wy)

		local r10 = 2*(xy - wz)
		local r11 = 1 - 2*(xx + zz)
		local r12 = 2*(yz + wx)

		local r20 = 2*(xz + wy)
		local r21 = 2*(yz - wx)
		local r22 = 1 - 2*(xx + yy)

		return constructor(x, y, z, r00, r01, r02, r10, r11, r12, r20, r21, r22)
	end

	local function toQuaternion(cf)
		local r00, r01, r02 = cf.r00, cf.r01, cf.r02
		local r10, r11, r12 = cf.r10, cf.r11, cf.r12
		local r20, r21, r22 = cf.r20, cf.r21, cf.r22

		local trace = r00 + r11 + r22
		local qw, qx, qy, qz
		if trace > 0 then
			local s = sqrt(trace + 1.0) * 2
			qw = 0.25 * s
			qx = (r21 - r12) / s
			qy = (r02 - r20) / s
			qz = (r10 - r01) / s
		elseif r00 > r11 and r00 > r22 then
			local s = sqrt(1.0 + r00 - r11 - r22) * 2
			qw = (r21 - r12) / s
			qx = 0.25 * s
			qy = (r01 + r10) / s
			qz = (r02 + r20) / s
		elseif r11 > r22 then
			local s = sqrt(1.0 + r11 - r00 - r22) * 2
			qw = (r02 - r20) / s
			qx = (r01 + r10) / s
			qy = 0.25 * s
			qz = (r12 + r21) / s
		else
			local s = sqrt(1.0 + r22 - r00 - r11) * 2
			qw = (r10 - r01) / s
			qx = (r02 + r20) / s
			qy = (r12 + r21) / s
			qz = 0.25 * s
		end

		local len = sqrt(qx*qx + qy*qy + qz*qz + qw*qw)
		if len == 0 then
			return 0, 0, 0, 1
		end

		return qx/len, qy/len, qz/len, qw/len
	end

	local function slerp(qx1, qy1, qz1, qw1, qx2, qy2, qz2, qw2, alpha)
		local dot = qx1*qx2 + qy1*qy2 + qz1*qz2 + qw1*qw2
		if dot < 0 then
			qx2, qy2, qz2, qw2 = -qx2, -qy2, -qz2, -qw2
			dot = -dot
		end

		local EPS = 1e-6
		if dot > 1 - EPS then
			local qx = qx1 + (qx2 - qx1) * alpha
			local qy = qy1 + (qy2 - qy1) * alpha
			local qz = qz1 + (qz2 - qz1) * alpha
			local qw = qw1 + (qw2 - qw1) * alpha
			local len = sqrt(qx*qx + qy*qy + qz*qz + qw*qw)

			return qx/len, qy/len, qz/len, qw/len
		end

		local theta0 = acos(clamp(dot, -1, 1))
		local sinTheta0 = sin(theta0)
		local theta = theta0 * alpha
		local sinTheta = sin(theta)

		local s0 = cos(theta) - dot * sinTheta / sinTheta0
		local s1 = sinTheta / sinTheta0

		local qx = s0*qx1 + s1*qx2
		local qy = s0*qy1 + s1*qy2
		local qz = s0*qz1 + s1*qz2
		local qw = s0*qw1 + s1*qw2
		return qx, qy, qz, qw
	end

	local function matMul(a, b)
		return
			a.r00*b.r00 + a.r01*b.r10 + a.r02*b.r20,
			a.r00*b.r01 + a.r01*b.r11 + a.r02*b.r21,
			a.r00*b.r02 + a.r01*b.r12 + a.r02*b.r22,

			a.r10*b.r00 + a.r11*b.r10 + a.r12*b.r20,
			a.r10*b.r01 + a.r11*b.r11 + a.r12*b.r21,
			a.r10*b.r02 + a.r11*b.r12 + a.r12*b.r22,

			a.r20*b.r00 + a.r21*b.r10 + a.r22*b.r20,
			a.r20*b.r01 + a.r21*b.r11 + a.r22*b.r21,
			a.r20*b.r02 + a.r21*b.r12 + a.r22*b.r22
	end

	local function rotTranspose(cf)
		return
			cf.r00, cf.r10, cf.r20,
			cf.r01, cf.r11, cf.r21,
			cf.r02, cf.r12, cf.r22
	end

	local function rotateVec(cf, v)
		return Vector3.new(
			cf.r00*v.x + cf.r01*v.y + cf.r02*v.z,
			cf.r10*v.x + cf.r11*v.y + cf.r12*v.z,
			cf.r20*v.x + cf.r21*v.y + cf.r22*v.z
		)
	end

	local function rotateVecT(cf, v)
		return Vector3.new(
			cf.r00*v.x + cf.r10*v.y + cf.r20*v.z,
			cf.r01*v.x + cf.r11*v.y + cf.r21*v.z,
			cf.r02*v.x + cf.r12*v.y + cf.r22*v.z
		)
	end

	local function columnsFromEuler(rx, ry, rz, order)
		order = string.upper(order or "XYZ")

		local cx, sx = cos(rx), sin(rx)
		local cy, sy = cos(ry), sin(ry)
		local cz, sz = cos(rz), sin(rz)

		local function matXYZ()
			local r00 = cy*cz
			local r01 = cx*sz + sx*sy*cz
			local r02 = sx*sz - cx*sy*cz

			local r10 = -cy*sz
			local r11 = cx*cz - sx*sy*sz
			local r12 = sx*cz + cx*sy*sz

			local r20 = sy
			local r21 = -sx*cy
			local r22 = cx*cy

			return r00,r01,r02, r10,r11,r12, r20,r21,r22
		end

		local function matYXZ()
			local r00 = cy*cz + sy*sx*sz
			local r01 = cx*sz
			local r02 = cy*sx*sz - sy*cz

			local r10 = sy*cz - cy*sx*sz
			local r11 = cx*cz
			local r12 = sy*sx*sz + cy*cz

			local r20 = sx*sy
			local r21 = -sx
			local r22 = cx*cy

			return r00,r01,r02, r10,r11,r12, r20,r21,r22
		end

		if order == "XYZ" then
			return matXYZ()
		elseif order == "YXZ" then
			return matYXZ()
		else
			return matXYZ()
		end
	end

	--- public functions ---

	CFrame.new = function(...)
		local n = select("#", ...)
		if n == 0 then
			return constructor(0, 0, 0)
		end

		local a1 = select(1, ...)
		if n == 1 and isVector3(a1) then
			return constructor(a1.x, a1.y, a1.z)
		end

		if n == 2 and isVector3(a1) and isVector3(select(2, ...)) then
			local pos = a1 :: any
			local lookAt = select(2, ...) :: any

			return CFrame.lookAt(pos, lookAt)
		end

		if n == 3 then
			local x, y, z = a1, select(2, ...), select(3, ...)
			assert("number" == type(x) and "number" == type(y) and "number" == type(z),
				`CFrame.new: expected numbers for x,y,z, got {type(x)},{type(y)},{type(z)}`)

			return constructor(x, y, z)
		end

		if n == 7 then
			local x, y, z, qx, qy, qz, qw = a1, select(2,...), select(3,...), select(4,...), select(5,...), select(6,...), select(7,...)
			assert("number" == type(qx) and "number" == type(qy) and "number" == type(qz) and "number" == type(qw), "CFrame.new: expected quaternion numbers")

			return fromQuaternion(x, y, z, qx, qy, qz, qw)
		end

		if n == 12 then
			local x,y,z, r00,r01,r02, r10,r11,r12, r20,r21,r22 =
				a1, select(2,...), select(3,...),
				select(4,...), select(5,...), select(6,...),
				select(7,...), select(8,...), select(9,...),
				select(10,...), select(11,...), select(12,...)

			return constructor(x,y,z, r00,r01,r02, r10,r11,r12, r20,r21,r22)
		end

		return error("CFrame.new: invalid arguments")
	end

	function CFrame.lookAt(at, lookAt, up)
		assert(isVector3(at),              `CFrame.lookAt: expected Vector3 for 1st argument, got {type(at)}`)
		assert(isVector3(lookAt),          `CFrame.lookAt: expected Vector3 for 2nd argument, got {type(lookAt)}`)
		up = (up and assert(isVector3(up), `CFrame.lookAt: expected Vector3 for 3rd argument, got {type(up)}`) and up) or Vector3.yAxis

		local forward = (lookAt - at).unit
		if forward.magnitude == 0 then
			return constructor(at.x, at.y, at.z)
		end

		local right = up:cross(forward).unit
		if right.magnitude == 0 then
			local alt = abs(forward.y) < 0.999 and Vector3.yAxis or Vector3.xAxis
			right = alt:cross(forward).unit
		end

		local normalized = forward:cross(right).unit
		local z = (right:cross(normalized))
		z = forward * -1

		return constructor(
			at.x, at.y, at.z,
			right.x, normalized.x, z.x,
			right.y, normalized.y, z.y,
			right.z, normalized.z, z.z
		)
	end

	function CFrame.lookAlong(at, direction, up)
		assert(isVector3(at),        `CFrame.lookAlong: expected Vector3 for 1st argument, got {type(at)}`)
		assert(isVector3(direction), `CFrame.lookAlong: expected Vector3 for 2nd argument, got {type(direction)}`)

		return CFrame.lookAt(at, at + direction, up)
	end

	function CFrame.fromRotationBetweenVectors(from, to)
		assert(isVector3(from), `CFrame.fromRotationBetweenVectors: expected Vector3 for 1st argument, got {type(from)}`)
		assert(isVector3(to),   `CFrame.fromRotationBetweenVectors: expected Vector3 for 2nd argument, got {type(to)}`)

		local f = from.unit
		local t = to.unit
		if f.magnitude == 0 or t.magnitude == 0 then
			return constructor(0,0,0)
		end

		local dot = clamp(f:dot(t), -1, 1)
		if dot > 1 - 1e-8 then
			return constructor(0,0,0)
		elseif dot < -1 + 1e-8 then
			local axis = (abs(f.x) < 0.9 and Vector3.xAxis or Vector3.yAxis):cross(f).unit
			return CFrame.fromAxisAngle(axis, math.pi)
		else
			local axis = f:cross(t).unit
			local angle = acos(dot)
			return CFrame.fromAxisAngle(axis, angle)
		end
	end

	function CFrame.fromEulerAngles(rx, ry, rz, order)
		local r00,r01,r02, r10,r11,r12, r20,r21,r22 = columnsFromEuler(rx, ry, rz, order)

		return constructor(0,0,0, r00,r01,r02, r10,r11,r12, r20,r21,r22)
	end

	function CFrame.fromEulerAnglesXYZ(rx, ry, rz)
		return CFrame.fromEulerAngles(rx, ry, rz, "XYZ")
	end

	function CFrame.fromEulerAnglesYXZ(rx, ry, rz)
		return CFrame.fromEulerAngles(rx, ry, rz, "YXZ")
	end

	function CFrame.Angles(rx, ry, rz)
		return CFrame.fromEulerAnglesXYZ(rx, ry, rz)
	end

	function CFrame.fromOrientation(rx, ry, rz)
		return CFrame.fromEulerAnglesYXZ(rx, ry, rz)
	end

	function CFrame.fromAxisAngle(v, r)
		assert(isVector3(v),        `CFrame.fromAxisAngle: expected Vector3 for axis, got {type(v)}`)
		assert("number" == type(r), `CFrame.fromAxisAngle: expected number for angle, got {type(r)}`)

		local axis = v.unit
		local x,y,z = axis.x, axis.y, axis.z
		local c, s, t = cos(r), sin(r), 1 - cos(r)

		local r00 = t*x*x + c
		local r01 = t*x*y + s*z
		local r02 = t*x*z - s*y

		local r10 = t*x*y - s*z
		local r11 = t*y*y + c
		local r12 = t*y*z + s*x

		local r20 = t*x*z + s*y
		local r21 = t*y*z - s*x
		local r22 = t*z*z + c

		return constructor(0,0,0, r00,r01,r02, r10,r11,r12, r20,r21,r22)
	end

	function CFrame.fromMatrix(pos, vX, vY, vZ)
		assert(isVector3(pos), `CFrame.fromMatrix: expected Vector3 for pos, got {type(pos)}`)
		assert(isVector3(vX),  `CFrame.fromMatrix: expected Vector3 for vX, got {type(vX)}`)
		assert(isVector3(vY),  `CFrame.fromMatrix: expected Vector3 for vY, got {type(vY)}`)

		if nil ~= vZ then assert(isVector3(vZ), `CFrame.fromMatrix: expected Vector3 for vZ, got {type(vZ)}`) end

		local x = vX
		local y = vY
		local z = vZ or x:cross(y).unit

		return constructor(
			pos.x, pos.y, pos.z,
			x.x, y.x, z.x,
			x.y, y.y, z.y,
			x.z, y.z, z.z
		)
	end

	--- methods ---

	function CFrame:inverse()
		local rt00,rt01,rt02, rt10,rt11,rt12, rt20,rt21,rt22 = rotTranspose(self)
		local p = Vector3.new(self.x, self.y, self.z)

		local ip = Vector3.new(
			-(rt00*p.x + rt01*p.y + rt02*p.z),
			-(rt10*p.x + rt11*p.y + rt12*p.z),
			-(rt20*p.x + rt21*p.y + rt22*p.z)
		)

		return constructor(ip.x, ip.y, ip.z, rt00,rt01,rt02, rt10,rt11,rt12, rt20,rt21,rt22)
	end

	function CFrame:lerp(goal, alpha: number)
		assert(isCFrame(goal),          `CFrame.lerp: expected a CFrame, got {type(goal)}`)
		assert("number" == type(alpha), `CFrame.lerp: expected a number for alpha, got {type(alpha)}`)

		local nx = self.x + (goal.x - self.x) * alpha
		local ny = self.y + (goal.y - self.y) * alpha
		local nz = self.z + (goal.z - self.z) * alpha

		local qx1, qy1, qz1, qw1 = toQuaternion(self)
		local qx2, qy2, qz2, qw2 = toQuaternion(goal)
		local qx, qy, qz, qw = slerp(qx1,qy1,qz1,qw1, qx2,qy2,qz2,qw2, alpha)

		return fromQuaternion(nx, ny, nz, qx, qy, qz, qw)
	end

	function CFrame:orthonormalize()
		local x = Vector3.new(self.r00, self.r10, self.r20).unit
		local y = Vector3.new(self.r01, self.r11, self.r21)

		y = (y - x * x:dot(y)).unit

		local z = x:cross(y)

		return constructor(
			self.x, self.y, self.z,
			x.x, y.x, z.x,
			x.y, y.y, z.y,
			x.z, y.z, z.z
		)
	end

	function CFrame:toworldspace(...)
		local args = table.pack(...)

		for i=1, args.n do
			assert(isCFrame(args[i]), `CFrame.toworldspace: expected CFrame, got {type(args[i])}`)
			args[i] = self * args[i]
		end

		return table.unpack(args, 1, args.n)
	end

	function CFrame:toobjectspace(...)
		local inv = self:inverse()
		local args = table.pack(...)

		for i=1, args.n do
			assert(isCFrame(args[i]), `CFrame.toobjectspace: expected CFrame, got {type(args[i])}`)
			args[i] = inv * args[i]
		end

		return table.unpack(args, 1, args.n)
	end

	function CFrame:pointtoworldspace(...)
		local args = table.pack(...)

		for i=1, args.n do
			assert(isVector3(args[i]), `CFrame.pointtoworldspace: expected Vector3, got {type(args[i])}`)
			local v: any = args[i]
			args[i] = Vector3.new(self.x, self.y, self.z) + rotateVec(self, v)
		end

		return table.unpack(args, 1, args.n)
	end

	function CFrame:pointtoobjectspace(...)
		local args = table.pack(...)

		for i=1, args.n do
			assert(isVector3(args[i]), `CFrame.pointtoobjectspace: expected Vector3, got {type(args[i])}`)
			local v: any = args[i]
			local p = v - Vector3.new(self.x, self.y, self.z)
			args[i] = rotateVecT(self, p)
		end

		return table.unpack(args, 1, args.n)
	end

	function CFrame:vectortoworldspace(...)
		local args = table.pack(...)

		for i=1, args.n do
			assert(isVector3(args[i]), `CFrame.vectortoworldspace: expected Vector3, got {type(args[i])}`)
			args[i] = rotateVec(self, args[i])
		end

		return table.unpack(args, 1, args.n)
	end

	function CFrame:vectortoobjectspace(...)
		local args = table.pack(...)
		for i=1, args.n do
			assert(isVector3(args[i]), `CFrame.vectortoobjectspace: expected Vector3, got {type(args[i])}`)
			args[i] = rotateVecT(self, args[i])
		end
		return table.unpack(args, 1, args.n)
	end

	function CFrame:getcomponents()
		return self.x, self.y, self.z,
			self.r00, self.r01, self.r02,
			self.r10, self.r11, self.r12,
			self.r20, self.r21, self.r22
	end

	function CFrame:toeulerangles(order)
		order = string.upper(order or "XYZ")

		local r00,r01,r02 = self.r00, self.r01, self.r02
		local r10,r11,r12 = self.r10, self.r11, self.r12
		local r20,r21,r22 = self.r20, self.r21, self.r22

		if order == "XYZ" then
			local sy = r20
			local rx, ry, rz

			if abs(sy) < 0.999999 then
				rx = atan(-r21, r22)
				ry = atan(sy, sqrt(1 - sy*sy))
				rz = atan(-r10, r00)
			else
				rx = atan(r11, r12)
				ry = atan(sy, sqrt(1 - sy*sy))
				rz = 0
			end

			return rx, ry, rz
		elseif order == "YXZ" then
			local sx = -r21
			local rx, ry, rz
			if abs(sx) < 0.999999 then
				ry = atan(r20, r22)
				rx = atan(sx, sqrt(1 - sx*sx))
				rz = atan(r01, r11)
			else
				ry = atan(-r02, r00)
				rx = atan(sx, sqrt(1 - sx*sx))
				rz = 0
			end

			return rx, ry, rz
		else
			return CFrame.fromEulerAnglesXYZ(0,0,0):toeulerangles("XYZ")
		end
	end

	function CFrame:toeuleranglesxyz()
		return self:toeulerangles("XYZ")
	end

	function CFrame:toeuleranglesyxz()
		return self:toeulerangles("YXZ")
	end

	function CFrame:toorientation()
		return self:toeulerangles("YXZ")
	end

	function CFrame:toaxisangle()
		local qx, qy, qz, qw = toQuaternion(self)
		local angle          = 2 * acos(clamp(qw, -1, 1))
		local s              = sqrt(1 - qw*qw)

		if s < 1e-6 then
			return Vector3.xAxis, 0
		end

		return Vector3.new(qx/s, qy/s, qz/s), angle
	end

	function CFrame:fuzzyeq(other, epsilon: number?)
		assert(isCFrame(other),                                     `CFrame.fuzzyeq: expected a CFrame, got {type(other)}`)
		assert("number" == type(epsilon) or "nil" == type(epsilon), `CFrame.fuzzyeq: expected a number for epsilon, got {type(epsilon)}`)

		epsilon = epsilon or 1e-5
		if abs(self.x - other.x) > epsilon or abs(self.y - other.y) > epsilon or abs(self.z - other.z) > epsilon then
			return false
		end

		return self:anglebetween(other) <= epsilon
	end

	function CFrame:anglebetween(other)
		assert(isCFrame(other), `CFrame.anglebetween: expected a CFrame, got {type(other)}`)

		local r00, _r01, _r02, _r10, r11, _r12, _r20, _r21, r22 = matMul(
			{
				r00 = self.r00,
				r01 = self.r01,
				r02 = self.r02,
				r10 = self.r10,
				r11 = self.r11,
				r12 = self.r12,
				r20 = self.r20,
				r21 = self.r21,
				r22 = self.r22,
			},
			{
				r00 = other.r00,
				r01 = other.r01,
				r02 = other.r02,
				r10 = other.r10,
				r11 = other.r11,
				r12 = other.r12,
				r20 = other.r20,
				r21 = other.r21,
				r22 = other.r22,
			}
		)

		return acos(clamp((r00 + r11 + r22 - 1) * 0.5, -1, 1))
	end

	--- properties ---

	CFrame.identity    = constructor(0,0,0)
	CFrame.__metatable = "CFrame"

	--- metatables ---

	function CFrame:__mul(other)
		if isVector3(other) then
			local v = other :: any

			return Vector3.new(
				self.x + self.r00 * v.x + self.r01 * v.y + self.r02 * v.z,
				self.y + self.r10 * v.x + self.r11 * v.y + self.r12 * v.z,
				self.z + self.r20 * v.x + self.r21 * v.y + self.r22 * v.z
			)
		end

		assert(isCFrame(other), `CFrame.__mul: expected CFrame or Vector3, got {type(other)}`)

		local r00, r01, r02, r10, r11, r12, r20, r21, r22 = matMul(self, other)

		local p = Vector3.new(
			self.x + self.r00 * other.x + self.r01 * other.y + self.r02 * other.z,
			self.y + self.r10 * other.x + self.r11 * other.y + self.r12 * other.z,
			self.z + self.r20 * other.x + self.r21 * other.y + self.r22 * other.z
		)

		return constructor(p.x, p.y, p.z, r00,r01,r02, r10,r11,r12, r20,r21,r22)
	end

	function CFrame:__add(other)
		assert(isVector3(other), `CFrame.__add: expected a Vector3, got {type(other)}`)
		return constructor(self.x + other.x, self.y + other.y, self.z + other.z,
			self.r00, self.r01, self.r02, self.r10, self.r11, self.r12, self.r20, self.r21, self.r22)
	end

	function CFrame:__sub(other)
		assert(isVector3(other), `CFrame.__sub: expected a Vector3, got {type(other)}`)
		return constructor(self.x - other.x, self.y - other.y, self.z - other.z,
			self.r00, self.r01, self.r02, self.r10, self.r11, self.r12, self.r20, self.r21, self.r22)
	end

	function CFrame:__index(index)
		index = string.lower(index)

		if "position" == index then
			return Vector3.new(self.x, self.y, self.z)
		end

		if "rotation" == index then
			return constructor(0, 0, 0, self.r00,self.r01,self.r02, self.r10,self.r11,self.r12, self.r20,self.r21,self.r22)
		end

		if "x" == index then return self.x end
		if "y" == index then return self.y end
		if "z" == index then return self.z end

		if "xvector" == index or "rightvector" == index then
			return Vector3.new(self.r00, self.r10, self.r20)
		end

		if "yvector" == index or "upvector" == index then
			return Vector3.new(self.r01, self.r11, self.r21)
		end

		if "zvector" == index then
			return Vector3.new(self.r02, self.r12, self.r22)
		end

		if "lookvector" == index then
			return Vector3.new(self.r02, self.r12, self.r22) * -1
		end

		return rawget(CFrame, index) or self[index]
	end

	function CFrame:__tostring()
		return `({self.x}, {self.y}, {self.z}, {self.r00}, {self.r01}, {self.r02}, {self.r10}, {self.r11}, {self.r12}, {self.r20}, {self.r21}, {self.r22})`
	end
end

---- exports ----

return table.freeze(CFrame)