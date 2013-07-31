//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
// Alterado pela ultima vez em 17/05/13
//-----------------------------------------------------------

class BD_Anao_Engenheiro_Pawn extends BD_AnaoRangedPawn;


defaultproperties
{
	
	//defesa basica
	def = 20
	//atributos basicos
	str = 10
	agi = 10
	cons = 10
	wis =10
	//vida inicial
	maxhealth = 200+(cons*0.7+agi*0.3+str*0.1)
	health = 150

	time = 0.0
	//bstun = false

	
}