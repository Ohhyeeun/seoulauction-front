//무보증 표시 팝업 
function PopupGuarantee(elem){
	var lot_no = $(elem).attr("data-lotno"); 
	var guarantee_popup = document.getElementById("auctionList_guarantee"+lot_no); 
	guarantee_popup.classList.toggle("show");        
}
function aucListPopup_open01(elem){
	var lot_no = $(elem).attr("data-lotno");
	document.getElementById("auctionList_guarantee"+lot_no).style.display = "block";  
}
function aucListPopup_close01(elem){    
	var lot_no = $(elem).attr("data-lotno"); 
	document.getElementById("auctionList_guarantee"+lot_no).style.display = "none";    
}  
//무가 표시 팝업     
function Popupmoney(elem){  
	var lot_no = $(elem).attr("data-lotno");
	var money_popup = document.getElementById("auctionList_money"+lot_no);   
	money_popup.classList.toggle("show");       
}   
function aucListPopup_open02(elem){
	var lot_no = $(elem).attr("data-lotno");
	document.getElementById("auctionList_money"+lot_no).style.display = "block";    
}
function aucListPopup_close02(elem){  
	var lot_no = $(elem).attr("data-lotno");
	document.getElementById("auctionList_money"+lot_no).style.display = "none";           
} 

