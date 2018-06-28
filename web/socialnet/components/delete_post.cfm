<cfscript>
post = new Prefiniti.SocialNetworking.Post();

post.retrieve(form.post_id);
post.delete();

</cfscript>