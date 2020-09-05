for _, hook in pairs(_hooks) do
	addhook(hook, "_"..hook);
end

function _join(id)
	_player[id] = Player:new();

	msg2(id, _serverMsgs["success"].."Welcome to "..game("sv_name"));

	if(player(id, "usgn") == 0) then
		msg2(id, _serverMsgs["error"].."You have to be logged in via USGN");
	else
		_player[id].usgn = player(id, "usgn");
		_player[id].joinTeamAllowed = true;
	end
end

function _team(id, team)
	if(not _player[id].joinTeamAllowed) then
		msg2(id, _serverMsgs["error"].."You are not allowed to join a team");
		return 1;
	end
end