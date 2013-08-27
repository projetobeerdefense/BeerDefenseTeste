//-----------------------------------------------------------
// Criado por Vinicius Lima
// Criado em 30/01/2013
//-----------------------------------------------------------

class mouseHUD extends HUD
        config(Game);

//-----------------------------------------------------------
// @@ Classe responsavel pelo mouse
//-----------------------------------------------------------

//VARS
var String joyMessage;
var FONT joyFont;

//variaveis de largura e altura
var float joyWidth;
var float joyHeight;

//variaveis do mundo 3d
var Vector WorldOrigin;
var Vector WorldDirection;
var FontRenderInfo VictoryHudText;
var Texture2D    CursorTexture;

/** Various colors */
var const color VictoryCursorColor;

//Variaves para controle do Mouse
var Vector2D    MousePosition;             //variavel de posição
var vector HitLocation, HitNormal;         //Variaveis de projeção
var BD_PlayerController joyfulController;         //Variavel de controle do Player
var float limiteX, limiteY;                // variaveis de limite para o mouse

var bool selected;
var int anao;
var int oldtarget;

var GFx_BeerHUD HudMovie;



// evento que encerra o Hud
singular event Destroyed() 
{
	if (HudMovie != none) 
	{
		// apaga da memória temporária o HudMovie
		HudMovie.Close(true);
		HudMovie = none;
	}
}

Simulated Event PostBeginPlay()
{
    //include this line or you will break your HUD class too hee hee
    super.postbeginplay();


	HudMovie = new class'GFx_BeerHUD';
	// define o tempo do swf para rodar em tempo real, independente se o jogo está em slomo ou pausado
	HudMovie.SetTimingMode(TM_Real);
	// chama a função de inicio do GFxHud
	HudMovie.Init(class'Engine'.static.GetEngine().GamePlayers[HudMovie.LocalPlayerOwnerIndex]);


	//set worldinfo var
	BeerDefenceGame(WorldInfo.Game).joyHUD = Self;

	//retrieve worldinfo var
	joyfulController = BeerDefenceGame(WorldInfo.Game).joyfulPlayerController;
}



// evento atualizado após cada Tick
event PostRender() 
{
	HudMovie.TickHUD();
	super.PostRender();
}

function DisplayKismetMessages();
function DisplayConsoleMessages();
function DisplayLocalMessages();



//função q da a centralização do mouse
function centerCursor()
{
	MousePosition.X = joyWidth/2;
	MousePosition.Y = joyHeight / 2;
}

