class UDNPawn extends UTPawn ;

var float CamOffsetDistance_pitch;       //distance to offset the camera from the player
var float CamOffsetDistance_yaw;         //distance to offset the camera from the player
var int IsoCamAngle_pitch;               //pitch angle of the camera
var int IsoCamAngle_yaw;                 //yaw angle of the camera
var float IsoZDistance;                  //pitch angle of the camera
//Variaveis da posição da camera para o zoom
var int ZoomValueX;    
var int ZoomValueY;
//--------------------------------------------
//Define qual a camera------------------------
var int Cams;
//--------------------------------------------
//Posições x e y para as cameras de 1 a 4-----
//Camera 1
var int PosX1;
var int PosY1;
//Camera 2
var int PosX2;
var int PosY2;
//Camera 3
var int PosX3;
var int PosY3;
//Camera 4
var int PosX4;
var int PosY4;
//Rotação da camera
var int multrot;
//Chaves de ativação
var bool Chave;
var bool Chave2;
var bool Chave3;
var bool Chave4;
var bool time_key;
//velocidade de transição da camera
var int CamSpeed;
//velocidade de rotação da camera
var int CamSpeedRot;
//velocidade do zoom
var int ZoomSpeed;
//Variaveis de movimentação de camera
var int MovecamX;
var int MovecamY;
var int MovecamZ;
// localização inicial
var vector InitialLocation;
//controlador de tempo (referencia alice in wonderland)
var float mr_rabbit;
//variavel q guarda ultimo tempo
var float time;


//Função da camera----------------------------------------------------------------------------------------------------------------

