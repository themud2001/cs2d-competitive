Player = {
	-- The values change every match
	id = 1;
	joinTeamAllowed = false;
	team = 0;
	score = 0;
	deaths = 0;
	assists = 0;
	roundDmg = 0;
	totalDmg = 0;
	ADR = 0;
	MVP = 0;
	rounds = 0;

	-- Saved for the player
	rank = 0;
	points = 0;
};

function Player:new(object)
	object = object or {};
	setmetatable(object, self);
	self.__index = self;
	return object;
end

function Player:resetStats()
	self.score = 0;
	self.deaths = 0;
	self.assists = 0;
	self.MVP = 0;
	self.rounds = 0;
	self.ADR = 0;
end

function Player:calculateWin()
	local score = self.score * 0.3;
	local assists = self.assists * 0.2;
	local MVPs = self.MVP * 0.2;
	self.ADR = self.totalDmg / self.rounds;
	local ADR = self.ADR * 0.1;
	self.points = self.points + math.abs((score + assists + MVPs + ADR));
end