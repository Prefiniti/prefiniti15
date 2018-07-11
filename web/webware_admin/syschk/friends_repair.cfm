<cfset prefiniti = new Prefiniti.Base()>

<cfset users = prefiniti.getUserIDs()>



<cfquery name="getFriends" datasource="webwarecl">
SELECT source_id, target_id FROM friends;
</cfquery>

<cfset delCt = 0>

<cfoutput query="getFriends">
    <cfif NOT prefiniti.userIDExists(source_id) OR NOT prefiniti.userIDExists(target_id)>
        <p>Deleting invalid entry src = #source_id#, tgt = #target_id#</p>
        <cfset prefiniti.deleteFriend(source_id, target_id)>
    </cfif>
</cfoutput>