<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/contentmanager/cm_udf.cfm">
<cfoutput>
<!--
<wwafcomponent>#getLongname(url.user_id)#'s Photos</wwafcomponent>
-->
</cfoutput>


<!---<cfinclude template="/customtags/fraction.cfm">--->
<cfparam name="uname" default="">
<cfparam name="pc" default="">
<cfparam name="p_url" default="">
<cfset pc=cmsGetUserFiles(#url.user_id#)>

<cfparam name="maxImageHeight" default="0">
<cfparam name="imgInfo" default="">
<cfset imgInfo=StructNew()>

<!---<cfoutput query="pc">
	<cfif basedir EQ "profile_images">
        <cfimage action="info" source="#cmsUserFileURL(id)#" structname="imgInfo">
    
        <cfif imgInfo.height GT maxImageHeight>
            <cfset maxImageHeight="#imgInfo.height#">
        </cfif>
	</cfif>
</cfoutput> 

<cfset maxImageHeight=Round((imgInfo.height / imgInfo.width) * 200)+50>--->


<cfoutput>
	
    <table width="100%">
    <tr>
    <td align="left" valign="top">
	<div style="width:100%; height:120px; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat;">
    <h3 class="stdHeader" style="margin-bottom:0px;"><img src="/graphics/globe-compass-48x48.png" align="top"> #getLongname(url.user_id)#'s Photos</h3>
	
    </div>
    </td>
    <td align="right">
    	<cfif url.allow_edit EQ true>
    	<cfmodule template="/contentmanager/components/quota_check.cfm" user_id="#url.user_id#">
        </cfif>
	</td>        
    </tr>
    </table>
    
    <div style="padding-left:10px; padding-top:0px; clear:both;"><strong><a href="javascript:viewProfile(#url.user_id#);">Return to profile</a><cfif #url.allow_edit# EQ true>
    <!---function prepareUploader(filter, filter_description, mode, user_id, dest_folder)--->
    <cfif getQuotaUsed(url.user_id) LT 100>| <a href="javascript:cmsPrepareUploader('*.jpg;*.gif;*.png', 'Image Files', 'user', '#url.current_site_id#', '#url.user_id#', 'profile_images', '');">Upload photo</a><div id="browseButton" style="display:none;"><input type="button"  onclick="glob_uploader.selectFiles();" class="normalButton" value="Browse Files" /></div>
    <cfelse>
    	&nbsp;| <strong style="color:red;">Disk quota exceeded.</strong>
	</cfif>        
</cfif></strong></div>
    
</cfoutput>

<div style="padding-left:30px;" id="userActionTarget">
    
</div>

<hr>

<cfif pc.RecordCount EQ 0>
	<strong>No pictures.</strong>
</cfif>

<cfoutput query="pc">
	<cfif basedir EQ "profile_images">
    	<cfimage action="info" source="#cmsUserFilePath(id)#" structname="imgInfo">
		<cfset p_url=cmsUserFileURL(id)>
		<cfparam name="hide_delete" default="">
        <cfif url.calledByUser NEQ #user_id#>
        	<cfset hide_delete=true>
        <cfelse>
        	<cfset hide_delete=false>
		</cfif>            
        <div style="margin:10px; padding:8px; background-color:##EFEFEF; -moz-border-radius:5px; width:200px; float:left;" id="fileLine_#id#" onclick="cmsSelectFile(#id#, 'user', #hide_delete#);">
	
    
    
    <div style="height:220px; clear:both;">
    <!---<cfimage action="info" source="#p_url#" structname="imgInfo">--->
    
    
    <cfimage source="#cmsUserFilePath(id)#" name="myImage">
	<!--- Turn on antialiasing to improve image quality. --->
    <cfset ImageSetAntialiasing(myImage,"on")>
    <cfset ImageScaleToFit(myImage,200,200, "NEAREST")>
    <!--- Display the modified image in a browser. --->

    <cfimage source="#myImage#" action="writeToBrowser">
    </div>
    <table width="100%" cellspacing="0" style="background-color:##EFEFEF; clear:left;">
    <tr>
    	<td style="background-color:##EFEFEF;"><strong>Description:</strong></td><td style="background-color:##EFEFEF;">#description#</td>
	</tr>
    <tr>
    	<td style="background-color:##EFEFEF;"><strong>Aspect Ratio:</strong></td>
        <td style="background-color:##EFEFEF;">#NumberFormat(cmsImageAspectRatio(imgInfo.width, imgInfo.height), "_._")#
        </td>
	</tr>
    <tr>
	    <td style="background-color:##EFEFEF;"><strong>Dimensions:</strong></td>
        <td style="background-color:##EFEFEF;">#imgInfo.width#x#imgInfo.height#</td>
	</tr>        
    <!---<tr>        
    	<td style="background-color:##EFEFEF;"><strong>Size:</strong></td><td style="background-color:##EFEFEF;">#Round(size/1024)# KB</td>
    </tr>--->
    </table>
 	<cfparam name="pth" default="">
    <!---<cfset pth="D:\\Inetpub\\WebWareCL\\UserContent\\#getUsername(url.user_id)#\\profile_images\\#name#">--->
    <cfif isProfilePicture(url.user_id, p_url)>   
	    <img src="/graphics/photos.png" align="absmiddle"> Default profile image
    <cfelse>
        <cfif url.allow_edit EQ true>
        	<br>
            <img src="/graphics/photos.png" align="absmiddle"> <a href="javascript:setProfilePicture(#url.user_id#, '#p_url#');">Set as Profile Image</a>
        </cfif>
    </cfif> 
    <!---<cfif url.user_id NEQ url.calledByUser>
	<div id="fcopy_#name#"><img src="/graphics/photo_link.png" align="absmiddle" /> <a href="javascript:copyFile('#name#', 'profile_images',  #url.user_id#, 'profile_images', #url.calledByUser#, 'fcopy_#name#');">Copy to My Photos</a></div>
    </cfif>--->
	<!---<cfif url.allow_edit EQ true>
		
    	<cfmodule template="/socialnet/components/file_editor.cfm" filename="#name#" full_path="#URLEncodedFormat(pth)#">
	</cfif>--->
     <!---<cffunction name="isProfilePicture" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="file_name" type="string" required="yes">--->
    
       
    </div>
    </cfif>
</cfoutput>
