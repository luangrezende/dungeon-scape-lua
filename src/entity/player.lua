
local Player = {}
local MovementSystem = require('src/system/movement_system')
local Constants = require('src/core/constants')

function Player.create(x, y)
    return {
        type = Constants.ENTITY_TYPES.PLAYER,
        sprite = 260,
        x = x or 70,
        y = y or 100,
        backgroundColor = 6,
        animationFrame = 1,
        keys = 0,
        health = 100
    }
end

function Player.update(player, objects)
    local animationFrames = {
        {256, 258},
        {260, 262},
        {264, 266},
        {268, 270}
    }
    
    local directions = {
        {deltaX = 0, deltaY = -1},
        {deltaX = 0, deltaY = 1},
        {deltaX = -1, deltaY = 0},
        {deltaX = 1, deltaY = 0}
    }
    
    for key = 0, 3 do
        if btn(key) then
            player.sprite = animationFrames[key + 1][math.floor(player.animationFrame)]
            MovementSystem.moveEntity(player, directions[key + 1], objects)
        end
    end
end

return Player
