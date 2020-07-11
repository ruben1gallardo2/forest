extends Area2D


func _on_Rune_body_entered(body):
	if body.is_in_group("Player"):
		
		call_deferred("queue_free")
		
