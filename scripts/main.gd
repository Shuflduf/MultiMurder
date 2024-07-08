extends Node2D


@onready var player_spawner: MultiplayerSpawner = $MultiplayerSpawner
@onready var bullet_parent: Node2D = $BulletParent

var multiplayer_peer = ENetMultiplayerPeer.new()

const ADDRESS = "localhost"

var connected_ids = []

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


@rpc("any_peer", "call_local", "reliable", 1)
func add_bullet(bullet: PackedScene, bullet_transform):
	var new_bullet = bullet.instantiate()
	new_bullet.global_transform = bullet_transform
	bullet_parent.add_child(new_bullet)
