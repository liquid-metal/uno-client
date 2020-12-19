extends Node


var connected = false
var lobby_resource = load("res://Lobby.tscn")
var game_reesource = load("res://Game.tscn")

var lobby = null
var game = null


func _ready():
	$Client.connect_to_server()


func clientConnectionEstablished():
	connected = true
	$WelcomeScreen.display_available()


func clientConnectionClosed():
	connected = false
	$WelcomeScreen.display_unavailable()


func clientDataReceived(data):
	print("Got data from server: ", data)
	if data == '<lobby>: waiting':
		lobby = lobby_resource.instance()
		add_child(lobby)
		$WelcomeScreen.hide()
	elif data.find('<game>: ') == 0:
		# <game>: [players];[hand cards];top card
		var data_points = data.substr(8, data.length() - 8).split(';')
		var players = data_points[0].substr(1, data_points[0].length()).split(', ')
		var hand_cards = data_points[1].substr(2, data_points[1].length()-2).split('\', \'')
		var top_card = data_points[2]
		print('list of players: ' + str(players))
		print('list of hand cards: ' + str(hand_cards))
		print('top card: ' + top_card)
		game = game_reesource.instance()
		add_child(game)
		lobby.queue_free()
		
		game.set_top(top_card)
		game.set_hand(hand_cards)


func _on_Main_tree_exiting():
	# window close event
	$Client.close_connection()


func nameEntered(nickname):
	if connected:
		$Client.send_data("<nickname>: " + nickname)
	else:
		openPopup()


func openPopup():
	$Darkener.show()
	$ConnectFailurePopup.popup()

func closePopup():
	$Darkener.hide()
	$ConnectFailurePopup.hide()
	