simulated function bool CalcCamera( float fDeltaTime, out vector out_CamLoc, out rotator out_CamRot, out float out_FOV )
{
   local BD_CarrocaPawn aux;

   foreach WorldInfo.Game.AllActors(class'BD_CarrocaPawn', aux)
   {
           //`log("Carroça Encontrada");
           out_CamLoc = aux.Location;
   }
   //----segura a posição basica da camera---------------
	if(IsoZDistance<400){
		IsoZDistance=400;

	}
	if(IsoZDistance>1200){
		IsoZDistance=1200;
	}
	//------------------------------------------------------
	//Controle de tempo (se o tempo atual - tempo anterior for >= q o controle,  o time é atualizado e a chave é marcada como true 
	if(WorldInfo.TimeSeconds - time >= mr_rabbit){
	time= WorldInfo.TimeSeconds;
	time_key=true;
	}
	//------------------------------------------------------
	
//execução da mudança de camera-----------------------------
	//a cada vez q a chave seja true------------------------
if(time_key){
	time_key=false; // define chave como false novamente
	//rotação e translação
	//camera 1
	if(Cams == 1){
		//rotação
			if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
				IsoCamAngle_yaw=IsoCamAngle_yaw+CamSpeedRot;
					if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
						IsoCamAngle_yaw=8192+(multrot*(32768/2));
					}
			}
			if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
			IsoCamAngle_yaw=IsoCamAngle_yaw-CamSpeedRot;
				if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
					IsoCamAngle_yaw=8192+(multrot*(32768/2));
				}}
		
		//------------------------------------------------		
		//movimentação basica	
			if(MovecamX < PosX1){
				Chave = true;
				MovecamX = MovecamX +CamSpeed;
				
			}
			else if(MovecamY < PosY1){
				Chave2=true;
				MovecamY = MovecamY +CamSpeed;
		//---------------------------
		//movimentação pra atualização do zoom nas variaveis X e Y
			}
			if(Chave == true){
			if(ZoomValueX < MovecamZ){
					ZoomValueX = ZoomValueX+ZoomSpeed;
			} 
			else Chave=false;
			}
			
			if(Chave2 == true){
			if(ZoomValueY < MovecamZ){
					ZoomValueY = ZoomValueY+ZoomSpeed;
			}
			else Chave2 = false;
			}
		//---------------------------------------------------------------
}
	//camera 2
	if(Cams == 2){
		//rotação
			if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
				IsoCamAngle_yaw=IsoCamAngle_yaw+CamSpeedRot;
					if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
						IsoCamAngle_yaw=8192+(multrot*(32768/2));
					}
			}
			if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
			IsoCamAngle_yaw=IsoCamAngle_yaw-CamSpeedRot;
				if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
					IsoCamAngle_yaw=8192+(multrot*(32768/2));
				}}
		//movimentação basica
			if(MovecamY > PosY2){
				Chave2 = true;
			MovecamY = MovecamY -CamSpeed;
			}
			else if(MovecamX > PosX2){
				Chave = true;
			MovecamX = MovecamX -CamSpeed;
			
			
			}
		//-----------------------------------------
		//moimentação para atualização do zoom
			if(Chave == true){
				if(ZoomValueX > -MovecamZ){
					ZoomValueX = ZoomValueX-ZoomSpeed;
				}
		    	else Chave = false; 
			}
			
			
			if(Chave2 == true){
				if(ZoomValueY > -MovecamZ){
					ZoomValueY = ZoomValueY-ZoomSpeed;
				}
				else Chave2 = false; 
			}

			//----------------------------------------
	}
	//camera 3
	if(Cams == 3){
		//rotação
			if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
				IsoCamAngle_yaw=IsoCamAngle_yaw+CamSpeedRot;
					if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
						IsoCamAngle_yaw=8192+(multrot*(32768/2));
					}
			}
			if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
			IsoCamAngle_yaw=IsoCamAngle_yaw-CamSpeedRot;
				if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
					IsoCamAngle_yaw=8192+(multrot*(32768/2));
				}}
		//movimentação basica
			if(MovecamX > PosX3){
				Chave = true;
			MovecamX = MovecamX -CamSpeed;
			}
			else if(MovecamY < PosY3){
				Chave2=true;
				MovecamY = MovecamY +CamSpeed;			
			}
		//------------------------------
		//movimentação para atualização do zoom
			if(Chave == true){
				if(ZoomValueX > -MovecamZ){
					ZoomValueX = ZoomValueX-ZoomSpeed;
				}
				else Chave = false; 
			}			
			
			if(Chave2 == true){
			if(ZoomValueY < MovecamZ){
					ZoomValueY = ZoomValueY+ZoomSpeed;
			}
			else Chave2 = false;
			}
		//-----------------------------------------
	}
	//camera 4
	if(Cams == 4){
		//rotação
			if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
				IsoCamAngle_yaw=IsoCamAngle_yaw+CamSpeedRot;
					if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
						IsoCamAngle_yaw=8192+(multrot*(32768/2));
					}
			}
			if(IsoCamAngle_yaw>8192+(multrot*(32768/2))){
			IsoCamAngle_yaw=IsoCamAngle_yaw-CamSpeedRot;
				if(IsoCamAngle_yaw<8192+(multrot*(32768/2))){
					IsoCamAngle_yaw=8192+(multrot*(32768/2));
				}}

			//movimentação basica
			if(MovecamX < PosX4){
				Chave = true;
				MovecamX = MovecamX +CamSpeed;
				
			}
			else if(MovecamY > PosY4){
				Chave2 = true;
			MovecamY = MovecamY -CamSpeed;
			}
			//movimentação para atualização do zoom
			if(Chave == true){
			if(ZoomValueX < MovecamZ){
					ZoomValueX = ZoomValueX+ZoomSpeed;
			} 
			else Chave=false;
			}
			
			if(Chave2 == true){
				if(ZoomValueY > -MovecamZ){
					ZoomValueY = ZoomValueY-ZoomSpeed;
				}
				else Chave2 = false; 
			}
			//---------------------------------------			
	}
}
	// fim da mudança de camera
		//calculo da camera--------------------------------------------------------
			out_CamLoc.X -= Cos(IsoCamAngle_pitch * UnrRotToRad) * (CamOffsetDistance_pitch + ZoomValueX + MovecamX);
			out_CamLoc.Y -= Cos(IsoCamAngle_yaw * UnrRotToRad) * (CamOffsetDistance_yaw + ZoomValueY + MovecamY);
			out_CamLoc.Z += (IsoZDistance + MovecamZ);
			/*
			out_CamLoc.X -=  (ViewTarget.POV.Rotation.X) * (CamOffsetDistance_pitch + ZoomValueX + MovecamX);
			out_CamLoc.Y -=  (ViewTarget.POV.Rotation.Y)*(CamOffsetDistance_yaw + ZoomValueY + MovecamY);
			out_CamLoc.Z += (ViewTarget.POV.Rotation.Z)*(IsoZDistance + MovecamZ);
*/
		//------------------------------------------------------------------------

		
			//if(Chave2 == false) Chave = true;
			//if(Chave == false) Chave2 = true;
   /*
   WorldInfo.Game.Broadcast(self,"Distancia Z = "@ IsoZDistance+MovecamZ);
   WorldInfo.Game.Broadcast(self,"Distancia Y = "@ CamOffsetDistance_yaw + ZoomValueY+ MovecamY);
   WorldInfo.Game.Broadcast(self,"Distancia X = "@ CamOffsetDistance_pitch + ZoomValueX + MovecamX);
   WorldInfo.Game.Broadcast(self,"Camera = "@ Cams);
   WorldInfo.Game.Broadcast(self,"MoveZ = "@ MovecamZ);
   WorldInfo.Game.Broadcast(self,"MoveX = "@ MovecamX);
   WorldInfo.Game.Broadcast(self,"MoveY = "@ MovecamY);
   WorldInfo.Game.Broadcast(self,"ZoomX = "@ ZoomValueX);
   WorldInfo.Game.Broadcast(self,"ZoomY = "@ ZoomValueY);
   WorldInfo.Game.Broadcast(self,"CamX = "@ CamOffsetDistance_pitch);
   WorldInfo.Game.Broadcast(self,"CamY = "@ CamOffsetDistance_yaw);
   WorldInfo.Game.Broadcast(self,"Chave1 = "@ Chave);
   WorldInfo.Game.Broadcast(self,"Chave2 = "@ Chave2);
   WorldInfo.Game.Broadcast(self,"Time = "@ time);*/




   //out_CamLoc.Z += Sin(IsoCamAngle_pitch * UnrRotToRad) * CamOffsetDistance_pitch;
	
