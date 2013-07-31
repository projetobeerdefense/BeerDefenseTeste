//-----------------------------------------------------------
// Codigo retirado do livro "Beginning iOS 3D Unreal Games
// Development - Robert Chin" e adaptado para o Jogo Thor Mobile
//-----------------------------------------------------------
class MouseMark extends Actor;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
 //   WorldInfo.Game.Broadcast(self,"BotMarker Has Been Touched");
}


defaultproperties
{      

      Begin Object Class=ParticleSystemComponent Name=move
        bAutoActivate=true 
			
			Scale=3 
		//ParticleSystem'Pickups.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle'
		Template = ParticleSystem'Pickups.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle'
            //Scale3D=(X=0.1,Y=0.1,Z=0.1)
			BlockRigidBody=true
			CollideActors=true
      End Object
	  /*
	Begin Object Class=ParticleSystemComponent Name=select
        bAutoActivate=true 
			Scale=4.0    
		//ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
		Template = ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
            //Scale3D=(X=0.1,Y=0.1,Z=0.1)
			BlockRigidBody=true
			CollideActors=true
      End Object
	  
	Begin Object Class=ParticleSystemComponent Name=normal
        bAutoActivate=true 
			Scale=3.0    
		Template = ParticleSystem'Pickups.Health_Large.Effects.P_Pickups_Base_Health_Glow'
            //Scale3D=(X=0.1,Y=0.1,Z=0.1)
			BlockRigidBody=true
			CollideActors=true
      End Object
	  */
	Components.Add(move);
     
	
	
}