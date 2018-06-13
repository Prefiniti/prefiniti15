<!--
<wwafcomponent>Add Subdivision</wwafcomponent>
-->

<h3 class="stdHeader">Add Subdivision</h3>

<form name="addSubdivision" id="addSubdivision" action="post">
	<table width="100%">
    	<tr>
        	<td>Subdivision Name:</td>
            <td><input type="text" name="subdivisionName" id="subdivisionName" /></td>
        </tr>
        <tr>
        	<td colspan="2" align="right">
            	<input type="button" class="normalButton" name="submit" value="Add Subdivision" onclick="AjaxSubmitForm(AjaxGetElementReference('addSubdivision'), '/workflow/components/subdivisionAddSubmit.cfm', 'tcTarget');">
            </td>
		</tr>            
    </table>
</form>