//calculo de rotação----------------------------
   out_CamRot.Pitch = -1 * IsoCamAngle_pitch;
   out_CamRot.Yaw = IsoCamAngle_yaw;
   out_CamRot.Roll = 0;
//----------------------------------------------
   return true;
}


//função executavel de zoom In
exec function CamZoomIn()
{
	`Log("Zoom in");
	//controle para q ele não seja menor q zero
if(MovecamZ>0){
	MovecamZ=MovecamZ-ZoomSpeed; // altera a variavel Z
	// move o x e y segundo a posição correspondente do Z
//zoom para camera 1
	if(Cams == 1){
	ZoomValueX=ZoomValueX-ZoomSpeed;
	ZoomValueY=ZoomValueY-ZoomSpeed;
		
	}
//zoom para camera 2
	if(Cams == 2){
	ZoomValueX=ZoomValueX+ZoomSpeed;
	ZoomValueY=ZoomValueY+ZoomSpeed;
		}
//zoom para camera 3
	if(Cams == 3){
	ZoomValueX=ZoomValueX+ZoomSpeed;
	ZoomValueY=ZoomValueY-ZoomSpeed;
	}
//zoom para camera 4
	if(Cams == 4){
	ZoomValueX=ZoomValueX-ZoomSpeed;
	ZoomValueY=ZoomValueY+ZoomSpeed;
	}
}}

//função executavel de zoom Out
exec function CamZoomOut()
{
	`Log("Zoom out");
	//controle para q não seja maior q 600
	if(MovecamZ<1600){
		MovecamZ=MovecamZ+ZoomSpeed;//move a variavel Z
	// move o x e y segundo a posição correspondente do Z
//zoom da camera 1
	if(Cams == 1){
	ZoomValueX=ZoomValueX+ZoomSpeed;
	ZoomValueY=ZoomValueY+ZoomSpeed;
	}
//zoom da camera 2
	if(Cams == 2){
		
	ZoomValueX=ZoomValueX-ZoomSpeed;
	ZoomValueY=ZoomValueY-ZoomSpeed;
		}
//zoom da camera 3
	if(Cams == 3){
	ZoomValueX=ZoomValueX-ZoomSpeed;
	ZoomValueY=ZoomValueY+ZoomSpeed;
	}
//zoom da camera 4
	if(Cams == 4){
	ZoomValueX=ZoomValueX+ZoomSpeed;
	ZoomValueY=ZoomValueY-ZoomSpeed;
	}
	}}
//função da rotação para direita
exec function RotateLeft()
{
	`Log("Rotation Left");
	Cams = Cams +1;//muda para proxima camera
	if (Cams<1) Cams = 4; //verifica pois só tem 4 cameras
	if (Cams>4) Cams = 1; //verifica pois só tem 4 cameras
	multrot = multrot+1;  //muda o controle de rotação para cima
//	AuxZ = MovecamZ;
	//Chave = false;
	
}

exec function RotateRight()
{
	`Log("Rotation Left");
	Cams = Cams -1;//muda para camera anterior
	if (Cams<1) Cams = 4; //verifica pois só tem 4 cameras
	if (Cams>4) Cams = 1; //verifica pois só tem 4 cameras
	multrot = multrot-1;  //muda o controle de rotação para baixo
//	AuxZ = MovecamZ;
	//Chave = false;
	
}


simulated singular event Rotator GetBaseAimRotation()
{
   local rotator   POVRot, tempRot;

   tempRot = Rotation;
   tempRot.Pitch = 0;
   SetRotation(tempRot);
   POVRot = Rotation;
   POVRot.Pitch = 0;

   return POVRot;
}

defaultproperties
{
	IsoCamAngle_pitch=7282 //35.264 degrees
	IsoCamAngle_yaw=8192
	//CamOffsetDistance_pitch=500.0
	//CamOffsetDistance_yaw=850.0
	
	CamOffsetDistance_pitch=550.0
	CamOffsetDistance_yaw=550.0
	//posição camera 1
	 PosX1 = 0
	 PosY1 = 0
	//posição camera 2
	 PosX2 = -1100
	 PosY2 = -1100
	 
	//pocição camera 3
	 PosX3 = -1100
	 PosY3 = 0
	//pocição camera 4
	 PosX4 = 0
	 PosY4 = -1100
	//chaves de movimentação
	Chave = true
	Chave2 = true
	//Camera
	Cams = 1
	CamSpeed = 100
	CamSpeedRot = 500

	multrot = 0
	//variavel de movimentação segura
	MovecamX=0
	MovecamY=0
	//X,Y and Z calc base to zoom
	
	ZoomValueX =0
	ZoomValueY =0
	MovecamZ = 0
	//---------------------
	//valores do zoom
	IsoZDistance=400
	ZoomSpeed = 50

	//valores de tempo
	time_key=false //chave do tempo
	mr_rabbit=0.01 //controle do tempo
	time=0.01      //tempo inicial
}

// Lembrar www.gamedev.net/