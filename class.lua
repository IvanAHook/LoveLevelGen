local class_mt = {}

function class_mt:__index(key)
	return self.__baseclass[key]
end

function class:new(...)
	local c = {}
	c.__baseclass = self
	setmetatable(c, getmetatable(self))
	if c.init then
		c:init(...)
	end
	return c
end