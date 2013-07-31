//-----------------------------------------------------------
// Codigo retirado do livro "Beginning iOS 3D Unreal Games
// Development - Robert Chin" e adaptado para o Jogo Thor Mobile
//-----------------------------------------------------------
class MouseSel extends Actor;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
  //  WorldInfo.Game.Broadcast(self,"BotMarker Has Been Touched");
}

defaultproperties
{
      Begin Object Class=ParticleSystemComponent Name=StaticMeshComponent0
        bAutoActivate=true 
			Scale=4.0    
		//ParticleSystem'WP_ShockRifle.Particles.P_WP_ShockRifle_Ball'
		//ParticleSystem'KismetGame_Assets.Projectile.P_Spit_01'
		Template = ParticleSystem'KismetGame_Assets.Projectile.P_Spit_01'
            //Scale3D=(X=0.1,Y=0.1,Z=0.1)
			BlockRigidBody=true
			CollideActors=true
      End Object

      Components.Add(StaticMeshComponent0)
}