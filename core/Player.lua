Player = {
	usgn = 0;
	joinTeamAllowed = false;
	rank = "Supreme";
	team = 0;
};

function Player:new(object)
	object = object or {};
	setmetatable(object, self);
	self.__index = self;
	return object;
end