
-- title:  Dungeon Scape Game
-- author: LUAN GOMES
-- desc:   2D RPG Game
-- script: lua

local ScreenManager = require('src/core/screen_manager')

function init()
    ScreenManager.init()
end

function TIC()
    ScreenManager.update()
    ScreenManager.render()
end

init()
