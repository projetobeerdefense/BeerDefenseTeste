class MyAttachment_Sword extends UTWeaponAttachment;
var vector hitlocation, hitnormal, traceEnd, traceStart;
// verifica se o personagem est� atacando para executar o trace
simulated function Tick(float DeltaTime)
{
    super.Tick(DeltaTime);
	
    
	Mesh.GetSocketWorldLocationAndRotation ('StartControl', traceStart);                     // posi��o inicial do tra�ado
    Mesh.GetSocketWorldLocationAndRotation ('EndControl', traceEnd);   
	drawdebugline(traceStart, traceEnd, 255,0,0);
    if(MyWeap_Sword(UTPawn(Instigator).Weapon).bAttacking == true)
    {
          MeleeAttack();
    }
}

// cria o trace (tra�ado) do ataque
simulated function MeleeAttack()
{
     local actor traced;

     

     local pawn hitpawn;

     Mesh.GetSocketWorldLocationAndRotation ('StartControl', traceStart);                     // posi��o inicial do tra�ado
     Mesh.GetSocketWorldLocationAndRotation ('EndControl', traceEnd);                          // posi��o final do tra�ado
     drawdebugline(traceStart, traceEnd, 255,0,0);                                             // cria uma linha da cor determinada no jogo para determinar o tra�ado

     // cria o tra�ado
		traceStart.x =traceStart.x +25;
		traceEnd.x =traceEnd.x +25;
     Foreach TraceActors(class'actor', traced, hitlocation, hitnormal, traceEnd, traceStart, vect(10,10,10))
     {
		// se o tra�ado atingir um Pawn diferente do player
		if(traced != Owner && Pawn(traced) != none && Pawn(traced).isa('BD_InimigoPawn')/* && TopHalfAnimSlot.bIsPlayingCustomAnim*/)
		{
			hitpawn = Pawn(traced);

			hitpawn.TakeDamage(500, Controller(Owner), hitlocation,  Normal((Traced.Location - Owner.Location)) * 10000, class'UTDmgType_ShockBall');         // cria o dano
			PlayHitSound();                                                                                                                                  // ativa o som do hit
			WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'T_FX.Effects.P_FX_Bloodhit_Corrupt_Far',Hitlocation,, Traced);                               // cria as particulas do ataque
			MyWeap_Sword(UTPawn(Instigator).Weapon).bAttacking = false;
		}
    }

		traceStart.x =traceStart.y +25;
		traceEnd.x =traceEnd.y +25;
     Foreach TraceActors(class'actor', traced, hitlocation, hitnormal, traceEnd, traceStart, vect(10,10,10))
     {
		// se o tra�ado atingir um Pawn diferente do player
		if(traced != Owner && Pawn(traced) != none && Pawn(traced).isa('BD_InimigoPawn')/* && TopHalfAnimSlot.bIsPlayingCustomAnim*/)
		{
			hitpawn = Pawn(traced);

			hitpawn.TakeDamage(500, Controller(Owner), hitlocation,  Normal((Traced.Location - Owner.Location)) * 10000, class'UTDmgType_ShockBall');         // cria o dano
			PlayHitSound();                                                                                                                                  // ativa o som do hit
			WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'T_FX.Effects.P_FX_Bloodhit_Corrupt_Far',Hitlocation,, Traced);                               // cria as particulas do ataque
			MyWeap_Sword(UTPawn(Instigator).Weapon).bAttacking = false;
		}
    }

		traceStart.x =traceStart.x -50;
		traceEnd.x =traceEnd.x -50;

	Foreach TraceActors(class'actor', traced, hitlocation, hitnormal, traceEnd, traceStart, vect(10,10,10))
		{
		// se o tra�ado atingir um Pawn diferente do player
		if(traced != Owner && Pawn(traced) != none && Pawn(traced).isa('BD_InimigoPawn')/* && TopHalfAnimSlot.bIsPlayingCustomAnim*/)
		{
			hitpawn = Pawn(traced);

			hitpawn.TakeDamage(500, Controller(Owner), hitlocation,  Normal((Traced.Location - Owner.Location)) * 10000, class'UTDmgType_ShockBall');         // cria o dano
			PlayHitSound();                                                                                                                                  // ativa o som do hit
			WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'T_FX.Effects.P_FX_Bloodhit_Corrupt_Far',Hitlocation,, Traced);                               // cria as particulas do ataque
			MyWeap_Sword(UTPawn(Instigator).Weapon).bAttacking = false;
		}
    }


		traceStart.x =traceStart.y -50;
		traceEnd.x =traceEnd.y -50;

	Foreach TraceActors(class'actor', traced, hitlocation, hitnormal, traceEnd, traceStart, vect(10,10,10))
		{
		// se o tra�ado atingir um Pawn diferente do player
		if(traced != Owner && Pawn(traced) != none && Pawn(traced).isa('BD_InimigoPawn')/* && TopHalfAnimSlot.bIsPlayingCustomAnim*/)
		{
			hitpawn = Pawn(traced);

			hitpawn.TakeDamage(500, Controller(Owner), hitlocation,  Normal((Traced.Location - Owner.Location)) * 10000, class'UTDmgType_ShockBall');         // cria o dano
			PlayHitSound();                                                                                                                                  // ativa o som do hit
			WorldInfo.MyEmitterPool.SpawnEmitter(ParticleSystem'T_FX.Effects.P_FX_Bloodhit_Corrupt_Far',Hitlocation,, Traced);                               // cria as particulas do ataque
			MyWeap_Sword(UTPawn(Instigator).Weapon).bAttacking = false;
		}
    }
}

// cria o som do impacto do ataque
simulated function PlayHitSound()
{
    local SoundCue HitSound;
	HitSound = SoundCue'A_Vehicle_Scorpion.SoundCues.A_Vehicle_Scorpion_BladeBreakOff';
	PlaySound(HitSound, false, true,,, true);
}


event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation1, vector HitNormal1){
      super.Touch(Other, OtherComp, HitLocation1, HitNormal1);
		
	`log("espada tocando em algo");
    if(other.isa('BD_InimigoPawn') && MyWeap_Sword(UTPawn(Instigator).Weapon).bAttacking){      
    	Other.TakeDamage(5000, Instigator.Controller, HitLocation1, -HitNormal, None);
    }
	
}


defaultproperties
{
    // cria a arma na camera de terceira pessoa
	Begin Object Name=SkeletalMeshComponent0
		SkeletalMesh=SkeletalMesh'personagem.espada'       // skeletalmesh da arma
		Scale=1.0                                                             // altera o tamanho da arma
		//Rotation=(Pitch=-3000, Yaw=16384)                                     // rotaciona a arma (neste caso est� em 90 graus no eixo Y)
	End Object
	
	Begin Object Class=CylinderComponent NAME=CollisionCylinder25
		CollideActors=true
        CollisionRadius=+25.000000
        CollisionHeight=+60.000000
		End Object
			CollisionComponent=CollisionCylinder25
			Components.Add(CollisionCylinder25)
    

	WeapAnimType=EWAT_DualPistols                                             // especifica o tipo de anima��o que vai ser chamada no animtree

	WeaponClass=class'MyWeap_Sword'                                           // classe da arma que est� usando este attachment
}
