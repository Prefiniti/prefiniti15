<!---<cffunction name="cmsGetFileAssociations" returntype="query">
	<cfargument name="file_id" type="numeric" required="yes">--->
	
<cfinclude template="/contentmanager/cm_udf.cfm">
<cfinclude template="/workflow/workflow_udf.cfm">

<cfparam name="res" default="">
<cfset res=cmsGetFileAssociations('#attributes.file_id#')>

<cfif res.RecordCount EQ 0>
No associated projects.
<cfelse>

	<cfoutput><a href="javascript:showDiv('fa_view_#attributes.file_id#');">#res.RecordCount# associated projects.</a></cfoutput>
	<div <cfoutput>id="fa_view_#attributes.file_id#"</cfoutput> style="display:none; z-index:300; width:auto;">
    	<table cellspacing="0">
        <tr>
        	<th>Project</th>
            <th>Scope</th>
            <th>Description</th>
            <th>Privacy</th>
		</tr>            
		<cfoutput query="res">
			<tr>
            	<td><a href="javascript:loadProjectViewer(#project_id#);">#wfProjectNumberByID(project_id)#</a></td>
                <td>
                	<cfif assoc_type EQ 0>
                    	Personal
					<cfelse>
                    	Site
					</cfif>
				</td>
                <td>#description#</td>
                <td nowrap>
                	<cfif releasable EQ 0>
                    	Not Releasable
					<cfelse>
                    	Releasable
					</cfif>
				</td>
			</tr>                                    
		</cfoutput>
        </table>
    </div>
</cfif>    