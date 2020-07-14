extends KinematicBody2D


var coin_picked = false
var score = 0 
var run_speed = 300
var walk_speed = 150
var jump_speed = -1000
var gravity = 4000
var velocity = Vector2()
var ladder_on = false
var state
var current_animation
var new_animation
var chest = false
var rune = false

enum {IDLE, WALK, RUN, JUMP, CLIMB, ATTACK1, ATTACK2, ATTACK3}


func _physics_process(delta):
	
	if current_animation != new_animation:
		current_animation = new_animation
		$AnimatedSprite.play(current_animation)
		
	velocity.y += gravity * delta
	get_input()
	transition_to(IDLE)
	
	if is_on_floor() and Input.is_action_just_pressed("ui_select"):
		velocity.y = jump_speed	
		transition_to(JUMP)
	if state == IDLE and velocity.x != 0:
		transition_to(RUN)
	if state == RUN and velocity.x == 0:
		transition_to(IDLE)
	if state in [IDLE, RUN] and !is_on_floor() and ladder_on == false:
		transition_to(JUMP)
	if state == JUMP and is_on_floor():
		transition_to(IDLE)
	if state in [IDLE, RUN, JUMP]  and Input.is_action_pressed("attack1"):
		transition_to(ATTACK1)
	if state in [IDLE,RUN,JUMP ] and ladder_on == true:
		transition_to(CLIMB)
	if state in [IDLE, RUN, JUMP]  and Input.is_action_pressed("attack2"):
		transition_to(ATTACK2)
	if state in [IDLE, RUN, JUMP]  and Input.is_action_pressed("attack3"):
		transition_to(ATTACK3)
	if state in [IDLE,RUN,JUMP] and Input.is_action_pressed("walk_right") and Input.is_action_pressed("walk_left"):
		transition_to(WALK)
		
	
	velocity = move_and_slide(velocity, Vector2(0, -1))
	RunePicked()
	CoinPicked()
func transition_to(new_state):
	state = new_state
	match state:
		IDLE:
			new_animation = "idle"
		WALK:
			new_animation = "walk"
		RUN:
			new_animation = "run"
		JUMP:
			new_animation = "jump"
		ATTACK1:
			new_animation = "attack1"
		CLIMB: 
			new_animation = "climb"
		ATTACK2:
			new_animation = "attack2"
		ATTACK3:
			new_animation = "attack3"	
		
		
func get_input():
	velocity.x = 0
	var climb_down = Input.is_action_pressed("ui_down")
	var climb = Input.is_action_pressed("ui_up")
	var right = Input.is_action_pressed('ui_right')
	var left = Input.is_action_pressed('ui_left')
	var jump = Input.is_action_just_pressed('ui_select')
	var attack1 = Input.is_action_pressed('attack1')
	var attack2 = Input.is_action_pressed("attack2")
	var attack3 = Input.is_action_pressed("attack3")
	var walk_right = Input.is_action_pressed("walk_right")
	var walk_left = Input.is_action_pressed("walk_left")
	# movimientos
	if is_on_floor() and jump:
		velocity.y = jump_speed			
	if right:
		velocity.x += run_speed	
		$AnimatedSprite.flip_h = false				
	elif left:
		velocity.x -= run_speed
		$AnimatedSprite.flip_h = true			

	if $AnimatedSprite.flip_h == true:
		#se coloca la position de la collision shape acomodada al girar a la izquierda
		$CollisionShape2D.position.x = 9
	else:
		$CollisionShape2D.position.x = -1	
		
	if $AnimatedSprite.flip_h == true:
		$AnimatedSprite/AttackArea/CollisionShape2D.position.x = -10
	else:
		$AnimatedSprite/AttackArea/CollisionShape2D.position.x = 9.575


	#colocamos al player a subir escaleras					
	if ladder_on == true:		
		gravity = 0
		if climb:
			velocity.y = -run_speed
			#$AnimatedSprite.animation ="climb"
		elif climb_down:
			velocity.y = run_speed
		else:
			velocity.y = 0
	else:
		gravity = 4000

	#script para que el player camine
	if is_on_floor() and walk_right:
		velocity.x += walk_speed
		$AnimatedSprite.animation = "walk" 
		$AnimatedSprite.flip_h = false
	elif is_on_floor() and walk_left:
		$AnimatedSprite.animation = "walk" 
		$AnimatedSprite.flip_h = true
		velocity.x -= walk_speed
		
func CoinPicked():
	if coin_picked == true:
		score += 1
		print(score)
func RunePicked():
	if chest == true:
		print(chest)
		if rune == true:
			print(rune)
			
		
func _on_AnimatedSprite_frame_changed():
	#activar la mascara de colision para los diferentes ataques activandola en frames especificos
	if ATTACK1 or ATTACK2 or ATTACK3:
		if $AnimatedSprite.animation == "attack1" and $AnimatedSprite.frame == 3 or $AnimatedSprite.animation == "attack2" and $AnimatedSprite.frame == 4 or $AnimatedSprite.animation == "attack3" and $AnimatedSprite.frame == 4: 
			$AnimatedSprite/AttackArea/CollisionShape2D.disabled = false
		else:
			$AnimatedSprite/AttackArea/CollisionShape2D.disabled = true




