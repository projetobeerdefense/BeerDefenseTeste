//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_mousePawn extends BD_SimplePawn;

event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal)
{
	local BD_PlayerController pcontroller;
	
	pcontroller = BeerDefenceGame(WorldInfo.Game).joyfulPlayerController;
    super.Touch(Other, OtherComp, HitLocation, HitNormal);		
	if(Other.IsA('BD_InimigoPawn')){
		`log("toque");
		//pcontroller.canatak = true;
	//	pcontroller.exemplo = BD_InimigoPawn(Other);
	}
		
}

function mouseselect(int sel){
local ParticleSystem part1;
local ParticleSystem part2;
local ParticleSystem part3;



part1 = ParticleSystem'KismetGame_Assets.Projectile.P_Spit_01';
part2 = ParticleSystem'Pickups.Base_Teleporter.Effects.P_Pickups_Teleporter_Base_Idle';
part3 = ParticleSystem'KismetGame_Assets.Projectile.P_Spit_01';
if(sel == 1){
worldinfo.MyEmitterPool.SpawnEmitter(part1,self.Location);
worldinfo.MyEmitterPool.SetLocation(self.Location);

}
if(sel == 2){
worldinfo.MyEmitterPool.SpawnEmitter(part2,self.Location);
worldinfo.MyEmitterPool.SetLocation(self.Location);
}
if(sel == 3){
worldinfo.MyEmitterPool.SpawnEmitter(part3,self.Location);
worldinfo.MyEmitterPool.SetLocation(self.Location);
}
	}

defaultproperties
{	
	 Begin Object Class=CylinderComponent NAME=rangecylinder2
		CollideActors=true
		hiddengame =false;
        CollisionRadius=+150.000000
        CollisionHeight=+10.000000
    End Object
	Components.Add(rangecylinder2)
	
}