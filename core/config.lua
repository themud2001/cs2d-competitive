_player = {};

_hooks = {"join", "team", "say", "name", "endround", "hit", "startround", "startround_prespawn", "kill", "leave", "minute"};

_serverMsgs = {
	["info"] = "\169041098255[Server]: \169250250250";
	["success"] = "\169000225000[Server]: \169250250250";
	["error"] = "\169250025025[Server]: \169250250250";
};

_chatColors = {
	[0] = "\169175175175";
	[1] = "\169213000000";
	[2] = "\169048079254";
};

_ranks = {
	[0] = {
		name = "Iron";
		tag = "\169121085072[Iron]";
		points = 0;
		winPoints = 120;
		losePoints = 80;
	};

	[1] = {
		name = "Bronze";
		tag = "\169237098005[Bronze]";
		points = 300;
		winPoints = 115;
		losePoints = 85;
	};

	[2] = {
		name = "Silver";
		tag = "\169130130130[Silver]";
		points = 700;
		winPoints = 110;
		losePoints = 90;
	};

	[3] = {
		name = "Gold";
		tag = "\169240210000[Gold]";
		points = 1100;
		winPoints = 100;
		losePoints = 95;
	};

	[4] = {
		name = "Emerald";
		tag = "\169033232002[Emerald]";
		points = 1650;
		winPoints = 90;
		losePoints = 110;
	};

	[5] = {
		name = "Diamond";
		tag = "\169000210252[Diamond]";
		points = 2150;
		winPoints = 85;
		losePoints = 110;
	};

	[6] = {
		name = "Guardian";
		tag = "\169163000205[Guardian]";
		points = 2650;
		winPoints = 80;
		losePoints = 115;
	};

	[7] = {
		name = "Supreme";
		tag = "\169000150255[S\169000125255u\169000100255p\169000080255r\169000065255e\169000035255m\169000000255e]";
		points = 3250;
		winPoints = 75;
		losePoints = 115;
	};

	[8] = {
		name = "Overlord";
		tag = "\169000000000[Overlord]";
		points = 3900;
		winPoints = 65;
		losePoints = 120;
	};
};

_cmds = {
	prefix = "!";

	admin = {
		[0] = {
			name = "kick";
			usage = "!kick <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(cmd[2] == id) then
					msg2(id, _serverMsgs["error"].."You can\'t kick yourself");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was kicked by \169000225000"..player(id, "name"));
					parse("kick "..cmd[2].." Kicked by "..player(id, "name"));
				end
			end;
		};

		[1] = {
			name = "ban";
			usage = "!ban <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(cmd[2] == id) then
					msg2(id, _serverMsgs["error"].."You can\'t ban yourself");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was banned by \169000225000"..player(id, "name"));
					parse("banip "..cmd[2]);
				end
			end;
		};

		[2] = {
			name = "mute";
			usage = "!mute <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(cmd[2] == id) then
					msg2(id, _serverMsgs["error"].."You can\'t mute yourself");
				elseif(_player[cmd[2]].isMuted ~= 0) then
					msg2(id, _serverMsgs["error"].."The player is already muted");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was muted by \169000225000"..player(id, "name"));
					_player[cmd[2]].isMuted = 1;
				end
			end;
		};

		[3] = {
			name = "unmute";
			usage = "!unmute <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(_player[cmd[2]].isMuted == 0) then
					msg2(id, _serverMsgs["error"].."The player is not muted");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was unmuted by \169000225000"..player(id, "name"));
					_player[cmd[2]].isMuted = 0;
				end
			end;
		};

		[4] = {
			name = "fow";
			usage = "!fow <mode>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2]) then
					msg2(id, _serverMsgs["error"].."Specify a FOW mode (1-3)");
				else
					msg(_serverMsgs["info"].."Fog of war was set by \169000225000"..player(id, "name"));
					parse("sv_fow "..cmd[2]);
				end
			end;
		};

		[5] = {
			name = "map";
			usage = "!map <map name>";
			execute = function(id, cmd)
				if(not cmd[2]) then
					msg2(id, _serverMsgs["error"].."Specify a map name");
				else
					for _, mapName in pairs(_maps) do
						if(mapName == cmd[2]) then
							msg(_serverMsgs["info"].."The map was changed to \169000225000"..mapName.." \169250250250by \169000225000"..player(id, "name"));
							parse("changemap "..mapName);
							return;
						end
					end

					msg2(id, _serverMsgs["error"].."The map doesn\'t exist or isn\'t a standard one");
				end
			end;
		};
	};

	normal = {
		[0] = {
			name = "rs";
			usage = "!rs";
			execute = function(id)
				parse("setscore "..id.." 0");
				parse("setdeaths "..id.." 0");
				parse("setscore "..id.." 0");
				msg2(id, _serverMsgs["success"].."You have reset your score");
			end;
		};

		[1] = {
			name = "stats";
			usage = "!stats";
			execute = function(id) _player[id]:printStats(); end;
		};

		[2] = {
			name = "rank";
			usage = "!rank";
			execute = function(id) _player[id]:printStats(); end;
		};
	};
};

_hints = {
	[0] = _chatColors[0].."Type \"".._cmds.prefix.."rank\" or \"".._cmds.prefix.."stats\" to see your stats";
	[1] = _chatColors[0].."Type \"".._cmds.prefix.."rs\" to reset your score";
	[2] = _chatColors[0].."Running doesn\'t affect weapons recoil";
	[3] = _chatColors[0].."Killing higher rank players give you additional points";
	[4] = _chatColors[0].."Shotguns are short-ranged guns";
	[5] = _chatColors[0].."Planting the bomb or defusing it gives you addtional points";
	[6] = _chatColors[0].."Check every corner, campers can be everywhere";
};

_maps = {"de_dust", "de_dust2", "cs_office", "de_cs2d", "de_inferno", "cs_assault", "de_cbble", "de_desert", "de_aztec"};