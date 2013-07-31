class BD_BulletMeele extends BD_BulletBase;
var float meeleradius;
function Init( Vector Direction )
{
hurtradius( bulletdamage, meeleradius, class 'damagetype', 0, self.location, InstigatorController.Pawn );
`log("InstigatorController "@InstigatorController);
self.destroy();
}
simulated singular event Touch(Actor Other, PrimitiveComponent OtherComp, vector 
HitLocation, vector HitNormal) 
{ 
  //  Other.TakeDamage(bulletdamage, InstigatorController, HitLocation, -HitNormal, None); 
}


defaultproperties
{
bulletdamage = 500
meeleradius = 100
}