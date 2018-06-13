<cfquery name="gProj" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#url.id#
</cfquery>

<form name="viewRFP" method="post">
<table width="100%">
<tr>
    	<td rowspan="2" style="background-color:#EFEFEF; color:black"><img src="/graphics/cls.gif" width="200"></td>
	  <td style="background-color:#C0C0C0; color:black" align="right"><h2 align="right">Bid Proposal</h2></td>
	</tr>
    <tr>
      <td style="background-color:#EFEFEF; color:black"><strong>Client:</strong>
        <cfmodule template="/jobViews/components/companyByClientID.cfm" id="#gProj.clientID#">
        <br>
        <strong>Ordered By:</strong>
        <cfmodule template="/jobViews/components/custNameByID.cfm" id="#gProj.clientID#">
        <br>
        <strong>Order Date:</strong> <cfoutput>#gProj.ordered_date#</cfoutput><br>
        <strong>Project Type:</strong> <cfoutput>#gProj.ServiceType# #gProj.jobtype#</cfoutput><br>
        <strong>Location:</strong> <cfoutput>#gProj.address#, #gProj.city#, #gProj.state#  #gProj.zip#</cfoutput><br>
        <strong>Subdivision:</strong> <cfoutput>#gProj.subdivision# Lot #gProj.lot# Block #gProj.block#</cfoutput><br>
        <strong>Legal Description:</strong> <cfoutput>Section #gProj.section#, #gProj.township#, #gProj.range#</cfoutput> </td>
    </tr>
    <tr>
      <td>Scope of Services:</td>
      <td><cfoutput><pre>#gProj.ScopeOfServices#</pre></cfoutput></td>
    </tr>
    <tr>
      <td>Rate Schedule:</td>
      <td><cfoutput><pre>#gProj.RateSchedule#</pre></cfoutput></td>
    </tr>
    <tr>
      <td>Timeline:</td>
      <td><cfoutput><pre>#gProj.Timeline#</pre></cfoutput></td>
    </tr>
    <tr>
      <td>Contract:</td>
      <td><cfoutput><pre>#gProj.Contract#</pre></cfoutput></td>
    </tr>
    <tr>
      <td>Total Cost:</td>
      <td align="right"><cfoutput><strong>$#gProj.TotalCost#</strong></cfoutput></td>
    </tr>
    <cfif NOT IsDefined("url.viewOnly")>
    <tr>
      <td>&nbsp;</td>
      <td><div align="right">
        <cfoutput>
        <input type="button" name="acceptProposal" id="acceptProposal" value="Accept Proposal" onclick="acceptRFP(#gProj.id#);">
        <input type="button" name="declineProposal" id="declineProposal" value="Decline Proposal" onclick="declineRFP(#gProj.id#);">
        </cfoutput>
      </div></td>
    </tr>
    </cfif>
</table>
</form>