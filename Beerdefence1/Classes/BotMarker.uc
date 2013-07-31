//-----------------------------------------------------------
// Codigo retirado do livro "Beginning iOS 3D Unreal Games
// Development - Robert Chin" e adaptado para o Jogo Thor Mobile
//-----------------------------------------------------------
class BotMarker extends Actor;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
    `log(self@"BotMarker Has Been Touched");
}

defaultproperties
{
      Begin Object Class=SkeletalMeshComponent Name=StaticMeshComponent0
            SkeletalMesh=SkeletalMesh'Personagem.anao_UV';
            Scale3D=(X=3.0,Y=3.0,Z=3.0)
			BlockRigidBody=false
			CollideActors=false
			
      End Object
		bhidden = true

      Components.Add(StaticMeshComponent0)
}