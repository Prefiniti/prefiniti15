<cfset prefiniti = new Prefiniti.Base()>
<cfset assoc = new Prefiniti.Authentication.SiteAssociation(session.current_association)>
<cfset projects = assoc.getProjects()>

<table class="table table-striped">
    <thead>
        <th>Name</th>
        <th>Roles</th>
        <th>Completion</th>
        <th>Status</th>
        <th>Value</th>        
    </thead>
    <tbody>
        <cfloop struct="#projects#" item="key">
            <cfset project = projects[key]>

            <cfset roles = project.project.getUserRoles(session.user.id)>

            <cfset complete = project.project.getPercentComplete()>
            <cfset incomplete = 100 - complete>
            <cfoutput>
                <cfset projectLink = "Prefiniti.Projects.view(#project.project.id#);">
                <tr>
                    <td>
                        <a href="##" onclick="#projectLink#">#project.project.project_name#</a>                        
                    </td>
                    <td>
                        <cfloop array="#roles#" item="role">
                            <span class="label label-info">#role#</span>
                        </cfloop>
                    </td>
                    <td><span class="pie">#complete#,#incomplete#</span></td>
                    <td>#project.project.getStatus()#</td>
                    <td>#lsCurrencyFormat(project.project.getValue(), "local")#</td>                    
                </tr>
            </cfoutput>
        </cfloop>
    </tbody>
</table>
