var nextToClose;
nextToClose=null;
	
function showDivC(which) 
{
	var imgOld;
	var imgNew;
	
	if (nextToClose != null) {
		imgOld = nextToClose + "Btn";
		document.getElementById(imgOld).style.backgroundColor="#EFEFEF";
		if (document.getElementById("KeepTabsOpen").checked == false) {
			document.getElementById(nextToClose).style.display="none";
		}
	}
	imgNew = which + "Btn";
	document.getElementById(imgNew).style.backgroundColor="#EFEFEF";
	
	document.getElementById(which).style.left="0px";//findPosX(AjaxGetElementReference(which + 'Btn')) + "px";
	document.getElementById(which).style.top=findPosY(AjaxGetElementReference(which + 'Btn'))+20 + "px";
	
	document.getElementById(which).style.display="inline";
	nextToClose=which;
	soundManager.play('click');
}
function hideDivC(which) 
{
	soundManager.play('click');
	document.getElementById(which).style.display="none";
	
	
}
function SwapShown(which)
{
	if (document.getElementById(which).style.display == "none") {
		showDivC(which);
	}
	else {
		hideDivC(which);
	}
}