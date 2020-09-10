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
	matchPoints = 0;

	-- Saved for the player
	rank = 8;
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
	self.matchPoints = 0;
	self.roundDmg = 0;
	self.totalDmg = 0;
end

function Player:calculateWin()
	local score = self.score * 0.3;
	local assists = self.assists * 0.2;
	local MVPs = self.MVP * 0.2;
	self.ADR = self.totalDmg / self.rounds;
	local ADR = self.ADR * 0.1;
	self.matchPoints = (score + assists + MVPs + ADR);
	self.points = self.points + self.matchPoints;
end

function Player:calculateLose()
	local deaths = self.deaths * 0.9;
	local bonus = (self.score + self.assists + self.MVP + self.ADR) * 0.05;
	self.matchPoints = deaths + 10 - bonus;
	self.points = self.points - self.matchPoints;
	if(self.points <= 0) then self.points = 0; end
end

function Player:printStats()
	msg2(self.id, _chatColors[0].."---------Match Stats---------");
	msg2(self.id, _chatColors[0].."Kills: \169000225000"..self.score);
	msg2(self.id, _chatColors[0].."Deaths: \169000225000"..self.deaths);
	msg2(self.id, _chatColors[0].."Assists: \169000225000"..self.assists);
	msg2(self.id, _chatColors[0].."MVPs: \169000225000"..self.MVP);
	msg2(self.id, _chatColors[0].."ADR: \169000225000"..self.ADR);
	msg2(self.id, _chatColors[0].."Rounds played: \169000225000"..self.rounds);
	msg2(self.id, _chatColors[0].."Points: "..((_player[self.id].team == _match.teamWon and "\169000225000+") or "\169240000000-")..self.matchPoints);
end

function Player:maintainStats()
	parse("setscore "..self.id.." "..self.score);
	parse("setdeaths "..self.id.." "..self.deaths);
end

function Player:updateRank()
	if(self.rank >= (#_ranks - 1)) then return; end
	if(self.points >= _ranks[self.rank + 1].points) then
		self.rank = self.rank + 1;
		msg2(self.id, _serverMsgs["success"].."Congratulations! You ranked up to: ".._ranks[self.rank].tag);
	elseif(self.points < _ranks[self.rank].points) then
		self.rank = self.rank - 1;
		msg2(self.id, _serverMsgs["error"].."You deranked down to: ".._ranks[self.rank].tag);
	end
end