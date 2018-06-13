<!--
<wwafcomponent>Edit Subdivision</wwafcomponent>
-->

<cfquery name="qryEditSub" datasource="webwarecl">
	SELECT name FROM subdivisions WHERE id=#url.id#
</cfquery>    

<h3 class="stdHeader">Edit Subdivision</h3>

<cfoutput query="qryEditSub">
<form name="editSubdivision" id="editSubdivision">
<input type="hidden" name="subdivisionID" id="subdivisionID" value="#id#">
	<table width="100%">
    	<tr>
        	<td>Subdivision Name:</td>
            <td><input type="text" name="subdivisionName" id="subdivisionName" value="#name#" /></td>
        </tr>
        <tr>
        	<td colspan="2" align="right">
            	<input type="button" class="normalButton" name="submit" value="Save Subdivision" onclick="AjaxSubmitForm(AjaxGetElementReference('editSubdivision'), '/workflow/components/subdivisionEditSubmit.cfm', 'tcTarget');" />
			</td>
		</tr>                            
    </table>
</form>
</cfoutput>