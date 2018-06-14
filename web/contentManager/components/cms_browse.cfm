<!--
	<wwafcomponent>Browse Files</wwafcomponent>
-->
<cfinclude template="/contentManager/cm_udf.cfm">
<cfinclude template="/authentication/authentication_udf.cfm">


<div style="background-color:#EFEFEF; width:100%; padding:3px; vertical-align:middle;">
<cfoutput>

    <span>
    	<label>Folder:
    	<select name="mode_select" id="mode_select" size="1" onChange="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), '', GetValue('mode_select'), GetValue('search_criteria'));">
          <option value="user" <cfif url.mode EQ "user">selected</cfif>>Personal files</option>
          <cfif getPermissionByKey("CM_VIEW_STAGED", url.current_association)>
	          <option value="site" <cfif url.mode EQ "site">selected</cfif>>Site files</option>
    	  </cfif>
        </select>
    	<select name="dir_select" id="dir_select" size="1" onchange="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), '', GetValue('mode_select'), GetValue('search_criteria'));">
        	<option value="profile_images" <cfif url.basedir EQ "profile_images">selected</cfif>>Profile photos</option>
            <option value="project_files" <cfif url.basedir EQ "project_files">selected</cfif>>Project files</option>
		</select> 
        </label>
	</span>

</cfoutput>    
<cfif url.mode EQ "site" and url.basedir NEQ "profile_images">
    <span>
    	<label>Project:
        	<cfoutput><cfdirectory action="list" directory="#cmsSiteBasePath(url.current_site_id)#\project_files" name="subdirs"></cfoutput>
  <cfoutput><select name="subdir_select" id="subdir_select" onchange="cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), GetValue('subdir_select'), GetValue('mode_select'), GetValue('search_criteria'));"></cfoutput>
				<option value="" <cfif url.subdir EQ "">selected</cfif>>Projects Root</option>
				<cfoutput query="subdirs">
                		
                	<cfif subdirs.type EQ "Dir">
                    	<option value="#name#" <cfif url.subdir EQ "#name#">selected</cfif>>#name#</option>
					</cfif>                                    
            	</cfoutput>
		</select>
		</label> 
        
    </span>
</cfif>
<cfoutput>
<label><input type="text" name="search_criteria" id="search_criteria" <cfif url.search_criteria NEQ "undefined">value="#url.search_criteria#"</cfif>> 
        <cfif url.subdir EQ "">
        <a href="javascript:cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), '', GetValue('mode_select'), GetValue('search_criteria'));"><img src="/graphics/find.png" align="absmiddle" border="0"></a>
        <cfelse>
        <a href="javascript:cmsBrowseFolder(#url.calledByUser#, GetValue('dir_select'), GetValue('subdir_select'), GetValue('mode_select'), GetValue('search_criteria'));"><img src="/graphics/find.png" align="absmiddle" border="0"></a>
		</cfif></label>
</cfoutput>        
<cfoutput>               
	<span>
    	<!-- function cmsPrepareUploader(filter, filter_description, mode, site_id, user_id, basedir, subdir) -->
   	<cfif url.mode EQ "user">
            <a href="javascript:cmsPrepareUploader('*.*', 'All Files', '#url.mode#', '#url.current_site_id#', '#url.calledByUser#', GetValue('dir_select'), '');">
                Upload Files
            </a>
        <cfelse>
      <cfif getPermissionByKey("CM_STAGE", url.current_association)>
      <a href="javascript:cmsPrepareUploader('*.*', 'All Files', '#url.mode#', '#url.current_site_id#', '#url.calledByUser#', GetValue('dir_select'), GetValue('subdir_select'));">
                Stage Files
      </a></cfif> 
	</cfif> <cfif url.subdir EQ "" AND url.mode EQ "site" AND url.basedir NEQ "profile_images">| <img src="/graphics/folder_add.png" border="0" align="absmiddle"> <a href="##">Create Folder</a></cfif>
        <span id="browseButton" style="display:none;"><input type="button"  onclick="glob_uploader.selectFiles();" class="normalButton" value="My Computer" /></span>
	</span> 
         
</div>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat;">
	<div style="float:left">
		<h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Content Management</h3>
	</div>
	<div align="right">
    <cfmodule template="/contentManager/components/quota_check.cfm" user_id="#url.calledByUser#">
    </div>
    <div style="padding:10px; width:100%; clear:left;">
    <cfif url.mode EQ "user">
    	<strong>Path: #getUsername(url.calledByUser)#/#url.basedir#</strong>
	<cfelse>
    	<strong>Path: #url.current_site_id#/#url.basedir#<cfif url.subdir NEQ "">/#url.subdir#</cfif></strong>
	</cfif>                
        <br><strong>Folder Size: #Round(getDirectorySize(url.calledByUser, url.basedir) / 1024)#MB</strong></div>
</div>    
<cfif url.mode EQ "user">
	<cfmodule template="/contentManager/components/cms_user_files.cfm" user_id="#url.calledByUser#" mode="#url.mode#" basedir="#url.basedir#" search_criteria="#url.search_criteria#">
<cfelse>
	<cfmodule template="/contentManager/components/cms_site_files.cfm" site_id="#url.current_site_id#" user_id="#url.calledByUser#" mode="#url.mode#" basedir="#url.basedir#" subdir="#url.subdir#" search_criteria="#url.search_criteria#">
</cfif>
</cfoutput>
	