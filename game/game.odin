package game

import rl "vendor:raylib"

import "core:fmt"

import "../core"
import "../graphics"


Screen :: enum {
	MENU,
	PLAYING,
	GAME_OVER,
}

// Main goal is that the game run's here
GameState :: struct {
	screen:        Screen,
	player:        Player,
	bullets:       [dynamic]Bullet,
	enemy_bullets: [dynamic]Bullet,
	enemies:       [dynamic]Enemy,
	spawner:       Spawner,
	score:         int,
	assets:        graphics.AssetStore,
}


init_game :: proc() -> GameState {
	return GameState{
		screen  = .MENU,
		player  = create_player(),
		spawner = create_spawner(),
		score   = 0,
		assets  = graphics.load_all(),
	}
}

shutdown_game :: proc(s: ^GameState) {
	graphics.unload_all(&s.assets)
}

update_game :: proc(s: ^GameState) {
	inputs := core.Get_Input()

	switch s.screen {
	case .MENU:
		if inputs.start {
			s.screen = .PLAYING
		}
	case .PLAYING:
		update_player(&s.player, inputs, &s.bullets)
			update_spawner(&s.spawner, &s.enemies)
		update_pool(&s.bullets, update_bullet)
		update_pool(&s.enemy_bullets, update_bullet)

		bullet_collision(s)

		// same logic for enemies i guess
		for i := len(s.enemies) - 1; i >= 0; i -= 1 {
			update_enemy(&s.enemies[i], &s.enemy_bullets, s.player.position)
			if !s.enemies[i].active {
				unordered_remove(&s.enemies, i)
			}
		}

		if !s.player.active {
			s.screen = .GAME_OVER
		}

	case .GAME_OVER:
		if inputs.restart {
			s^ = init_game()
		}
	}
}

draw_game :: proc(s: ^GameState) {
	rl.BeginDrawing()
	rl.ClearBackground(BG_COLOR)

	switch s.screen {
	case .MENU:
		rl.DrawText("PRESS ENTER TO START", 150, 400, 20, TEXT_COLOR)
	case .PLAYING:
			draw_player(s.player)
		draw_pool(s.bullets[:], draw_bullet)
		draw_pool(s.enemy_bullets[:], draw_bullet)

		for enemy in s.enemies {
			draw_enemy(enemy)
		}
		rl.DrawText(fmt.ctprintf("Score: %d", s.score), 10, 10, 20, TEXT_COLOR)
	case .GAME_OVER:
		draw_player(s.player)
		draw_pool(s.bullets[:], draw_bullet)
		draw_pool(s.enemy_bullets[:], draw_bullet)

		for enemy in s.enemies {
			draw_enemy(enemy)
		}

		rl.DrawText("GAME OVER", 220, 400, 40, TEXT_COLOR_RED)
		rl.DrawText(fmt.ctprintf("Final Score: %d", s.score), 200, 460, 25, TEXT_COLOR)
		rl.DrawText("PRESS R TO RESTART", 190, 520, 20, TEXT_COLOR)
	}

	rl.EndDrawing()
}
