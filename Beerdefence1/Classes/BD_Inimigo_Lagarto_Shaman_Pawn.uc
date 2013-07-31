//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Inimigo_Lagarto_Shaman_Pawn extends BD_InimigoPawn;
var BotMarker SpawnSpot;
var actor BackSpot;
var vector SpawnSpotLocation;
var float offset;

simulated function PostBeginPlay()
{
	  super.PostBeginPlay();

	  SpawnSpotLocation = self.Location;
      SpawnSpotLocation.X += offset;
      SpawnSpot = Spawn(class'BotMarker',,,SpawnSpotLocation);

	  BackSpot=findbackspot();
}

function updateSpawnSpot()
{
      local vector updateLocation;

      updateLocation = self.Location;
      updateLocation.x += offset;
      SpawnSpot.SetLocation(updateLocation);
      `log("atualizando");
}

function actor findbackspot()
{
	local note aux;

	foreach worldInfo.AllActors(class'Note', aux)
		{
			
				return aux;
			
		}
}

function Tick(float DeltaTime)
{
	 //if (!BotSpawned)
  //  {
  //      SpawnBot(Pawn.Location);
  //      BotSpawned = true;
  //      UDNPawn(Pawn).InitialLocation = Pawn.Location;
  //  }

updateSpawnSpot();

}
defaultproperties
{
offset = 250
}