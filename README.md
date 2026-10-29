# Odin + Raylib Starter Kit

Minimal, copy-and-go top-down shooter scaffold built for learning and rapid prototyping.

## Quickstart

### Requirements
- [Odin](https://odin-lang.org/) compiler installed and in PATH
- Raylib available via Odin vendor (ships with Odin installs in most cases)

### Build & Run
```bash
# With make
make run

# With shell script
./build.sh

# Manually
odin build . -collection:.. -out:game
./game
```

## Controls
| Key | Action |
|-----|--------|
| Arrow keys | Move |
| SPACE | Shoot |
| ENTER | Start (from menu) |
| R | Restart (from game over) |

## Structure
```
main.odin        -> entry point
core/            -> input, utilities
game/            -> game state, entities, config
graphics/        -> texture loading, asset store
assets/texture/  -> sprites
```

## Features Included
- [x] Menu / Playing / Game Over screen state machine
- [x] Player movement + shooting
- [x] Enemy spawning + AI shooting
- [x] Bullet pooling with collision
- [x] Score tracking
- [x] Central config (`game/config.odin`)
- [x] Asset store with explicit load/unload
- [x] Unified pooling helpers (`update_pool` / `draw_pool`)
- [x] Build scripts (Makefile, build.sh)
- [x] .gitignore

## Roadmap

### Must Have (for reuse)
- [ ] **Build system**: Makefile/build.sh/justfile to build/run (done basic version)
- [ ] **README with setup**: install odin + raylib, build steps, run steps (expand)
- [ ] **Assets dir structure**: documented + placeholder dirs (textures/sounds/fonts)
- [ ] **Main entry**: clean, configurable (window size/title/fps in config)
- [ ] **Core modules**: math utils, input abstraction, time/dt, color helpers
- [ ] **Game scaffold**: GameState with screen enum, update/draw split, init/shutdown
- [ ] **Entity pattern**: consistent (struct + create/update/draw), pooling via [dynamic] + update_pool
- [ ] **Collision helpers**: circle/rect/aabb in common
- [ ] **Resource mgmt**: asset store + unload

### Nice to Have
- [ ] **Camera**: 2D camera wrapper
- [ ] **Particles/explosions**: reusable animation system
- [ ] **UI system**: buttons/text helpers, menus
- [ ] **Save/load**: config/high scores
- [ ] **Logging/debug**: draw fps, debug overlay toggle
- [ ] **Scene system**: more than just screen enum
- [ ] **Object pool generic**: stronger than current update_pool
- [ ] **Timer/tween helpers**: common for animations
- [ ] **Input mapping**: action-based (move_up etc) not raw keys
- [ ] **Random utils**: seeded rng wrapper
- [ ] **Math helpers**: vec utils, angles

### Planned Improvements
- [ ] Migrate all entities to use AssetStore passed in (optional path)
- [ ] Add sound support
- [ ] Add fonts support
- [ ] Gamepad support
- [ ] Hot reload helper

## Tips
- Keep constants in `game/config.odin`
- Add new entities following existing pattern
- Use `update_pool`/`draw_pool` for dynamic lists
- Call `shutdown_game` on exit (done in main)