//the variable Canvas is only valid inside DrawHUD() and in postRender() which is not used here
//this function gets automatically called every frame like .tick() in other classes
function drawbarriolife(){
 canvas.font=class'Engine'.static.GetMediumFont();
 canvas.setdrawcolor(255,255,255);
 canvas.setpos(800,4);
 canvas.drawtext("barrio{0}"@joyfulController.car_followpawn.barrlife[0]);
  canvas.setpos(800,24);
 canvas.drawtext("barrio{1}"@joyfulController.car_followpawn.barrlife[1]);
  canvas.setpos(800,44);
 canvas.drawtext("barrio{2}"@joyfulController.car_followpawn.barrlife[2]);
  canvas.setpos(800,64);
 canvas.drawtext("barrio{3}"@joyfulController.car_followpawn.barrlife[3]);
  canvas.setpos(800,84);
 canvas.drawtext("barrio{4}"@joyfulController.car_followpawn.barrlife[4]);
  canvas.setpos(800,104);
 canvas.drawtext("barrio{5}"@joyfulController.car_followpawn.barrlife[5]);
 canvas.setpos(800,144);
 canvas.drawtext("carroca life"@joyfulController.car_followpawn.health);
 //joyfulController
}
function DrawHUD()
{
   //  local string StringMessage;


	// drawbarriolife();

	//get origin and dir
	Canvas.DeProject(MousePosition, WorldOrigin, WorldDirection);
	//Limitação espacial do mouse ----------------------------------------------------------------
	if(MousePosition.X<0) MousePosition.X=0;

	else if(MousePosition.X>limiteX) MousePosition.X=limiteX;

	if(MousePosition.Y<0) MousePosition.Y=0;

	else if(MousePosition.Y>limiteY) MousePosition.Y=limiteY;
	//--------------------------------------------------------------------------------------------

	//StringMessage = "MouseX" @ MousePosition.X @ "MouseY" @ MousePosition.Y;


    //HitLocation may not be valid, use this if to ensure it is valid and not null/None
	if (joyfulController.Trace(HitLocation, HitNormal, WorldOrigin + (WorldDirection * 100000), WorldOrigin, true) != none)
    {
        //HitLocation is the point in 3D space where our 2D mouse cursor is pointing
        joyMessage = "wx" @ HitLocation.x @ "wy" @ HitLocation.y @ "wz" @ HitLocation.z;

	    //set an actor to always follow the cursor as it moves
        //SomeHappyActor.SetLocation(HitLocation);
	}


    //draw the string to the screen, telling us where cursor is pointing to in 3D world
	Canvas.DrawColor = VictoryCursorColor;
	Canvas.SetPos( 10, 10 );
	//Canvas.DrawText( StringMessage, false, , , VictoryHudText );

	//Set position for mouse and plot the 2d texture.
	Canvas.SetPos(MousePosition.X , MousePosition.Y );
	Canvas.DrawTile(CursorTexture, 26 , 26, 380, 320, 26, 26);

	//teste posição do mouse no mundo...


	//Sample code for adding messages to your HUD
	Canvas.SetPos(50,100);
	Canvas.SetDrawColor(255,0,0,180);
	//Canvas.SetDrawColor(255,0,255,0);

    //yay custom fonts easier to read! set in default properties
	Canvas.Font = JoyFont;

	//Update Joy Message
	//Canvas.DrawText(JoyMessage);
}

//---------------------------------função para a seleção dos anões------------------------------------------------------
//exec function Selection()
//{
//	//seleciona o anão
//	if(selected==false)
//    {
//           //Verifica se o anão 0 está selecionado
//           if(HitLocation.X <= joyfulController.Anao_Pawn[0].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[0].Location.X -100 &&
//		      HitLocation.Y <= joyfulController.Anao_Pawn[0].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[0].Location.Y -100)
//           {
//			    //   WorldInfo.Game.Broadcast(self,"CLICK SELECT 0 ");
//			       selected=true;
//			       anao=0;
//           }

//           //Verifica se o anão 1 está selecionado
//	       if(HitLocation.X <= joyfulController.Anao_Pawn[1].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[1].Location.X -100 &&
//		      HitLocation.Y <= joyfulController.Anao_Pawn[1].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[1].Location.Y -100)
//           {
//                //   WorldInfo.Game.Broadcast(self,"CLICK SELECT 1 ");
//			       selected=true;
//			       anao=1;
//           }

//	       //Verifica se o anão 2 está selecionado
//           if(HitLocation.X <= joyfulController.Anao_Pawn[2].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[2].Location.X -100 &&
//		      HitLocation.Y <= joyfulController.Anao_Pawn[2].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[2].Location.Y -100)
//           {
//               //    WorldInfo.Game.Broadcast(self,"CLICK SELECT 2 ");
//			       selected=true;
//			       anao=2;
//           }

//           //Verifica se o anão 3 está selecionado
//	       if(HitLocation.X <= joyfulController.Anao_Pawn[3].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[3].Location.X -100 &&
//		      HitLocation.Y <= joyfulController.Anao_Pawn[3].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[3].Location.Y -100)
//           {
//               //    WorldInfo.Game.Broadcast(self,"CLICK SELECT 3 ");
//			       selected=true;
//			       anao=3;
//           }

