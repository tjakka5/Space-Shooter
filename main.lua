local GameState = require("lib.gamestate")
GameState.registerEvents()

local Menu = require("src.states.menu")
local Game = require("src.states.game")

GameState.switch(Game)
