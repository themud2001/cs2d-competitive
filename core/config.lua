_player = {};

_hooks = {"join", "team", "say", "sayteam", "name", "endround", "hit", "startround", "spawn", "kill", "leave", "minute", "serveraction", "mapchange"};

_ranksPath = "gfx/ranks/";

_cooldownTime = 3000;

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
		tag = "\169102071060[Iron I]";
		points = 0;
		winPoints = 100;
		losePoints = 45;
	};

	[1] = {
		tag = "\169121085072[Iron II]";
		points = 100;
		winPoints = 100;
		losePoints = 45;
	};

	[2] = {
		tag = "\169148107092[Iron III]";
		points = 200;
		winPoints = 100;
		losePoints = 45;
	};

	[3] = {
		tag = "\169212087004[Bronze I]";
		points = 300;
		winPoints = 100;
		losePoints = 50;
	};

	[4] = {
		tag = "\169237098005[Bronze II]";
		points = 435;
		winPoints = 100;
		losePoints = 50;
	};

	[5] = {
		tag = "\169232115037[Bronze III]";
		points = 565;
		winPoints = 100;
		losePoints = 50;
	};

	[6] = {
		tag = "\169110110110[Silver I]";
		points = 700;
		winPoints = 100;
		losePoints = 50;
	};

	[7] = {
		tag = "\169140140140[Silver II]";
		points = 835;
		winPoints = 100;
		losePoints = 55;
	};

	[8] = {
		tag = "\169170170170[Silver III]";
		points = 965;
		winPoints = 100;
		losePoints = 55;
	};

	[9] = {
		tag = "\169219172002[Gold I]";
		points = 1100;
		winPoints = 90;
		losePoints = 65;
	};

	[10] = {
		tag = "\169235184002[Gold II]";
		points = 1235;
		winPoints = 85;
		losePoints = 65;
	};

	[11] = {
		tag = "\169255200003[Gold III]";
		points = 1365;
		winPoints = 85;
		losePoints = 70;
	};

	[12] = {
		tag = "\169030212002[Emerald I]";
		points = 1500;
		winPoints = 75;
		losePoints = 85;
	};

	[13] = {
		tag = "\169033232002[Emerald II]";
		points = 1700;
		winPoints = 70;
		losePoints = 90;
	};

	[14] = {
		tag = "\169037252003[Emerald III]";
		points = 1900;
		winPoints = 70;
		losePoints = 95;
	};

	[15] = {
		tag = "\169000210252[Diamond I]";
		points = 2100;
		winPoints = 70;
		losePoints = 110;
	};

	[16] = {
		tag = "\169000210252[Diamond II]";
		points = 2300;
		winPoints = 70;
		losePoints = 115;
	};

	[17] = {
		tag = "\169000210252[Diamond III]";
		points = 2500;
		winPoints = 70;
		losePoints = 115;
	};

	[18] = {
		tag = "\169163000205[Guardian]";
		points = 3000;
		winPoints = 60;
		losePoints = 120;
	};

	[19] = {
		tag = "\169000150255[S\169000125255u\169000100255p\169000080255r\169000065255e\169000035255m\169000000255e]";
		points = 3600;
		winPoints = 60;
		losePoints = 120;
	};

	[20] = {
		tag = "\169000000000[Overlord]";
		points = 4250;
		winPoints = 60;
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
					parse("kick "..cmd[2].." \"Kicked by "..player(id, "name").."\"");
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
					parse("banip "..cmd[2].." 0 \"Banned by "..player(id, "name").."\"");
				end
			end;
		};

		[2] = {
			name = "tempban";
			usage = "!tempban <id> <hours>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				cmd[3] = tonumber(cmd[3]) or 1;
				local hourString = cmd[3] > 1 and "hours" or "hour";

				if(cmd[3] > 24) then cmd[3] = 24; end
				if(cmd[3] <= 0) then cmd[3] = 1; end

				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(cmd[2] == id) then
					msg2(id, _serverMsgs["error"].."You can\'t ban yourself");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was temp-banned by \169000225000"..player(id, "name").." \169250250250for (\169000225000"..cmd[3].."\169250250250) "..hourString);
					parse("banip "..cmd[2].." "..(cmd[3] * 60).." \"Temporarily-banned by "..player(id, "name").." for "..cmd[3].." "..hourString.."\"");
				end
			end;
		};

		[3] = {
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

		[4] = {
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

		[5] = {
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

		[6] = {
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

		[7] = {
			name = "admin";
			usage = "!admin <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(_player[cmd[2]].isAdmin ~= 0) then
					msg2(id, _serverMsgs["error"].."The player with the specified ID is already an admin");
				else
					_player[cmd[2]].isAdmin = 1;
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was promoted to admin by \169000225000"..player(id, "name"));
					msg2(cmd[2], _serverMsgs["success"].."You are now an admin");
				end
			end;
		};

		[8] = {
			name = "unadmin";
			usage = "!unadmin <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(_player[cmd[2]].isAdmin == 0) then
					msg2(id, _serverMsgs["error"].."The player with the specified ID is not an admin");
				elseif(cmd[2] == id) then
					msg2(id, _serverMsgs["error"].."You can\'t demote yourself");
				else
					_player[cmd[2]].isAdmin = 0;
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was demoted to user by \169000225000"..player(id, "name"));
					msg2(cmd[2], _serverMsgs["error"].."You are now a normal user");
				end
			end;
		};

		[9] = {
			name = "maket";
			usage = "!maket <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(_player[cmd[2]].team == 1) then
					msg2(id, _serverMsgs["error"].."The player with the specified ID is already in TT");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was moved to TT by \169000225000"..player(id, "name"));
					parse("maket "..cmd[2]);
				end
			end;
		};

		[10] = {
			name = "makect";
			usage = "!makect <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(_player[cmd[2]].team == 2) then
					msg2(id, _serverMsgs["error"].."The player with the specified ID is already in CT");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was moved to CT by \169000225000"..player(id, "name"));
					parse("makect "..cmd[2]);
				end
			end;
		};

		[11] = {
			name = "makespec";
			usage = "!makespec <id>";
			execute = function(id, cmd)
				cmd[2] = tonumber(cmd[2]);
				if(not cmd[2] or not player(cmd[2], "exists")) then
					msg2(id, _serverMsgs["error"].."The player doesn\'t exist");
				elseif(_player[cmd[2]].team == 0) then
					msg2(id, _serverMsgs["error"].."The player with the specified ID is already a spectator");
				else
					msg(_serverMsgs["info"].."Player \169000225000"..player(cmd[2], "name").." \169250250250was made a spectator by \169000225000"..player(id, "name"));
					parse("makespec "..cmd[2]);
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
	[0] = _chatColors[0].."Type \"".._cmds.prefix.."rank\", \"".._cmds.prefix.."stats\" or click [F4] to see your stats";
	[1] = _chatColors[0].."Type \"".._cmds.prefix.."rs\" to reset your score";
	[2] = _chatColors[0].."Running doesn\'t affect weapons recoil";
	[3] = _chatColors[0].."Killing higher rank players give you additional points";
	[4] = _chatColors[0].."Shotguns are short-ranged guns";
	[5] = _chatColors[0].."Planting the bomb or defusing it gives you addtional points";
	[6] = _chatColors[0].."Check every corner, campers can be everywhere";
	[7] = _chatColors[0].."Type \"".._cmds.prefix.."help\" to see a list of available commands";
};

_maps = {"de_dust", "de_dust2", "cs_office", "de_cs2d", "de_inferno", "cs_assault", "de_cbble", "de_desert", "de_aztec"};