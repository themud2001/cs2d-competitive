function _match.getMVP(roundDmg, totalDmg)
	local roundMVP = math.max(unpack(roundDmg));
	local totalMVP = math.max(unpack(totalDmg));
	local roundMVPId, totalMVPId;

	for id, dmg in pairs(roundDmg) do
		if(dmg == roundMVP) then roundMVPId = id; break; end
	end

	for id, dmg in pairs(totalDmg) do
		if(dmg == totalMVP) then totalMVPId = id; break; end
	end

	return roundMVPId, totalMVPId;
end

function _match.setMatchLive()
	parse("mp_startmoney 800");
	parse("sv_fow 1");
	parse("mp_roundtime 2");
	parse("mp_freezetime 5");
	parse("mp_lagcompensation 2");
	parse("mp_autoteambalance 0");
	parse("mp_unbuyable \"Tactical Shield, AWP, SG552, Aug, Scout, G3SG1, SG550\"");
	parse("restart ".._match.restartWait);
	_match.prelive = true;
	msg(_serverMsgs["info"].."Good luck & have fun!");
	msg(_serverMsgs["info"].."The match is starting in ".._match.restartWait.." seconds...");
end

function _match.switchPlayers()
	local ttTable, ctTable = player(0, "team1"), player(0, "team2");

	for _, id in pairs(ttTable) do
		parse("makect "..id);
	end

	for _, id in pairs(ctTable) do
		parse("maket "..id);
	end
end

function _match.endFirstHalf()
	_match.ttRounds, _match.ctRounds = _match.ctRounds, _match.ttRounds;
	_match.switchPlayers();
	_match.half = 2;
	msg(_serverMsgs["info"].."Good half! The first half has ended with the score: \169000225000".._match.ctRounds.."-".._match.ttRounds);
end

function _match.calculateStats()
	for _, id in pairs(player(0, "team".._match.teamWon)) do
		_player[id]:calculateWin();
		msg(_player[id].points);
	end
end