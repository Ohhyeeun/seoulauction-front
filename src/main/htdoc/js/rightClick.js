$(document).ready(function(){
	//이미지가 들어가 있는 페이지는 전부 마우스 우클릭 방지 2022.02.04
 	document.addEventListener("contextmenu", e=> {
 		e.target.matches("img","gif","png") && e.preventDefault(); 
 	}); 
 	
 	//안드로이드 저장 막기
 	document.oncontextmenu="return false style='-webkit-touch-callout:none'";
	
	/*document.oncontextmenu= function(){return false;}*/ 
}); 