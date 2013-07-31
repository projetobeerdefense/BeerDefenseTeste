//-----------------------------------------------------------
// Codigo Baseado no do Livro - "Beginning iOS 3D Unreal Games Development"
// Criado por Robert Chin
// Modificaçõoes feita para o Jogo "Beer Defense"
// Modificado por Igor Felga
// Criado em 11/08/2012 - 09:25
//-----------------------------------------------------------

class BeerDefenceGame extends FrameworkGame;

//Variaveis usadas pelo hud do mouse------------------------------
var mouseHUD joyHUD;
var BD_PlayerController joyfulPlayerController;
//-----------------------------------------------------------------


event OnEngineHasLoaded()
{
   //   WorldInfo.Game.Broadcast(self,"BeerDefenceGame Type Active - Engine Has Loaded!!!!");
}

function bool PreventDeath(Pawn KilledPawn, Controller Killer, class<DamageType> DamageType, vector HitLocation)
{
      return true;
}

static event class<GameInfo> SetGameType(string MapName, string Options, string Portal)
{
      return super.SetGameType(MapName, Options, Portal);
}



defaultproperties
{
     PlayerControllerClass=class'BeerDefence1.BD_PlayerController'       //Player Controller Padrão
     DefaultPawnClass=class'BeerDefence1.UDNPawn'                 //Pawn padrão
     HUDType=class'mouseHUD'                                      //HUD padrão
     bRestartLevel=false
     bWaitingToStartMatch=true
     bDelayedStart=false
}