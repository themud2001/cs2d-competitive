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

function removeCooldown(id)
	_player[tonumber(id)].cooldown = false;
end

function setCooldown(id)
	_player[id].cooldown = true;
	timer(_cooldownTime, "removeCooldown", id);
end

function checkCommands(id, text)
	if(text:sub(0, 1) == _cmds.prefix) then
		text = text:lower();
		local cmd = splitText(text);

		if(_player[id].cooldown) then
			return 1;
		end

		if(cmd[1] == "!help") then
			msg2(id, _chatColors[0].."---------Commands List---------");

			for i=0, #_cmds.normal do
				msg2(id, _chatColors[0].._cmds.normal[i].name..": \169000225000".._cmds.normal[i].usage);
			end

			if(_player[id].isAdmin ~= 0) then
				for i=0, #_cmds.admin do
					msg2(id, _chatColors[0].._cmds.admin[i].name..": \169000225000".._cmds.admin[i].usage);
				end
			end

			setCooldown(id);

			return 1;
		end

		for i=0, #_cmds.normal do
			if(cmd[1]:sub(2) == _cmds.normal[i].name) then
				_cmds.normal[i].execute(id);
				setCooldown(id);
				return 1;
			end
		end

		if(_player[id].isAdmin ~= 0) then
			for i=0, #_cmds.admin do
				if(cmd[1]:sub(2) == _cmds.admin[i].name) then
					_cmds.admin[i].execute(id, cmd);
					return 1;
				end
			end
		end
	end
end