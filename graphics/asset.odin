package graphics

import rl "vendor:raylib"

AssetStore :: struct {
	player: rl.Texture2D,
	bullet: rl.Texture2D,
	enemy:  rl.Texture2D,
}

load_all :: proc() -> AssetStore {
	return AssetStore{
		player = rl.LoadTexture("assets/texture/player.png"),
		bullet = rl.LoadTexture("assets/texture/bullet.png"),
		enemy  = rl.LoadTexture("assets/texture/enemy.png"),
	}
}

unload_all :: proc(a: ^AssetStore) {
	if a.player.id != 0 do rl.UnloadTexture(a.player)
	if a.bullet.id != 0 do rl.UnloadTexture(a.bullet)
	if a.enemy.id  != 0 do rl.UnloadTexture(a.enemy)
}
