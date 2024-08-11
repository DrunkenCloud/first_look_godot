extends CharacterBody2D

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var world = get_parent()
const MAX_VELOCITY = 600.0
var HP = 100
var MAX_HP = 100
var collided = false
@onready var hp_bar = $HPBar

func _ready():
    hp_bar.max_value = MAX_HP
    hp_bar.value = HP

func _physics_process(delta):
    var curr = velocity
    velocity += Global.gravity_vector * gravity * delta
    if velocity.length() > MAX_VELOCITY:
        velocity = velocity.normalized() * MAX_VELOCITY
    
    var collision_info = move_and_slide()

    if collision_info and collided:
        reduce_hp(curr.length() / 20)
        collided = false
    elif (not collision_info):
        collided = true

func reduce_hp(damage):
    HP -= damage
    hp_bar.value = HP

    if HP <= 0:
        Global.score += 1
        if world:
            world.update_score_label()
        queue_free()

func increase_hp(percent):
    var hp_increase = MAX_HP * (percent / 100.0)
    HP += hp_increase
    if HP > 100:
        HP = 100
    hp_bar.value = HP
