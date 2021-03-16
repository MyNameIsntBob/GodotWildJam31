extends Sprite

func _on_Area2D_body_entered(body):
	if Global.keys:
		Global.use_key()
		self.queue_free()
