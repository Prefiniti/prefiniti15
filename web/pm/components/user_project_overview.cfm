<cfset prefiniti = new Prefiniti.Base()>
<cfset assoc = new Prefiniti.Authentication.SiteAssociation(attributes.role_id)>
<cfset user = prefiniti.getUserByAssociationID(attributes.role_id)>
<cfset projects = assoc.getProjects()>

<table class="table table-striped">
    <thead>
        <th>Name</th>
        <th>Roles</th>
        <th>Completion</th>
        <cfif NOT isDefined("attributes.mini")>
            <th>Status</th>
            <th>Value</th>        
        </cfif>
    </thead>
    <tbody>
        <cfloop struct="#projects#" item="key">
            <cfset project = projects[key]>

            <cfset roles = project.project.getUserRoles(user.id)>

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
                    <cfif NOT isDefined("attributes.mini")>
                        <td>#project.project.getStatus()#</td>
                        <td>#lsCurrencyFormat(project.project.getValue(), "local")#</td>  
                    </cfif>                 
                </tr>
            </cfoutput>
        </cfloop>
    </tbody>
</table>
