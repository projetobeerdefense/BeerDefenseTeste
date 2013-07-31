//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 15:38
// Classe "BD_AnaoPawn" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_SecAction_SetSpawnPlace extends SequenceAction;
var Pawn inimigo;
var actor place;
function activated(){
BD_Inimigo_Controller(inimigo.controller).spawnplace = place;
}


defaultproperties
{
	ObjName="Inimigo set spawn place"
	ObjCategory="Beer Defence"
VariableLinks(0)=(ExpectedType=class'SeqVar_Object',LinkDesc="Inimigo",PropertyName=inimigo)
VariableLinks(1)=(ExpectedType=class'SeqVar_Object',LinkDesc="place",PropertyName=place)
}