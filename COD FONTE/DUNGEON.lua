-- title:  Dungeon Scape
-- author: LUAN GOMES
-- desc:   RPG 2D
-- script: LUA - TIC 80
----------------------------------------------------------------------

Constantes = {
--largura padrão
	LARGURA_DA_TELA = 240,
	ALTURA_DA_TELA = 138,
	VELOCIDADE_PERSONAGEM = 0.1,
	SPRITE_CHAVE = 364,
	SPRITE_PORTA = 366,
	SPRITE_INIMIGO = 292,
	ID_SFX_CHAVE = 00,
	ID_SFX_PORTA = 01,
	INIMIGO = "INIMIGO",
	jogador = "jogador",

	Direcao = {
		BAIXO = 1,
		CIMA = 2,
		DIREITA = 3,
		ESQUERDA = 4
	},

	tela = {
		INICIO = "INICIO",
		JOGO = "JOGO"
	}
}

objetos = {}


---------------------------------- FUNÇÕES -------------------------------
function TemColisao( ponto )
	local blocoX = ponto.x /8
	local blocoY = ponto.y /8
	local blocoID = mget(blocoX, blocoY)
		
		if blocoID >= 128 then
			return true
		else
			return false
		end
end

----------------------------------------
function Movimento(personagem, delta)

	local NovaPosicao = {
  	x = personagem.x + delta.deltaX,
  	y = personagem.y + delta.deltaY
 	}

 	if VerificaColisaoObjetos(personagem, NovaPosicao) then
  		return
 	end

	local superiorEsquerdo = {
		x = personagem.x - 8 + delta.deltaX,
		y = personagem.y - 8 + delta.deltaY
	}
	local superiorDireito = {
		x = personagem.x + 7 + delta.deltaX,
		y = personagem.y - 8 + delta.deltaY
	}
	local inferiorDireito = {
		x = personagem.x + 7 + delta.deltaX,
		y = personagem.y + 7 + delta.deltaY
	}
	local inferiorEsquerdo = {
		x = personagem.x - 8 + delta.deltaX,
		y = personagem.y + 7 + delta.deltaY
	}

	if not (TemColisao(inferiorDireito) or
	  	TemColisao(inferiorEsquerdo) or
	  	TemColisao(superiorDireito) or
	  	TemColisao(superiorEsquerdo)) then
		 	personagem.FrameAnimacao = personagem.FrameAnimacao + Constantes.VELOCIDADE_PERSONAGEM
	 	if personagem.FrameAnimacao >= 3 then
	 		personagem.FrameAnimacao = 1
	 	end

	 	personagem.y = personagem.y + delta.deltaY
	  	personagem.x = personagem.x + delta.deltaX
	end
end
----------------------------------------

function AtualizaJogo()
	local AnimacaoJogador = {
		{256, 258},
		{260, 262},
		{264, 266},
		{268, 270}
	}
    local Direcao = {
		{deltaX = 0, deltaY = -1},
		{deltaX = 0, deltaY = 1},
		{deltaX = -1, deltaY = 0},
		{deltaX = 1, deltaY = 0}
	}
	for tecla =0,3 do
		if btn(tecla) then
			jogador.sprite = AnimacaoJogador[tecla+1][math.floor(jogador.FrameAnimacao)]
			Movimento(jogador, Direcao[tecla+1])
		end
	end
	VerificaColisaoObjetos(jogador,{x=jogador.x , y=jogador.y})

	for indice, objeto in pairs(objetos) do
		if objeto.tipo == Constantes.INIMIGO then
			AtualizaInimigo(objeto)
		end
	end		
end
----------------------------------------

function AtualizaInimigo(inimigo)
	local delta = {
		deltaY = 0,
		deltaX = 0
	}

	if jogador.y > inimigo.y then
		delta.deltaY = 0.4
		inimigo.Direcao = Constantes.Direcao.CIMA
	elseif jogador.y < inimigo.y then
		delta.deltaY = -0.4
		inimigo.Direcao = Constantes.Direcao.BAIXO
	end
	Movimento(inimigo, delta)
	
	----------------------
	delta = {
		deltaY = 0,
		deltaX = 0
	}
	if jogador.x > inimigo.x then
		delta.deltaX = 0.4
		inimigo.Direcao = Constantes.Direcao.ESQUERDA
	elseif jogador.x < inimigo.x then
		delta.deltaX = -0.4
		inimigo.Direcao = Constantes.Direcao.DIREITA
	end
	Movimento(inimigo, delta)


	local AnimacaoInimigo = {
		{288, 290},
		{292, 294},
		{296, 298},
		{300, 302}
	}

	local Frames = AnimacaoInimigo[inimigo.Direcao]
	local Frame = math.floor(inimigo.FrameAnimacao)
	inimigo.sprite= Frames[Frame]
end
----------------------------------------

function DesenhaMapa()
	map(
	0, -- posicao x no mapa
	0, -- posicao y no mapa
	Constantes.LARGURA_DA_TELA, -- quantos blocos desenhar x
	Constantes.ALTURA_DA_TELA, -- quantos blocos desenhar y
	0, -- em qual ponto colocar o x
	0) -- em qual ponto colocar o y
end
----------------------------------------

