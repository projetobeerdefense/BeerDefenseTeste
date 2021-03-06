class BD_BulletBase extends Projectile;
var int bulletdamage;

simulated function Explode(vector HitLocation, vector HitNormal)
{
}

simulated singular event Touch(Actor Other, PrimitiveComponent OtherComp, vector 
HitLocation, vector HitNormal) 
{ 
    Other.TakeDamage(bulletdamage, InstigatorController, HitLocation, -HitNormal, None);
	self.Destroy();
	//`log( killer );
}

function Init( Vector Direction )
{
local vector NewDir;
NewDir = Normal(Vector(InstigatorController.Pawn.Rotation));
Velocity = Speed * NewDir;
}
defaultproperties
{
bulletdamage = 75
Begin Object Class=StaticMeshComponent Name=Bullet
StaticMesh=StaticMesh'EngineMeshes.Sphere'
Scale3D=(X=0.050000,Y=0.050000,Z=0.05000)
End Object
Components.Add(Bullet)
Begin Object Class=ParticleSystemComponent Name=BulletTrail
Template=ParticleSystem'Castle_Assets.FX.P_FX_Fire_SubUV_01'
End Object
Components.Add(BulletTrail)
MaxSpeed=+05000.000000
Speed=+05000.000000
}