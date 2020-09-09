Player = {
	joinTeamAllowed = false;
	rank = 0;
	team = 0;
	score = 0;
	deaths = 0;
	assists = 0;
	roundDmg = 0;
	totalDmg = 0;
	ADR = 0;
	MVP = 0;
};

function Player:new(object)
	object = object or {};
	setmetatable(object, self);
	self.__index = self;
	return object;
end