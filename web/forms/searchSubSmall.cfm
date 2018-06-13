<cfoutput>
<!--
<wwafcomponent>Project search (#url.SearchField# <cfif #url.searchtype# EQ "BeginsWith">begins with<cfelse>contains</cfif> #url.SearchValue#)</wwafcomponent>
-->
</cfoutput>
<cfparam name="RowNum" default="0">
<cfparam name="ColOdd" default="">
<cfparam name="ColColor" default="white">

	<cfswitch expression="#url.SearchType#">
	<cfcase value="BeginsWith">	
		<cfquery name="Rsearch" datasource="webwarecl">
			SELECT * FROM projects WHERE #URL.SearchField# 
			LIKE '#URL.SearchValue#%'
			<cfif #url.currentUserOnly# EQ "true">
				AND clientID=#url.userid#
			</cfif>
             AND site_id=#url.current_site_id#
			<cfif #url.SearchField# EQ "section" OR #url.SearchField# EQ "township" OR #url.SearchField# EQ "range">
				ORDER BY range
			<cfelseif #url.SearchField# EQ "subdivision">
				ORDER BY block
			<cfelse>
				ORDER BY clsJobNumber DESC
			</cfif>
		</cfquery>
	</cfcase>
	<cfcase value="Contains">
		<cfquery name="Rsearch" datasource="webwarecl">
			SELECT * FROM projects WHERE #URL.SearchField# 
			LIKE '%#URL.SearchValue#%'
			<cfif #url.currentUserOnly# EQ "true">
				AND clientID=#url.userid#
			</cfif>
             AND site_id=#url.current_site_id#
			<cfif #url.SearchField# EQ "section" OR #url.SearchField# EQ "township" OR #url.SearchField# EQ "range">
				ORDER BY range
			<cfelseif #url.SearchField# EQ "subdivision">
				ORDER BY block
			<cfelse>
				ORDER BY clsJobNumber DESC
			</cfif>
		</cfquery>
	</cfcase>
	</cfswitch>
	<!---
	On the search function:
Selection: Subdivision
Result: Sub, Lot, Block

Selection:Sec, Town, Rang
Result:Sec, Twn, Range
--->

	<h3 align="left" style="font-family: 'Times New Roman', Times, serif; color:#3399CC; font-weight:lighter; font-size:24px; margin-top:3px;">Search Results</h3>
	<h4 style="font-family: 'Times New Roman', Times, serif; color:#666666;"><em><cfoutput>#Rsearch.RecordCount# projects found 
	<cfif #url.SearchType# EQ "BeginsWith">beginning with<cfelse>containing</cfif> the value '#url.SearchValue#'</cfoutput></em> </h4>
	<table width="100%" cellspacing="0">
  <th>Project Number</th>
      <th>Address</th>
    <cfif #url.SearchField# EQ "subdivision">
        <th>Subdivision</th>
      <th>Lot</th>
      <th>Block</th>
    </cfif>
      <cfif #url.SearchField# EQ "section" OR #url.SearchField# EQ "township" OR #url.SearchField# EQ "range">
        <th>Section</th>
        <th>Township</th>
        <th>Range</th>
      </cfif>
  </tr>
  <cfoutput query="Rsearch">
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
      <td style="background-color:#ColColor#"><img src="/graphics/zoom.png" border="0" align="absmiddle" /> <a href="javascript:loadProjectViewer(#id#);">
        <cfif #clsJobNumber# NEQ "">
          #clsJobNumber#
            <cfelse>
          [No project number]
        </cfif>
      </a><br />#description#</td>
      <td style="background-color:#ColColor#">#address#<br />
        #city#, #state# #zip#</td>
      <cfif #url.SearchField# EQ "subdivision">
        <td style="background-color:#ColColor#">#subdivision#</td>
        <td style="background-color:#ColColor#">#lot#</td>
        <td style="background-color:#ColColor#">#block#</td>
      </cfif>
      <cfif #url.SearchField# EQ "section" OR #url.SearchField# EQ "township" OR #url.SearchField# EQ "range">
        <td style="background-color:#ColColor#">#section#</td>
        <td style="background-color:#ColColor#">#township#</td>
        <td style="background-color:#ColColor#">#range#</td>
      </cfif>
    </tr>
  </cfoutput>
    </table>
	