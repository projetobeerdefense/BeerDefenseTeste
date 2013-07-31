//-----------------------------------------------------------
// Classe "BD_CarrocaPawn" - Para o Jogo Beer Defense
//
// Codigo Baseado no do Livro - "Beginning iOS 3D Unreal Games Development"
// Criado por Robert Chin
//
// Modificaçõoes feita para o Jogo "Beer Defense"
// Modificado por Igor Felga
// Criado em 11/08/2012 - 16:35
//-----------------------------------------------------------
// Atualizado Por Vinicius Soares Lima em 13/11/12 16:00
//-----------------------------------------------------------
// @@ Classe responsavel pelo Pawn da Carroça
//-----------------------------------------------------------

class BD_CarrocaPawn extends UDNPawn;
var int def;
var int index;
var int maxbarriu;
var int barrlife[6];


function menosindex(){
index--;
}


simulated event TakeDamage(int Damage, Controller EventInstigator, vector HitLocation, vector Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor DamageCauser)
{
	
	local int actualDamage;
	local controller need;
	`log("e um lagarto..."@DamageCauser);
	if(DamageCauser.isa('BD_Inimigo_Lagarto_Thief_Pawn')){
	barrlife[BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).index] = barrlife[BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).index]-damage;
	if(barrlife[BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).index]<= 0){
		need = BD_Inimigo_Lagarto_Thief_Pawn(DamageCauser).controller;
		BD_Inimigo_Lagarto_Thief_Controller(need).goaway();
	}
	}
	else{
		if(DamageCauser.isa('BD_InimigoPawn')){ 
	actualDamage = Damage-def;
	if(actualDamage <1) actualDamage =1;
	Super.TakeDamage(actualDamage, EventInstigator, HitLocation, Momentum, DamageType, HitInfo, DamageCauser);
		}
	}

}

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal){
    local int cont;  
	
	super.Touch(Other, OtherComp, HitLocation, HitNormal);
		cont =0;
		//cont2=0;
	
    if(other.isa('BD_Inimigo_Lagarto_Thief_Pawn')){ 
    index ++; 
    if(index >= maxbarriu){
    index = 0;
    }
	for(cont=0; cont < 6 ; cont++){
	`log("for cont = "@cont);
		if(index < 6){
		if(barrlife[index] <= 0){
			index ++;
			//cont2++;
		}
	else{
	BD_Inimigo_Lagarto_Thief_Pawn(other).index=index;
	break;
	}
	}
	else{
		index = 0;
		//cont2++;
	}
	}
	if(cont >= 6){
	sembarris();
	}
}
}

function Sembarris(){
TriggerGlobalEventClass(class'BD_SecEvent_Over', self, 0);

}

defaultproperties
{
	def = 50;
	SupportedEvents.Add(class'BD_SecEvent_Over')
	
	Begin Object Class=SkeletalMeshComponent Name=Carroca
        SkeletalMesh=SkeletalMesh'BD_Characters.Carroca.carroca_com_animacao'
		AnimSets(0)=AnimSet'BD_Characters.Carroca.carrocaset'
        AnimTreeTemplate=AnimTree'BD_Characters.Carroca.carrocaanim'
        BlockRigidBody=true
        CollideActors=true
		Rotation=(Pitch=0,Yaw=-16383,Roll=0)// Gira a carroça 90°

    End Object
	drawscale = 2
	Begin Object Class=CylinderComponent NAME=rangecylinder
		CollideActors=true
		blockactors = true
		hiddengame =false
        CollisionRadius=+250.000000
        CollisionHeight=+25.000000
    End Object

	Components.Add(rangecylinder)

Begin Object Class=CylinderComponent NAME=betouched
		CollideActors=true
		blockactors = false
		hiddengame =false
        CollisionRadius=+300.000000
        CollisionHeight=+25.000000
    End Object
	Components.Add(betouched)
    MaxDesiredSpeed = 0.5


    Mesh = Carroca // Set The mesh for this object
	
    Components.Add(Carroca) // Attach this mesh to this Actor
	index=-1
	maxbarriu =6
	barrlife[0] = 100
	barrlife[1] = 100
	barrlife[2] = 100
	barrlife[3] = 100
	barrlife[4] = 100
	barrlife[5] = 100
	
}