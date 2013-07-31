class MyWeap_Sword extends UTWeapon;

var bool bAttacking; 

// verifica se o personagem está atacando
simulated function Tick(float DeltaTime)
{
	if(UTPlayerController(UTPawn(Instigator).Controller).bBehindView || UTBot(Instigator.Controller) != none)
	{
		if(!BD_AnaoMeelePawn(Instigator).TopHalfAnimSlot.bIsPlayingCustomAnim)
		DisableAttack();
	}
}

// executa o ataque quando o jogador usa o primeiro tiro da arma
//simulated function CustomFire()
//{
//	// se a visão for de terceira pessoa, executa a animação do personagem
//	if(UTPlayerController(UTPawn(Instigator).Controller).bBehindView || UTBot(Instigator.Controller) != none)
//		UTPawn(Instigator).TopHalfAnimSlot.PlayCustomAnim('hoverboardjumprtstart', 1.0, 0.35, 0.35, false, true);   // para esta animação é necessário o node TopHalfAnimSlot no animtree igual ao do personagem do UDK

//	// se a camera for de primeira pessoa, executa a animação da arma
//	else
//	{
//		PlayWeaponAnimation(WeaponFireAnim[CurrentFireMode],FireInterval[CurrentFireMode]);   // verifica a animação da arma e o tempo de intervalo do ataque para tocar a animação 
//		SetTimer(FireInterval[CurrentFireMode],false,'DisableAttack');                        // calcula o tempo de intervado do ataque para desabilitar o trace
//	}
//	bAttacking = true;
//	PlayAttackSound();                                                                        // ativa o som do ataque
//}

// faz com que a arma não gaste munição
function ConsumeAmmo(byte FireModeNum)
{
	bAttacking = true;
}


event Touch(Actor Other, PrimitiveComponent OtherComp, vector HitLocation, vector HitNormal){
      super.Touch(Other, OtherComp, HitLocation, HitNormal);
		
	`log("espada tocando em algo");
    if(other.isa('BD_InimigoPawn') && self.bAttacking){      
    	Other.TakeDamage(5000, Instigator.Controller, HitLocation, -HitNormal, None);
    }
	
}

// desabilita o trace
simulated function DisableAttack()
{
	bAttacking = false;
}

// cria o som do ataque
simulated function PlayAttackSound()
{
	local SoundCue AttackSound;
	AttackSound = SoundCue'A_Character_Footsteps.FootSteps.A_Character_Footstep_DirtJumpCue';
	PlaySound(AttackSound, false, true,,, true);
}

defaultproperties
{
	Begin Object class=AnimNodeSequence Name=MeshSequenceA
		bCauseActorAnimEnd=true
	End Object

      // cria a arma na camera de primeira pessoa
      Begin Object Name=FirstPersonMesh
            SkeletalMesh=SkeletalMesh'personagem.espada'                         // skeletalmesh da arma
            FOV=60.0                                                             // foco de visão da arma
            Scale=1.0                                                            // tamanho da arma
			//Translation=(X=30.0,Y=5.0,Z=-10.0)                                   // altera o local da arma
            //AnimSets(0)=AnimSet'GDC_Materials.Meshes.SwordAnimset'               // animações do AnimSet da arma 
			//Animations=MeshSequenceA
      End Object
      
      WeaponFireAnim(0)=Slice_01                                                 // animação do ataque da arma
    
      AttachmentClass=class'MyAttachment_Sword'                                  // classe do attachment da arma em terceira pessoa
      
      // mesh da arma quando é dropada
      Begin Object Name=PickupMesh
            SkeletalMesh=SkeletalMesh'personagem.espada'      // skeletalmesh da arma
      End Object

  //    Begin Object Class=CylinderComponent NAME=CollisionCylinder25
		//CollideActors=true
  //      CollisionRadius=+25.000000
  //      CollisionHeight=+60.000000
		//End Object
		//	CollisionComponent=CollisionCylinder25
		//	Components.Add(CollisionCylinder25)
    
	
		FireInterval(0)=+1.8                                                      // tempo entre os ataques

      //FiringStatesArray(0)=Attack
      FiringStatesArray(1)=Active                                                // faz com que a arma não despare o segundo tiro

	  //WeaponFireTypes(0)=EWFT_Custom                                             // cria um tipo customizável de tiro
      
      AmmoCount=1                                                                // munição inicial da arma
      MaxAmmoCount=1                                                             // munição máxima que a arma suporta

      EquipTime=+0.6                                                             // tempo para equipar a arma
      PutDownTime=+0.45                                                          // tempo para trocar a arma

	 
}