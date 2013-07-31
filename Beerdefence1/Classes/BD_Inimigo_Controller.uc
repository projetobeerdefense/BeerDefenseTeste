//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 12:25
// Classe "BD_AnaoController" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Inimigo_Controller extends BotController;

var bool bbarrio;
var actor spawnplace;
var float time;      
var bool earlyborn;
//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Basica do Inimigo
//-----------------------------------------------------------
//var float distance;

function GoAway()
{
self.stop();
currentgoal = pawn;

bbarrio =true;
//bgodmode=true;
BD_Inimigo_Lagarto_Thief_Pawn(pawn).atacking = false;
//go();
`log("the place is " @spawnplace);
}

simulated function PostBeginPlay()
{
	  super.PostBeginPlay();
	  time = WorldInfo.TimeSeconds;
}

function Tick(float DeltaTime)
{
      WhatToDoNext();
		if(BD_InimigoPawn(pawn).bstun) bStop = true;

	  if(self.currentgoal.isa('BD_CarrocaPawn')){
	  BD_InimigoPawn(pawn).distance = vsize(self.currentgoal.location - pawn.location);
	 
	  }
	  else BD_InimigoPawn(pawn).distance = 2000;
	  `log(self@"distante "@BD_InimigoPawn(pawn).distance);

	  if(earlyborn){
			if(WorldInfo.TimeSeconds - time >= 1){
				bstop=false;
				earlyborn = true;
			}
	  }
}

DefaultProperties
{

}