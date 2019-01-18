<cfset project = new Prefiniti.ProjectManagement.Project(attributes.project_id)>

<cfif isDefined("attributes.task_id")>
    <cfset entries = project.getTimeEntries(attributes.task_id)>
<cfelse>
    <cfset entries = project.getTimeEntries()>
</cfif>

<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Stakeholder</th>
            <th>Service</th>
            <th>Work Performed</th>
            <th>Start Time</th>
            <th>End Time</th>
            <th>Hours</th>            
            <th>Value</th>
            <th><i class="fa fa-cogs"></i>
        </tr>
    </thead>
    <tbody>
        <cfset totalHours = 0>
        <cfset totalValue = 0>
        <cfloop array="#entries#" item="entry">

            <cftry>
                <cfset hours = entry.minutes / 60>
                <cfset totalHours = totalHours + hours>
                <cfset user = project.getUserByAssociationID(entry.assoc_id)>   
                <cfset totalValue = totalValue + entry.service_value>         
                <cfoutput>
                    <tr>
                        <td><img src="#user.getPicture()#" class="rounded-circle avatar-sm"> <a href="##" onclick="Prefiniti.Social.loadProfile(#user.id#);"><strong>#user.longName#</strong></a></td>
                        <td>#entry.task_code_name#</td>
                        <td>#entry.work_performed#</td>
                        <td>#dateFormat(entry.start_time, "m/dd/yyyy")# #timeFormat(entry.start_time, "h:mm tt")#</td>
                        <td>
                            <cfif entry.closed EQ 1>
                                #dateFormat(entry.end_time, "m/dd/yyyy")# #timeFormat(entry.end_time, "h:mm tt")#
                            <cfelse>
                                <span class="text-warning">In Progress</span>
                            </cfif>
                        </td>
                        <td>#decimalFormat(hours)#</td>
                        <td>
                            <cfif project.getPermissionByKey("WF_VIEWSTATS", session.current_association)>
                                #lsCurrencyFormat(entry.service_value, "local")#
                            <cfelse>
                                <span class="text-muted">Hidden</span>
                            </cfif>
                        </td>
                        <td>
                            <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                            <div class="dropdown-menu">                            
                                <cfif ((entry.closed EQ 0) AND (session.current_association EQ entry.assoc_id)) OR (project.checkPermission(session.user.id, "TIME_EDIT"))>
                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.editTimeEntry(#entry.id#, #attributes.project_id#);">Edit Log Entry...</button>
                                </cfif>
                                
                                <cfif entry.closed EQ 0>
                                    <cfif session.current_association EQ entry.assoc_id OR project.checkPermission(session.user.id, "TIME_EDIT")>
                                        <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.closeTimeEntry(#entry.id#);">Close Log Entry</button>
                                        <div class="dropdown-divider"></div>
                                    </cfif>
                                </cfif>
                                
                                <cfif session.current_association EQ entry.assoc_id OR project.checkPermission(session.user.id, "TIME_DELETE")>
                                    <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteTimeEntry(#entry.id#);">Delete Log Entry</button>
                                </cfif>
                            </div>                         
                        </td>
                    </tr>
                </cfoutput>
            <cfcatch type="any">
                <tr>
                    <td colspan="8">Error displaying entry ID <cfoutput>#entry.id#</cfoutput></td>
                </tr>
            </cfcatch>
            </cftry>
        </cfloop>
    </tbody>
    <tfoot>
        <tr>
            <td colspan="5">&nbsp;</td>
            <td><strong>Total Hours:</strong></td>
            <td colspan="2" align="left"><cfoutput><strong>#totalHours#</strong></cfoutput></td>
        </tr>
        <tr>
            <td colspan="5">&nbsp;</td>
            <td><strong>Total Value:</strong></td>
            <td colspan="2" align="left"><cfoutput><strong>#lsCurrencyFormat(totalValue, "local")#</strong></cfoutput></td>
        </tr>
    </tfoot>
</table>