function DesenhaJogador()
  	spr(jogador.sprite,
    jogador.x - 8, -- O "-8" é para poder alinhar o personagem no mapa
    jogador.y - 8,
    jogador.CorFundo, -- cor de fundo
    1, -- escala(tamanho padrão = 1)
    0, -- espelhar
    0, -- rotacionar
    2, -- quantos blocos para direita (quantidade de blocos para o sprite)
    2) -- quantos blocos para baixo
end
----------------------------------------

function DesenhaObjetos()
	for indice,objeto in pairs(objetos) do
		spr(objeto.sprite,
		objeto.x -8,
		objeto.y -8,
		objeto.CorFundo,
		1,
		0,
		0,
		2,
		2)
	end
end
----------------------------------------

function DesenhaJogo()
	cls() -- Função limpa tela
	DesenhaMapa()
	DesenhaJogador()
	DesenhaObjetos()
end
----------------------------------------

function CriaChave(coluna, linha)
	local chave = {
	sprite = Constantes.SPRITE_CHAVE,
	x = coluna * 8,
	y = linha * 8,
	CorFundo = 6,
	colisoes = {
		INIMIGO = PassaDireto,
		jogador = ColisaoJogadorChave
		}
	}
	return chave
end
----------------------------------------

function CriaPorta(coluna, linha)
	local Porta = {
	sprite = Constantes.SPRITE_PORTA,
	x = coluna *8,
	y = linha *8,
	CorFundo = 6,
	colisoes = {
		INIMIGO = ColisaoInimigoPorta,
		jogador = ColisaoJogadorPorta
		}
	}
	return Porta
end
----------------------------------------

function CriaInimigo(coluna, linha)
	local inimigo = {
	tipo = Constantes.INIMIGO,

	sprite = Constantes.SPRITE_INIMIGO,
	x = coluna *8 +8,
	y = linha *8 +8,
	CorFundo = 14,
	FrameAnimacao = 0.2,
	colisoes = {
		INIMIGO = PassaDireto,
		jogador = ColisaoJogadorInimigo
		}
	}
	return inimigo
end
----------------------------------------
function inicializa()
	Tela = {
 		INICIO = {
  			atualiza = AtualizaIntro,
 			desenha = DesenhaIntro
 		},
 		JOGO = {
  			atualiza = AtualizaJogo,
  			desenha = DesenhaJogo
 		}
 	}	

	objetos = {}

	local chave = CriaChave(3, 3)
	table.insert(objetos, chave)

	local Porta = CriaPorta(16, 8)
	table.insert(objetos, Porta)

	local inimigo = CriaInimigo(25, 13)
	table.insert(objetos, inimigo)

	jogador = {
	-- valores iniciais
	tipo = Constantes.jogador,
    sprite = 260, --local do sprite do personagem
    x = 70, -- local x onde sera colocado
    y = 100, -- local y onde sera colocado
    CorFundo = 6,
    FrameAnimacao = 1,
    chave = 0
	}

	tela = Tela.INICIO

end
----------------------------------------

function ColisaoJogadorChave(indice)
	-- apos colidir com a chave, ela sera removida da tabela e logo tambem sera removida da tela pelo TIC
	jogador.chave = jogador.chave +1
	table.remove(objetos, indice)
	sfx(ID_SFX_CHAVE,
		36, --nota que ira tocar
		32, --quantos quadros vai tocar
		0, --canal que ira tocar
		8,
		1) --velocidade

	return false
end
----------------------------------------

function ColisaoInimigoPorta(indice)
	return true
end

----------------------------------------

function PassaDireto(indice)
	return false
end

----------------------------------------

function ColisaoJogadorPorta(indice)
	if jogador.chave > 0 then
		jogador.chave = jogador.chave -1
		table.remove(objetos,indice)
		sfx(ID_SFX_PORTA,
			60,
			30,
			0,
			8,
			1)

		return false
	end	
	return true
end
----------------------------------------

function ColisaoJogadorInimigo(indice)
	inicializa()
	return true
end
--------------------------------------------------------------------------------

function TemColisaoObjetos(objetoA, objetoB)
	local esquerdaDeB = objetoB.x - 8
	local direitaDeB = objetoB.x + 7
	local baixoDeB = objetoB.y + 7
	local cimaDeB = objetoB.y - 8

	local direitaDeA = objetoA.x + 7
	local esquerdaDeA = objetoA.x - 8
	local baixoDeA = objetoA.y + 7
	local cimaDeA = objetoA.y - 8

	if esquerdaDeB > direitaDeA or
  		direitaDeB < esquerdaDeA or 
  		baixoDeA < cimaDeB or
  		cimaDeA > baixoDeB then
  			return false
	end
	return true
end
----------------------------------------

function VerificaColisaoObjetos(personagem, NovaPosicao)
	for indice, objeto in pairs(objetos) do
		
		if TemColisaoObjetos(NovaPosicao, objeto)then
				local FuncaoColisao = objeto.colisoes[personagem.tipo]
				return FuncaoColisao(indice)
		end
	end
	return false
end
---------------------------------------

function DesenhaIntro(tela)
	cls()
	spr(368, --spr titulo
		78,
		15,
		0,
		1,
		0,
		0,
		12,
		4
		)

	print("Pressione BAIXO", 75, 100, 6)
	print("Luan G.", 98, 120, 15)
	return tela
end	

---------------------------------------

function AtualizaIntro()
	if btn(1) then
		tela = Tela.JOGO
	end	
end

---------------------------------------




---------------------------------- EXECUÇÃO -------------------------------
function TIC()
	tela.atualiza()
 	tela.desenha()
end

inicializa()