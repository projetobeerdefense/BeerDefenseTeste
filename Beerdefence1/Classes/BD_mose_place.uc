class BD_mose_place extends pawn;

var actor follower;

simulated event postbeginplay(){

super.PostBeginPlay();

self.SetCollision(true,false);
 
}

function followby(actor body){
follower = body;
}


function Tick(float DeltaTime)
{
	self.SetLocation(follower.Location);

}

DefaultProperties
{
	Begin Object Class=CylinderComponent NAME=rangecylinder2
		CollideActors=true
		hiddengame =false;
        CollisionRadius=+50.000000
        CollisionHeight=+10.000000
    End Object
	Components.Add(rangecylinder2)
}
