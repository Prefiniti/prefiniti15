<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>
<cfset stakeholders = project.getStakeholders()>
<cfoutput>
    <table class="table table-striped table-hover">
        <tbody>
            <cfloop array="#stakeholders#" item="stakeholder">
                <tr>
                    <td class="client-avatar"><img alt="image" src="#stakeholder.user.getPicture()#"></td>
                    <td><a class="client-link" href="##" onclick="Prefiniti.Social.loadProfile(#stakeholder.user.id#)">#stakeholder.user.longName#</a></td>
                    <td class="client-status">
                        <span class="label label-primary">#stakeholder.type#</span>
                    </td>
                    <td class="text-right">
                        <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                        <div class="dropdown-menu">   
                            <button class="dropdown-item" type="button" onclick="Prefiniti.Mail.writeMessage(#stakeholder.user.id#);">Send Message</button>

                            <cfif project.checkPermission(session.user.id, "SH_DELETE")>
                                <div class="dropdown-divider"></div>
                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteStakeholder(#stakeholder.id#);">Delete Stakeholder</button>
                            </cfif>
                        </div>  
                    </td>
                </tr>                                                            
            </cfloop> 
        </tbody>
    </table>
</cfoutput>