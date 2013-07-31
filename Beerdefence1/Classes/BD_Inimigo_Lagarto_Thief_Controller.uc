//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 12:25
// Classe "BD_AnaoController" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Inimigo_Lagarto_Thief_Controller extends BD_Inimigo_Controller;

//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Basica do Inimigo
//-----------------------------------------------------------
var float dist;          //Variavel para verificação da distancia entre Anão e Inimigo
//var float time;          //Variavel para caluclo de tempo, para fixar ciclo de tempo
var bool bmorreu;        //Variavel para saber se o alvo está vivo
var bool bsoulider;

/* ### Modificação futura ############################################

###################################################################### */
function findcar(){
	local BD_PlayerController playercontroler;
foreach worldInfo.Localplayercontrollers(class'BD_PlayerController', playercontroler)
		{
		self.CurrentGoal = playercontroler.Car_FollowPawn;     //Troca o alvo para o novo
					
		self.gotostate('FollowTarget', 'Begin');

		}
}

simulated function PostBeginPlay()
{
	  super.PostBeginPlay();
	  time = WorldInfo.TimeSeconds;

}


event WhatToDoNext()
{
	if(!bbarrio){
	if(bsoulider){
	findcar();
//	self.spawnplace = BD_Inimigo_Lagarto_Thief_Pawn(pawn).findbackspot();
	}}
		
			
		
	
self.gotostate('FollowTarget', 'Begin');
}

DefaultProperties
{
	dist = 10000000000000000000000000000000000000000000
	time =0.0
	bsoulider = false
	earlyborn = true

}