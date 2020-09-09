_player = {};

_match = {
	live = false; -- Debugging
	ttRounds = 0;
	ctRounds = 0;
	half = 1;
}

_hooks = {"join", "team", "say", "name", "endround", "hit", "startround"};

_serverMsgs = {
	["info"] = "\169041098255[Info]: \169250250250";
	["success"] = "\169000225000[Sucess]: \169250250250";
	["error"] = "\169221044000[Error]: \169250250250";
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
	};

	[1] = {
		name = "Bronze";
		tag = "\169237098005[Bronze]";
	};

	[2] = {
		name = "Silver";
		tag = "\169130130130[Silver]";
	};

	[3] = {
		name = "Gold";
		tag = "\169255220000[Gold]";
	};

	[4] = {
		name = "Emerald";
		tag = "\169033232002[Emerald]";
	};

	[5] = {
		name = "Diamond";
		tag = "\169000210252[Diamond]";
	};

	[6] = {
		name = "Guardian";
		tag = "\169163000205[Guardian]";
	};

	[7] = {
		name = "Supreme";
		tag = "\169000150255[S\169000125255u\169000100255p\169000080255r\169000065255e\169000035255m\169000000255e]";
	};

	[8] = {
		name = "Overlord";
		tag = "\169000000000[Overlord]";
	};
};