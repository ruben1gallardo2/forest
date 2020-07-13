extends Area2D



func _on_Coin_body_entered(body):
	if body.is_in_group("Player"):
		get_node("../../../Player").coin_picked = true
		call_deferred("queue_free")
	


func _on_Coin_body_exited(body):
	if body.is_in_group("Player"):
		get_node("../../../Player").coin_picked = false
	
