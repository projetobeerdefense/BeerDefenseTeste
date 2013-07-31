class inimigo extends UDKBot;

//Classe para testar a funcionalidade do Git

var int iHealth;
var vector vPosition;

simulated function PostBeginPlay()
{
	super.PostBeginPlay();
	`log('teste');
}

defaultproperties
{
	iHealth=100
}