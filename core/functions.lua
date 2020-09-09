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