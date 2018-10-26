<cfif url.criteria EQ "unbilled">
    <cfset filename = session.site.SiteName & " - Unbilled Hours.csv">
<cfelse>
    <cfset filename = session.site.SiteName & " - Billed Hours.csv">
</cfif>    
<cfheader name="Content-Type" value="text/csv">
<cfheader name="Content-Disposition" value="attachment; filename=""#filename#""">
<cfset employees = session.site.employees()>
Employee,Project,Task,Service,Work Performed,Start Date,Start Time,End Date,End Time,Hours,Rate,Pre-Tax Value<cfoutput>#chr(13)##chr(10)#</cfoutput>
<cfloop array="#employees#" item="employee">
    <cfset employeeShown = false>
    <cfif url.criteria EQ "unbilled">
        <cfset hours = employee.association.getUnbilledHours()>
    <cfelse>
        <cfset hours = employee.association.getBilledHours()>
    </cfif>
    <cfoutput query="hours">
        <cfset project = new Prefiniti.ProjectManagement.Project(project_id)>
        <cfset service = project.getTaskCodeNameByID(task_code_id)>
        <cfset hrs = dateDiff("n", start_time, end_time) / 60>
        <cfset rate = project.getServiceRate(task_code_id)>
        <cfset value = project.getServiceValue(task_code_id, hrs)>
"#employee.user.longName#","#project.project_name#","<cfif task_id NEQ 0>#project.getTaskById(task_id).task_name#</cfif>","#service#","#work_performed#",#dateFormat(start_time, "m/d/yyyy")#,#timeFormat(start_time, "h:mm tt")#,#dateFormat(end_time, "m/d/yyyy")#,#timeFormat(end_time, "h:mm tt")#,#hrs#,#rate#,#value##chr(13)##chr(10)#
    </cfoutput>                            
</cfloop>     
        