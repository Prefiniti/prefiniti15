<cfset project = new Prefiniti.ProjectManagement.Project(attributes.project_id)>

<cfif isDefined("attributes.task_id")>
    <cfset entries = project.getTravelEntries(attributes.task_id)>
<cfelse>
    <cfset entries = project.getTravelEntries()>
</cfif>

<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Stakeholder</th>
            <th>Task Code</th>
            <th>Travel Reason</th>
            <th>Travel Date</th>
            <th>Odometer Start</th>
            <th>Odometer End</th>
            <th>Miles</th>
            <th><i class="fa fa-cogs"></i></th>
        </tr>
    </thead>
    <tbody>
        <cfset totalMiles = 0>        
        <cfloop array="#entries#" item="entry">
            <cfoutput>
                <cfset user = project.getUserByAssociationID(entry.assoc_id)>
                <cfset totalMiles = totalMiles + entry.miles>
                <tr>
                    <td><img src="#user.getPicture()#" class="rounded-circle avatar-sm"> <a href="##" onclick="Prefiniti.Social.loadProfile(#user.id#);"><strong>#user.longName#</strong></a></td>
                    <td>#entry.task_code_name#</td>
                    <td>#entry.travel_reason#</td>
                    <td>#dateFormat(entry.travel_date, "m/dd/yyyy")#</td>
                    <td>#entry.odometer_start#</td>
                    <td>#entry.odometer_end#</td>
                    <td>#entry.miles#</td>
                    <td>
                        <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                        <div class="dropdown-menu">                                                                                
                            <cfif session.current_association EQ entry.assoc_id OR project.checkPermission(session.user.id, "TRAVEL_DELETE")>
                                <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteTravelEntry(#entry.id#);">Delete Log Entry</button>
                            </cfif>
                        </div>
                    </td>
                </tr>
            </cfoutput>
        </cfloop>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="5">&nbsp;</td>
            <td><strong>Total Miles:</strong></td>
            <td colspan="2" align="left"><cfoutput><strong>#totalMiles#</strong></cfoutput></td>
        </tr>
    </tfoot>
</table>