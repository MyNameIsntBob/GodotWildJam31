extends Control

var keys = []
var size = Vector2(5, 5)

export (NodePath) var place_key_at

const key_path = preload('res://Prefabs/UI/Key.tscn')

func _process(delta):
	if len(keys) < Global.keys:
		var newKey = key_path.instance()
		get_node(place_key_at).add_child(newKey)
		newKey.rect_scale = size
		keys.append(newKey)
		
	elif len(keys) > Global.keys:
		var key = keys.pop_back()
		key.queue_free()
