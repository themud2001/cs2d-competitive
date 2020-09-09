function getRoundMVP(dmgTable)
	local mvp = math.max(unpack(dmgTable));
	for id, dmg in pairs(dmgTable) do
		if(dmg == mvp) then
			return id;
		end
	end
end