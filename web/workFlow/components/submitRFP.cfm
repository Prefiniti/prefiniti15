<cfquery name="writeRFP" datasource="webwarecl">
	UPDATE projects
    SET	ScopeOfServices='#url.ScopeOfServices#',
    	RateSchedule='#url.RateSchedule#',
        Timeline='#url.Timeline#',
        Contract='#url.Contract#',
        TotalCost=#url.TotalCost#,
        rfp_processed=1
	WHERE id=#url.projectID#
</cfquery>    

<cfoutput>
<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Proposal submitted.</h1>
            
            <p class="VPLink"><a href="javascript:loadProjectViewer(#url.projectID#);">View project</a></p>
        </td>
    </tr>
</table>    

</cfoutput>