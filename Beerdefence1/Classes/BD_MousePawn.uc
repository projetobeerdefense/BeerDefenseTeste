//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_mousePawn extends BD_SimplePawn;
var vector vscale;
var actor A_tocado;

simulated event postbeginplay(){
	super.PostBeginPlay();
  self.SetCollision(true,false);
  self.Mesh.SetSkeletalMesh(SkeletalMesh'Personagem.anao_UV');
  self.Mesh.SetScale(1.5);
}

function Tick(float DeltaTime)
{
local actor aux;
if(Touching.Length == 0) {
		`log("toque3");
		if(A_tocado == none){
		mouseselect(1);
		}else mouseselect(3);
	}else
{
foreach TouchingActors (class'actor', aux){
if(aux.IsA('BD_InimigoPawn')){
		//`log("toque1");
		mouseselect(4);
	}else if(aux.IsA('BD_mose_place')){
		//`log("toque2");
		mouseselect(2);
	}else {
		//`log("toque3");
		if(A_tocado == none){
		mouseselect(1);
		}else mouseselect(3);
	}
}}
  
}

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
		
}



function mouseselect(int sel){


if(sel == 1){
	self.Mesh.SetSkeletalMesh(SkeletalMesh'KismetGame_Assets.Pickups.SK_Carrot');
	self.Mesh.SetScale(1.5);
}
if(sel == 2){
	self.Mesh.SetSkeletalMesh(SkeletalMesh'Personagem.anao_UV');
	self.Mesh.SetScale(1.5);
}
if(sel == 3){
	self.Mesh.SetSkeletalMesh(SkeletalMesh'CTF_Flag_IronGuard.Mesh.S_CTF_Flag_IronGuard');
	self.Mesh.SetScale(1.5);
}
if(sel == 4){
	self.Mesh.SetSkeletalMesh(SkeletalMesh'Personagem.espada');
	self.Mesh.SetScale(1.5);
}
	}


function Selection(actor pumba)
{
A_tocado = pumba;
//`log("A_tocado " @A_tocado);
}

function int doaction(){
	local BD_mose_place aux_anao;
	local actor aux;
		
	
		//se não estiver tocando ninguem então não faz nada
	foreach TouchingActors (class'actor', aux){
		if(A_tocado == none){          //se tiver um anao selecionado e
							  //se não estiver tocando ninguem move
					
					if(aux.isA('BD_mose_place')){// se tiver tocando um outro anão muda selecao
						aux_anao = BD_mose_place(aux);
						self.Selection(aux_anao.follower);
					return 3;
					}
				}
		
		else {//se não tiver ninguem selecionado e
			 // estiver tocando alguem e
			
			if(aux.isA('BD_InimigoPawn')){  // se estiver tocando alguem da o comando de ataque
					BD_AnaoPawn(A_tocado).doAtack(BD_InimigoPawn(aux));
					return 2;
					}	
			if(aux.isA('BD_mose_place')){ // esse alguem é um anão então seleciona
					aux_anao = BD_mose_place(aux);
					self.Selection(aux_anao.follower);
					return 3;
				}
				 // se não for um anão então não faz nada
		}
		//se não estiver tocando ninguem então não faz nada
	}
		BD_AnaoPawn(A_tocado).bemoveto(self.Location);
				return 1;
	}

defaultproperties
{	
	 Begin Object Class=CylinderComponent NAME=rangecylinder2
		CollideActors=true
		hiddengame =false;
        CollisionRadius=+50.000000
        CollisionHeight=+10.000000
    End Object
	Components.Add(rangecylinder2)
	vscale=10
}