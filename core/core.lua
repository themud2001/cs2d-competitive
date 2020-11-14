math.randomseed(os.time());

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
		msg2(id, _serverMsgs["error"].."Log in via USGN or Steam to save stats");
	else
		_player[id]:loadStats();
		_player[id]:updateRank();
		msg2(id, _serverMsgs["info"].."Welcome to "..game("sv_name"));
		msg2(id, _serverMsgs["info"].."Your rank is ".._ranks[_player[id].rank].tag);

		if(_player[id].isAdmin ~= 0) then
			msg2(id, _serverMsgs["info"].."Your current role is \169000225000admin");
		end
	end
end

function _team(id, team)
	_player[id].team = team;
end

function _say(id, text)
	text = text:gsub("[@C]+", "");

	if(_player[id].isMuted ~= 0 and _player[id].isAdmin == 0) then 
		msg2(id, _serverMsgs["error"].."You are muted");
		return 1;
	end

	if(checkCommands(id, text)) then return 1; end

	msg(_chatColors[_player[id].team].._player[id].name.." ".._ranks[_player[id].rank].tag.."\169240240240"..(player(id, "health") == 0 and " *DEAD*" or "")..": "..text);
	return 1;
end

function _sayteam(id, text)
	local team = player(0, "team".._player[id].team);
	for _, id in pairs(team) do
		msg2(id, _chatColors[_player[id].team].._player[id].name.." ".._ranks[_player[id].rank].tag.." \169240240240(Team)"..(player(id, "health") == 0 and " *DEAD*" or "")..": "..text);
	end

	return 1;
end

function _name(id, old, new)
	_player[id].name = new;
end

function _endround(mode)
	if(mode == 3 or mode == 4 or mode == 5) then return; end

	local ttPlayers = player(0, "team1");
	local ctPlayers = player(0, "team2");
	local roundDmg = {};

	for _, id in pairs(ttPlayers) do
		_player[id].rounds = _player[id].rounds + 1;
		roundDmg[id] = _player[id].roundDmg;
		msg2(id, _serverMsgs["info"].."Your damage: \169250250250(\169000225000".._player[id].roundDmg.."\169250250250 damage)");
	end

	for _, id in pairs(ctPlayers) do
		_player[id].rounds = _player[id].rounds + 1;
		roundDmg[id] = _player[id].roundDmg;
		msg2(id, _serverMsgs["info"].."Your damage: \169250250250(\169000225000".._player[id].roundDmg.."\169250250250 damage)");
	end

	if(next(roundDmg) ~= nil) then
		local roundMVP = getMVP(roundDmg);
		if(_player[roundMVP].roundDmg > 0) then
			_player[roundMVP].MVP = _player[roundMVP].MVP + 1;
			msg(_serverMsgs["info"].."Highest damage: ".._chatColors[_player[roundMVP].team].._player[roundMVP].name.."\169250250250 (\169000225000".._player[roundMVP].roundDmg.."\169250250250 damage)");	
		end
	end
end

function _hit(id, source, weapon, hpdmg, apdmg, rawdmg)
	if(player(source, "exists")) then
		if(_player[source].team ~= _player[id].team) then
			_player[source].roundDmg = _player[source].roundDmg + hpdmg;
			_player[source].totalDmg = _player[source].totalDmg + hpdmg;
		end
	end
end

function _startround(mode)
	local ttPlayers = player(0, "team1");
	local ctPlayers = player(0, "team2");

	for _, id in pairs(ttPlayers) do
		_player[id]:updateRank();
		_player[id]:freeImage();
		_player[id]:updateRankImage();

		_player[id].roundDmg = 0;
		parse("setmoney "..id.." 16000");
	end

	for _, id in pairs(ctPlayers) do
		_player[id]:updateRank();
		_player[id]:freeImage();
		_player[id]:updateRankImage();
		
		_player[id].roundDmg = 0;
		parse("setmoney "..id.." 16000");
	end
end

function _spawn(id)
	_player[id]:updateRankImage();
end

function _kill(killer, victim, weapon, x, y, killerobject, assistant)
	_player[killer].score = _player[killer].score + 1;
	_player[victim].deaths = _player[victim].deaths + 1;
	if(assistant ~= 0) then _player[assistant].assists = _player[assistant].assists + 1; end

	_player[killer]:calculateKill(victim);
	_player[victim]:calculateDeath(killer);
end

function _leave(id)
	_player[id]:freeImage();
	if(_player[id].usgn ~= 0 or _player[id].steamid ~= "0") then
		_player[id]:saveStats();
		_player[id] = nil;
	end
end

function _minute()
	msg(_hints[math.random(0, #_hints)]);
end

function _serveraction(id, action)
	if(_player[id].cooldown) then return; end
	if(action == 3) then
		_player[id]:printStats();
		setCooldown(id);
	end
end