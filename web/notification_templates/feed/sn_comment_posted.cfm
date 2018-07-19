<cfset prefiniti = new Prefiniti.Base()>
<cfset author = new Prefiniti.Authentication.UserAccount({id: attributes.postAuthor}, false)>

<cfset postPlace = "">

<cfif attributes.post_class EQ "USER">
    <cfset recipient = new Prefiniti.Authentication.UserAccount({id: attributes.postRecipient}, false)>
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has posted a comment on <a href="##" onclick="Prefiniti.Social.loadProfile(#recipient.id#);">#recipient.longName#'s</a> wall.</cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has replied to a comment on <a href="##" onclick="Prefiniti.Social.loadProfile(#recipient.id#);">#recipient.longName#'s</a> wall.</cfoutput>
    </cfif>
</cfif>
<cfif attributes.post_class EQ "PJCT">    
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has posted a comment on a project.</cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has replied to a comment on a project.</cfoutput>
    </cfif>
</cfif>
<cfif attributes.post_class EQ "TASK">
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has posted a comment on a task.</cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has replied to a comment on a task.</cfoutput>
    </cfif>
</cfif>