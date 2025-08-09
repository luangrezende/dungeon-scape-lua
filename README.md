
# 🏰 Dungeon Scape Game 🐉

A 2D dungeon crawler game built with Lua for the TIC-80 fantasy console.

## Overview

Dungeon Scape Game is a classic-style RPG where players navigate through a dungeon, collect keys, avoid enemies, and find the exit. The game features pixel art graphics, sound effects, and smooth character animations.

## Features

- **Modular Architecture**: Clean code organization with separated systems
- **Entity-Component System**: Player, enemies, and objects as independent entities
- **Collision Detection**: Precise collision system for map tiles and entities
- **Animation System**: Smooth sprite animations for all characters
- **Sound Effects**: Audio feedback for key collection and door opening
- **State Management**: Screen transitions between intro and gameplay

## Project Structure

```
src/
├── core/           # Core utilities and constants
├── entity/         # Game entities (player, enemy, objects)  
├── screen/         # Game screens (intro, game)
├── system/         # Game systems (collision, movement, render)
└── main.lua        # Entry point
```

## How to Play

1. Open `Dungeon Scape Game.html` in a web browser
2. Press DOWN arrow key to start
3. Use arrow keys to move
4. Collect keys to open doors
5. Avoid enemies or restart the level

## Development

Built for TIC-80 fantasy console using:
- **Language**: Lua
- **Graphics**: 8-bit pixel art sprites
- **Resolution**: 240x136 pixels
- **Palette**: 16-color palette

## Files

- `game.tic` - TIC-80 cartridge with game data
- `Dungeon Scape Game.html` - Browser-playable version
- `src/` - Source code modules

## License

Created by Luan Gomes.
