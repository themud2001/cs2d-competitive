for _, hook in pairs(_hooks) do
	addhook(hook, "_"..hook);
end

function _join(id)
	_player[id] = Player:new({
		name = player(id, "name");
		usgn = player(id, "usgn");
	});

	msg2(id, _serverMsgs["info"].."Welcome to "..game("sv_name"));
	msg2(id, _serverMsgs["info"].."Your rank is ".._ranks[_player[id].rank].tag);

	if(_player[id].usgn == 0) then
		msg2(id, _serverMsgs["error"].."You have to be logged in via USGN");
		-- Debugging
		_player[id].joinTeamAllowed = true;
	else
		_player[id].joinTeamAllowed = true;
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
		local players = player(0, "table");
		if(#players >= 10) then
			msg("Mix is starting in 10 seconds...");
			return 1;
		else
			msg("There are not enough players");
			return 1;
		end
	end

	if(text == "!test") then
		for _, val in pairs(player(0, "tableliving")) do
			msg(val);
		end
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
		if(mode == 1 or mode == 20) then
			_match.ttRounds = _match.ttRounds + 1;
		else
			_match.ctRounds = _match.ctRounds + 1;
		end

		local playersTable = player(0, "table");
		local mvp = next(playersTable, nil);
		for id in pairs(playersTable) do
			if(_player[id].team ~= 0) then
				_player[id].score = player(id, "score");
				_player[id].deaths = player(id, "deaths");
				_player[id].assists = player(id, "assists");
				_player[id].MVP = player(id, "mvp");

				if(id ~= mvp) then
					if(_player[id].roundDmg > _player[mvp].roundDmg) then
						mvp = id;
					end
				end
			end
			msg2(id, _serverMsgs["info"].."Your damage: \169250250250 (\169000225000".._player[id].roundDmg.."\169250250250)");
		end

		if(_player[mvp].roundDmg > 0) then
			msg(_serverMsgs["info"].."Highest damage: ".._chatColors[_player[mvp].team].._player[mvp].name.."\169250250250 (\169000225000".._player[mvp].roundDmg.."\169250250250)");
			msg(_serverMsgs["info"].."Highest total damage: ".._chatColors[_player[mvp].team].._player[mvp].name.."\169250250250 (\169000225000".._player[mvp].totalDmg.."\169250250250)");
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
	for id in pairs(player(0, "table")) do
		if(_player[id].team ~= 0) then
			_player[id].roundDmg = 0;
		end
	end
end
