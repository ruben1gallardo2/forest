extends Area2D

var score = 0 


func _ready():
	$AnimatedSprite.play()
	$Tween.interpolate_property(
	$AnimatedSprite,
	'scale',
	$AnimatedSprite.scale,
	$AnimatedSprite.scale * 2,
	1,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT		
	)
	$Tween.interpolate_property(
	$AnimatedSprite,
	'modulate',
	Color(1,1,1,1),
	Color(1,1,1,0),
	1,
	Tween.TRANS_QUAD,
	Tween.EASE_IN_OUT
	)


func _on_Coins_body_entered(body):
	if body.is_in_group("Player"):
		$Tween.start()
		yield($Tween, "tween_completed")
		call_deferred("queue_free")
		score += 1
		print(score)
