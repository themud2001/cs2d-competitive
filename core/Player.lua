Player = {
	usgn = 0;
	joinTeamAllowed = false;
};

function Player:new(object)
	object = object or {};
	setmetatable(object, self);
	self.__index = self;
	return object;
end