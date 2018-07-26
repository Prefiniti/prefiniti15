<cfcomponent extends="Prefiniti.Base" output="false" hint="Represents a project">

    <cffunction name="init" returntype="Prefiniti.ProjectManagement.Project" output="false" hint="Project constructor">
        <cfargument name="id" type="numeric" required="true" default="0" hint="Project ID">
        <cfargument name="template_id" type="numeric" required="true" default="0" hint="ID of template to use">

        <cfscript>

            this.id = arguments.id;
            this.employee_assoc = session.current_association;
            this.client_assoc = session.current_association;
            this.template_id = arguments.template_id;
            this.project_name = "";
            this.project_priority = 1;
            this.project_status = "Active";
            this.project_start_date = createODBCDate(now());
            this.project_due_date = createODBCDate(now());
            this.project_description = "";
            this.project_created = createODBCDateTime(now());

            this.permissionKeys = ["PRJ_VIEW", "PRJ_EDIT", "PRJ_DELETE", "TIME_LOG", "TIME_EDIT", "TIME_APPROVE", "TIME_DELETE",
                                   "TRAVEL_LOG", "TRAVEL_EDIT", "TRAVEL_APPROVE", "TRAVEL_DELETE", "TASK_ADD", "TASK_EDIT", "TASK_DELETE",
                                   "SH_ADD", "SH_EDIT", "SH_DELETE", "DEL_ADD", "DEL_EDIT", "DEL_DELETE", "LOC_ADD", "LOC_EDIT", "LOC_DELETE",
                                   "DOC_ADD", "DOC_EDIT", "DOC_DELETE", "DISP_ADD", "DISP_CANCEL"];

            this.permissionLookup = {
                PRJ_VIEW: 1,
                PRJ_EDIT: 2,
                PRJ_DELETE: 4,
                TIME_LOG: 8,
                TIME_EDIT: 16,
                TIME_APPROVE: 32,
                TIME_DELETE: 64,
                TRAVEL_LOG: 128,
                TRAVEL_EDIT: 256,
                TRAVEL_APPROVE: 512,
                TRAVEL_DELETE: 1024,
                TASK_ADD: 2048,
                TASK_EDIT: 4096,
                TASK_DELETE: 8192,
                SH_ADD: 16384,
                SH_EDIT: 32768,
                SH_DELETE: 65536,
                DEL_ADD: 131072,
                DEL_EDIT: 262144,
                DEL_DELETE: 524288,
                LOC_ADD: 1048576,
                LOC_EDIT: 2097152,
                LOC_DELETE: 4194304,
                DOC_ADD: 8388608,
                DOC_EDIT: 16777216,
                DOC_DELETE: 33554432,
                DISP_ADD: 67108864,
                DISP_CANCEL: 134217728
            };

        </cfscript>

        <cfquery name="checkIfProjectExists" datasource="webwarecl">
            SELECT * FROM pm_projects WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfif checkIfProjectExists.recordCount GT 0>
            <cfoutput query="checkIfProjectExists">
                <cfscript>
                    this.id = id;
                    this.employee_assoc = employee_assoc;
                    this.client_assoc = client_assoc;
                    this.template_id = template_id;
                    this.project_name = project_name;
                    this.project_priority = project_priority;
                    this.project_status = project_status;
                    this.project_start_date = project_start_date;
                    this.project_due_date = project_due_date;
                    this.project_description = project_description;
                    this.project_created = project_created;
                    this.project_client = this.getUserByAssociationID(this.client_assoc);
                    this.project_employee = this.getUserByAssociationID(this.employee_assoc);
                    this.template_id = checkIfProjectExists.template_id;
                </cfscript>
            </cfoutput>
<!---
            <cfif NOT this.checkPermission(session.user.id, "PRJ_VIEW")>
                <cfthrow message="Permission Denied" detail="You do not have the PRJ_VIEW permission on this project">
            </cfif>
