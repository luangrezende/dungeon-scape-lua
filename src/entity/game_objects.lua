
local GameObjects = {}
local Constants = require('src/core/constants')

function GameObjects.createKey(column, row)
    return {
        sprite = Constants.SPRITE_KEY,
        x = column * 8,
        y = row * 8,
        backgroundColor = 6,
        collisions = {
            [Constants.ENTITY_TYPES.ENEMY] = function() return false end,
            [Constants.ENTITY_TYPES.PLAYER] = function(index, player, objects)
                player.keys = player.keys + 1
                table.remove(objects, index)
                sfx(Constants.SFX_KEY, 36, 32, 0, 8, 1)
                return false
            end
        }
    }
end

function GameObjects.createDoor(column, row)
    return {
        sprite = Constants.SPRITE_DOOR,
        x = column * 8,
        y = row * 8,
        backgroundColor = 6,
        collisions = {
            [Constants.ENTITY_TYPES.ENEMY] = function() return true end,
            [Constants.ENTITY_TYPES.PLAYER] = function(index, player, objects)
                if player.keys > 0 then
                    player.keys = player.keys - 1
                    table.remove(objects, index)
                    sfx(Constants.SFX_DOOR, 60, 30, 0, 8, 1)
                    return false
                end
                return true
            end
        }
    }
end

return GameObjects