//            //Verifica se a carroça ta selecionada está selecionado
//            if(HitLocation.X <= joyfulController.Car_Followpawn.Location.X +200 && HitLocation.X >= joyfulController.Car_Followpawn.Location.X -100 &&
//		       HitLocation.Y <= joyfulController.Car_Followpawn.Location.Y +200 && HitLocation.Y >= joyfulController.Car_Followpawn.Location.Y -100)
//           {
//			  //     WorldInfo.Game.Broadcast(self,"CLICK SELECT CARROCA ");
//			       selected=true;
//			       anao=4;
//           }
//	}

//	//faz o anão selecionado andar até a posição do clique caso não clique em outro anão
//	else {

//           //se clicar no anão 0, muda a seleção para o anão para ele
//	       if(HitLocation.X <= joyfulController.Anao_Pawn[0].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[0].Location.X -100 &&
//		      HitLocation.Y <= joyfulController.Anao_Pawn[0].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[0].Location.Y -100)
//           {

//                    if(anao == 0)
//                    {
//			               //WorldInfo.Game.Broadcast(self,"CLICK DESELECT 0 ");
//			               //WorldInfo.Game.Broadcast(self,"VOLTA HUD DA CARROCA");
//			               anao=4;
//			               selected=FALSE;
//        			}

//                    else
//                    {
//			         //      WorldInfo.Game.Broadcast(self,"CLICK SELECT CHANGE TO 0 ");
//			               anao=0;
//                    }
//           }

//	       //se clicar no anão 1, muda a seleção para o anão para ele
//	       else if(HitLocation.X <= joyfulController.Anao_Pawn[1].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[1].Location.X -100 &&
//		           HitLocation.Y <= joyfulController.Anao_Pawn[1].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[1].Location.Y -100)
//           {
//			        if(anao == 1)
//                    {
//                  //         WorldInfo.Game.Broadcast(self,"CLICK DESELECT 1 ");
//			               //WorldInfo.Game.Broadcast(self,"VOLTA HUD DA CARROCA");
//			               anao=4;
//			               selected=FALSE;
//                    }

//                    else
//                    {
//			            //   WorldInfo.Game.Broadcast(self,"CLICK SELECT CHANGE TO 1 ");
//			               anao=1;
//                    }
//           }

//           //se clicar no anão 2, muda a seleção para o anão para ele
//	       else if(HitLocation.X <= joyfulController.Anao_Pawn[2].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[2].Location.X -100 &&
//		           HitLocation.Y <= joyfulController.Anao_Pawn[2].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[2].Location.Y -100)
//           {
//			        if(anao == 2)
//                    {
//			           //    WorldInfo.Game.Broadcast(self,"CLICK DESELECT 2 ");
//			             //  WorldInfo.Game.Broadcast(self,"VOLTA HUD DA CARROCA");
//			               anao=4;
//			               selected=FALSE;
//                    }

//                    else
//                    {
//			               //WorldInfo.Game.Broadcast(self,"CLICK SELECT CHANGE TO 2 ");
//			               anao=2;
//                    }
//           }

//           //se clicar no anão 3, muda a seleção para o anão para ele
//	       else if(HitLocation.X <= joyfulController.Anao_Pawn[3].Location.X +200 && HitLocation.X >= joyfulController.Anao_Pawn[3].Location.X -100 &&
//		           HitLocation.Y <= joyfulController.Anao_Pawn[3].Location.Y +200 && HitLocation.Y >= joyfulController.Anao_Pawn[3].Location.Y -100)
//           {
//			       if(anao == 3)
//                   {
//			     //         WorldInfo.Game.Broadcast(self,"CLICK DESELECT 3 ");
//			       //       WorldInfo.Game.Broadcast(self,"VOLTA HUD DA CARROCA");
//			              anao=4;
//			              selected=FALSE;
//                   }

