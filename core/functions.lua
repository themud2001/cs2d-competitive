function tableMax(t, f)
	local max, maxVal = next(t, nil);
	for k, v in pairs(t) do
		if(k ~= max and v ~= nil) then
			if(v > maxVal) then
				max = k;
				maxVal = v;
			end
		end
	end

	return max;
end

function _match.getMVP(roundDmg, totalDmg)
	local roundMVP = tableMax(roundDmg, "roundDmg");
	local totalMVP = tableMax(totalDmg, "totalDmg");
	return roundMVP, totalMVP;
end

function _match.reset()
	_match.ttRounds = 0;
	_match.ctRounds = 0;
	_match.prelive = false;
	_match.live = false;
	_match.finished = false;
	_match.half = 1;
end

function _match.setLive()
	_match.printResetStats();
	_match.reset();
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
	for _, id in pairs(_match.ttPlayers) do
		parse("makect "..id);
	end

	for _, id in pairs(_match.ctPlayers) do
		parse("maket "..id);
	end
end

function _match.endFirstHalf()
	_match.ttRounds, _match.ctRounds = _match.ctRounds, _match.ttRounds;
	_match.switchPlayers();
	_match.half = 2;
	msg(_serverMsgs["info"].."Good half! The first half has ended with the score: \169000225000".._match.ctRounds.."-".._match.ttRounds);
end

function _match.calculateWin()
	local teamWon = (_match.teamWon == 1 and "1") or "2";
	for _, id in pairs(player(0, "team"..teamWon)) do
		_player[id]:calculateWin();
	end
end

function _match.calculateLose()
	local teamLost = (_match.teamWon == 1 and "2") or "1";
	for _, id in pairs(player(0, "team"..teamLost)) do
		_player[id]:calculateLose();
	end
end

function _match.printResetStats(mode)
	for _, id in pairs(player(0, "table")) do
		if(mode == "all") then
			_player[id]:printStats();
			_player[id]:updateRank();
		end
		_player[id]:resetStats();
	end
end