extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func _on_player_entered(body):
	if(!body.disableControls):
		body.velocity.x += 600;
		body.disableControls = true;
	else:
		body.velocity.x = body.SPEED;
		body.disableControls = false;
	#get_tree().quit() # Replace with function body.
