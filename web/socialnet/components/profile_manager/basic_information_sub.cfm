<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="ubi" datasource="webwarecl">
	UPDATE Users
   	SET		firstName='#url.firstName#',
    		middleInitial='#url.middleInitial#',
            lastName='#url.lastName#',
            <cfif url.middleInitial EQ "">
				longName='#url.firstName# #url.lastName#',
            <cfelse>
				longName='#url.firstName# #url.middleInitial#. #url.lastName#',
			</cfif>
            gender='#url.gender#',
            birthday=#CreateODBCDate(url.birthday)#
	WHERE	id=#url.user_id#
</cfquery>
Profile updated.

<cfoutput>
	<cfparam name="et" default="">
    <cfset et="#getLongname(url.user_id)# has updated #getHisHer(url.user_id)# basic information.">
	#writeUserEvent(url.user_id, "user.png", et)#
</cfoutput>                                