extends StaticBody2D


@export var game_manager : Node2D

@export var vidaBloco : int

@export var vermelho : Color

@export var verde : Color

@export var amarelo : Color

func _ready():
	atualizarCor()


func atualizarCor() -> void:
	
	if vidaBloco == 3:
		modulate = vermelho
	elif vidaBloco == 2:
		modulate = amarelo
	elif vidaBloco == 1:
		modulate = verde
	else:
		modulate = Color.WHITE

func receberDano() -> void:
	vidaBloco -= 1
	
	if vidaBloco >= 1:
		atualizarCor()
	else:
		game_manager.atualizar_contagem_dos_blocos()
		queue_free()



