_player = {};

_match = {
	prelive = false;
	live = false;
	finished = false;
	ttRounds = 0;
	ctRounds = 0;
	ttFirstHalfRounds = 0;
	ctFirstHalfRounds = 0;
	roundsLimit = 3; -- Testing
	restartWait = 1; -- Testing
	half = 1;
	teamWon = 0;
	playoffs = false;
	playoffsRoundsLimit = 3;
	ttPlayers = {};
	ctPlayers = {};
}

_hooks = {"join", "team", "say", "name", "endround", "hit", "startround", "startround_prespawn", "kill", "leave"};

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
	};

	[1] = {
		name = "Bronze";
		tag = "\169237098005[Bronze]";
		points = 75;
	};

	[2] = {
		name = "Silver";
		tag = "\169130130130[Silver]";
		points = 175;
	};

	[3] = {
		name = "Gold";
		tag = "\169240210000[Gold]";
		points = 300;
	};

	[4] = {
		name = "Emerald";
		tag = "\169033232002[Emerald]";
		points = 450;
	};

	[5] = {
		name = "Diamond";
		tag = "\169000210252[Diamond]";
		points = 625;
	};

	[6] = {
		name = "Guardian";
		tag = "\169163000205[Guardian]";
		points = 800;
	};

	[7] = {
		name = "Supreme";
		tag = "\169000150255[S\169000125255u\169000100255p\169000080255r\169000065255e\169000035255m\169000000255e]";
		points = 975;
	};

	[8] = {
		name = "Overlord";
		tag = "\169000000000[Overlord]";
		points = 1150;
	};
};