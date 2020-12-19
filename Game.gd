extends Label


var card_resource = load("res://Card.tscn")


func set_hand(hand_cards):
	for c in hand_cards:
		var card = card_resource.instance()
		card.set_look(c)
		$HandContainer.add_child(card)
		
func set_top(top_card):
	var card = card_resource.instance()
	card.set_look(top_card)
	add_child(card)
