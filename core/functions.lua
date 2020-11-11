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