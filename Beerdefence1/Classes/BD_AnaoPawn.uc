//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_AnaoPawn extends BD_SimplePawn;

var bool bStun;         //Variavel para controlar se anão está atordoado
var int def;
var int str;
var int agi;
var int cons;
var int wis;
var int maxhealth;

var float time;

var bool inisel;

var Inventory MainGun;
var array<BD_InimigoPawn> alvos;

//-----------------------------------------------------------------------
// Event death()
// Metodo que toma conta das ação dadas quando o Anão
// entra no estado "Morto"
//-----------------------------------------------------------------------

function CleanAlvos(){
	alvos.remove(0,alvos.length);
`log(self@"limpando alvos");
}
simulated function StartFire(byte FireModeNum){
	//local BD_AnaoController aux;
super.startfire(FireModeNum);
BD_AnaoController(controller).stop();
}

simulated function StopFire(byte FireModeNum)
{
	//local BD_AnaoController aux;
super.stopfire(FireModeNum);
BD_AnaoController(controller).go();
}


function AddGunToSocket(Name SocketName)
{
	local Vector SocketLocation;
	local Rotator SocketRotation;
    
	if (Mesh != None)
	{
        if (Mesh.GetSocketByName(SocketName) != None)
	{
	Mesh.GetSocketWorldLocationAndRotation(SocketName, SocketLocation,SocketRotation);
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


function bd_inimigopawn next()
{
		
}


//event death()
//{
//      super.death();
		
//      if(!bstun)
//      {
//          bStun = true;

//      }
//}

//base do sistema de defesa do personagem
simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	local int actualDamage;
	actualDamage = Damage-def;
	if(actualDamage <1) actualDamage =1;
	if(!EventInstigator.IsA('BD_AnaoController')){
	Super.TakeDamage(actualDamage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
	}
}

function update_maxhealth(){
	local int aux;
	aux = 200+(cons*0.7+agi*0.3+str*0.1);
	if(maxhealth != aux){
		maxhealth = aux;
	`log("novo maxhealth:"@self.maxhealth);
	}
	}

	

defaultproperties
{
	
	//defesa basica
	def = 20
	//atributos basicos
	str = 10
	agi = 10
	cons = 10
	wis =10
	//vida inicial
	maxhealth = 200+(cons*0.7+agi*0.3+str*0.1)
	health = 150

	time = 0.0
	//bstun = false
    Begin Object class=SkeletalMeshComponent Name=Anao
        SkeletalMesh=SkeletalMesh'KismetGame_Assets.Anims.SK_Jazz'

		AnimSets(0)=AnimSet'KismetGame_Assets.Anims.SK_Jazz_Anims'
        AnimTreeTemplate=AnimTree'KismetGame_Assets.Anims.Jazz_AnimTree'

        BlockRigidBody=true
        CollideActors=true
    End Object
	
    Mesh = Anao; // Set The mesh for this object
    Components.Add(Anao); // Attach this mesh to this Actor
	 // Collision Component for This actor
    Begin Object Class=CylinderComponent NAME=CollisionCylinder2
        //blockactors = true
		CollideActors=true
        CollisionRadius=+25.000000
        CollisionHeight=+40.000000
    End Object
	 CollisionComponent=CollisionCylinder2
   // CylinderComponent=CollisionCylinder2
    Components.Add(CollisionCylinder2)

	bCanBeDamaged = false 
	
}