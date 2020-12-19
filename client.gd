extends Node

signal connectionClosed
signal connectionEstablished
signal dataReceived(data)

# The URL we will connect to.
export var websocket_url = "ws://localhost:10001"

var _client = null

func _ready():
	_client = WebSocketClient.new()
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("data_received", self, "_on_data")


func connect_to_server():
	print('trying to connect to server')
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect. err: " + err)
	return err


func _closed(was_clean = false):
	emit_signal("connectionClosed")


func _connected(proto = ""):
	emit_signal("connectionEstablished")
	print("Connected with protocol: ", proto)


func _on_data():
	emit_signal("dataReceived", _client.get_peer(1).get_packet().get_string_from_utf8())


func _process(_delta):
	_client.poll()


func send_data(data):
	_client.get_peer(1).put_packet(data.to_utf8())
	
	
func close_connection():
	_client.get_peer(1).put_packet("quit".to_utf8())
