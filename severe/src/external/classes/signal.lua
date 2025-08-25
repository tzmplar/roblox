---- definitions ----

type connection = { disconnect: () -> () }

---- module ----

local signal = {}; do
	--- constructor ---

	local function constructor()
		return setmetatable( { _map = {} }, { __index = signal } )
	end

	--- public functions ---

	signal.new = constructor

	--- public methods ---

	function signal:fire<T...>(...: T...)
		for i = #self, 1, -1 do
			local callback = self[i]

			if callback then
				if "function" == type(callback) then
					coroutine.wrap(callback)(...)
				elseif "thread" == type(callback) then
					coroutine.resume(callback, ...)
				end
			end
		end

		return self
	end

	function signal:connect<T...>(f: (T...) -> ()): connection
		table.insert(self, f)

		return {
			disconnect = function()
				local index = table.find(self, f)

				if index then
					table.remove(self, index)
				end
			end
		}
	end

	function signal:once<T...>(f: (T...) -> ()): connection
		local connection; do
			connection = self:connect(function(...)
				f(...)

				connection:disconnect()
			end)
		end

		return connection
	end

	function signal:wait<T...>(): T...
		local running = coroutine.running()

		self:once(function(...)
			coroutine.resume(running, ...)
		end)

		return coroutine.yield()
	end

	--- metatables ---

	setmetatable( signal, {
		__call = constructor
	} )
end

---- exports ----

return signal