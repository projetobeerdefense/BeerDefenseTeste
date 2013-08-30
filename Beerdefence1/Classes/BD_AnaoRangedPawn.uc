//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
// Alterado pela ultima vez em 17/05/13
//-----------------------------------------------------------

class BD_AnaoRangedPawn extends BD_anaoPawn;



//var array<BD_InimigoPawn> alvos;

function CleanAlvos(){
alvos.remove(0,alvos.length);
//`log(self@"limpando alvos");
}

function bool touchthat(actor target){
local BD_InimigoPawn aux;
	foreach TouchingActors(class'BD_InimigoPawn', aux){
		if(target.IsA('BD_InimigoPawn')){
		if(aux == target) return true; 
		}
}
return false;
}

//simulated function postbeginplay(){
//settimer(10,true,'CleanAlvos');
//}

function AddDefaultInventory()
{
	MainGun = InvManager.CreateInventory(class'BD_WeaponRanged');
	MainGun.SetHidden(false);
	AddGunToSocket('one_hand_wepon');
	
	Weapon(MainGun).FireOffset = vect(0,0,-70);
}


event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
    super.Touch(Other, OtherComp, HitLocation, HitNormal);		
	//local primitivecomponent auxcomponent;
	//auxcomponent = self.components[2];  //srangecylinder;
	//`log(self@"tocou"@other);
    if(other.isa('BD_InimigoPawn')){      
    	alvos.additem(BD_InimigoPawn(Other));
    }
}

function bd_inimigopawn next(){
		if(alvos.length!=0){
		selectionsort();
		return alvos[0];
		}
		else return none;
}


function quemtaai(){
local BD_InimigoPawn aux;
//`log("super teste");
alvos.remove(0,alvos.length);
foreach TouchingActors(class 'BD_InimigoPawn', aux){
	alvos.additem(aux);
}
}


function selectionsort(){
local array<BD_InimigoPawn> vaux;
local BD_InimigoPawn aux;
local int i;
local int j;
alvos.remove(0,alvos.length);

foreach TouchingActors(class 'BD_InimigoPawn', aux){
	//`log(self @"maluco funfo");
	alvos.additem(aux);

}

`log(self@"numero de alvos antes do sort"@alvos.length);
for(i=0 ; i<alvos.length ; i++){
	if(alvos[i]!= none){
		for(j=i ; j<alvos.length ;j++){
			if(alvos[j]!= none){ 
				if(alvos[i].distance >= alvos[j].distance)
					aux = alvos[j];
				else aux = alvos[i];
			}
		}
		if(aux != none && !aux.bstun){
			vaux.AddItem(aux);
		}
	}
}
alvos.remove(0,alvos.length);
alvos = vaux;
//`log(self@"numero de alvos depois do sort"@alvos.length);
}



event death()
{
      super.death();
		
      if(!bstun)
      {
          bStun = true;

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

	 Begin Object class=SkeletalMeshComponent Name=Ranged
        SkeletalMesh=SkeletalMesh'BD_Characters.dwarf.Anão_Ranged'

		AnimSets(0)=AnimSet'BD_Characters.dwarf.Anão_Ranged_Animations'
        AnimTreeTemplate=AnimTree'BD_Characters.dwarf.Anão_Ranged_AnimTree_Weapon'
		
        BlockRigidBody=true
        CollideActors=true
    End Object
	drawscale = 2
    Mesh = Ranged // Set The mesh for this object
    Components.remove(anao)
	Components.Add(Ranged) // Attach this mesh to this Actor



	//bstun = false
   Begin Object Class=CylinderComponent NAME=rangecylinder
		CollideActors=true
		hiddengame =false;
        CollisionRadius=+1100.000000
        CollisionHeight=+25.000000
    End Object
	Components.Add(rangecylinder)
	
}