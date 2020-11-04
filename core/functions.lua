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

function _match.getMVP(roundDmg)
	local roundMVP = tableMax(roundDmg);
	return roundMVP;
end