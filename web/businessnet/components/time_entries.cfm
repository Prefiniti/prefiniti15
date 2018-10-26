<div class="wwaf-metadata">
    <wwaftitle>Time Entries</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,Time Entries</wwafbreadcrumbs>
</div>

<cfset employees = session.site.employees()>

<div class="wrapper wrapper-content animated fadeInUp">
    <div class="mail-box-header">
        <form method="get" action="index.html" class="float-right mail-search">
            <div class="input-group">
                <input type="text" id="search-messages" class="form-control form-control-sm" name="search" placeholder="Search Time Entries" onkeyup="Prefiniti.Business.searchTimeEntries();">
                <div class="input-group-append">
                    <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Business.searchTimeEntries();">
                        Search
                    </button> 
                </div>
            </div>
        </form>
        <cfif url.criteria EQ "unbilled">
            <h2>Unbilled Time Entries</h2>
        <cfelse>
            <h2>Billed Time Entries</h2>
        </cfif>
        <div class="mail-tools tooltip-demo m-t-md">
            <button class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="left" title="Refresh" onclick="Prefiniti.reload();"><i class="fa fa-refresh"></i> Refresh</button>
            <cfif url.criteria EQ "unbilled">
                <button onclick="Prefiniti.Business.markSelectedTimeBilled();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Mark as billed"><i class="fa fa-file-invoice-dollar"></i> Mark Billed</button> 
            <cfelse>
                <button onclick="Prefiniti.Business.markSelectedTimeUnbilled();" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Mark as unbilled"><i class="fa fa-file-invoice-dollar"></i> Mark Unbilled</button>
            </cfif> 
                <cfoutput>
                    <a class="btn btn-white btn-sm" href="/businessnet/components/time_entries_csv.cfm?criteria=#url.criteria#" download target="_blank"><i class="fa fa-table"></i> Download CSV</a>
                </cfoutput>
        </div>           
    </div>   
    <div class="mail-box">                
        <table class="table table-hover">
            <thead>       
                <tr>
                    <th><input type="checkbox" onclick="Prefiniti.Business.toggleSelectAll();" id="time-toggle-all"></th>
                    <th>Employee</th>
                    <th>Project [Task]</th>                           
                    <th>Service</th>
                    <th>Work Performed</th>
                    <th>Date</th>                            
                    <th>Hours</th>
                    <th>Rate</th>
                    <th>Pre-Tax</th>
                </tr>
            </thead>
            <tbody>
                <cfset grandTotalHours = 0>
                <cfset grandTotalValue = 0>
                <cfloop array="#employees#" item="employee">
                    <cfset employeeShown = false>
                    <cfif url.criteria EQ "unbilled">
                        <cfset hours = employee.association.getUnbilledHours()>
                    <cfelse>
                        <cfset hours = employee.association.getBilledHours()>
                    </cfif>
                    <cfset employeeTotalHours = 0>
                    <cfset employeeTotalValue = 0>
                    <cfoutput query="hours">
                        <cfset project = new Prefiniti.ProjectManagement.Project(project_id)>
                        <cfset service = project.getTaskCodeNameByID(task_code_id)>
                        <cfset hrs = dateDiff("n", start_time, end_time) / 60>
                        <cfset rate = project.getServiceRate(task_code_id)>
                        <cfset value = project.getServiceValue(task_code_id, hrs)>
                        <cfset employeeTotalValue = employeeTotalValue + value>
                        <cfset grandTotalValue = grandTotalValue + value>
                        <cfset employeeTotalHours = employeeTotalHours + hrs>
                        <cfset grandTotalHours = grandTotalHours + hrs>
                        <tr id="time-entry-#id#">
                            <td><input type="checkbox" class="time-checkbox" data-time-entry-id="#id#"></td>
                            <cfif not employeeShown>
                                <cfset employeeShown = true>
                                <td>#employee.user.longName#</td>
                            <cfelse>
                                <td>&nbsp;</td>
                            </cfif>
                            <td>
                                #project.project_name#
                                <cfif task_id NEQ 0>
                                    <br>[#project.getTaskById(task_id).task_name#]
                                </cfif>
                            </td>
                            <td>#service#</td>
                            <td>#work_performed#</td>
                            <td>#dateFormat(start_time, "m/d/yyyy")# #timeFormat(start_time, "h:mm tt")# - #dateFormat(end_time, "m/d/yyyy")# #timeFormat(end_time, "h:mm tt")#</td>
                            <td>#decimalFormat(hrs)#</td>
                            <td>$#decimalFormat(rate)#</td>
                            <td>$#decimalFormat(value)#</td>
                        </tr>                                
                    </cfoutput>                            
                    <cfoutput>
                    <cfif employeeTotalHours GT 0>
                        <tr>
                            <td colspan="6"><strong>Total (#employee.user.longName#):</strong></td>
                            <td><strong>#decimalFormat(employeeTotalHours)#</strong></td>
                            <td>&nbsp;</td>
                            <td><strong>$#decimalFormat(employeeTotalValue)#</strong></td>
                        </tr>
                    </cfif>
                    </cfoutput>
                </cfloop>     
                <cfoutput>
                    <tr>
                        <td colspan="6"><strong>Total (All Employees):</strong></td>
                        <td><strong>#decimalFormat(grandTotalHours)#</strong></td>
                        <td>&nbsp;</td>
                        <td><strong>$#decimalFormat(grandTotalValue)#</strong></td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>
    </div>
</div>