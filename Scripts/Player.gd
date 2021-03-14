extends KinematicBody2D

var velocity := Vector2.ZERO
var jump_force := 500
var acceleration := 1000
var max_speed := 300
var friction := 0.9

var top := []
var left := []
var right := []
var bottom := []

#var jumping := false
#var jumpTime := 0.25
#var jumpTimeCounter := 0.0
#
#var coyoteJumpTime := 0.1
#var coyoteJumpTimer := 0.0
#
#var cancelJump := 0.1
#var cancelJumpCounter := 0.0
#var jumpAgain := false

var printCounter := 0.0
var printTime := 2.0

func _ready():
	velocity.y = jump_force
	
func _process(delta):
	if Input.is_action_just_pressed('restart'):
		Global.load_level()
	
	var input_vector = Vector2.ZERO
	
	if bottom or top:
		input_vector.x = Input.get_action_strength('move_right') - Input.get_action_strength('move_left')
		
		if input_vector != Vector2.ZERO:
			velocity += input_vector * acceleration * delta
			
			if velocity.x > max_speed:
				velocity.x = max_speed
			if velocity.x < -max_speed:
				velocity.x = -max_speed
		else:
			velocity.x *= friction
		
	if left or right:
		input_vector.y = Input.get_action_strength('move_down') - Input.get_action_strength('move_up')
		
		if input_vector != Vector2.ZERO:
			velocity += input_vector * acceleration * delta
		
			if velocity.y > max_speed:
				velocity.y = max_speed
			if velocity.y < -max_speed:
				velocity.y = -max_speed
		else:
			velocity.y *= friction

	if Input.is_action_just_pressed('jump'):
		if bottom:
			velocity.x = 0
			velocity.y = -jump_force
		if top:
			velocity.x = 0
			velocity.y = jump_force
		if left:
			velocity.x = jump_force
			velocity.y = 0
		if right: 
			velocity.x = -jump_force
			velocity.y = 0
	
	velocity = self.move_and_slide(velocity, Vector2(0, -1))
	
	


func _on_Right_body_entered(body):
	print(body)
	right.append(body)

func _on_Right_body_exited(body):
	right.erase(body)

func _on_Left_body_entered(body):
	print(body)
	left.append(body)

func _on_Left_body_exited(body):
	left.erase(body)

func _on_Top_body_entered(body):
	top.append(body)

func _on_Top_body_exited(body):
	top.erase(body)

func _on_Bottom_body_entered(body):
	bottom.append(body)

func _on_Bottom_body_exited(body):
	bottom.erase(body)
