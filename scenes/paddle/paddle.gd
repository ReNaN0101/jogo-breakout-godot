extends StaticBody2D

# Movimento do Paddle/Jogador
var velocidade_paddle : float = 700.0
var x_minimo : float = 40
var x_maximo : float = 760


func _process(delta):
	movimentar_paddle(delta)
	limitar_pos_paddle()


func movimentar_paddle(delta : float) -> void :
	# Movimenta o Paddle/Jogador para direita/esquerda
	if Input.is_action_pressed("mv_esquerda"):
		position.x -= velocidade_paddle * delta
	elif Input.is_action_pressed("mv_direita"):
		position.x += velocidade_paddle * delta


func limitar_pos_paddle() -> void :
	# Impede que o Paddle/Jogador saia da tela
	position.x = clamp(position.x, x_minimo,x_maximo)
