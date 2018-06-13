<cfquery name="udRFP" datasource="webwarecl">
	UPDATE projects
    SET		rfp=0,
    		rfp_accepted=1
    WHERE	id=#url.id#
</cfquery>

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Proposal Accepted.</h1>
            
            <p>This proposal has now been submitted as a project order.</p>
            
            <cfoutput><p class="VPLink"><a href="javascript:loadProjectViewer(#url.id#);">View project</a></p></cfoutput>
        </td>
	</tr>
</table>            
