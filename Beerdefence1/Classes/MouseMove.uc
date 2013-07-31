//-----------------------------------------------------------
// Codigo retirado do livro "Beginning iOS 3D Unreal Games
// Development - Robert Chin" e adaptado para o Jogo Thor Mobile
//-----------------------------------------------------------
class MouseMove extends Actor;

var string Mname;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
 //   WorldInfo.Game.Broadcast(self,"BotMarker Has Been Touched");
}


defaultproperties
{
      //Mname= 'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
	  
	Begin Object Class=SkeletalMeshComponent Name=select
   ////     bAutoActivate=true 
			////Scale=4.0    
		//ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
		//Template = ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
		SkeletalMesh=SkeletalMesh'Personagem.anao_UV'
            Scale3D=(X=3,Y=3,Z=3)
			BlockRigidBody=false
			CollideActors=false
      End Object
	  
	
	  Components.Add(select);
     
}