<div id="stdUpload">
</div>

<div id="degUpload">
</div>
<div id="uploadWrapper" style="background-color:#EFEFEF; border:1px solid silver; display:none; position:absolute; z-index:300; left:100px; top:100px; height:auto; width:367px;">
	<table width="100%" border="0" cellspacing="0">
	<tr><th align="left" id="gMsgTitle">Upload Status</th><th align="right"><a href="javascript:hideDiv('uploadWrapper');"><img src="/graphics/cross.png" border="0"></a></th></tr></table>
    <div id="ulProgress">
    	
    </div>
    <center>
    <input type="button" class="normalButton" id="test" name="test" onclick="glob_uploader.startUpload();" value="Start Upload">
   	<input type="button" class="normalButton" id="cancelFUpload" value="Cancel Uploads" onclick="cancelQueue(glob_uploader);">
    </center>
</div>
