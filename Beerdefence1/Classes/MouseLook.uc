//-----------------------------------------------------------
// Codigo retirado do livro "Beginning iOS 3D Unreal Games
// Development - Robert Chin" e adaptado para o Jogo Thor Mobile
//-----------------------------------------------------------
class MouseLook extends actor;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
    WorldInfo.Game.Broadcast(self,"BotMarker Has Been Touched");
}

defaultproperties
{
		 Begin Object Class=ParticleSystemComponent Name=move
        bAutoActivate=true 
			
			//Scale=3 
		//ParticleSystem'Pickups.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle'
		Template = ParticleSystem'Pickups.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle'
            //Scale3D=(X=0.1,Y=0.1,Z=0.1)
			BlockRigidBody=false
			CollideActors=false
			
      End Object

  //  	Begin Object Class=CylinderComponent NAME=mouselookcin
		//CollideActors=false
		//BlockRigidBody=false
		//hiddengame =false
  //      CollisionRadius=+200.000000
  //      CollisionHeight=+25.000000
		
		//End Object
		//Components.Add(mouselookcin)
}