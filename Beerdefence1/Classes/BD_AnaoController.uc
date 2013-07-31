//-----------------------------------------------------------
// Criado por Igor Felga
// Criado em 05/10/2012 - 12:25
// Classe "BD_AnaoController" - Para o Jogo Beer Defense
//-----------------------------------------------------------

class BD_AnaoController extends BotController;
var float time;
var float time2;
var float stumtime;
var int x;
var bool preparar;
var bd_inimigopawn proxalvo;
var actor spot;
var bool vaikey;
var bool cronoskey;
var int cronos;
var int tempolimite;
var int timeclean;
var bool click;
var bool bused;
var actor themouse;
//-----------------------------------------------------------
// @@ Classe responsavel pela IA da Basica do Anao
//-----------------------------------------------------------
function voltabesta(actor goal){

	self.currentgoal = goal;
	go();
	preparar = true;
	vaikey = true;
}

function setgoal(actor buya){
	if(!bused){
		currentgoal = buya;
		bused =true;
		themouse = buya;
	}
}

function float laDistance(actor A, actor B){
	local float hip;
	local float catop;
	local float catad;
	catop = A.Location.X - B.Location.X;
	catad = A.Location.Y - B.Location.Y;
	hip = sqrt(catop*catop + catad*catad);
	return hip;
}


function clicking(){
if (click) click = false;
else click = true;
}



DefaultProperties
{
    stumtime = 3
	preparar = true
	x=0
	tempolimite = 10
	cronos = 0
	timeclean =0
}