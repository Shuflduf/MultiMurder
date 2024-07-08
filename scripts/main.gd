extends Node2D


@onready var player_spawner: MultiplayerSpawner = $MultiplayerSpawner

var multiplayer_peer = ENetMultiplayerPeer.new()

var port = 9999
const ADDRESS = "localhost"

var connected_ids = []

func _ready() -> void:
	match Global.current_type:
		Global.gameType.Host:
			multiplayer_peer.create_server(port)
			print("Host")
			add_player(1)
			
			multiplayer_peer.peer_connected.connect(
				func(new_peer_id):
					await get_tree().create_timer(1).timeout
					rpc("add_newly_connected_player", new_peer_id)
					rpc_id(new_peer_id, "add_previously_connected_player", connected_ids)
					add_player(new_peer_id)
			)
		Global.gameType.Join:
			multiplayer_peer.create_client(ADDRESS, port)
			print("Client")
			
			
	multiplayer.multiplayer_peer = multiplayer_peer

func add_player(peer_id):
	connected_ids.append(peer_id)
	var player = preload("res://scenes/player.tscn").instantiate()
	add_child(player)

@rpc
func add_newly_connected_player(new_peer_id):
	add_player(new_peer_id)

@rpc
func add_previously_connected_player(peer_ids):
	for id in peer_ids:
		add_player(id)
