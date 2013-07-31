//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 12:25
// Classe "BD_AnaoController" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Inimigo_Lagarto_Warior_Controller extends BD_Inimigo_Controller;

//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Basica do Inimigo
//-----------------------------------------------------------
var float dist;          //Variavel para verificação da distancia entre Anão e Inimigo
//var float time;          //Variavel para caluclo de tempo, para fixar ciclo de tempo
var bool bmorreu;        //Variavel para saber se o alvo está vivo

/* ### Modificação futura ############################################

###################################################################### */

event WhatToDoNext()
{
	local BD_AnaoPawn aux;      //Variavel utilizado durante o foreach

    //Variaveis usadas para o calculo de distancia
	local float catop;          //Cateto Oposto
	local float catad;          //Cateto Adjacente
	local float hip;            //Hipotenusa

	super.WhatToDoNext();

    //Verifica se possui um CurrentGoal
    if(self.currentgoal != none)
    	self.gotostate('FollowTarget', 'Begin');

    //Verifica se o CurrentGoal esta atordoado ou seu CurrentGoal é nulo
    if(BD_Anaopawn(currentgoal).bstun || currentgoal == none)
	{
		`log("Meu alvo morreu");
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

                `log("Aux:"@aux);
				`log("Hip:"@hip);
				`log("Dist:"@dist);
				//Verifica se a distancia do alvo atual é maior que a calculada
                if(dist > hip)
				{
					//Verifica se é o mesmo alvo
                    if(aux == currentgoal)
					{
						`log("Mesmo Alvo:"@self.currentgoal);
						self.gotostate('FollowTarget', 'Begin');
					}
					//Senão troca o alvo
                    else
					{
						`log("Trocando o Alvo: "@aux);
						dist = hip;                 //Atualiza o valor da distancia
						self.CurrentGoal = aux;     //Troca o alvo para o novo
						self.gotostate('FollowTarget', 'Begin');
					}
				}
			}

			else
			{
				`log("esta morto"@aux);
				//self.currentgoal = none;
			}
            //Verifica se o alvo esta dentro de um raio

            /* ### Modificação futura ############################################
            atualiza para uma variavel dentro das armas, facilitando balanceamento
            ###################################################################### */
			if(hip<60.0)
			{
				//Verifica se o alvo está vivo
                if(!bmorreu)
                {
				     //Para o Inimigo e começa a atirar
                     pawn.Startfire(0);
				     self.Stop();
				}
				else pawn.stopfire(0);
			}
            //O Alvo está fora do meu Range
			else
			{
				//Para de atirar e começa a seguir o inimigo
                pawn.stopfire(0);
				self.go();
			}
		}

		`log("Escolhido:"@self.currentgoal);
	}

    //Ciclo que será feito todo tick
    else
	{
		foreach worldInfo.AllActors(class'BD_Anaopawn', aux)
		{
			//Meu alvo atual está de pé
            if(aux == currentgoal && !aux.bStun)
			{
				`log("Manter meu Alvo:"@self.currentgoal);
				self.gotostate('FollowTarget', 'Begin');
			}

            /* ### Modificação futura ############################################
            Verificar por que ele cai nessa opção e ver o que fazer para evitar, ou
            qual ação tomar.
            ###################################################################### */
            else
				`log("eu não deveria estar aqui:"@self.currentgoal);
		}
	}
}

DefaultProperties
{
	dist = 10000000000000000000000000000000000000000000
	time =0.0
}