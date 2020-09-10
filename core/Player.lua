Player = {
	id = 1;
	joinTeamAllowed = false;
	rank = 0;
	points = 0;
	team = 0;
	score = 0;
	deaths = 0;
	assists = 0;
	roundDmg = 0;
	totalDmg = 0;
	ADR = 0;
	MVP = 0;
	rounds = 0;
};

function Player:new(object)
	object = object or {};
	setmetatable(object, self);
	self.__index = self;
	return object;
end

function Player:setStats()
	self.score = player(self.id, "score");
	self.deaths = player(self.id, "deaths");
	self.assists = player(self.id, "assists");
	self.MVP = player(self.id, "mvp");
	self.rounds = self.rounds + 1;
	self.ADR = self.totalDmg / self.rounds;
end

function Player:calculateWin()
	local score = self.score * 0.3;
	local assists = self.assists * 0.2;
	local MVPs = self.MVP * 0.2;
	local ADR = self.ADR * 0.1;
	local deaths = self.deaths * 0.15;
	self.points = self.points + math.abs((score + assists + MVPs + ADR) - deaths);
end