//-----------------------------------------------------------
// Codigo retirado do livro "Beginning iOS 3D Unreal Games
// Development - Robert Chin" e adaptado para o Jogo Thor Mobile
//-----------------------------------------------------------
class GFx_BeerHUD extends GFxMoviePlayer;



//swfs barris e anões
var GFxObject BD_flash_HUD;

function Init(optional LocalPlayer player)
{
	Start();
	Advance(0.f);

		BD_flash_HUD = GetVariableObject("_global");
		
}

function TickHUD() 
{
	local BD_PlayerController PC;	
    
	PC = BD_PlayerController(GetPC());

	if(PC != none){
		BD_flash_HUD.SetInt("anao_01", pc.Anao_Pawn[0].Health);
		BD_flash_HUD.SetInt("anao_02", pc.Anao_Pawn[1].Health);
		BD_flash_HUD.SetInt("anao_03", pc.Anao_Pawn[2].Health);
		BD_flash_HUD.SetInt("anao_04", pc.Anao_Pawn[3].Health);

		BD_flash_HUD.SetInt("barril_01", pc.Car_FollowPawn.barrlife[0]);
		BD_flash_HUD.SetInt("barril_02", pc.Car_FollowPawn.barrlife[1]);
		BD_flash_HUD.SetInt("barril_03", pc.Car_FollowPawn.barrlife[2]);
		BD_flash_HUD.SetInt("barril_04", pc.Car_FollowPawn.barrlife[3]);
		BD_flash_HUD.SetInt("barril_05", pc.Car_FollowPawn.barrlife[4]);
		BD_flash_HUD.SetInt("barril_06", pc.Car_FollowPawn.barrlife[5]);
		

	}


}

DefaultProperties
{
	bDisplayWithHudOff=true           // se for verdadeiro, mantem o Hud funcionando mesmo que o bShowHud seja falso
	MovieInfo=SwfMovie'BD_flash.hud_jogo'    // swf do Hud
}