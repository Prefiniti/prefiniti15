<cfset prefiniti = new Prefiniti.Base()>

<cfset author = new Prefiniti.Authentication.UserAccount({id: attributes.postAuthor}, false)>
<cfset recipient = new Prefiniti.Authentication.UserAccount({id: attributes.postRecipient}, false)>

<cfset postPlace = "">

<cfscript>
    switch(attributes.post_class) {
        case "USER": postPlace = "your wall"; break;
        case "PJCT": postPlace = "a project you follow"; break;
        case "TASK": postPlace = "a task you follow"; break;
    }
</cfscript>

<cfoutput>
    <h1>Comment Posted</h1>

    <cfif attributes.parent_post_id EQ 0>
        <h4><strong>#author.longName#</strong> has posted a comment on #postPlace#.</h4>
    <cfelse>
        <h4><strong>#author.longName#</strong> has posted a reply to your comment on #postPlace#.</h4>
    </cfif>

    <p>#attributes.body_copy#</p>
</cfoutput>