extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var gravity_switch = 1
var gravity_switch_start_hop = 2
var zoom = false;
var disableControls = false;


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity") * gravity_switch
@onready var animated_sprite = $AnimatedSprite2D


#ZOOM START

func _physics_process(delta):
	#GRAVITY SWITCH
	if Input.is_action_just_pressed("ui_gravity_switch"): 
		gravity_switch *= -1;
		velocity.y += 2 * gravity_switch
		if(animated_sprite.flip_v): animated_sprite.flip_v = false;
		else: animated_sprite.flip_v = true;
	# Add the gravity.
	#physics between cieling and floor
	if (not is_on_floor() || animated_sprite.flip_v) && (not is_on_ceiling() || animated_sprite.flip_v == false):
		velocity.y += gravity * delta * gravity_switch
		animated_sprite.animation = "jump"
		#if(velocity.y < 0) do fall 
		#else play jump
	else:
		animated_sprite.animation = "run"

	# Handle Jump on cieling and floor
	if Input.is_action_just_pressed("ui_accept") && (is_on_floor() || is_on_ceiling()):
		velocity.y = JUMP_VELOCITY * gravity_switch

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction && !disableControls:
		velocity.x = direction * SPEED
		#flips direction of animation based on current direction
		if (velocity.x < 0):
			animated_sprite.flip_h = true
		elif (velocity.x > 0):
			animated_sprite.flip_h = false
	#TEST ELIF
	elif disableControls:
		pass
		#visible = not visible
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
