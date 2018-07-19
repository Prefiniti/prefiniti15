<cfsilent>
<cfset prefiniti = new Prefiniti.Base()>

<cfset author = new Prefiniti.Authentication.UserAccount({id: attributes.postAuthor}, false)>
<cfset recipient = new Prefiniti.Authentication.UserAccount({id: attributes.postRecipient}, false)>

<cfset postPlace = "">

<cfscript>
    switch(attributes.post_class) {
        case "USER": postPlace = "your wall"; break;
        case "PJCT": postPlace = "a project you follow"; break;
    }
</cfscript>
</cfsilent><cfoutput>#author.longName# has posted a comment on #postPlace#.</cfoutput>