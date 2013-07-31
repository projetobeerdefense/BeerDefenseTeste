//-----------------------------------------------------------
// Codigo Baseado no do Livro - "Beginning iOS 3D Unreal Games Development"
// Criado por Robert Chin
// Modificaçõoes feita para o Jogo "Beer Defense"
// Modificado por Igor Felga
// Criado em 11/08/2012 - 09:33
//-----------------------------------------------------------

//-----------------------------------------------------------
// @@ PlayerController - todos os controles dos 5 bots (Carroça + 4 Anões)
//    estão presentes nessa classe
//-----------------------------------------------------------

class BD_PlayerController extends SimplePC;

//Variaveis relacionadas a Carroça
var BD_CarrocaController Car_FollowBot;   //Controller - Carroca
var BD_CarrocaPawn Car_FollowPawn;        //Pawn - Carroca
var BD_CarrocaController javali_bot;
var BD_JavaliPawn Javali_pawn;


var array<BD_AnaoController> Anao_Bot;    //Controller - Anao
var array<BD_AnaoPawn> Anao_Pawn;         //Pawn - Anao

var bool BotSpawned;                      //Variavel de controle para saber se o Bot Já nasceu
var vector SpotLocation;                  //Variavel usada para determinar a posicao dos Spots

var Actor BotTarget;                      //Destino do Bot

var array<PathNode> Caminhos;             //Array de caminhos usados pela Carracao
var array<BotMarker> Spots;               //Array de Spots usados pelos Anao
var array<BotMarker> Nspot;               //Array de Spots usados pelos Anao
var array<actor> minimi; 

var MouseMark MouseX;
//var bool MouseXKey;
var MouseSel MouseY;
//var bool MouseYKey;
var MouseMove MouseZ;
//var bool MouseYKey;
var array<Actor> nMouse; 

var int themouse;
//var BotMarker MouseX;
//var mouseHUD joyHUD;

var array<bool> movekey;
var array<float> time;
var float tempo;

var array<float> catop;  //cateto oposto
var array<float> catad;  //cateto adjacente
var array<float> hip;    //hipotenusa

var array<BD_InimigoPawn> alvo1;
var array<BD_InimigoPawn> alvo2;

var BD_InimigoPawn exemplo;

var array <bool> controles;

