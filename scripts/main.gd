extends Node2D


@onready var player_spawner: MultiplayerSpawner = $MultiplayerSpawner

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
