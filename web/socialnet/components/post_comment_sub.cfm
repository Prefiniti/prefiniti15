<cfscript>
post = new Prefiniti.SocialNetworking.Post();

post.post_class = "USER";
post.parent_post_id = form.parent_post_id;
post.author_id = form.author_id;
post.recipient_id = form.recipient_id;
post.body_copy = form.body_copy;

post.create();
</cfscript>
