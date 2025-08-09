local IntroScreen = {}
local RenderSystem = require('src/system/render_system')

function IntroScreen.update()
    if btn(1) then
        return "GAME"
    end
    return "INTRO"
end

function IntroScreen.render()
    RenderSystem.clear()
    
    spr(368,
        78,
        15,
        0,
        1,
        0,
        0,
        12,
        4
    )

    print("Pressione BAIXO", 75, 100, 6)
    print("Luan G.", 98, 120, 15)
end

return IntroScreen
