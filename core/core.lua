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
	msg(_chatColors[_player[id].team].._player[id].name.." ".._ranks[_player[id].rank].tag..": \169240240240"..text);
	return 1;
end

function _name(id, old, new)
	_player[id].name = new;
end