simulated function PostBeginPlay()
{
    local PathNode aux;

    super.PostBeginPlay();

	BeerDefenceGame(WorldInfo.Game).joyfulPlayerController = Self;

    foreach WorldInfo.AllNavigationPoints(class'PathNode', aux)
    {
       if(aux.Tag == Name("PathNode"))
       {
           self.Caminhos.AddItem(aux);
       }

       `log("Caminhos:"@Caminhos.Length);
    }
}

// FUNÇÃO PARA MOVER O ANÃO PARA NOVO LOCAL
//função recebe as variaveis do ponto em que deve andar e o numero anão que ira andar;
function Mover(Vector ponto,int anao){   
local rotator rootate;
Nspot[anao] = Spawn(class'BotMarker',,,ponto); //cria novo spot que o anão vai seguir
Nspot[anao].SetRotation(rootate);
//minimi[anao] = Spawn(class'MouseMove',,,ponto);
Nspot[anao].SetHidden(false);
Anao_Bot[anao].voltabesta( self.Nspot[anao]); //manda o anão seguir o novo spot
Anao_Bot[anao].cronos = WorldInfo.TimeSeconds;
Anao_Pawn[anao].CleanAlvos();
//WorldInfo.Game.Broadcast(self,"MOVENDO "@anao);
time[anao]= WorldInfo.TimeSeconds;  //marca o momento em que o anão começa a seguir 
movekey[anao]=true; //muda a chave de tempo para true
}

//------------------------------------------
//função para mandar todos os anões ao inicio
exec function Goback(){
movekey[0]=false;
movekey[1]=false;
movekey[2]=false;
movekey[3]=false;
}

function SpawnBot(Vector SpawnLocation)
{
      //Configura localização de Spawn da Carroca
      SpawnLocation.z = SpawnLocation.z + 500;

      //Spawn e Configurção da Carroça da Carroca
      Car_FollowBot = Spawn(class'BD_CarrocaController',,,SpawnLocation);
      Car_FollowPawn = Spawn(class'BD_CarrocaPawn',,,SpawnLocation);
      Car_FollowBot.Possess(Car_FollowPawn,false);
     // Car_FollowBot.CurrentGoal = self.Caminhos[Car_FollowBot.caminhoIndex];
      Car_Followpawn.InitialLocation = SpawnLocation;
	  Car_FollowBot.FollowDistance = 250;
      Car_FollowPawn.SetPhysics(PHYS_Falling);
		
	  SpawnLocation.y = Car_FollowPawn.location.y +300;
	  javali_bot = Spawn(class'BD_CarrocaController',,,SpawnLocation);
      Javali_pawn = Spawn(class'BD_JavaliPawn',,,SpawnLocation);
      javali_bot.Possess(Javali_pawn,false);
      javali_bot.CurrentGoal = self.Caminhos[javali_bot.caminhoIndex];
      Javali_pawn.InitialLocation = SpawnLocation;
      Javali_pawn.SetPhysics(PHYS_Falling);
	   Car_FollowBot.CurrentGoal= Javali_pawn;

	  //Spawn mouse mark
	  nMouse[0] = Spawn(class'MouseMark',,,BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation);
	  nMouse[1] = Spawn(class'MouseSel',,,BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation);
	  nMouse[2] = Spawn(class'MouseMove',,,BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation);

      //Spawn e config. dos Spots
      SpotLocation = Car_FollowBot.Location;
      Spotlocation.X += 30;
      Spots[0] = Spawn(class'BotMarker',,,SpotLocation);
	 
      SpotLocation = Car_FollowBot.Location;
      Spotlocation.X -= 30;
      Spots[1] = Spawn(class'BotMarker',,,SpotLocation);
	 
      SpotLocation = Car_FollowBot.Location;
      Spotlocation.Y += 30;
      Spots[2] = Spawn(class'BotMarker',,,SpotLocation);
	 
      SpotLocation = Car_FollowBot.Location;
      Spotlocation.Y -= 30;
      Spots[3] = Spawn(class'BotMarker',,,SpotLocation);
	
      SpawnLocation.z += 100;
      SpawnLocation.x += 100;

      //Spawn e Configuração dos Anoes
      Anao_Bot[0] = Spawn(class'BD_Anao_Atirador_Controller',,,SpawnLocation);
      Anao_Pawn[0] = Spawn(class'BD_Anao_Atirador_Pawn',,,SpawnLocation);
      Anao_Bot[0].Possess(Anao_Pawn[0],false);
      Anao_Bot[0].CurrentGoal = self.Spots[0];
	  Anao_Bot[0].spot= self.Spots[0];
      Anao_Pawn[0].SetPhysics(PHYS_Falling);
		
	  SpawnLocation.x += 50;

	  Anao_Bot[1] = Spawn(class'BD_Anao_Atirador_Controller',,,SpawnLocation);
      Anao_Pawn[1] = Spawn(class'BD_Anao_Atirador_Pawn',,,SpawnLocation);
      Anao_Bot[1].Possess(Anao_Pawn[1],false);
      Anao_Bot[1].CurrentGoal = self.Spots[1];
	  Anao_Bot[1].spot= self.Spots[1];
      Anao_Pawn[1].SetPhysics(PHYS_Falling);

	  SpawnLocation.x += 50;

	  Anao_Bot[2] = Spawn(class'BD_Anao_Engenheiro_Controller',,,SpawnLocation);
      Anao_Pawn[2] = Spawn(class'BD_Anao_Engenheiro_Pawn',,,SpawnLocation);
      Anao_Bot[2].Possess(Anao_Pawn[2],false);
      Anao_Bot[2].CurrentGoal = self.Spots[2];
	  Anao_Bot[2].spot= self.Spots[2];
      Anao_Pawn[2].SetPhysics(PHYS_Falling);

	  SpawnLocation.x += 50;

	  Anao_Bot[3] = Spawn(class'BD_Anao_Engenheiro_Controller',,,SpawnLocation);
      Anao_Pawn[3] = Spawn(class'BD_Anao_Engenheiro_Pawn',,,SpawnLocation);
      Anao_Bot[3].Possess(Anao_Pawn[3],false);
      Anao_Bot[3].CurrentGoal = self.Spots[3];
	  Anao_Bot[3].spot= self.Spots[3];
      Anao_Pawn[3].SetPhysics(PHYS_Falling);

	  Anao_Pawn[0].AddDefaultInventory();
	  Anao_Pawn[1].AddDefaultInventory();
	  Anao_Pawn[2].AddDefaultInventory();
	  Anao_Pawn[3].AddDefaultInventory();

      //Seta true para dizer que bot foram 'spawned'
      BotSpawned = true;
}


function updateSpots(vector newLocation)
{
    local vector updateLocation;

    updateLocation = newLocation;
	updateLocation.x += 400;
    Spots[0].SetLocation(updateLocation);

    updateLocation = newLocation;
    updateLocation.x -= 400;
    Spots[1].SetLocation(updateLocation);

    updateLocation = newLocation;
    updateLocation.y += 400;
    Spots[2].SetLocation(updateLocation);

    updateLocation = newLocation;
    updateLocation.y -= 400;
    Spots[3].SetLocation(updateLocation);
}

function updateMousep(vector newLocation,int x)
{
    local vector updateLocation;

    updateLocation = newLocation;
	nMouse[x].SetLocation(updateLocation);
	
}


function PlayerTick(float DeltaTime)
{
    local int dist;
	local  float mx;  //change in mouse x direction from user
	local  float my;  //change in mouse y direction from user
	local int cont;
	
	//
	//worldinfo.game.broadcast(self,"carroca index = "@car_followpawn.index);

	//playercontroller.playerinput, its built in to unreal engine
//----------pega posição do mouse do usuario-------------------------------
		 mx = PlayerInput.aMouseX;
		 my = PlayerInput.aMouseY;

		// MouseX.SetLocation(joyHUD.HitLocation);
		updateMousep(BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation,themouse);
//-------------------------------------------------------------------------

    Super.PlayerTick(DeltaTime); //chama o tick de novo

  //  WorldInfo.Game.Broadcast(self,"Carroca Velo:"@Car_FollowPawn.MaxDesiredSpeed);

    if(BotSpawned)
    {
        dist = Vsize(javali_bot.Pawn.Location - javali_bot.CurrentGoal.Location);
        if(dist < 55)
        {
           javali_bot.changeGoal = true;
           javali_bot.caminhoIndex++;
           javali_bot.auxGoal = self.Caminhos[javali_bot.caminhoIndex];
			
		  // Car_FollowBot.changeGoal = true;
           Car_FollowBot.currentgoal = Javali_pawn;
		   Car_FollowBot.gotostate('FollowTarget','Begin');
		

        }
		if(Car_FollowBot.statuswalking == false){
			javali_bot.Stop();
		}
		else javali_bot.go();
		
        updateSpots(Car_FollowPawn.Location);
    }

    if (!BotSpawned)
    {
        SpawnBot(Pawn.Location);
        BotSpawned = true;
        UDNPawn(Pawn).InitialLocation = Pawn.Location;
    }

//--------Atualiza posição no HUD----------------------------------------
		BeerDefenceGame(WorldInfo.Game).joyHUD.MousePosition.X += mx;
		BeerDefenceGame(WorldInfo.Game).joyHUD.MousePosition.Y += -my;
//---------------------------------------------------------------------
//muda particula ao selecionar---------------------------------------
		if(BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X <= Anao_Pawn[0].Location.X +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X >= Anao_Pawn[0].Location.X -100 &&
		BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y <= Anao_Pawn[0].Location.Y +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y >= Anao_Pawn[0].Location.Y -100){
			
		//	MouseX.Destroy();
			themouse=1;
			nMouse[0].SetHidden(true);
			nMouse[1].SetHidden(false);
			nMouse[2].SetHidden(true);
			//WorldInfo.Game.Broadcast(self,"Spot0 Z = "@ MouseX.Location.Z);
			
		} else
			if(BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X <= Anao_Pawn[1].Location.X +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X >= Anao_Pawn[1].Location.X -100 &&
		BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y <= Anao_Pawn[1].Location.Y +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y >= Anao_Pawn[1].Location.Y -100){
			
		//	MouseX.Destroy();
			themouse=1;
			nMouse[0].SetHidden(true);
			nMouse[1].SetHidden(false);
			nMouse[2].SetHidden(true);
		//	WorldInfo.Game.Broadcast(self,"Spot0 Z = "@ MouseX.Location.Z);
			
		} else
			if(BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X <= Anao_Pawn[2].Location.X +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X >= Anao_Pawn[2].Location.X -100 &&
		BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y <= Anao_Pawn[2].Location.Y +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y >= Anao_Pawn[2].Location.Y -100){
			
		//	MouseX.Destroy();
			themouse=1;
			nMouse[0].SetHidden(true);
			nMouse[1].SetHidden(false);
			nMouse[2].SetHidden(true);
	//		WorldInfo.Game.Broadcast(self,"Spot0 Z = "@ MouseX.Location.Z);
			
		} else
			if(BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X <= Anao_Pawn[3].Location.X +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.X >= Anao_Pawn[3].Location.X -100 &&
		BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y <= Anao_Pawn[3].Location.Y +200 && BeerDefenceGame(WorldInfo.Game).joyHUD.HitLocation.Y >= Anao_Pawn[3].Location.Y -100){
			
		//	MouseX.Destroy();
			themouse=1;
			nMouse[0].SetHidden(true);
			nMouse[1].SetHidden(false);
			nMouse[2].SetHidden(true);
		//	WorldInfo.Game.Broadcast(self,"Spot0 Z = "@ MouseX.Location.Z);
			
		} else
//muda particula até escolher o local para mover
		if(BeerDefenceGame(WorldInfo.Game).joyHUD.selected ==true){
		//	MouseX.tag='move';
			themouse=2;
			nMouse[0].SetHidden(true);
			nMouse[1].SetHidden(true);
			nMouse[2].SetHidden(false);
		//	WorldInfo.Game.Broadcast(self,"Spot0 Z = "@ MouseX.Location.Z);
		} else
//volta ao normal----------------------------------------------------------------------
		//MouseX.tag='normal'
		{
			themouse=0;
			nMouse[0].SetHidden(false);
			nMouse[1].SetHidden(true);
			nMouse[2].SetHidden(true);
		}

for(cont=0; cont <4; cont++){
	if(vsize(Anao_Pawn[cont].Location - Nspot[cont].Location) <100){
		`log("entrando destroy"@Nspot[cont]);
		Nspot[cont].Destroy();
	}

}


