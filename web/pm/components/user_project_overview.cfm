<cfset prefiniti = new Prefiniti.Base()>
<cfset projects = prefiniti.getProjectsByAssoc(attributes.role_id)>

<table class="table table-striped">
    <thead>
        <th>Name</th>
        <th>Roles</th>
        <th>Status</th>
        <th>Due Date</th>
    </thead>
    <tbody>
        <cfloop array="#projects#" item="project">
            <cfoutput>
                <cfset projectLink = "Prefiniti.Projects.view(#project.project.id#);">
                <tr>
                    <td><a href="##" onclick="#projectLink#">#project.project.project_name#</a></td>
                    <td><label class="label label-info">#project.project_role#</label></td>
                    <td>#project.project.getStatus()#</td>
                    <td>#dateFormat(project.project.project_due_date, "mmm d, yyyy")#</td>
                </tr>
            </cfoutput>
        </cfloop>
    </tbody>
</table>