<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WF_PROCESSORDER">
<cfquery name="gProj" datasource="webwarecl">
	SELECT * FROM projects WHERE id='#url.id#'
</cfquery>



<cfif #gProj.maint_lock# EQ 1 AND #url.calledByUser# NEQ 1>
	<h1>Access Denied</h1>
	<p>This project has been locked for maintenance, and can only be modified by the webmaster.</p>
	<cfabort>
</cfif>


<form name="processOrder" id="processOrder" method="post">
<cfoutput><input type="hidden" name="clientID" value="#gProj.clientID#">
<input type="hidden" name="id" value="#url.id#" />
</cfoutput>
<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Process Order</h3>
        </div>
    </div>
    <br />
    <br />
<table width="100%" cellspacing="0" cellpadding="5">

	<tr>
		<td colspan="2" style="font-size:x-small;">
			<strong>Client:</strong> <cfmodule template="/jobViews/components/companyByClientID.cfm" id="#gProj.clientID#"><br>
			<strong>Ordered By:</strong> <cfmodule template="/jobViews/components/custNameByID.cfm" id="#gProj.clientID#"><br>
			<strong>Order Date:</strong> <cfoutput>#gProj.ordered_date#</cfoutput><br>
			<strong>Project Type:</strong> <cfoutput>#gProj.jobtype#</cfoutput><br>
			<strong>Location:</strong> <cfoutput>#gProj.address#, #gProj.city#, #gProj.state#  #gProj.zip#</cfoutput><br>
			<strong>Subdivision:</strong> <cfoutput>#gProj.subdivision#</cfoutput><br>
			<strong>Legal Description:</strong> <cfoutput>Section #gProj.section#, #gProj.township#, #gProj.range#</cfoutput>
		</td>
	</tr>
	<tr>
		<td valign="top">Choose the charge type for this order:</td>
		<td valign="top">
			<p>
			<label>
			<input type="radio" name="charge_type" value="Lump Sum" checked>
			Lump Sum</label>
			<br>
			<label>
			<input type="radio" name="charge_type" value="Time & Materials">
			Time & Materials</label>
			<br>
			</p>
		</td>
	</tr>
	<tr>
		<td valign="top">Assign a project number:</td>
		<td valign="top">
			<textarea name="clsJobNumber" id="clsJobNumber" readonly></textarea>
			<input type="button" class="normalButton" onClick="javascript:AjaxLoadPageToValueCtl('clsJobNumber', '/workFlow/components/getPN.cfm');" value="Get Project Number"><font color="red" style="font-size:xx-small"><br>*The project number can be changed on the Project View page once this order has been processed.</font>
		</td>
	</tr>
	<tr>
		<td valign="top">Press release:</td>
		<td valign="top">
			<textarea name="articleText" <cfif #gProj.allow_publication# EQ 0>readonly</cfif>><cfmodule template="/jobViews/components/companyByClientID.cfm" id="#gProj.clientID#"> ordered a <cfoutput>#gProj.jobtype#</cfoutput></textarea>
			<blockquote>
			<label><input type="checkbox" name="publish" <cfif #gProj.allow_publication# EQ 1>checked<cfelse>disabled</cfif>>Publish in site news</label>
			</blockquote>
		</td>
	</tr>
	<tr>
		<td valign="top">Choose processing options:</td>
		<td valign="top">
			<p>
			<label>
			<input type="radio" name="stage" value="1" checked>
			Accept this order and award project</label>
			<br>
			<label>
			<input type="radio" name="stage" value="0">
			Reverse order to client</label>
				<blockquote>
					<label>Explanation: <input type="text" name="reverse_explanation"></label>
				</blockquote>
			</p>		
		</td>
	</tr>
	<tr>
		<td colspan="2" align="right">
			<input type="button" onclick="AjaxSubmitForm(AjaxGetElementReference('processOrder'), '/workflow/components/processOrderSub.cfm', 'tcTarget');" name="submit" value="Process This Order">
		</td>
	</tr>
	
</table>
</form>
