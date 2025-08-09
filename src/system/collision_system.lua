local CollisionSystem = {}

function CollisionSystem.hasMapCollision(point)
    local blockX = point.x / 8
    local blockY = point.y / 8
    local blockID = mget(blockX, blockY)
    
    return blockID >= 128
end

function CollisionSystem.hasEntityCollision(entityA, entityB)
    local leftB = entityB.x - 8
    local rightB = entityB.x + 7
    local bottomB = entityB.y + 7
    local topB = entityB.y - 8

    local rightA = entityA.x + 7
    local leftA = entityA.x - 8
    local bottomA = entityA.y + 7
    local topA = entityA.y - 8

    if leftB > rightA or
       rightB < leftA or 
       bottomA < topB or
       topA > bottomB then
        return false
    end
    
    return true
end

function CollisionSystem.checkObjectCollision(character, newPosition, objects)
    for index, object in pairs(objects) do
        if CollisionSystem.hasEntityCollision(newPosition, object) then
            local collisionFunction = object.collisions[character.type]
            if collisionFunction then
                return collisionFunction(index)
            end
        end
    end
    return false
end

return CollisionSystem
