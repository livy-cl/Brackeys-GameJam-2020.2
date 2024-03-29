extends RigidBody2D

var explosion = preload("res://assets/src/prefabs/Bullets/AnimationBulletEnemieAR.tscn")
var PlayerHealth
var Damage
var BulletLifeTime
var DestoryTimer

func _ready() -> void:
	DestoryTimer = get_tree().create_timer(BulletLifeTime)
	yield(DestoryTimer, "timeout")
	queue_free()


func _on_BulletEnemieRPG_body_entered(body: Node) -> void:
	if body.is_in_group("Player"):
		var ExplosionInstance = explosion.instance()
		ExplosionInstance.position = get_global_position()
		get_tree().get_root().add_child(ExplosionInstance)
		
		get_tree().root.get_node("LevelTemplate").get_node("Player").Health = get_tree().root.get_node("LevelTemplate").get_node("Player").Health-Damage
		
		queue_free()
	elif not body.is_in_group("Enemie"):
		var ExplosionInstance = explosion.instance()
		ExplosionInstance.position = get_global_position()
		get_tree().get_root().add_child(ExplosionInstance)
		
		queue_free()

