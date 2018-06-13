<cfquery name="qrySubdivisionAdd" datasource="webwarecl">
	INSERT INTO subdivisions (name)
    VALUES ('#url.subdivisionName#')
</cfquery>

<table width="100%">
	<tr>
    	<td align="center">
        	<h1>Subdivision Created.</h1>
            
            <p class="VPLink"><a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workflow/components/subdivisionList.cfm');">Return to Subdivisions</a></p>
        </td>
	</tr>
</table>            