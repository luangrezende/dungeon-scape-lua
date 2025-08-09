local MovementSystem = {}
local CollisionSystem = require('src/system/collision_system')
local Constants = require('src/core/constants')

function MovementSystem.moveEntity(character, delta, objects)
    local newPosition = {
        x = character.x + delta.deltaX,
        y = character.y + delta.deltaY
    }

    if CollisionSystem.checkObjectCollision(character, newPosition, objects) then
        return
    end

    local topLeft = {
        x = character.x - 8 + delta.deltaX,
        y = character.y - 8 + delta.deltaY
    }
    local topRight = {
        x = character.x + 7 + delta.deltaX,
        y = character.y - 8 + delta.deltaY
    }
    local bottomRight = {
        x = character.x + 7 + delta.deltaX,
        y = character.y + 7 + delta.deltaY
    }
    local bottomLeft = {
        x = character.x - 8 + delta.deltaX,
        y = character.y + 7 + delta.deltaY
    }

    if not (CollisionSystem.hasMapCollision(bottomRight) or
            CollisionSystem.hasMapCollision(bottomLeft) or
            CollisionSystem.hasMapCollision(topRight) or
            CollisionSystem.hasMapCollision(topLeft)) then
        
        character.animationFrame = character.animationFrame + Constants.PLAYER_SPEED
        if character.animationFrame >= 3 then
            character.animationFrame = 1
        end

        character.y = character.y + delta.deltaY
        character.x = character.x + delta.deltaX
    end
end

return MovementSystem
