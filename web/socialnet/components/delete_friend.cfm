<cfscript>
friend = new Prefiniti.Authentication.UserAccount({id: form.friend_id}, false);

session.user.deleteFriend(friend);
</cfscript>