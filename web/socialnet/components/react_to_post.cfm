<!---
post_reactions(
    -> id bigint(20) not null primary key auto_increment,
    -> post_id bigint(20) not null,
    -> reaction varchar(10) not null,
    -> user_id bigint(20) not null);
    --->

<cfscript>
post = new Prefiniti.SocialNetworking.Post().retrieve(form.post_id);
post.react(session.user, form.reaction);
</cfscript>