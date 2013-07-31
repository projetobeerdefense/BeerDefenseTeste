//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_Inimigo_Lagarto_Thief_Pawn extends BD_InimigoPawn;
var int index;
var bool atacking;
var actor outro;
var int tempo;
var int tempolimite;
var AnimNodeSlot ANS;
event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal){
    super.Touch(Other, OtherComp, HitLocation, HitNormal);
		
    if(other.isa('BD_CarrocaPawn')){
		atacking = true;
		outro = other;
    //BD_CarrocaPawn(Other).TakeDamage(10, Controller, HitLocation, -HitNormal, None,hitinfo, misterx);
	//FullBodyAnimSlot.PlayCustomAnim('bite', 1.0, 0.55, 0.25, false, true);
    }	
}

simulated function tick(float deltatime){
if(atacking){
if(WorldInfo.TimeSeconds - tempo >= tempolimite){
	atack();
	tempo = WorldInfo.TimeSeconds;
		}
}
}

simulated function PostInitAnimTree(SkeletalMeshComponent SkelComp)
{
  super.PostInitAnimTree(SkelComp);
  
  ANS = AnimNodeSlot(Mesh.FindAnimNode('FullBodySlot'));
}
function actor findbackspot()
{
	local note aux;

	foreach worldInfo.AllActors(class'Note', aux)
		{
			
				return aux;
			
		}
}
function atack(){
	local tracehitinfo hitinfo;  
	local BD_Inimigo_Lagarto_Thief_Pawn misterx;
	local vector hitlocation;
	local vector hitnormal;
	
	misterx = self;
	BD_CarrocaPawn(outro).TakeDamage(5, Controller, HitLocation, -HitNormal, None,hitinfo, misterx);
	ANS.PlayCustomAnim('mutant_punch_1', 1.5, 0.15, 0.0, false, true);
}

defaultproperties
{
	def = 20
    tempo = 0
	tempolimite = 5
	Begin Object class=SkeletalMeshComponent Name=Thief
        SkeletalMesh=SkeletalMesh'BD_Characters.Rato.Rato'
		AnimSets(0)=AnimSet'BD_Characters.Rato.Rato_Anims'
        AnimTreeTemplate=AnimTree'BD_Characters.Rato.Rato_AnimTree'

        BlockRigidBody=true
        CollideActors=true
    End Object
	drawscale = 15

    Mesh = Thief // Set The mesh for this object
	Components.remove(inimigo)
    Components.Add(Thief) // Attach this mesh to this Actor
	
	//CollisionComponent=CollisionCylinder2
    //CylinderComponent=CollisionCylinder2
    //Components.Add(CollisionCylinder2)
}