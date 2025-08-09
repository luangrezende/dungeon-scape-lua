
local Enemy = {}
local MovementSystem = require('src/system/movement_system')
local Constants = require('src/core/constants')

function Enemy.create(x, y)
    return {
        type = Constants.ENTITY_TYPES.ENEMY,
        sprite = Constants.SPRITE_ENEMY,
        x = x * 8 + 8,
        y = y * 8 + 8,
        backgroundColor = 14,
        animationFrame = 0.2,
        direction = Constants.DIRECTIONS.DOWN,
        collisions = {
            [Constants.ENTITY_TYPES.ENEMY] = function() return false end,
            [Constants.ENTITY_TYPES.PLAYER] = function(index)
                return true
            end
        }
    }
end

function Enemy.update(enemy, player, objects)
    local delta = { deltaY = 0, deltaX = 0 }

    if player.y > enemy.y then
        delta.deltaY = 0.4
        enemy.direction = Constants.DIRECTIONS.UP
    elseif player.y < enemy.y then
        delta.deltaY = -0.4
        enemy.direction = Constants.DIRECTIONS.DOWN
    end
    MovementSystem.moveEntity(enemy, delta, objects)

    delta = { deltaY = 0, deltaX = 0 }

    if player.x > enemy.x then
        delta.deltaX = 0.4
        enemy.direction = Constants.DIRECTIONS.LEFT
    elseif player.x < enemy.x then
        delta.deltaX = -0.4
        enemy.direction = Constants.DIRECTIONS.RIGHT
    end
    MovementSystem.moveEntity(enemy, delta, objects)

    local animationFrames = {
        {288, 290},
        {292, 294},
        {296, 298},
        {300, 302}
    }

    local frames = animationFrames[enemy.direction]
    local frame = math.floor(enemy.animationFrame)
    enemy.sprite = frames[frame]
end

return Enemy
