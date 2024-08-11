extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const MAX_VELOCITY = 1000.0
var collided = false

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var player = get_node("AnimatedSprite2D")
@onready var camera = get_node("Camera2D")

func _ready():
    player.play("idle")

func _physics_process(delta):
    update_gravity_direction()
    
    var curr = velocity

    velocity += Global.gravity_vector * gravity * delta

    if velocity.length() > MAX_VELOCITY:
        velocity = velocity.normalized() * MAX_VELOCITY

    var collision_info = move_and_slide()

    if collision_info and collided:
        if camera:
            camera.update_hp(curr.length() / 70)
            collided = false
    elif (not collision_info):
        collided = true

func update_gravity_direction():
    if Input.is_action_pressed("move_up"):
        Global.gravity_vector = Vector2(0, -1)
        player.rotation_degrees = 180
    elif Input.is_action_pressed("move_down"):
        Global.gravity_vector = Vector2(0, 1)
        player.rotation_degrees = 0
    elif Input.is_action_pressed("move_left"):
        Global.gravity_vector = Vector2(-1, 0)
        player.rotation_degrees = 90
    elif Input.is_action_pressed("move_right"):
        Global.gravity_vector = Vector2(1, 0)
        player.rotation_degrees = 270

    Global.gravity_vector = Global.gravity_vector.normalized()

    player.play("crouch")

func increase_hp(percent):
    camera.increase_hp(camera.MAX_HP * (percent / 100.0))
    
func _on_button_pressed():
    get_tree().quit()
