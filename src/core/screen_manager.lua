
local ScreenManager = {}
local IntroScreen = require('src/screen/intro_screen')
local GameScreen = require('src/screen/game_screen')

local currentScreen = "INTRO"
local screens = {
    INTRO = IntroScreen,
    GAME = GameScreen
}

function ScreenManager.init()
    currentScreen = "INTRO"
    GameScreen.init()
end

function ScreenManager.update()
    local screen = screens[currentScreen]
    if screen and screen.update then
        local nextScreen = screen.update()
        if nextScreen and nextScreen ~= currentScreen then
            currentScreen = nextScreen
            if nextScreen == "GAME" then
                GameScreen.init()
            end
        end
    end
end

function ScreenManager.render()
    local screen = screens[currentScreen]
    if screen and screen.render then
        screen.render()
    end
end

return ScreenManager
