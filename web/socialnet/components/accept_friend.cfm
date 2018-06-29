<cfscript>
    source = new Prefiniti.Authentication.UserAccount({id: form.source_id}, false);
    target = new Prefiniti.Authentication.UserAccount({id: form.target_id}, false);

    target.acceptFriendRequest(source);
</cfscript>