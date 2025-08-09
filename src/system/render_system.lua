local RenderSystem = {}
local Constants = require('src/core/constants')

function RenderSystem.renderMap()
    map(
        0,
        0,
        Constants.SCREEN_WIDTH,
        Constants.SCREEN_HEIGHT,
        0,
        0
    )
end

function RenderSystem.renderEntity(entity)
    spr(entity.sprite,
        entity.x - 8,
        entity.y - 8,
        entity.backgroundColor or 6,
        1,
        0,
        0,
        2,
        2)
end

function RenderSystem.renderObjects(objects)
    for _, object in pairs(objects) do
        RenderSystem.renderEntity(object)
    end
end

function RenderSystem.clear()
    cls()
end

return RenderSystem
