//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 12:25
// Classe "BD_AnaoController" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Inimigo_Lagarto_Shaman_Controller extends BD_Inimigo_Controller;
var int tempolimite;
//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Basica do Inimigo
//-----------------------------------------------------------
var float dist;          //Variavel para verificação da distancia entre Anão e Inimigo
var float delaytime;          //Variavel para caluclo de tempo, para fixar ciclo de tempo
var bool bmorreu;        //Variavel para saber se o alvo está vivo
var bool bRead;
var float tempo;
var bool spawned;
/* ### Modificação futura ############################################

###################################################################### */

function spawnthief()
{
	local BD_Inimigo_Lagarto_Thief_Pawn enimypawn;
	local BD_Inimigo_Lagarto_Thief_Controller enimybot;
	local vector spawnpoint;

	if(!spawned)
    {

	    `log("passo 1: bot");
	    spawnpoint = BD_Inimigo_Lagarto_Shaman_Pawn(pawn).SpawnSpot.Location;
	    spawnpoint.z += 500;
	    enimybot = Spawn(class'BD_Inimigo_Lagarto_Thief_Controller',,,spawnpoint);
	    `log("passo 2: pawn");
        enimypawn = Spawn(class'BD_Inimigo_Lagarto_Thief_Pawn',,,spawnpoint);
	    `log("passo 3: backspot");
        enimybot.spawnplace = BD_Inimigo_Lagarto_Shaman_Pawn(pawn).BackSpot;
	    `log("passo 4: posses");
        enimybot.Possess(enimypawn,false);
	    `log("passo 5: physics");
	    enimypawn.SetPhysics(PHYS_Falling);
	    `log("passo 6: current goal");
	    enimybot.bsoulider = true;
	    enimybot.bStop = true;
		
	    enimybot.earlyborn = true;
		
	    spawned = true;
		delaytime = WorldInfo.TimeSeconds;
	}

	
 }

event WhatToDoNext()
{
	local BD_AnaoPawn aux;      //Variavel utilizado durante o foreach
//	local BD_Inimigo_Lagarto_Shaman_Pawn Companheiro;
    //Variaveis usadas para o calculo de distancia
	local float catop;          //Cateto Oposto
	local float catad;          //Cateto Adjacente
	local float hip;            //Hipotenusa

	super.WhatToDoNext();
	if(spawned){
		if(WorldInfo.TimeSeconds - delaytime > 5){
		spawned = false;
		}
	}
	else
	{
		delaytime = WorldInfo.TimeSeconds;
	}



    //Verifica se possui um CurrentGoal
    if(self.currentgoal != none)
    	self.gotostate('FollowTarget', 'Begin');

    //Verifica se o CurrentGoal esta atordoado ou seu CurrentGoal é nulo
    if(BD_Anaopawn(currentgoal).bstun || currentgoal == none)
	{
	//	`log("Meu alvo morreu");
		///WorldInfo.Game.Broadcast(self,"Meu alvo morreu");
        dist = 10000000000000000000000000000000000000000000;       //Seta a distancia com um valor enorme
		bmorreu = true;
		pawn.stopfire(0);                                          //Faz o Inimigo para de atirar
	}

    //Ciclo de atualização a cada 1 segundo
    if(WorldInfo.TimeSeconds - time > 1)
    {
		//Atualiza a variavel de tempo para futuro ciclo
        time = WorldInfo.TimeSeconds;
		foreach worldInfo.AllActors(class'BD_Anaopawn', aux)
		{
			//Verifica se o possivel alvo não está atordoado
            if(!aux.bstun)
			{
                bmorreu=false;

                //Calculo da Distancia
                catop = Pawn.Location.X - aux.Location.X;
				catad = Pawn.Location.Y - aux.Location.Y;
				hip = sqrt(catop*catop + catad*catad);


                if(dist > hip)
				{
					//Verifica se é o mesmo alvo
                    if(aux == currentgoal)
					{
					//	`log("Mesmo Alvo:"@self.currentgoal);
						self.gotostate('FollowTarget', 'Begin');
					}
					//Senão troca o alvo
                    else
					{
					//	`log("Trocando o Alvo: "@aux);
						dist = hip;                 //Atualiza o valor da distancia
						self.CurrentGoal = aux;     //Troca o alvo para o novo
						self.gotostate('FollowTarget', 'Begin');
					}
				}
			}

			else
			{

			}
            //Verifica se o alvo esta dentro de um raio

            /* ### Modificação futura ############################################
            atualiza para uma variavel dentro das armas, facilitando balanceamento
            ###################################################################### */
			if(hip<1500.0)
			{
				//Verifica se o alvo está vivo
                if(!bmorreu)
                {
				     //Para o Inimigo e começa a atirar
					bRead = true;
				     self.Stop();
				}
			}
            //O Alvo está fora do meu Range
			else
			{
				//Para de atirar e começa a seguir o inimigo
				bRead = false;
				self.go();
			}
		}

		//`log("Escolhido:"@self.currentgoal);
	}

    //Ciclo que será feito todo tick
    else
	{
		foreach worldInfo.AllActors(class'BD_Anaopawn', aux)
		{
			//Meu alvo atual está de pé
            if(aux == currentgoal && !aux.bStun)
			{
			//	`log("Manter meu Alvo:"@self.currentgoal);
				self.gotostate('FollowTarget', 'Begin');
			}

            /* ### Modificação futura ############################################
            Verificar por que ele cai nessa opção e ver o que fazer para evitar, ou
            qual ação tomar.
            ###################################################################### */
            //else
				//`log("eu não deveria estar aqui:"@self.currentgoal);
		}
	}



}

DefaultProperties
{
	dist = 10000000000000000000000000000000000000000000
	time =0.0
	tempolimite = 5;
	tempo = 0
	spawned = false;
}