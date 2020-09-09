function getMVP(roundDmg, totalDmg)
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

function setMatchLive()
	parse("mp_startmoney 800");
	parse("sv_fow 1");
	parse("mp_roundtime 2");
	parse("mp_freezetime 5");
	parse("mp_lagcompensation 2");
	parse("mp_autoteambalance 0");
	parse("mp_unbuyable \"Tactical Shield, AWP, SG552, Aug, Scout, G3SG1, SG550\"");
	parse("restart 10");
	msg(_serverMsgs["info"].."Good luck & have fun!");
	msg(_serverMsgs["info"].."The match is starting in 10 seconds...");
	_match.live = true;
end