//			       else
//                   {
//			         //     WorldInfo.Game.Broadcast(self,"CLICK SELECT CHANGE TO 3 ");
//			              anao=3;
//         	       }
//           }

//	       else if(HitLocation.X <= joyfulController.Car_Followpawn.Location.X +200 && HitLocation.X >= joyfulController.Car_Followpawn.Location.X -100 &&
//                   HitLocation.Y <= joyfulController.Car_Followpawn.Location.Y +200 && HitLocation.Y >= joyfulController.Car_Followpawn.Location.Y -100)
//           {
//			       if(anao == 4)
//                   {
//                   ///       WorldInfo.Game.Broadcast(self,"CLICK DESELECT CARROCA ");
//			       //       WorldInfo.Game.Broadcast(self,"VOLTA HUD DA CARROCA");
//			              anao=4;
//			              selected=FALSE;
//                   }

//                   else
//                   {
//			     //         WorldInfo.Game.Broadcast(self,"CLICK SELECT CHANGE TO CARROCA ");
//			              anao=4;
//                   }
//           }

//	       // se não clicar em nenhum anão move o anão selecionado para a posição indicada
//	       else
//           {
//		           if(anao != 4)
//                   {
//		            //      WorldInfo.Game.Broadcast(self,"CLICK MOVE " @anao);
//		                  selected=FALSE;
//		                  joyfulController.Mover(HitLocation,anao);
//                   }
//           }
//	}

//}


//HUD de interface
function interHUD(int target)
{
    if(target == 4)
    {
           if(oldtarget == 4);
               //WorldInfo.Game.Broadcast(self,"MANTEM HUD 4");

           else
           {
	           oldtarget = 4;
	      //     WorldInfo.Game.Broadcast(self,"CALL HUD 4");
           }
    }

    else if(target == 3)
    {
	       if(oldtarget == 3);
               // WorldInfo.Game.Broadcast(self,"MANTEM HUD 3");

           else
           {
	           oldtarget = 3;
	         //  WorldInfo.Game.Broadcast(self,"CALL HUD 3");
           }
    }

    else if(target == 2)
    {
	       if(oldtarget == 2);
               //WorldInfo.Game.Broadcast(self,"MANTEM HUD 2");

           else
           {
	           oldtarget = 2;
	      //     WorldInfo.Game.Broadcast(self,"CALL HUD 2");
           }
    }

    else if(target == 1)
    {
	       if(oldtarget == 1);
               // WorldInfo.Game.Broadcast(self,"MANTEM HUD 1");

           else
           {
	           oldtarget = 1;
	       //    WorldInfo.Game.Broadcast(self,"CALL HUD 1");
           }
    }

    else if(target == 0)
    {
           if(oldtarget == 0);
               //WorldInfo.Game.Broadcast(self,"MANTEM HUD 0");

           else
           {
	           oldtarget = 0;
	        //   WorldInfo.Game.Broadcast(self,"CALL HUD 0");
           }
    }
}

//-----------------------------------------------------------------------------------------------------------------------


//-----------------------------------------------------------------------------------------------------------------------
//PROPERTIES
defaultproperties
{
	//other built in fonts
    //joyFont="UI_Fonts.MultiFonts.MF_HudLarge"
	//joyFont = "UI_Fonts.MultiFonts.MF_HudMedium"
	//joyFont = "UI_Fonts.MultiFonts.MF_HudSmall"

    //sample way to output nice happy info to your HUD in game
    joyFont = "UI_Fonts_Final.HUD.MF_Medium"
	joyMessage = "Joy!"

	//change if you want cursor to look different
	CursorTexture=Texture2D'UI_HUD.HUD.UTCrossHairs'

	VictoryCursorColor = (R = 255, G = 0, B = 0, A = 255)
	VictoryHudText = (bClipText = true)

    //----limite x e y para o mouse
	limiteX=1250
	limiteY=650

	//inicia na carroca
	anao = 4
	oldtarget = 4
}