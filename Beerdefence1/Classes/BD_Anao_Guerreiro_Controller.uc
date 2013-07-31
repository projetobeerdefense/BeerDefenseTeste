//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 12:25
// Classe "BD_AnaoController" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Anao_Guerreiro_Controller extends BD_AnaoController;

//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Basica do Anao
//-----------------------------------------------------------

// Variavel que guarda o nome da anima��o que ser� usada para uma arma customizada
var name AnimName;

// Variavel que guarda o tempo da anima��o que ser� usada para uma arma customizada
var float AnimTime;

//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Basica do Anao
//-----------------------------------------------------------


//// Fun��o chamada quando o personagem atira
//function StartFire(optional byte FireModeNum)
//{
//	// Checa se a arma � a espada 
//	if(Pawn.Weapon.Class == class'MyWeap_Sword')
//		if(VSize(Pawn.Velocity) > 10)              // Checa se o personagem est� em movimento
//			// Toca uma anima��o da metade de cima do corpo do personagem. PlayCustomAnim(nome da anima��o, velocidade da anima��o, blend in, blend out, looping, soprepor a anima��o)
//			BD_AnaoMeelePawn(Pawn).TopHalfAnimSlot.PlayCustomAnim(AnimName, 1.0, 0.55, 0.25, false, true); 

//	// Se o personagem estiver parado
//	else if(VSize(Pawn.Velocity) < 10)
//	{
//		SetTimer(AnimTime, false, 'TurnOnInputs');  // Delay para chamar a fun��o que reativa os inputs
//		BD_AnaoMeelePawn(Pawn).FullBodyAnimSlot.PlayCustomAnim(AnimName, 1.0, 0.55, 0.25, false, true);     // Toca a anima��o do corpo inteiro
	
//	}

//	super.StartFire(FireModeNum);
//}




function Tick(float DeltaTime0)
{   
		   //variavel auxiliar que guarda o currentgoal (spot ou click)
         //Confere se An�o est� atordoado
		//BD_Anao_Guerreiro_Pawn(pawn).quemtaai();
			proxalvo = BD_Anao_Atirador_Pawn(pawn).next();	 
	`Log(self@"Current Goal incial:"@self.CurrentGoal);

if(ladistance(self.pawn, spot)>2000){
	vaikey = true;
	voltabesta(spot);
}
//worldinfo.game.broadcast(self, 'distancia' @self@self.ladistance(self.pawn, spot));



 if(WorldInfo.TimeSeconds - timeclean > 10)
		    {
			 	timeclean = WorldInfo.TimeSeconds;
				BD_Anao_Guerreiro_Pawn(pawn).CleanAlvos();
		    }



if(!vaikey){
//-------------teste de tempo ---------------------			
		if(WorldInfo.TimeSeconds - cronos >= tempolimite){
			//WorldInfo.Game.Broadcast(self,"VOLTANDO 3 ");
			cronos=WorldInfo.TimeSeconds;
		cronoskey=true;
		}
		else{
			if(laDistance(self.pawn , currentgoal)<100){
		cronoskey = false;	
	}
			//cronoskey = false;
		}
//--------------------------------------------------
			
		if(!cronoskey){
		//if(BD_AnaoPawn(pawn).alvos.length != 0){
			`log(self@"Tenho"@BD_Anao_Guerreiro_Pawn(pawn).alvos.length@"inimigos");
			proxalvo = BD_Anao_Guerreiro_Pawn(pawn).next();
		//}
		 if(BD_Anao_Guerreiro_Pawn(pawn).bStun)
		 {
         	self.Stop();      //Faz o An�o parar seus movimentos

			if(WorldInfo.TimeSeconds - time > stumtime){
				BD_Anao_Guerreiro_Pawn(pawn).bStun = false;
				BD_Anao_Guerreiro_Pawn(pawn).health = BD_Anao_Guerreiro_Pawn(pawn).maxhealth;
			}
		}

         else
         {
                    //Faz o An�o retomar seus movimentos
			  time = WorldInfo.TimeSeconds;
			  BD_Anao_Guerreiro_Pawn(pawn).update_maxhealth();
			  //BD_AnaoPawn(pawn).regeneration();
			  self.go(); 
         }
		
		if(!BD_Anao_Guerreiro_Pawn(pawn).bstun)
		{
		    if(WorldInfo.TimeSeconds - time2 > 0.1)
		    {
			 	time = WorldInfo.TimeSeconds;
				`log(self@"Prox Alvo:"@self.proxalvo);
			 	if(proxalvo != none && !proxalvo.bstun)
				{
					self.currentgoal = proxalvo;

					BD_AnaoMeelePawn(pawn).startfire(0);

				//	self.stop();
				}

			else{
				if(currentgoal.IsA('bd_inimigopawn')){
				voltabesta(spot);
				}


				//preparar = true;
				
				BD_AnaoMeelePawn(pawn).stopfire(0);
			//	go();
			}
			}}
		} //fecha cronoskey
		else{
			voltabesta(spot);
		if(laDistance(self.pawn , currentgoal)<100){
		cronoskey = false;	
	}
		}

}//fecha vaikey
	else{
		//currentgoal = spot;
	//	go();
		if(laDistance(self.pawn , currentgoal)<100){
		vaikey = false;	
	}
	}
	if(currentgoal == none){
		voltabesta(spot);
	}

		 `Log(self@"Current Goal final:"@self.CurrentGoal);
		 WhatToDoNext();
}



event WhatToDoNext()
{
	
	super.WhatToDoNext();
}



DefaultProperties
{
	AnimName=Anao_SwordAttack01    // Nome da anima��o tocada quando a arma � usada

	AnimTime=1.5         // Tempo da anima��o usado no delay

stumtime = 3
	preparar = true
	x=0
	tempolimite = 10
	cronos = 0
}