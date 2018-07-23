<cfset prefiniti = new Prefiniti.Base()>

<cfset author = new Prefiniti.Authentication.UserAccount({id: attributes.postAuthor}, false)>
<cfset recipient = new Prefiniti.Authentication.UserAccount({id: attributes.postRecipient}, false)>

<cfset postPlace = "">



<cfif attributes.post_class EQ "USER">
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has posted a comment on <a href="##" onclick="Prefiniti.Social.loadProfile(#session.user.id#);">your profile</a></cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has replied to a comment on <a href="##" onclick="Prefiniti.Social.loadProfile(#session.user.id#);">your profile</a></cfoutput>
    </cfif>
</cfif>
<cfif attributes.post_class EQ "PJCT">
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has posted a comment on a project you follow</cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has replied to a comment on a project you follow</cfoutput>
    </cfif>
</cfif>
<cfif attributes.post_class EQ "TASK">
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has posted a comment on a task you follow</cfoutput>
    <cfelse>
        <cfoutput><a href="##" onclick="Prefiniti.Social.loadProfile(#author.id#);">#author.longName#</a> has replied to a comment on a task you follow</cfoutput>
    </cfif>
</cfif>