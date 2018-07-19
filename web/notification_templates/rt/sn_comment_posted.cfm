<cfset prefiniti = new Prefiniti.Base()>

<cfset author = new Prefiniti.Authentication.UserAccount({id: attributes.postAuthor}, false)>
<cfset recipient = new Prefiniti.Authentication.UserAccount({id: attributes.postRecipient}, false)>

<cfset postPlace = "">



<cfif attributes.post_class EQ "USER">
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput>#author.longName# has posted a comment on your wall.</cfoutput>
    <cfelse>
        <cfoutput>#author.longName# has replied to a comment on your wall.</cfoutput>
    </cfif>
</cfif>
<cfif attributes.post_class EQ "PJCT">
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput>#author.longName# has posted a comment on a project you follow.</cfoutput>
    <cfelse>
        <cfoutput>#author.longName# has replied to a comment on a project you follow.</cfoutput>
    </cfif>
</cfif>
<cfif attributes.post_class EQ "TASK">
    <cfif attributes.parent_post_id EQ 0>
        <cfoutput>#author.longName# has posted a comment on a task you follow.</cfoutput>
    <cfelse>
        <cfoutput>#author.longName# has replied to a comment on a task you follow.</cfoutput>
    </cfif>
</cfif>