local GameScreen = {}
local RenderSystem = require('src/system/render_system')
local CollisionSystem = require('src/system/collision_system')
local Player = require('src/entity/player')
local Enemy = require('src/entity/enemy')
local GameObjects = require('src/entity/game_objects')
local Constants = require('src/core/constants')

local player
local objects

function GameScreen.init()
    objects = {}
    
    local key = GameObjects.createKey(3, 3)
    table.insert(objects, key)
    
    local door = GameObjects.createDoor(16, 8)
    table.insert(objects, door)
    
    local enemy = Enemy.create(25, 13)
    table.insert(objects, enemy)
    
    player = Player.create(70, 100)
end

function GameScreen.update()
    Player.update(player, objects)
    
    CollisionSystem.checkObjectCollision(player, {x = player.x, y = player.y}, objects)
    
    for index, object in pairs(objects) do
        if object.type == Constants.ENTITY_TYPES.ENEMY then
            Enemy.update(object, player, objects)
            
            if CollisionSystem.hasEntityCollision(player, object) then
                return "INTRO"
            end
        end
    end
    
    return "GAME"
end

function GameScreen.render()
    RenderSystem.clear()
    RenderSystem.renderMap()
    RenderSystem.renderEntity(player)
    RenderSystem.renderObjects(objects)
    
    print("Chaves: " .. player.keys, 5, 5, 6)
end

return GameScreen
