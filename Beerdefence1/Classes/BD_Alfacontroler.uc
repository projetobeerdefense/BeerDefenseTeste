//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Alfacontroler extends Actor
	placeable;

var BD_Inimigo_Lagarto_Thief_Controller Lider;
var bool blider;

event tick(float DeltaTime){

	
	local BD_Inimigo_Lagarto_Thief_Controller aux ;
	
	
	foreach worldInfo.AllActors(class'BD_Inimigo_Lagarto_Thief_Controller', aux)
		{
			if(!blider){
				lider = aux;
				lider.bsoulider=true;
				blider= true;
			}
			else 
			{
				if(lider != none){
				aux.currentgoal = lider.currentgoal;
				}
				else blider = false;
			}


		}
}
defaultproperties
{
	blider = false
}