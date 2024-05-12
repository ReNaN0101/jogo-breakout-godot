extends Area2D

# Referencias gerais

@onready  var timer : Timer = $TimerDaBola


# Movimento da bola
var velocidade_bola : float = 400.0
var pos_inicial : Vector2 = Vector2 (400, 460)
var direcao_inicial : Vector2 = Vector2(0, 0)
var nova_direcao : Vector2 = Vector2(0,0)

# Limites da bola

var x_minimo : float = 0
var x_maximo : float = 800
var y_minimo : float = 0
var y_maximo : float = 600

# Verificações
var primeiro_lancamento : bool = true
var caiu_da_tela : bool = false


func _ready():
	timer.one_shot = true
	resetar_bola()
	
	
func _process(delta):
	# Se for o primeiro lançamento esperar a ação do jogador para lançar
	if primeiro_lancamento == true:
		if Input.is_action_just_pressed("lancar_bola"):
			escolher_direcao_inicial()
	movimentar_bola(delta)
	verificar_posi_bola()
	

func resetar_bola() -> void:
	position = pos_inicial


func escolher_direcao_inicial() -> void:
	# Escolhe uma nova direção horizontal da bola
	var x_aleatorio = [-1,1].pick_random()
	
	direcao_inicial = Vector2(x_aleatorio, -1)
	nova_direcao = direcao_inicial


func movimentar_bola(delta : float) -> void :
	# Movimenta a bola com base a sua nova direção
	position += nova_direcao * velocidade_bola * delta
	
	
func verificar_posi_bola() -> void:
	# Se a bola estiver dentro da tela a rebate 
	if position.y <= y_maximo:
		
		if position.y <= y_minimo:
			nova_direcao.y *= -1
			
		if position.x <= x_minimo or position.x >= x_maximo:
			nova_direcao.x *= -1
		
	if position.y > y_maximo and not caiu_da_tela:
			timer.start()
			caiu_da_tela = true
			
			
				
func sair_da_tela() -> void:
	# Para o movimento da bola e reseta sua posição 
	nova_direcao = Vector2(0, 0)
	primeiro_lancamento = true
	resetar_bola() 


func _on_body_entered(body):
	# Se colidir com o Paddle ela rebate
	if body.is_in_group("paddle"):
		nova_direcao.y *= -1
	
	elif body.is_in_group("blocos"):
		body.receberDano()
		nova_direcao.y *= -1


func _on_timer_da_bola_timeout():
	sair_da_tela()
	caiu_da_tela = false
	
	
	
	
	
	
	
