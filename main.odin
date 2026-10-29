package main

import rl "vendor:raylib"

import "game"

main :: proc() {
	rl.InitWindow(game.WINDOW_WIDTH, game.WINDOW_HEIGHT, game.WINDOW_TITLE)
	rl.SetTargetFPS(game.TARGET_FPS)

	state := game.init_game()

	for !rl.WindowShouldClose() {
		game.update_game(&state)
		game.draw_game(&state)
		free_all(context.temp_allocator)
	}

	game.shutdown_game(&state)
	rl.CloseWindow()
}
