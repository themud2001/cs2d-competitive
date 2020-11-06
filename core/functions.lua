function tableMax(table)
	local max, maxVal = next(table, nil);
	for k, v in pairs(table) do
		if(k ~= max and v ~= nil) then
			if(v > maxVal) then
				max = k;
				maxVal = v;
			end
		end
	end
	return max;
end

function splitText(text)
	local tempTable = {};
	for value in text:gmatch("[^%s]+") do
		table.insert(tempTable, value);
	end

	return tempTable;
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