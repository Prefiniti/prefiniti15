<link href="css/gecko.css" rel="stylesheet" type="text/css">

<div style="padding-left:30px;"  id="framework_status"></div>
<div style="padding-left:30px;" id="statTarget"></div>	

<div style="padding-left:20px;">
<table width="800">
	<tr>
    	<td style="padding:10px;" valign="top" width="240">
        	<div style="background-color:#EFEFEF; width:220px; height:400px; -moz-border-radius:5px; padding:5px;">
        	    <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/LandingSite/business.html');">Link 1</a>
            </div>
		</td>
        
        <td valign="top" style="padding-top:10px;">
        	<div id="tcTarget">
            
            </div>
        </td>
	</tr>  
</table>                      
</div>
	
<cfoutput>
	<script language="javascript">
		
		<cfif IsDefined("url.contentBar")>
		loadContentBar('#URL.contentBar#');
		</cfif>
		shiftOpacity('plogo', 6000);
	</script>
</cfoutput>    