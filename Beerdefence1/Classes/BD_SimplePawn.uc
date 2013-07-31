//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_SimplePawn extends UTPawn;
var SoundCue PawnHitSound; 

event TakeDamage(int Damage, Controller InstigatedBy, vector HitLocation, vector 
Momentum, class<DamageType> DamageType, optional TraceHitInfo HitInfo, optional Actor 
DamageCauser) 
{  
    PlaySound(PawnHitSound);  
    Health = Health - Damage; 
   // WorldInfo.Game.Broadcast(self,self @ " Has Taken Damage IN TAKEDAMAGE, HEALTH = " @Health@ "by" @InstigatedBy);  
	
    
    if (self.Health <= 0){ 
		self.Death();
}
} 

event Death (){
	//WorldInfo.Game.Broadcast(self,self @ " Morreu ");
}

defaultproperties
{
    
}