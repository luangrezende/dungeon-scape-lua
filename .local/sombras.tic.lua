-- title:  Dungeon Scape
-- author: LUAN GOMES
-- desc:   RPG 2D
-- script: LUA - TIC 80
-- observações: 
-- 1 - os pontos de colisão serão colocados em sprites abaixo de #128.

-- "IT'S A LONG WAY TO THE TOP" - AC DC
----------------------------------------------------------------------


jogador = {
	-- valores iniciais
    sprite = 260, --local do sprite do personagem
    x = 100, -- local x onde sera colocado
    y = 68, -- local y onde sera colocado
    CorFundo = 6,
    FrameAnimacao = 1
}

Constantes = {
--largura padrão
	LARGURA_DA_TELA = 240,
	ALTURA_DA_TELA = 138,
	VelocidadePersonagem = 0.1 
}

objetos = {}


---------------------------------- FUNÇÕES -------------------------------
function TemColisao( ponto )
	blocoX = ponto.x /8
	blocoY = ponto.y /8
	blocoID = mget(blocoX, blocoY)
		if blocoID >= 128 then
			return true
		else
			return false
		end
end


function Movimento(DeslocamentoX, DeslocamentoY)
	SuperiorEsquerdo = {
	  	x = jogador.x - 8 + DeslocamentoX,
	  	y = jogador.y - 8 + DeslocamentoY
	}
	SuperiorDireito = {
	  	x = jogador.x + 7 + DeslocamentoX,
	  	y = jogador.y - 8 + DeslocamentoY
	}
	InferiorDireito = {
	  	x = jogador.x + 7 + DeslocamentoX,
	  	y = jogador.y + 7 + DeslocamentoY
	}
	InferiorEsquerdo = {
	  	x = jogador.x - 8 + DeslocamentoX,
	  	y = jogador.y + 7 + DeslocamentoY
	}

	if TemColisao(InferiorDireito) or
	  	TemColisao(InferiorEsquerdo) or
	  	TemColisao(SuperiorDireito) or
	  	TemColisao(SuperiorEsquerdo) then
	-- colisao
	else
	 	jogador.FrameAnimacao = jogador.FrameAnimacao + Constantes.VelocidadePersonagem
	 	if jogador.FrameAnimacao >= 3 then
	 		jogador.FrameAnimacao = 1
	 	end

	 	jogador.y = jogador.y + DeslocamentoY
	  	jogador.x = jogador.x + DeslocamentoX
	end
end


function Atualiza()
	AnimacaoJogador = {
		{256, 258},
		{260, 262},
		{264, 266},
		{268, 270}
	}
	Direcao = {
		{0, -1},
		{0, 1},
		{-1, 0},
		{1, 0}
	}
	for tecla =0,3 do
		if btn(tecla) then
			jogador.sprite = AnimacaoJogador[tecla+1][math.floor(jogador.FrameAnimacao)]
		end
	end
		 -- cima
		if btn(0) then
			Movimento(Direcao[1][1], Direcao[1][2])
		end
		 
		 -- baixo
		if btn(1) then
		  	Movimento(Direcao[2][1], Direcao[2][2])	
		end
		 
		 -- esquerda
		if btn(2) then
		  	Movimento(Direcao[3][1], Direcao[3][2])
		end
		 
		 -- direita
		if btn(3) then
		  	Movimento(Direcao[4][1], Direcao[4][2])
		end
end


function DesenhaMapa()
	map(
	0, -- posicao x no mapa
	0, -- posicao y no mapa
	Constantes.LARGURA_DA_TELA, -- quantos blocos desenhar x
	Constantes.ALTURA_DA_TELA, -- quantos blocos desenhar y
	0, -- em qual ponto colocar o x
	0) -- em qual ponto colocar o y
end


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


function DesenhaObjetos()
	for indice,objeto in pairs(objetos) do
		spr(objeto.sprite,
		objeto.x,
		objeto.y,
		objeto.CorFundo,
		1,
		0,
		0,
		2,
		2)
	end
end


function Desenha()
	cls() -- Função limpa tela
	DesenhaMapa()
	DesenhaJogador()
	DesenhaObjetos()
end


function CriaChave(coluna, linha)
	local chave = {
	sprite = 364,
	x = coluna * 8,
	y = linha * 8,
	CorFundo = 6
	}
	return chave
end


function inicializa()
	local chave = CriaChave(5,4)
	table.insert(objetos, chave)
end


function ColisaoJogadorChave(indice)
	-- apos colidir com a chave, ela sera removida da tabela e logo tambem sera removida da tela pelo TIC
	table.remove(objetos, indice)
end


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


function VerificaColisaoObjetos()
	for indice, objeto in pairs(objetos) do
		if TemColisaoObjetos(jogador, objeto)then
			ColisaoJogadorChave(indice)
		end
	end
end


---------------------------------- EXECUÇÃO -------------------------------
function TIC()
	Atualiza()
	VerificaColisaoObjetos()
 	Desenha()
end

inicializa()