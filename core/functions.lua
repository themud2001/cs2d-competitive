function tableMax(t)
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

function getMVP(roundDmg)
	local roundMVP = tableMax(roundDmg);
	return roundMVP;
end

function updateRankHudtxt(id)
	parse("hudtxt2 "..id.." 1 \"\169250250250Rank: ".._ranks[_player[id].rank].tag.."\" 8 165");
end

function updatePointsHudtxt(id)
	parse("hudtxt2 "..id.." 2 \"\169250250250Points: \169000225000"..math.floor(_player[id].points).."\" 8 185");
end