//---------------------------------------------------------------
// Huds dos anões e do carro
if(BeerDefenceGame(WorldInfo.Game).joyHUD.anao ==4){
	BeerDefenceGame(WorldInfo.Game).joyHUD.interHUD(4);
}else if(BeerDefenceGame(WorldInfo.Game).joyHUD.anao ==3){
	BeerDefenceGame(WorldInfo.Game).joyHUD.interHUD(3);
}else if(BeerDefenceGame(WorldInfo.Game).joyHUD.anao ==2){
	BeerDefenceGame(WorldInfo.Game).joyHUD.interHUD(2);
}else if(BeerDefenceGame(WorldInfo.Game).joyHUD.anao ==1){
	BeerDefenceGame(WorldInfo.Game).joyHUD.interHUD(1);
}else if(BeerDefenceGame(WorldInfo.Game).joyHUD.anao ==0){
	BeerDefenceGame(WorldInfo.Game).joyHUD.interHUD(0);
}
//---------------------------------------------------------------
}

defaultproperties
{
    BotSpawned=false
	movekey[0]=false
	movekey[1]=false
	movekey[2]=false
	movekey[3]=false
	time[0]=0.0
	time[1]=0.0
	time[2]=0.0
	time[3]=0.0
	tempo=10.0
	themouse=0
	
}