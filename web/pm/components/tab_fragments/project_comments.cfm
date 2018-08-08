<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>
<cfset posts = project.getComments()>
<cfif project.checkPermission(session.user.id, "PRJ_VIEW")>
    <cfmodule template="/socialnet/components/new_post_form.cfm" author_id="#session.user.id#" recipient_id="#project.id#" post_class="PJCT" base_id="project-#project.id#">
</cfif>
<cfloop array="#posts#" item="post">
    <cfmodule template="/socialnet/components/view_post.cfm" id="#post.id#">
</cfloop>