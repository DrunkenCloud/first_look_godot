extends Camera2D

var HP = 100
var MAX_HP = 100
@onready var hp_bar = $ProgressBar

func _ready():
    hp_bar.max_value = MAX_HP
    hp_bar.value = HP

func increase_hp(hp_increase):
    HP += hp_increase
    if (HP > 100) :
        HP = 100
    hp_bar.value = HP

func update_hp(damage):
    HP -= damage
    hp_bar.value = HP

    if HP <= 0:
        get_tree().quit()
