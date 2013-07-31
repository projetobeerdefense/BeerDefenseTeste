//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Ncontroler extends Actor
	placeable;

var BD_Inimigo_Lagarto_Thief_Controller Lider;
var bool blider;
var int thiefcontador;


event tick(float DeltaTime)
{
	local BD_Inimigo_Lagarto_Thief_Controller aux ;
	local BD_Inimigo_Lagarto_Shaman_Controller shamanaux ;

    `log("Começando NController Tick");

	if(lider != none || lider.bbarrio)
	{
	   `log("if(lider != none || lider.bbarrio) == TRUE");
       blider = false;
	   lider = none;
	}

	foreach worldInfo.AllActors(class'BD_Inimigo_Lagarto_Thief_Controller', aux)
	{
		thiefcontador++;

			if(!blider)
			{
				if(!aux.bbarrio)
				{

                    `log("if(!blider) E if(!aux.bbarrio) SÃO TRUE");
                    lider = aux;
					lider.bsoulider=true;
					blider= true;
				}
			}

			else
			{
				if(lider != none)
				{
					if(!aux.bbarrio)
					{
					    `log("if(lider != none) E if(!aux.bbarrio) SÃO TRUE");
                        aux.currentgoal = lider.currentgoal;
					    aux.bsoulider = false;
					}
				}

				else
				  blider = false;
			}

			if(!aux.bStop)
			{
			    aux.bStop = true;
			}
	}

    foreach worldInfo.AllActors(class'BD_Inimigo_Lagarto_Shaman_Controller', shamanaux)
	{
	    `log("numero de thiefs"@thiefcontador);

        if(thiefcontador < 5 && shamanaux.bRead)
        {
	       shamanaux.spawnthief();
	       `log("chamou shaman");
	       thiefcontador++;
	    }
	}

    thiefcontador =0;
}






defaultproperties
{
	blider = false
	thiefcontador = 0
}