local scriptPath = debug.getinfo(1, "S").short_src:match("(.*/)");

dofile(scriptPath.."core/config.lua");
dofile(scriptPath.."core/Player.lua");
dofile(scriptPath.."core/functions.lua");
dofile(scriptPath.."core/core.lua");