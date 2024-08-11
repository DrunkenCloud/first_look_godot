extends Node2D

@export var eagle_scene: PackedScene
@export var cherry_scene: PackedScene
@onready var score_label = $ScoreLabel

func _ready():
    var eagle_timer = Timer.new()
    eagle_timer.wait_time = 5.0
    eagle_timer.autostart = true
    eagle_timer.one_shot = false
    eagle_timer.connect("timeout", Callable(self, "_on_eagle_timer_timeout"))
    add_child(eagle_timer)
    update_score_label()
    
    var cherry_timer = Timer.new()
    cherry_timer.wait_time = 10.0
    cherry_timer.autostart = true
    cherry_timer.one_shot = false
    cherry_timer.connect("timeout", Callable(self, "_on_cherry_timer_timeout"))
    add_child(cherry_timer)

func _on_eagle_timer_timeout():
    var eagle_instance = eagle_scene.instantiate()
    add_child(eagle_instance)
    
    eagle_instance.position = Vector2(randf_range(0, get_viewport_rect().size.x), 50)
    
func _on_cherry_timer_timeout():
    var cherry_instance = cherry_scene.instantiate()
    add_child(cherry_instance)
    
    cherry_instance.position = Vector2(randf_range(0, get_viewport_rect().size.x), randf_range(0, get_viewport_rect().size.y))

func update_score_label():
    score_label.text = "Score: %d" % Global.score
