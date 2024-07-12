extends Node2D

@onready var player_spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var bullet_parent: Node2D = $BulletParent

var multiplayer_peer = ENetMultiplayerPeer.new()

const ADDRESS = "localhost"

#var connected_ids = []

func _ready() -> void:
	match Global.current_type:
		Global.gameType.Host:
			multiplayer_peer.create_server(Global.port)
			print("Host")
			multiplayer.multiplayer_peer = multiplayer_peer
			add_player(1)
			multiplayer_peer.peer_connected.connect(func(id): add_player(id))
			
		Global.gameType.Join:
			multiplayer_peer.create_client(ADDRESS, Global.port)
			multiplayer.multiplayer_peer = multiplayer_peer
			print("Client")
			

func add_player(peer_id):
	var player = preload("res://scenes/player.tscn").instantiate()
	player.name = str(peer_id)
	add_child(player, true)


@rpc("any_peer", "call_local", "reliable", 0)
func add_bullet(bullet_scene_path: String, bullet_transform, bullet_owner):
	var new_bullet: Bullet = load(bullet_scene_path).instantiate()
	new_bullet.global_transform = bullet_transform
	new_bullet.bullet_owner = bullet_owner
	bullet_parent.add_child(new_bullet, true)


@rpc("any_peer", "call_local", "reliable", 0)
func hurt_player(player_name: StringName, damage):
	for player in get_children():
		if !player is Player:
			continue
		if player.name != player_name:
			continue
		player.health -= damage
	#var player_idx = multiplayer.get_peers().find(int(player_name))
	#multiplayer.get_peers()[player_idx].health -= damage
		#print(player)
