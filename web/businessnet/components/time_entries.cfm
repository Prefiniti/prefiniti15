<div class="wwaf-metadata">
    <wwaftitle>Time Entries</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,Time Entries</wwafbreadcrumbs>
</div>

<cfset employees = session.site.employees()>

<div class="wrapper wrapper-content animated fadeInUp">
    <div class="ibox">
        <div class="ibox-title">
            <h5>Unbilled Time Entries</h5>
            <div class="ibox-tools">
                <a href="#" class="btn btn-primary btn-xs" onclick=""><i class="fa fa-check-circle"></i> Mark Approved</a>
                <a href="#" class="btn btn-primary btn-xs" onclick=""><i class="fa fa-file-invoice-dollar"></i> Mark Billed</a>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row m-b-sm m-t-sm">
                <div class="col-md-1">
                    <button type="button" id="loading-example-btn" class="btn btn-white btn-sm" onclick="Prefiniti.reload();"><i class="fa fa-redo"></i> Refresh</button>
                </div>
                <div class="col-md-11">
                    <div class="input-group">
                        <input type="text" placeholder="Search" class="form-control-sm form-control" id="search-projects" onkeyup="Prefiniti.Projects.search();">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-sm btn-primary">Search</button> 
                        </div>
                    </div>
                </div>
            </div>

            <div class="project-list">

                

                <table class="table table-hover">
                    <thead>       
                        <tr>
                            <th><input type="checkbox" class="i-checks"></th>
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

                            <cfset hours=employee.association.getUnbilledHours()>
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

                                <tr>
                                    <td><input type="checkbox" class="i-checks"></td>
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
    </div>
</div>