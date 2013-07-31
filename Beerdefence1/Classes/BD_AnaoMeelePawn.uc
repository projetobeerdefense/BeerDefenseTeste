//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
// Alterado pela ultima vez em 17/05/13
//-----------------------------------------------------------

class BD_AnaoMeelePawn extends BD_anaoPawn;

//var BD_InimigoPawn alvo;

// Função chamada quando o personagem atira
var name AnimName;

// Variavel que guarda o tempo da animação que será usada para uma arma customizada
var float AnimTime;





function CleanAlvos(){
alvos.remove(0,alvos.length);
`log(self@"limpando alvos");
}

//simulated function postbeginplay(){
//settimer(10,true,'CleanAlvos');
//}

simulated function StartFire(byte FireModeNum)
{
	if(!IsActorPlayingFaceFXAnim())
	{
	// Checa se a arma é a espada 
	if(Weapon.Class == class'MyWeap_Sword')
		if(VSize(Velocity) > 100)              // Checa se o personagem está em movimento
			// Toca uma animação da metade de cima do corpo do personagem. PlayCustomAnim(nome da animação, velocidade da animação, blend in, blend out, looping, soprepor a animação)
			self.TopHalfAnimSlot.PlayCustomAnim(AnimName, 1.0, 0.55, 0.25, false, false); 

	// Se o personagem estiver parado
	else if(VSize(Velocity) < 100)
	{		
		self.FullBodyAnimSlot.PlayCustomAnim(AnimName, 1.0, 0.55, 0.25, false, false);     // Toca a animação do corpo inteiro
	}
	
	super.StartFire(FireModeNum);
	}
}


function AddDefaultInventory()
{
	MainGun = InvManager.CreateInventory(class'MyWeap_Sword');
	MainGun.SetHidden(false);
	//AddGunToSocket('WeponPoint');
	

	//
	//Weapon(MainGun).FireOffset = vect(0,0,-70);
}



event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal){
      super.Touch(Other, OtherComp, HitLocation, HitNormal);
		
	//local primitivecomponent auxcomponent;
	//auxcomponent = self.components[2];  //srangecylinder;
    if(other.isa('BD_InimigoPawn')){      
    	alvos.additem(BD_InimigoPawn(Other));
    }
	
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
	//`log("maluco funfo");
	alvos.additem(aux);

}


`log(self@"numero de alvos antes do sort"@alvos.length);
for(i=0 ; i<alvos.length ; i++){
	if(alvos[i]!= none){
		for(j=i ; j<alvos.length ;j++){
			if(alvos[j]!= none){ 

				if(vsize(self.location - alvos[i].location) >= vsize(self.location - alvos[j].location)){
				//	if(vsize(self.location - alvos[j].location) <200){
					aux = alvos[j];
					}

				else {
				//	if(vsize(self.location - alvos[i].location) <200){
					aux = alvos[i];
				//	}
				}
			}
		}
		if(aux != none && !aux.bstun){
			vaux.AddItem(aux);
		}
	}
}
alvos.remove(0,alvos.length);
alvos = vaux;
`log(self@"numero de alvos depois do sort"@alvos.length);
}




function bd_inimigopawn next(){
	
	if(alvos.length!=0){
		selectionsort();
	//	if(IsOverlapping(alvos[0])){
		return alvos[0];
	//	}else return none;
		}
		else return none;
}

event death()
{
      super.death();
      if(!bstun)
      {
          bStun = true;
		  `log("MORRIIIIIIIIIIIIIIIIIIIII"@self);
      }
}

simulated function SetCharacterClassFromInfo(class<UTFamilyInfo> Info);

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

	AnimName=espada    // Nome da animação tocada quando a arma é usada
	//bstun = false
    Begin Object class=SkeletalMeshComponent Name=meele
        SkeletalMesh=SkeletalMesh'BD_Personagens.anao.anao'

		AnimSets(0)=AnimSet'BD_Personagens.anao.anao_Anims'
        AnimTreeTemplate=AnimTree'BD_Personagens.anao.Anao_AnimTree'
		PhysicsAsset=PhysicsAsset'BD_Personagens.anao.anao_Physics'
        BlockRigidBody=true
        CollideActors=true
    End Object
	drawscale = 2
    Mesh = meele // Set The mesh for this object
    Components.remove(anao)
	Components.Add(meele) // Attach this mesh to this Actor

	Begin Object Class=CylinderComponent NAME=rangecylinder
		CollideActors=true
		hiddengame =false
        CollisionRadius=+200.000000
        CollisionHeight=+25.000000
    End Object
	Components.Add(rangecylinder)
}