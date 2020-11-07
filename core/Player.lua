Player = {
	score = 0;
	deaths = 0;
	assists = 0;
	ADR = 0;
	MVP = 0;
	rank = 0;
	points = 0;
	isAdmin = 0;
	isMuted = 0;

	team = 0;
	rounds = 0;
	roundDmg = 0;
	totalDmg = 0;
};

function Player:new(object)
	object = object or {};
	setmetatable(object, self);
	self.__index = self;
	return object;
end

function Player:calculateKill(killed)
	local deltaRank;
	local points;

	if(self.rank >= _player[killed].rank) then
		deltaRank = ((self.rank - _player[killed].rank > 0) and (self.rank - _player[killed].rank)) or 1;
		points = (_ranks[self.rank].winPoints / deltaRank);
	else
		deltaRank = _player[killed].rank - self.rank;
		points = _ranks[self.rank].winPoints + (10 * deltaRank);
	end

	self.points = self.points + points;
end

function Player:calculateDeath(killer)
	local deltaRank;
	local points;

	if(self.rank >= _player[killer].rank) then
		deltaRank = ((self.rank - _player[killer].rank > 0) and (self.rank - _player[killer].rank)) or 1;
		points = _ranks[self.rank].losePoints + (5 * deltaRank);
	else
		deltaRank = _player[killer].rank - self.rank;
		points = _ranks[self.rank].losePoints - (7 * deltaRank);
	end

	self.points = self.points - points;
	if(self.points <= 0) then self.points = 0; end
end

function Player:printStats()
	msg2(self.id, _chatColors[0].."---------Player Stats---------");
	msg2(self.id, _chatColors[0].."Kills: \169000225000"..self.score);
	msg2(self.id, _chatColors[0].."Deaths: \169000225000"..self.deaths);
	msg2(self.id, _chatColors[0].."Assists: \169000225000"..self.assists);
	msg2(self.id, _chatColors[0].."MVPs: \169000225000"..self.MVP);
	msg2(self.id, _chatColors[0].."ADR: \169000225000"..self.ADR);
	msg2(self.id, _chatColors[0].."Rounds played: \169000225000"..self.rounds);
	msg2(self.id, _chatColors[0].."Rank: ".._ranks[self.rank].tag.." ("..self.points..")");
end

function Player:updateRank()
	if(self.rank >= (#_ranks - 1)) then return; end
	if(self.points >= _ranks[self.rank + 1].points) then
		self.rank = self.rank + 1;
		msg2(self.id, _serverMsgs["success"].."Congratulations! You are promoted to: ".._ranks[self.rank].tag);
	elseif(self.points < _ranks[self.rank].points) then
		self.rank = self.rank - 1;
		msg2(self.id, _serverMsgs["error"].."You are demoted to: ".._ranks[self.rank].tag);
	end
end

function Player:loadStats()
	local file = io.open(scriptPath.."data/"..((self.usgn ~= 0 and self.usgn) or self.steamid)..".txt", "r");
	if(file) then
		self.score = tonumber(file:read());
		self.deaths = tonumber(file:read());
		self.assists = tonumber(file:read());
		self.ADR = tonumber(file:read());
		self.MVP = tonumber(file:read());
		self.rounds = tonumber(file:read());
		self.rank = tonumber(file:read());
		self.points = tonumber(file:read());
		self.isAdmin = tonumber(file:read());
		self.isMuted = tonumber(file:read());
		file:close();
	end
end

function Player:saveStats()
	local file = io.open(scriptPath.."data/"..((self.usgn ~= 0 and self.usgn) or self.steamid)..".txt", "w+");
	file:write(self.score.."\n");
	file:write(self.deaths.."\n");
	file:write(self.assists.."\n");
	file:write(self.ADR.."\n");
	file:write(self.MVP.."\n");
	file:write(self.rounds.."\n");
	file:write(self.rank.."\n");
	file:write(self.points.."\n");
	file:write(self.isAdmin.."\n");
	file:write(self.isMuted);
	file:close();
end