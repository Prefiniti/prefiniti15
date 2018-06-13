<!--
	<wwafcomponent>Manage Subdivisions</wwafcomponent>
-->
<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

<cfquery name="gSubs" datasource="webwarecl">
	SELECT id, name FROM subdivisions WHERE name != '' ORDER BY name
</cfquery>

<h3 class="stdHeader">Manage Subdivisions</h3>

<cfif url.permissionLevel EQ 1>
	<img src="/graphics/map_add.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionAdd.cfm');">Add Subdivision</a>
</cfif>    
<table width="100%" cellspacing="0">
	<tr>
    	<th>Subdivision</th>
        <th>Tools</th>
    </tr>
    <cfoutput query="gSubs">
    	<cfset RowNum=RowNum + 1>
		<cfset ColOdd=RowNum mod 2>
		
		<cfswitch expression="#ColOdd#">
			<cfcase value=1>
				<cfset ColColor="silver">
			</cfcase>
			<cfcase value=0>
				<cfset ColColor="white">
			</cfcase>
		</cfswitch>
    	<tr>
        	<td style="background-color:#ColColor#;">#name#</td>
            <td style="background-color:#ColColor#;" align="left">
            	<cfmodule template="/workflow/components/subdivisionMap.cfm" id="#id#"><br>
                <img src="/graphics/map_edit.png"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionEdit.cfm?id=#id#');">Edit Subdivision</a><br />
                <cfif url.permissionLevel EQ 1>
	                <img src="/graphics/map_delete.png" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionDeleteConfirm.cfm?id=#id#');">Delete Subdivision</a>
				</cfif>                    
            </td>
        </tr>
    </cfoutput>
</table>