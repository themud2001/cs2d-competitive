parse("mp_hudscale 1");

for _, hook in pairs(_hooks) do
	addhook(hook, "_"..hook);
end

function _join(id)
	_player[id] = Player:new({
		id = id;
		name = player(id, "name");
		usgn = player(id, "usgn");
		steamid = player(id, "steamid");
	});

	if(_player[id].usgn == 0 and _player[id].steamid == "0") then
		msg2(id, _serverMsgs["error"].."You have to be logged in via USGN or Steam");
		_player[id].joinTeamAllowed = false;
	else
		_player[id]:loadStats();
		_player[id]:updateRank();
		_player[id].joinTeamAllowed = true;
		msg2(id, _serverMsgs["info"].."Welcome to "..game("sv_name"));
		msg2(id, _serverMsgs["info"].."Your rank is ".._ranks[_player[id].rank].tag);
	end
end

function _team(id, team)
	if(not true) then
		msg2(id, _serverMsgs["error"].."You are not allowed to join a team");
		return 1;
	end

	_player[id].team = team;
end

-- Testing, temporary

function _say(id, text)
	msg(_chatColors[_player[id].team].._player[id].name.." ".._ranks[_player[id].rank].tag..": \169240240240"..text);
	return 1;
end

-- Testing, temporary

function _name(id, old, new)
	_player[id].name = new;
end

function _endround(mode)
	if(mode == 3 or mode == 4 or mode == 5) then return; end

	if(mode == 1 or mode == 10 or mode == 12 or mode == 20 or mode == 30 or mode == 40 or mode == 50 or mode == 60) then
		_match.ttRounds = _match.ttRounds + 1;
	else
		_match.ctRounds = _match.ctRounds + 1;
	end

	local ttPlayers = player(0, "team1");
	local ctPlayers = player(0, "team2");
	local roundDmg = {};
	local totalDmg = {};

	for _, id in pairs(ttPlayers) do
		_player[id].rounds = _player[id].rounds + 1;
		roundDmg[id] = _player[id].roundDmg;
		totalDmg[id] = _player[id].totalDmg;
		msg2(id, _serverMsgs["info"].."Your damage: \169250250250(\169000225000".._player[id].roundDmg.."\169250250250 damage)");
	end

	for _, id in pairs(ctPlayers) do
		_player[id].rounds = _player[id].rounds + 1;
		roundDmg[id] = _player[id].roundDmg;
		totalDmg[id] = _player[id].totalDmg;
		msg2(id, _serverMsgs["info"].."Your damage: \169250250250(\169000225000".._player[id].roundDmg.."\169250250250 damage)");
	end

	local roundMVP, totalMVP = _match.getMVP(roundDmg, totalDmg);

	if(_player[roundMVP].roundDmg > 0) then
		_player[roundMVP].MVP = _player[roundMVP].MVP + 1;
		msg(_serverMsgs["info"].."Highest damage: ".._chatColors[_player[roundMVP].team].._player[roundMVP].name.."\169250250250 (\169000225000".._player[roundMVP].roundDmg.."\169250250250 damage)");	
	end

	msg(_serverMsgs["info"].."Highest total damage: ".._chatColors[_player[totalMVP].team].._player[totalMVP].name.."\169250250250 (\169000225000".._player[totalMVP].totalDmg.."\169250250250 damage)");
end

function _hit(id, source, weapon, hpdmg, apdmg, rawdmg)
	if(_player[source].team ~= _player[id].team) then
		_player[source].roundDmg = _player[source].roundDmg + hpdmg;
		_player[source].totalDmg = _player[source].totalDmg + hpdmg;
	end
end

function _startround(mode)
	local ttPlayers = player(0, "team1");
	local ctPlayers = player(0, "team2");

	for _, id in pairs(ttPlayers) do
		_player[id].roundDmg = 0;
	end

	for _, id in pairs(ctPlayers) do
		_player[id].roundDmg = 0;
	end

	parse("hudtxt 1 \"".._chatColors[2].."CT \169000225000".._match.ctRounds.."-".._match.ttRounds.._chatColors[1].." TT\" 400 15");
	parse("setteamscores ".._match.ttRounds.." ".._match.ctRounds);
end


function _startround_prespawn(mode)
	if(_match.finished) then
		_match.calculateWin();
		_match.calculateLose();
		_match.resetPlayersStats();
		_match.reset();
	end
end

function _kill(killer, victim, weapon, x, y, killerobject, assistant)
	_player[killer].score = _player[killer].score + 1;
	_player[victim].deaths = _player[victim].deaths + 1;
	if(assistant ~= 0) then _player[assistant].assists = _player[assistant].assists + 1; end

	
end

function _leave(id)
	if(_player[id].usgn ~= 0 or _player[id].steamid ~= "0") then
		_player[id]:saveStats();
		_player[id] = nil;
	end
end