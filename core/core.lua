parse("mp_hudscale 1");

for _, hook in pairs(_hooks) do
	addhook(hook, "_"..hook);
end

function _join(id)
	_player[id] = Player:new({
		name = player(id, "name");
		usgn = player(id, "usgn");
		id = id;
	});

	_player[id]:loadRank();

	if(_player[id].usgn == 0) then
		msg2(id, _serverMsgs["error"].."You have to be logged in via USGN");
		-- Debugging
		_player[id].joinTeamAllowed = true;
	else
		_player[id].joinTeamAllowed = true;
		msg2(id, _serverMsgs["info"].."Welcome to "..game("sv_name"));
		msg2(id, _serverMsgs["info"].."Your rank is ".._ranks[_player[id].rank].tag);
	end
end

function _team(id, team)
	if(not _player[id].joinTeamAllowed) then
		msg2(id, _serverMsgs["error"].."You are not allowed to join a team");
		return 1;
	end

	_player[id].team = team;
end

function _say(id, text)
	if(text == "!startmix") then
		_match.setLive();
		return 1;
	end

	msg(_chatColors[_player[id].team].._player[id].name.." ".._ranks[_player[id].rank].tag..": \169240240240"..text);
	return 1;
end

function _name(id, old, new)
	_player[id].name = new;
end

function _endround(mode)
	if(_match.live) then
		if(mode == 3 or mode == 4 or mode == 5) then return; end

		if(mode == 1 or mode == 20) then
			_match.ttRounds = _match.ttRounds + 1;
		else
			_match.ctRounds = _match.ctRounds + 1;
		end

		local dmgTable = {
			roundDmg = {};
			totalDmg = {};
		};

		for _, id in pairs(_match.ttPlayers) do
			_player[id].rounds = _player[id].rounds + 1;
			dmgTable.roundDmg[id] = _player[id].roundDmg;
			dmgTable.totalDmg[id] = _player[id].totalDmg;
			msg2(id, _serverMsgs["info"].."Your damage: \169250250250(\169000225000".._player[id].roundDmg.."\169250250250 damage)");
		end

		for _, id in pairs(_match.ctPlayers) do
			_player[id].rounds = _player[id].rounds + 1;
			dmgTable.roundDmg[id] = _player[id].roundDmg;
			dmgTable.totalDmg[id] = _player[id].totalDmg;
			msg2(id, _serverMsgs["info"].."Your damage: \169250250250(\169000225000".._player[id].roundDmg.."\169250250250 damage)");
		end

		local roundMVP, totalMVP = _match.getMVP(dmgTable.roundDmg, dmgTable.totalDmg);

		if(_player[roundMVP].roundDmg > 0) then
			_player[roundMVP].MVP = _player[roundMVP].MVP + 1;
			msg(_serverMsgs["info"].."Highest damage: ".._chatColors[_player[roundMVP].team].._player[roundMVP].name.."\169250250250 (\169000225000".._player[roundMVP].roundDmg.."\169250250250 damage)");
			msg(_serverMsgs["info"].."Highest total damage: ".._chatColors[_player[totalMVP].team].._player[totalMVP].name.."\169250250250 (\169000225000".._player[totalMVP].totalDmg.."\169250250250 damage)");
		end

		if(_match.half == 1) then
			if(_match.ttRounds + _match.ctRounds == _match.roundsLimit) then
				_match.endFirstHalf();
			end
		else
			if(_match.ttRounds == _match.roundsLimit and _match.ctRounds == _match.roundsLimit) then
				msg("Draw");
			elseif(_match.ttRounds == _match.roundsLimit + 1) then
				_match.teamWon = 1;
				_match.finished = true;
			elseif(_match.ctRounds == _match.roundsLimit + 1) then
				_match.teamWon = 2;
				_match.finished = true;
			end
		end

		if(_match.finished) then
			msg(_serverMsgs["info"].."Good game! The match has finished with the score: \169000225000".._match.ctRounds.."-".._match.ttRounds);
			msg(_serverMsgs["info"].."The winning team is: ".._chatColors[_match.teamWon]..((_match.teamWon == 1 and "TT") or "CT"));
		end
	end
end

function _hit(id, source, weapon, hpdmg, apdmg, rawdmg)
	if(_match.live) then
		if(_player[source].team ~= _player[id].team) then
			_player[source].roundDmg = _player[source].roundDmg + hpdmg;
			_player[source].totalDmg = _player[source].totalDmg + hpdmg;
		end
	end
end

function _startround(mode)
	if(_match.prelive) then
		_match.live = true;
		_match.prelive = false;
	end

	if(_match.live) then
		_match.ttPlayers = player(0, "team1");
		_match.ctPlayers = player(0, "team2");

		for _, id in pairs(_match.ttPlayers) do
			_player[id].roundDmg = 0;
			_player[id]:maintainStats();
		end

		for _, id in pairs(_match.ctPlayers) do
			_player[id].roundDmg = 0;
			_player[id]:maintainStats();
		end

		parse("hudtxt 1 \"".._chatColors[2].."CT \169000225000".._match.ctRounds.."-".._match.ttRounds.._chatColors[1].." TT\" 400 20");
		parse("setteamscores ".._match.ttRounds.." ".._match.ctRounds);
	end
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
	if(_match.live) then
		_player[killer].score = _player[killer].score + 1;
		_player[victim].deaths = _player[victim].deaths + 1;
		if(assistant ~= 0) then _player[assistant].assists = _player[assistant].assists + 1; end
	end
end