extends Area2D

@export var hp_increase_percent = 20

func _ready():
    connect("body_entered", Callable(self, "_on_cherry_body_entered"))

func _on_cherry_body_entered(body):
    if body.has_method("increase_hp"):
        body.increase_hp(hp_increase_percent)
        queue_free()