--->
            <cfreturn this>
        <cfelse>            
            <cfset create_id = createUUID()>

            <cfquery name="createInitialProject" datasource="webwarecl">
                INSERT INTO pm_projects
                    (employee_assoc,
                    client_assoc,
                    template_id,
                    project_name,
                    project_priority,
                    project_status,
                    project_start_date,
                    project_due_date,
                    project_description,
                    project_created,
                    create_id)
                VALUES
                    (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.employee_assoc#">,
                     <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.client_assoc#">,
                     <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.template_id#">,
                     <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(this.project_name)#" maxlength="45">,
                     <cfqueryparam cfsqltype="cf_sql_tinyint" value="1">,
                     <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(this.project_status)#" maxlength="45">,
                     <cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.project_start_date#">,
                     <cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.project_due_date#">,
                     <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#HTMLEditFormat(this.project_description)#">,
                     <cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.project_created#">,
                     <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">)
            </cfquery>

            <cfif this.client_assoc NEQ this.employee_assoc>
                <cfset n_client = this.getUserByAssociationID(this.client_assoc)>
                <cfset n_emp = this.getUserByAssociationID(this.employee_assoc)>

                <cfset notification = new Prefiniti.Notification(n_client, "WF_PROJECT_CREATED", {project: this})>
                <cfset notification.send()>
                <cfset notification = new Prefiniti.Notification(n_emp, "WF_PROJECT_CREATED", {project: this})>
                <cfset notification.send()>
            <cfelse>
                <cfset n_emp = this.getUserByAssociationID(this.employee_assoc)>
                <cfset notification = new Prefiniti.Notification(n_emp, "WF_PROJECT_CREATED", {project: this})>
                <cfset notification.send()>
            </cfif>

            <cfquery name="getProjectID" datasource="webwarecl">
                SELECT id FROM pm_projects WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">
            </cfquery>

            <cfset this.id = getProjectID.id>
            <cfset this.applyTemplate(this.template_id)>


            <cfreturn new Prefiniti.ProjectManagement.Project(getProjectID.id, this.template_id)>
        </cfif>        

    </cffunction>

    <cffunction name="notifyStakeholders" returntype="void" output="false">
        <cfargument name="n_key" type="string" required="true">
        <cfargument name="fieldCollection" type="struct" required="true">

        <cfscript>
            var fields = arguments.fieldCollection;
            var notified = [];

            // we want to pass all of the project metadata into the
            // notification, in case a notification template needs to
            // display project information not otherwise supplied
            // by the caller.
            fields.project = this;

            var stakeholders = this.getStakeholders();
            var notification = "";

            for(stakeholder in stakeholders) {

                // the same user can be a stakeholder multiple times.
                // we only want to notify each user once for any project
                // for which they are a stakeholder.
                if(!notified.contains(stakeholder.user.id)) {
                    notification = new Prefiniti.Notification(stakeholder.user, arguments.n_key, fields);
                    notification.send();
                    notified.append(stakeholder.user.id);
                }
            }

        </cfscript>

    </cffunction>

    <cffunction name="save" returntype="Prefiniti.ProjectManagement.Project" output="false">

        <!---
        <cfif NOT this.checkPermission(session.user.id, "PRJ_EDIT")>
            <cfthrow message="Permission Denied" detail="You do not have the PRJ_EDIT permission on this project">
        </cfif>
        --->

        <cfquery name="updateProject" datasource="webwarecl">
            UPDATE pm_projects
            SET    employee_assoc=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.employee_assoc#">,
                   client_assoc=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.client_assoc#">,
                   project_name=<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(this.project_name)#" maxlength="45">,
                   project_status=<cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(this.project_status)#" maxlength="45">,
                   project_start_date=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.project_start_date#">,
                   project_due_date=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#this.project_due_date#">,
                   project_description=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#HTMLEditFormat(this.project_description)#">,
                   project_priority=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.project_priority#">,
                   template_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.template_id#">            
            WHERE  id=#this.id#
        </cfquery>

        
        <cfif this.employee_assoc NEQ this.client_assoc>
            <cfset this.addStakeholder(this.client_assoc, "Client", 1)>
        </cfif>
        
        <cfset this.addStakeholder(this.employee_assoc, "Project Manager", 268435455)>

        <cfset this.addTag(this.project_name)>
        <cfset this.addTag(this.project_client.longName)>
        <cfset this.addTag(this.project_employee.longName)>

        <cfset this.notifyStakeholders("WF_PROJECT_EDITED", {})>

        <cfreturn this>

    </cffunction>

    <cffunction name="delete" returntype="Prefiniti.ProjectManagement.Project" output="false">

        <cfif NOT this.checkPermission(session.user.id, "PRJ_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have the PRJ_DELETE permission on this project">
        </cfif>

        <cfquery name="deleteProject" datasource="webwarecl">
            DELETE FROM pm_projects WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_PROJECT_DELETED", {})>

        <cfreturn this>

    </cffunction>

    <cffunction name="getIncompleteTaskCount" returntype="numeric" output="false">
        
        <cfquery name="getIncompleteTaskCount" datasource="webwarecl">
            SELECT id FROM pm_tasks WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> AND task_complete=<cfqueryparam cfsqltype="cf_sql_tinyint" value="0">
        </cfquery>
    
        <cfreturn getIncompleteTaskCount.recordCount>

    </cffunction>

    <cffunction name="getInProgressTaskCount" returntype="numeric" output="false">
        
        <cfquery name="getInProgressTaskCount" datasource="webwarecl">
            SELECT id FROM pm_tasks WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> AND task_complete=<cfqueryparam cfsqltype="cf_sql_tinyint" value="1">
        </cfquery>
    
        <cfreturn getInProgressTaskCount.recordCount>

    </cffunction>

    <cffunction name="getCompleteTaskCount" returntype="numeric" output="false">
        
        <cfquery name="getCompleteTaskCount" datasource="webwarecl">
            SELECT id FROM pm_tasks 
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> 
            AND task_complete=<cfqueryparam cfsqltype="cf_sql_tinyint" value="2"> 
            AND task_priority!=<cfqueryparam cfsqltype="cf_sql_varchar" value="Wish List" maxlength="45">
        </cfquery>
    
        <cfreturn getCompleteTaskCount.recordCount>
        
    </cffunction>

    <cffunction name="getTaskCount" returntype="numeric" output="false">

        <cfreturn this.getTasks().recordCount>

    </cffunction>

    <cffunction name="getRequiredTaskCount" returntype="numeric" output="false">

        <cfquery name="getRequiredTasks" datasource="webwarecl">
            SELECT id FROM pm_tasks WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> AND task_priority!=<cfqueryparam cfsqltype="varchar" value="Wish List">
        </cfquery>

        <cfreturn getRequiredTasks.recordCount>

    </cffunction>

    <cffunction name="getPercentComplete" returntype="numeric" output="false">
        <cfreturn this.getPercentage(this.getCompleteTaskCount(), this.getRequiredTaskCount())>
    </cffunction>

    <cffunction name="getEffectivePermissions" returntype="numeric" output="true">
        <cfargument name="user_id" type="numeric" required="true">

        <cfset stakeholders = this.getStakeholders()>
        <cfset result = 0>

        <cfloop array="#stakeholders#" item="stakeholder">            
            <cfif stakeholder.user.id EQ arguments.user_id>                
                <cfset result = bitOr(result, stakeholder.permissions)>
            </cfif>
        </cfloop>

        <cfreturn result>

    </cffunction>

    <cffunction name="checkPermission" returntype="boolean" output="false">
        <cfargument name="user_id" type="numeric" required="true">
        <cfargument name="permission_key" type="string" required="true">

        <cfset permissionNumber = this.permissionLookup[arguments.permission_key]>

        <cfif bitAnd(this.getEffectivePermissions(arguments.user_id), permissionNumber) EQ permissionNumber>
            <cfreturn true>
        <cfelse>
            <cfreturn false>
        </cfif>

    </cffunction>

    <cffunction name="getAllPermissionKeys" returntype="array" output="false">
        <cfargument name="user_id" type="numeric" required="true">

        <cfset res = []>

        <cfloop array="#this.permissionKeys#" item="key">
            <cfif this.checkPermission(arguments.user_id, key)>
                <cfset res.append(key)>
            </cfif>
        </cfloop>

        <cfreturn res>
    </cffunction>

    <cffunction name="logTime" returntype="numeric" output="false">
        <cfargument name="task_id" type="numeric" required="true">
        <cfargument name="assoc_id" type="numeric" required="true">
        <cfargument name="task_code_id" type="numeric" required="true">
        <cfargument name="work_performed" type="string" required="true">
        <cfargument name="start_time" type="date" required="true">
        <cfargument name="end_time" type="date" required="false">

        <cfif arguments.assoc_id NEQ session.current_association AND NOT this.checkPermission(session.user.id, "TIME_APPROVE")>
            <cfthrow message="Permission Denied" detail="You do not have the TIME_APPROVE permission on this project">
        </cfif>

        <cfif NOT this.checkPermission(session.user.id, "TIME_LOG")>
            <cfthrow message="Permission Denied" detail="You do not have the TIME_LOG permission on this project">
        </cfif>


        <cfset create_id = createUUID()>

        <cfset startTime = createODBCDateTime(arguments.start_time)>

        <cfif NOT isDefined("arguments.end_time")>
            <cfset endTime = createODBCDateTime(now())>
            <cfset closed = 0>
        <cfelse>
            <cfset endTime = createODBCDateTime(arguments.end_time)>
            <cfset closed = 1>
        </cfif>

        <cfquery name="logTime" datasource="webwarecl">
            INSERT INTO pm_time_entries 
                (project_id, 
                task_id, 
                assoc_id, 
                task_code_id, 
                work_performed, 
                start_time, 
                end_time, 
                closed, 
                create_id)
            VALUES 
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_id#">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assoc_id#">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_code_id#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.work_performed#" maxlength="255">, 
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#startTime#">, 
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#endTime#">, 
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#closed#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">)
        </cfquery>

        <cfquery name="getTimeEntryID" datasource="webwarecl">
            SELECT id FROM pm_time_entries WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">
        </cfquery>        

        <cfset this.notifyStakeholders("WF_TIME_LOGGED", {
            task_code_id: arguments.task_code_id,
            task_code_name: this.getTaskCodeNameByID(arguments.task_code_id),
            task_id: arguments.task_id,
            work_performed: arguments.work_performed,
            user: this.getUserByAssociationID(arguments.assoc_id),
            perpetrator: session.user,
            closed: closed
        })>

        <cfreturn getTimeEntryID.id>
    </cffunction>

    <cffunction name="getTimeEntries" returntype="array" output="false">
        <cfargument name="task_id" type="numeric" required="false">

        <cfset result = []>

        <cfquery name="getTimeEntries" datasource="webwarecl">
            SELECT * FROM pm_time_entries
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            <cfif isDefined("arguments.task_id")>
                AND task_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_id#">
            </cfif>
            ORDER BY start_time DESC
        </cfquery>

        <cfoutput query="getTimeEntries">
            <cfif closed EQ 1>
                <cfset minutes = dateDiff("n", start_time, end_time)>
            <cfelse>
                <cfset minutes = dateDiff("n", start_time, now())>
            </cfif>

            <cfset result.append({
                id: id,
                task_id: task_id,
                assoc_id: assoc_id,
                task_code_id: task_code_id,
                task_code_name: this.getTaskCodeNameByID(task_code_id),
                service_value: this.getServiceValue(task_code_id, minutes / 60),
                work_performed: work_performed,
                start_time: start_time,
                end_time: end_time,
                closed: closed,
                minutes: minutes
            })>
        </cfoutput>

        <cfreturn result>
    </cffunction>

    <cffunction name="getValue" returntype="numeric" output="false">
        <cfset total = 0>
        <cfset entries = this.getTimeEntries()>

        <cfloop array="#entries#" item="entry">
            <cfset total = total + entry.service_value>
        </cfloop>

        <cfreturn total>
    </cffunction>

    <cffunction name="closeTimeEntry" returntype="void" output="false">
        <cfargument name="time_id" type="numeric" required="true">

        <cfquery name="chkTimeOwnership" datasource="webwarecl">
            SELECT assoc_id FROM pm_time_entries WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.time_id#">
        </cfquery>

        <cfset owner = this.getUserByAssociationID(chkTimeOwnership.assoc_id)>

        <cfif session.user.id NEQ owner.id AND NOT this.checkPermission(session.user.id, "TIME_APPROVE")>
            <cfthrow message="Permission Denied" detail="You do not have TIME_APPROVE on this project.">
        </cfif>

        <cfquery name="closeTimeEntry" datasource="webwarecl">
            UPDATE pm_time_entries
            SET end_time=<cfqueryparam cfsqltype="cf_sql_timestamp" value="#createODBCDateTime(now())#">,
                closed=<cfqueryparam cfsqltype="cf_sql_tinyint" value="1">
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.time_id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_TIME_CLOSED", {time_id: arguments.time_id})>

    </cffunction>

    <cffunction name="deleteTimeEntry" returntype="void" output="false">
        <cfargument name="time_id" type="numeric" required="true">

        <cfquery name="chkTimeOwnership" datasource="webwarecl">
            SELECT assoc_id FROM pm_time_entries WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.time_id#">
        </cfquery>

        <cfset owner = this.getUserByAssociationID(chkTimeOwnership.assoc_id)>

        <cfif session.user.id NEQ owner.id AND NOT this.checkPermission(session.user.id, "TIME_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have TIME_DELETE on this project.">
        </cfif>
        

        <cfquery name="deleteTimeEntry" datasource="webwarecl">
            DELETE FROM pm_time_entries WHERE id=#arguments.time_id#
        </cfquery>

        <cfset this.notifyStakeholders("WF_TIME_DELETED", {time_id: arguments.time_id})>

    </cffunction>

    <cffunction name="logTravel" returntype="numeric" output="false">
        <cfargument name="task_id" type="numeric" required="true">
        <cfargument name="assoc_id" type="numeric" required="true">
        <cfargument name="task_code_id" type="numeric" required="true">
        <cfargument name="travel_date" type="date" required="true">
        <cfargument name="travel_name" type="string" required="true">
        <cfargument name="odometer_start" type="numeric" required="true">
        <cfargument name="odometer_end" type="numeric" required="false">

        <cfif arguments.assoc_id NEQ session.current_association AND NOT this.checkPermission(session.user.id, "TRAVEL_APPROVE")>
            <cfthrow message="Persimmon Denied" detail="You do not have the TRAVEL_APPROVE permission on this project">
        </cfif>

        <cfif NOT this.checkPermission(session.user.id, "TRAVEL_LOG")>
            <cfthrow message="Permission Denied" detail="You do not have the TRAVEL_LOG permission on this project">
        </cfif>

        <cfset create_id = createUUID()>

        <cfif NOT isDefined("arguments.odometer_end")>
            <cfset odometerEnd = arguments.odometer_start>
            <cfset closed = 0>
        <cfelse>
            <cfset odometerEnd = arguments.odometer_end>
            <cfset closed = 1>
        </cfif>

        <cfquery name="logTravel" datasource="webwarecl">
            INSERT INTO pm_travel_entries(project_id, 
                                          task_id,
                                          assoc_id, 
                                          task_code_id, 
                                          travel_date, 
                                          travel_name, 
                                          odometer_start, 
                                          odometer_end, 
                                          closed, 
                                          create_id)
            VALUES (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">, 
                    <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_id#">,
                    <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assoc_id#">, 
                    <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_code_id#">, 
                    <cfqueryparam cfsqltype="cf_sql_timestamp" value="#createODBCDateTime(arguments.travel_date)#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#HTMLEditFormat(arguments.travel_name)#" maxlength="255">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#arguments.odometer_start#">,
                    <cfqueryparam cfsqltype="cf_sql_double" value="#odometerEnd#">,
                    <cfqueryparam cfsqltype="cf_sql_tinyint" value="#closed#">,
                    <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">)
        </cfquery>

        <cfquery name="getTravelID" datasource="webwarecl">
            SELECT id FROM pm_travel_entries WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">
        </cfquery>

        <cfset this.notifyStakeholders("WF_TRAVEL_LOGGED", {travel_id: getTravelID.id})>

        <cfreturn getTravelID.id>
    </cffunction>

    <cffunction name="getTravelEntries" returntype="array" output="false">
        <cfargument name="task_id" type="numeric" required="false">

        <cfset result = []>

        <cfquery name="getTravelEntries" datasource="webwarecl">
            SELECT * FROM pm_travel_entries
            WHERE project_id=#this.id#
            <cfif isDefined("arguments.task_id")>
                AND task_id=#arguments.task_id#
            </cfif>
            ORDER BY travel_date DESC
        </cfquery>

        <cfoutput query="getTravelEntries">
            <cfif closed EQ 1>
                <cfset miles = odometer_end - odometer_start>
            <cfelse>
                <cfset miles = 0>
            </cfif>

            <cfset result.append({
                id: id,
                task_id: task_id,
                assoc_id: assoc_id,
                task_code_id: task_code_id,
                task_code_name: this.getTaskCodeNameByID(task_code_id),
                travel_reason: travel_name,
                travel_date: travel_date,
                odometer_start: odometer_start,
                odometer_end: odometer_end,
                closed: closed,
                miles: miles
            })>
        </cfoutput>

        <cfreturn result>
    </cffunction>

    <cffunction name="deleteTravelEntry" returntype="void" output="false">
        <cfargument name="travel_id" type="numeric" required="true">

        <cfquery name="chkTravelOwnership" datasource="webwarecl">
            SELECT assoc_id FROM pm_travel_entries WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.travel_id#">
        </cfquery>

        <cfset owner = this.getUserByAssociationID(chkTravelOwnership.assoc_id)>

        <cfif session.user.id NEQ owner.id AND NOT this.checkPermission(session.user.id, "TIME_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have TIME_DELETE on this project.">
        </cfif>

        <cfquery name="deleteTravelEntry" datasource="webwarecl">
            DELETE FROM pm_travel_entries WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.travel_id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_TRAVEL_DELETED", {travel_id: arguments.travel_id})>

    </cffunction>

    <cffunction name="getStakeholders" returntype="array" output="false">
        <cfset result = []>

        <cfquery name="getStakeholders" datasource="webwarecl">
            SELECT * FROM pm_stakeholders WHERE project_id=#this.id#
        </cfquery>

        <cfsilent>
            <cfoutput query="getStakeholders">
                <cfscript>
                    tmp = {
                        type: stakeholder_type,
                        id: id,
                        permissions: permissions,
                        assoc_id: assoc_id,
                        user: this.getUserByAssociationID(assoc_id)
                    };

                    result.append(tmp);
                </cfscript>
            </cfoutput>
        </cfsilent>

        <cfreturn result>

    </cffunction>

    <cffunction name="addStakeholder" returntype="void" output="false">
        <cfargument name="assoc_id" type="numeric" required="true">
        <cfargument name="stakeholder_type" type="string" required="true">
        <cfargument name="permissions" type="numeric" required="true">

<!---
        <cfif NOT this.checkPermission(session.user.id, "SH_ADD")>
            <cfthrow message="Permission Denied" detail="You do not have SH_ADD on this project.">
        </cfif>
--->
        <cfset this.notifyStakeholders("WF_STAKEHOLDER_ADDED", {
            stakeholder: this.getUserByAssociationID(arguments.assoc_id),
            type: arguments.stakeholder_type
        })>

        <cfset this.removeStakeholder(arguments.assoc_id, arguments.stakeholder_type)>

        <cfquery name="addStakeholder" datasource="webwarecl">
            INSERT INTO pm_stakeholders 
                (create_id, 
                project_id, 
                assoc_id, 
                stakeholder_type, 
                permissions)
            VALUES                      
                (<cfqueryparam cfsqltype="cf_sql_varchar" value="#createUUID()#" maxlength="255">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assoc_id#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.stakeholder_type#" maxlength="45">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.permissions#">)
        </cfquery>

        <cfset this.addTag(this.getUserByAssociationID(arguments.assoc_id).longName)>
    </cffunction>

    <cffunction name="removeStakeholder" returntype="void" output="false">
        <cfargument name="assoc_id" type="numeric" required="true">
        <cfargument name="stakeholder_type" type="string" required="true">

<!---
        <cfif session.current_association NEQ arguments.assoc_id AND NOT this.checkPermission(session.user.id, "SH_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have SH_DELETE on this project">
        </cfif>
--->
        <cfset this.notifyStakeholders("WF_STAKEHOLDER_DELETED", {
            stakeholder: this.getUserByAssociationID(arguments.assoc_id),
            type: arguments.stakeholder_type
        })>

        <cfquery name="removeStakeholder" datasource="webwarecl">
            DELETE FROM pm_stakeholders 
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> 
            AND assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assoc_id#"> 
            AND stakeholder_type=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.stakeholder_type#" maxlength="45">
        </cfquery>

         <cfset this.removeTag(this.getUserByAssociationID(arguments.assoc_id).longName)>
    </cffunction>

    <cffunction name="removeStakeholderByID" returntype="void" output="false">
        <cfargument name="stakeholder_id" type="numeric" required="true">

        <cfif NOT this.checkPermission(session.user.id, "SH_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have SH_DELETE on this project.">
        </cfif>
        
        <cfquery name="removeStakeholderById" datasource="webwarecl">
            DELETE FROM pm_stakeholders WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.stakeholder_id#">
        </cfquery>
         
    </cffunction>


    <cffunction name="getTasks" returntype="query" output="false">

        <cfquery name="getTasks" datasource="webwarecl">
            SELECT * FROM pm_tasks 
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            ORDER BY task_complete, id
        </cfquery>

        <cfreturn getTasks>

    </cffunction>

    <cffunction name="getTasksByCompletion" returntype="query" output="false">
        <cfargument name="completion" type="numeric" required="true">

        <cfquery name="getTasksByCompletion" datasource="webwarecl">
            SELECT * FROM pm_tasks 
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            AND task_complete=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#arguments.completion#">
            ORDER BY task_priority
        </cfquery>

        <cfreturn getTasksByCompletion>
    </cffunction>

    <cffunction name="getTaskByID" returntype="query" output="false">
        <cfargument name="id" type="numeric" required="true">

        <cfquery name="getTaskByID" datasource="webwarecl">
            SELECT * FROM pm_tasks WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
        </cfquery>

        <cfreturn getTaskByID>
    </cffunction>

    <cffunction name="addTask" returntype="numeric" output="false">
        <cfargument name="task_name" type="string" required="true">
        <cfargument name="task_description" type="string" required="true">
        <cfargument name="assignee_assoc_id" type="numeric" required="true">
        <cfargument name="task_priority" type="string" required="true">

<!---
        <cfif NOT this.checkPermission(session.user.id, "TASK_ADD")>
            <cfthrow message="Permission Denied" detail="You do not have TASK_ADD on this project.">
        </cfif>
--->
        <cfset create_id = createUUID()>

        <cfquery name="addTask" datasource="webwarecl">
            INSERT INTO pm_tasks 
                (project_id, 
                task_name, 
                task_description, 
                assignee_assoc_id, 
                task_priority, 
                create_id)
            VALUES 
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.task_name#" maxlength="255">, 
                <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#HTMLEditFormat(arguments.task_description)#">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assignee_assoc_id#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.task_priority#" maxlength="45">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">)
        </cfquery>

        <cfquery name="getTaskID" datasource="webwarecl">
            SELECT id FROM pm_tasks WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">
        </cfquery>

        <cfset taskInfo = {
            task_name: arguments.task_name,
            task_priority: arguments.task_priority
        }>

        <cfif arguments.assignee_assoc_id NEQ 0>
            <cfset taskInfo.assignee = this.getUserByAssociationID(assignee_assoc_id)>
        <cfelse>
            <cfset taskInfo.assignee = "Unassigned">
        </cfif>

        <cfset this.notifyStakeholders("WF_TASK_CREATED", taskInfo)>

        <cfreturn getTaskID.id>

    </cffunction>

    <cffunction name="removeTask" returntype="void" output="false">
        <cfargument name="id" type="numeric" required="true">

        <cfif NOT this.checkPermission(session.user.id, "TASK_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have TASK_DELETE on this project.">
        </cfif>

        <cfquery name="removeTask" datasource="webwarecl">
            DELETE FROM pm_tasks WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_TASK_DELETED", {task_id: arguments.id})>
    </cffunction>

    <cffunction name="getTaskStatusName" returntype="string" output="false">
        <cfargument name="completion" type="numeric" required="true">

        <cfscript>
            switch (arguments.completion) {
                case 0: return "To-Do"; break;
                case 1: return "In Progress"; break;
                case 2: return "Done"; break;
            }

            return "Invalid Status";
        </cfscript>

    </cffunction> 

    <cffunction name="setTaskCompletion" returntype="void" output="false">
        <cfargument name="task_id" type="numeric" required="true">
        <cfargument name="completion" type="numeric" required="true">

        <cfset oldTask = this.getTaskByID(arguments.task_id)>

        <cfif session.current_association NEQ oldTask.assignee_assoc_id AND NOT this.checkPermission(session.user.id, "TASK_EDIT")>
            <cfthrow message="Permission Denied" detail="You do not have TASK_EDIT on this project.">
        </cfif>

        <cfset oldCompletion = this.getTaskStatusName(oldTask.task_complete)>


        <cfquery name="removeTask" datasource="webwarecl">
            UPDATE pm_tasks 
            SET task_complete=<cfqueryparam cfsqltype="cf_sql_tinyint" value="#arguments.completion#">
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_id#">
        </cfquery>

        <cfset newTask = this.getTaskByID(arguments.task_id)>
        <cfset newCompletion = this.getTaskStatusName(newTask.task_complete)>
        <cfset taskName = newTask.task_name>

        <cfset this.notifyStakeholders("WF_TASK_STATUS_CHANGED", {
            previousStatus: oldCompletion,
            currentStatus: newCompletion,
            taskName: taskName,
            perpetrator: session.user,
            taskId: arguments.task_id})>

    </cffunction>

    <cffunction name="setTaskPriority" returntype="void" output="false">
        <cfargument name="task_id" type="numeric" required="true">
        <cfargument name="priority" type="string" required="true">

        <cfset oldTask = this.getTaskByID(arguments.task_id)>

        <cfif session.current_association NEQ oldTask.assignee_assoc_id AND NOT this.checkPermission(session.user.id, "TASK_EDIT")>
            <cfthrow message="Permission Denied" detail="You do not have TASK_EDIT on this project.">
        </cfif>

        <cfquery name="setTaskPriority" datasource="webwarecl">
            UPDATE pm_tasks 
            SET task_priority=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.priority#" maxlength="45">
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_TASK_PRIORITY_CHANGED", {task_id: arguments.task_id, priority: arguments.priority})>
    </cffunction>

    <cffunction name="assignTask" returntype="void" output="false">
        <cfargument name="task_id" type="numeric" required="true">
        <cfargument name="assignee_assoc_id" type="numeric" required="true">

        <cfif NOT this.checkPermission(session.user.id, "TASK_EDIT")>
            <cfthrow message="Permission Denied" detail="You do not have TASK_EDIT on this project">
        </cfif>

        <cfquery name="assignTask" datasource="webwarecl">
            UPDATE pm_tasks 
            SET assignee_assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assignee_assoc_id#">
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.task_id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_TASK_ASSIGNED", {task_id: this.task_id, assignee: this.getUserByAssociationID(arguments.assignee_assoc_id)})>

    </cffunction>

    <cffunction name="getLocations" returntype="query" output="false">

        <cfquery name="getLocations" datasource="webwarecl">
            SELECT * FROM pm_locations 
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            ORDER BY location_name
        </cfquery>

        <cfreturn getLocations>

    </cffunction>

    <cffunction name="addLocation" returntype="void" output="false">
        <cfargument name="location_name" type="string" required="yes">
        <cfargument name="address" type="string" required="yes">
        <cfargument name="city" type="string" required="yes">
        <cfargument name="state" type="string" required="yes">
        <cfargument name="zip" type="string" required="yes">
        <cfargument name="subdivision" type="string" required="yes">
        <cfargument name="lot" type="string" required="yes">
        <cfargument name="block" type="string" required="yes">
        <cfargument name="trs_section" type="string" required="yes">
        <cfargument name="trs_township" type="string" required="yes">
        <cfargument name="trs_range" type="string" required="yes">
        <cfargument name="trs_meridian" type="string" required="yes">
        <cfargument name="latitude" type="string" required="yes">
        <cfargument name="longitude" type="string" required="yes">
        <cfargument name="elevation" type="string" required="yes">

        <cfif NOT this.checkPermission(session.user.id, "LOC_ADD")>
            <cfthrow message="Permission Denied" detail="You do not have LOC_ADD on this project.">
        </cfif>
        
        <cfset create_id = createUUID()>

        <cfquery name="addLocation" datasource="webwarecl">
            INSERT INTO pm_locations
                        (project_id,
                        location_name,
                        address,
                        city,
                        state,
                        zip,
                        subdivision,
                        lot,
                        block,
                        trs_section,
                        trs_township,
                        trs_range,
                        trs_meridian,
                        latitude,
                        longitude,
                        elevation,
                        create_id)
            VALUES      (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.location_name#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.address#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.city#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.state#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.zip#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.subdivision#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.lot#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.block#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.trs_section#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.trs_township#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.trs_range#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.trs_meridian#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.latitude#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.longitude#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.elevation#">,
                        <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#">)
        </cfquery>        

        <cfset this.notifyStakeholders("WF_LOCATION_CREATED", arguments)>
    </cffunction>

    <cffunction name="removeLocation" returntype="void" output="false">
        <cfargument name="location_id" type="numeric" required="true">

        <cfif NOT this.checkPermission(session.user.id, "LOC_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have LOC_DELETE on this project.">
        </cfif>

        <cfquery name="removeLocation" datasource="webwarecl">
            DELETE FROM pm_locations 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.location_id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_LOCATION_DELETED", arguments)>
    </cffunction>

    <cffunction name="addDeliverable" returntype="numeric" output="false">
        <cfargument name="deliverable_name" type="string" required="true">
        <cfargument name="deliverable_file_id" type="numeric" required="true">

<!---
        <cfif NOT this.checkPermission(session.user.id, "DEL_ADD")>
            <cfthrow message="Permission Denied" detail="You do not have DEL_ADD on this project.">
        </cfif>
--->
        <cfset create_id = createUUID()>

        <cfquery name="addDeliverable" datasource="webwarecl">
            INSERT INTO pm_deliverables 
                (project_id, 
                deliverable_name, 
                deliverable_file_id, 
                create_id)
            VALUES 
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.deliverable_name#" maxlength="45">, 
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.deliverable_file_id#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">)
        </cfquery>

        <cfquery name="getDeliverableID" datasource="webwarecl">
            SELECT id FROM pm_deliverables WHERE create_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#create_id#" maxlength="255">
        </cfquery>

        <cfset this.notifyStakeholders("WF_DELIVERABLE_CREATED", arguments)>

        <cfreturn getDeliverableID.id>
    </cffunction>

    <cffunction name="getDeliverables" returntype="query" output="false">
        <cfquery name="getDeliverables" datasource="webwarecl">
            SELECT * 
            FROM pm_deliverables 
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfreturn getDeliverables>
    </cffunction>

    <cffunction name="getDeliverableByID" returntype="query" output="false">
        <cfargument name="deliverable_id" type="numeric" required="true">

        <cfquery name="getDeliverableById" datasource="webwarecl">
            SELECT * 
            FROM pm_deliverables 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.deliverable_id#">
        </cfquery>

        <cfreturn getDeliverableById>
    </cffunction>

    <cffunction name="setDeliverableFileID" returntype="void" output="false">
        <cfargument name="deliverable_id" type="numeric" required="true">
        <cfargument name="deliverable_file_id" type="numeric" required="true">

        <cfif NOT this.checkPermission(session.user.id, "DEL_EDIT")>
            <cfthrow message="Permission Denied" detail="You do not have DEL_EDIT on this project.">
        </cfif>

        <cfquery name="setDeliverableFileID" datasource="webwarecl">
            UPDATE pm_deliverables 
            SET deliverable_file_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.deliverable_file_id#">
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.deliverable_id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_DELIVERABLE_FULFILLED", arguments)>

    </cffunction>

    <cffunction name="removeDeliverable" returntype="void" output="false">
        <cfargument name="deliverable_id" type="numeric" required="true">

        <cfif NOT this.checkPermission(session.user.id, "DEL_DELETE")>
            <cfthrow message="Permission Denied" detail="You do not have DEL_DELETE on this project.">
        </cfif>

        <cfquery name="removeDeliverable" datasource="webwarecl">
            DELETE FROM pm_deliverables 
            WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.deliverable_id#">
        </cfquery>

        <cfset this.notifyStakeholders("WF_DELIVERABLE_DELETED", arguments)>
    </cffunction>

    <cffunction name="getTags" returntype="array" output="false">

        <cfset result = []>

        <cfquery name="getTags" datasource="webwarecl">
            SELECT tag_text FROM pm_project_tags WHERE project_id=#this.id# ORDER BY tag_text
        </cfquery>

        <cfsilent>
            <cfoutput query="getTags">
                <cfset result.append(tag_text)>
            </cfoutput>
        </cfsilent>

        <cfreturn result>
     
    </cffunction>

    <cffunction name="addTag" returntype="void" output="false">
        <cfargument name="tag_text" type="string" required="true">

        <cfset this.removeTag(arguments.tag_text)>

        <cfquery name="addTag" datasource="webwarecl">
            INSERT INTO pm_project_tags 
                (project_id, 
                tag_text) 
            VALUES 
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">, 
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tag_text#" maxlength="45">)
        </cfquery>

    </cffunction>


    <cffunction name="removeTag" returntype="void" output="false">        
        <cfargument name="tag_text" type="string" required="true">

        <cfquery name="removeTag" datasource="webwarecl">
            DELETE FROM pm_project_tags 
            WHERE project_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            AND tag_text=<cfqueryparam cfsqltype="cf_sql_varchar" value="#arguments.tag_text#" maxlength="45">
        </cfquery>

    </cffunction>

    <cffunction name="getTaskComments" returntype="array" output="false">
        <cfargument name="id" type="numeric" required="true">
        <cfset result = []>

        <cfquery name="getComments" datasource="webwarecl">
            SELECT id AS post_id 
            FROM posts 
            WHERE recipient_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
            AND post_class="TASK" 
            AND parent_post_id=0 
            ORDER BY post_date DESC
        </cfquery>

        <cfoutput query="getComments">
            <cfset post = new Prefiniti.SocialNetworking.Post()>
            <cfset result.append(post.retrieve(post_id))>
        </cfoutput>

        <cfreturn result>
    </cffunction>


    <cffunction name="getComments" returntype="array" output="false">

        <cfset result = []>

        <cfquery name="getComments" datasource="webwarecl">
            SELECT id FROM posts WHERE recipient_id=#this.id# AND post_class="PJCT" AND parent_post_id=0 ORDER BY post_date DESC
        </cfquery>

        <cfoutput query="getComments">
            <cfset result.append(new Prefiniti.SocialNetworking.Post().retrieve(id))>
        </cfoutput>

        <cfreturn result>
    </cffunction>

    <cffunction name="getStatus" returntype="string" output="false">

        <cfscript>
            var class = "";

            switch(this.project_status) {
                case "Active":
                    class = "label label-primary";
                    break;
                case "Billed":
                    class = "label label-warning";
                    break;
                case "Paid":
                    class = "label label-success";
                    break;
                case "Delinquent":
                    class = "label label-danger";
                    break;
                case "Closed":
                    class = "label label-danger";
                    break;

            }

            return "<span class=""" & class & """>" & this.project_status & "</span>"
        </cfscript>

    </cffunction>

    <cffunction name="isOverdue" returntype="boolean" output="false">

        <cfif this.project_status EQ "Closed">
            <cfreturn false>
        </cfif>

        <cfset diff = dateCompare(now(), this.project_due_date)>

        <cfif diff EQ 0>
            <cfreturn true>
        </cfif>

        <cfif diff EQ 1>
            <cfreturn true>
        </cfif>

        <cfif diff EQ -1>
            <cfreturn false>
        </cfif>

    </cffunction>    


    <cffunction name="getPriority" returntype="string" output="false">

        <cfscript>
            var class = "";
            var message = "";

            switch(this.project_priority) {
                case 0:
                    class = "text-success";
                    message = "Low Priority";
                    break;
                case 1:
                    class = "text-primary";
                    message = "Medium Priority";
                    break;
                case 2:
                    class = "text-warning";
                    message = "High Priority";
                    break;
                case 3:
                    class = "text-danger";
                    message = "Critical";
                    break;
            }

            return "<span><i class=""fa fa-circle " & class & """></i> " & message & "</span>";
        </cfscript>

    </cffunction>

    <cffunction name="saveToNewTemplate" returntype="void" output="false">
        <cfargument name="template_name" type="string" required="true">

        <cfset template = new Prefiniti.ProjectManagement.Template()>
        
        <cfset template.template_name = arguments.template_name>
        <cfset template.save()>

        <cfset tasks = this.getTasks()>
        <cfset deliverables = this.getDeliverables()>

        <cfoutput query="tasks">
            <cfset template.addTask(task_name, task_priority)>
        </cfoutput>

        <cfoutput query="deliverables">
            <cfset template.addDeliverable(deliverable_name)>
        </cfoutput>

        <cfset this.template_id = template.id>
        <cfset this.save()>
    </cffunction>

    <cffunction name="updateTemplate" returntype="void" output="false">

        <cfif this.template_id EQ 0>
            <cfreturn>
        </cfif>

        <cfset template = new Prefiniti.ProjectManagement.Template().open(this.template_id)>
        <cfset template.removeAllElements()>

        <cfset tasks = this.getTasks()>
        <cfset deliverables = this.getDeliverables()>

        <cfoutput query="tasks">
            <cfset template.addTask(task_name, task_priority)>
        </cfoutput>

        <cfoutput query="deliverables">
            <cfset template.addDeliverable(deliverable_name)>
        </cfoutput>

    </cffunction>

    <cffunction name="applyTemplate" returntype="void" output="false">
        <cfargument name="template_id" type="numeric" required="true">

        <cfif arguments.template_id EQ 0>
            <cfreturn>
        </cfif>

        <cfset template = new Prefiniti.ProjectManagement.Template().open(arguments.template_id)>
        <cfset tasks = template.getTasks()>
        <cfset deliverables = template.getDeliverables()>

        <cfloop array="#tasks#" item="task">
            <cfset this.addTask(task.task_name, "", 0, task.task_priority)>
        </cfloop>

        <cfloop array="#deliverables#" item="deliverable">
            <cfset this.addDeliverable(deliverable.deliverable_name, 0)>
        </cfloop>

    </cffunction>

</cfcomponent>