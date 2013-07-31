//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_InimigoPawn extends BD_SimplePawn;

var Inventory MainGun;
var vector InitialLocation;
var int def;
var int distance;
var bool bStun;

simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local int actualDamage;
	actualDamage = Damage-def;
	if(actualDamage <1) actualDamage =1;
	Super.TakeDamage(actualDamage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
}


simulated singular event Rotator GetBaseAimRotation()
{
local rotator TempRot;
TempRot = Rotation;
TempRot.Pitch = 0;
SetRotation(TempRot);
return TempRot;
}

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	local BD_PlayerController pcontroller;
	
	pcontroller = BeerDefenceGame(WorldInfo.Game).joyfulPlayerController;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);		
	//if(Other.IsA('MouseSel')){
	//	`log("toque");
	//	pcontroller.canatak = true;
	//	pcontroller.exemplo = self;
	//}
}

simulated function playdying(class<damagetype> damagetype, vector hitloc)
{

mesh.setactorcollision(false, false);
cylindercomponent.setactorcollision(false, false);

}

event untouch(actor other){
if(other.isa('BD_CarrocaPawn')){
BD_CarrocaPawn(other).menosindex();
}
}

event death()
{
      super.death();
	  if(!bstun)
      {
          bStun = true;
		
      }	
	  self.destroy();
}


function AddGunToSocket(Name SocketName)
{
	local Vector SocketLocation;
	local Rotator SocketRotation;
    
	if (Mesh != None)
	{
        if (Mesh.GetSocketByName(SocketName) != None)
{
Mesh.GetSocketWorldLocationAndRotation(SocketName, SocketLocation,
SocketRotation);
MainGun.SetRotation(SocketRotation);
MainGun.SetBase(Self,, Mesh, SocketName);
}
else
{
`log(self@"!!!!!!SOCKET NAME NOT FOUND!!!!!");
}
}
else
{
`log(self@"!!!!!!MESH NOT FOUND!!!!!");
}
}
function AddDefaultInventory()
{
MainGun = InvManager.CreateInventory(class'BD_Weapon');
MainGun.SetHidden(false);
AddGunToSocket('Weapon_R');
Weapon(MainGun).FireOffset = vect(0,0,-70);
}

defaultproperties
{
	def = 20
    Begin Object class=SkeletalMeshComponent Name=Inimigo
        SkeletalMesh=SkeletalMesh'KismetGame_Assets.Anims.SK_Jazz'

		AnimSets(0)=AnimSet'KismetGame_Assets.Anims.SK_Jazz_Anims'
        AnimTreeTemplate=AnimTree'KismetGame_Assets.Anims.Jazz_AnimTree'

        BlockRigidBody=true
        CollideActors=true
    End Object
    Mesh = Inimigo; // Set The mesh for this object
    Components.Add(Inimigo); // Attach this mesh to this Actor

	  Begin Object Class=CylinderComponent NAME=CollisionCylinder72
        blockactors = true
		CollideActors=true
        CollisionRadius=+25.000000
        CollisionHeight=+40.000000
    End Object
	 CollisionComponent=CollisionCylinder72
   // CylinderComponent=CollisionCylinder2
    Components.Add(CollisionCylinder72)

	 Begin Object Class=CylinderComponent NAME=rangecylinder2
		CollideActors=true
		hiddengame =false;
        CollisionRadius=+150.000000
        CollisionHeight=+25.000000
    End Object
	Components.Add(rangecylinder2)
}