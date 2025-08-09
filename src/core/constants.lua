local Constants = {}

Constants.SCREEN_WIDTH = 240
Constants.SCREEN_HEIGHT = 138
Constants.PLAYER_SPEED = 1.0

Constants.SPRITE_KEY = 364
Constants.SPRITE_DOOR = 366
Constants.SPRITE_ENEMY = 292

Constants.SFX_KEY = 0
Constants.SFX_DOOR = 1

Constants.ENTITY_TYPES = {
    ENEMY = "ENEMY",
    PLAYER = "PLAYER"
}

Constants.DIRECTIONS = {
    DOWN = 1,
    UP = 2,
    RIGHT = 3,
    LEFT = 4
}

Constants.SCREENS = {
    INTRO = "INTRO",
    GAME = "GAME",
    GAME_OVER = "GAME_OVER"
}

return Constants
