class BD_Weapon extends Weapon;
defaultproperties
{
Begin Object Class=staticmeshcomponent Name=FirstPersonMesh
staticmesh=StaticMesh'BD_Personagens.rifle_yucif_Joint'
End Object
Mesh=FirstPersonMesh
Components.Add(FirstPersonMesh);
Begin Object Class=staticmeshcomponent Name=PickupMesh
staticmesh=StaticMesh'BD_Personagens.rifle_yucif_Joint'
End Object
DroppedPickupMesh=PickupMesh
PickupFactoryMesh=PickupMesh
WeaponFireTypes(0)=EWFT_Projectile
WeaponFireTypes(1)=EWFT_NONE
WeaponProjectiles(0)=class'BD_BulletBase'
//WeaponProjectiles(1)=class'BD_BulletDamage'
FiringStatesArray(0)=WeaponFiring
FireInterval(0)=2.50
weaponrange = 1
Spread(0)=0
}