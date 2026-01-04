# Dungeon Scape Game

A **2D dungeon crawler** built in **Lua** for the **TIC-80 fantasy console**, focused on clean modular design, deterministic gameplay, and classic RPG mechanics.

---

## Overview

Dungeon Scape Game is a small but structured dungeon crawler where the player navigates tile-based levels, collects keys, avoids enemies, and reaches the exit.

The project was built to explore:
- Modular game architecture in Lua
- Entity-based design
- Deterministic collision and movement systems
- State-driven screen transitions

Rather than focusing on content volume, the emphasis is on **code organization, clarity, and system separation**.

---

## Core Features

- **Modular Architecture**  
  Clear separation between core utilities, entities, systems, and screens.

- **Entity-Based Design**  
  Player, enemies, and interactive objects implemented as independent entities.

- **Tile-Based Collision System**  
  Deterministic collision handling against map tiles and entities.

- **Animation System**  
  Sprite-based animations with explicit state control.

- **Sound Effects**  
  Audio feedback for interactions such as key collection and door activation.

- **State Management**  
  Screen transitions between intro and gameplay using explicit game states.

---

## Project Structure

```
src/
├── core/           # Core constants and shared utilities
├── entity/         # Player, enemies, and interactive objects
├── screen/         # Game screens (intro, gameplay)
├── system/         # Core systems (movement, collision, rendering)
└── main.lua        # Application entry point
```

---

## How to Play

1. Open `Dungeon Scape Game.html` in a web browser  
2. Press **DOWN** to start  
3. Use arrow keys to move  
4. Collect keys to open doors  
5. Avoid enemies or restart the level  

---

## Technical Details

- **Platform**: TIC-80 fantasy console  
- **Language**: Lua  
- **Resolution**: 240×136  
- **Color Palette**: 16 colors  
- **Graphics**: Pixel art sprites  
- **Audio**: Built-in TIC-80 sound system  

---

## Distribution Files

- `game.tic` — TIC-80 cartridge containing the full game  
- `Dungeon Scape Game.html` — Browser-playable export  
- `src/` — Modular source code  

---

## Scope and Intent

This project is not intended as a full-scale RPG, but as:
- A demonstration of **structured Lua game architecture**
- A reference for **entity-based design in constrained environments**
- A compact example of **classic 2D game systems**

---

## License

Created by Luan Gomes.
