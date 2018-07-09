<cfcomponent extends="Prefiniti.Base" output="false">

    <cffunction name="init" returntype="Prefiniti.ProjectManagement.Project" output="false">
        <cfargument name="id" type="numeric" required="true" default="0">
        <cfargument name="template_id" type="numeric" required="true" default="0">

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
        </cfscript>

        <cfquery name="checkIfProjectExists" datasource="webwarecl">
            SELECT * FROM pm_projects WHERE id=#this.id#
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
                </cfscript>
            </cfoutput>

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
                    (#this.employee_assoc#,
                     #this.client_assoc#,
                     #this.template_id#,
                     "#this.project_name#",
                     1,
                     '#this.project_status#',
                     #this.project_start_date#,
                     #this.project_due_date#,
                     "#this.project_description#",
                     #this.project_created#,
                     "#create_id#")
            </cfquery>

            <cfquery name="getProjectID" datasource="webwarecl">
                SELECT id FROM pm_projects WHERE create_id="#create_id#"
            </cfquery>

            <cfreturn new Prefiniti.ProjectManagement.Project(getProjectID.id, this.template_id)>
        </cfif>        

    </cffunction>

    <cffunction name="save" returntype="Prefiniti.ProjectManagement.Project" output="false">

        <cfquery name="updateProject" datasource="webwarecl">
            UPDATE pm_projects
            SET    employee_assoc=#this.employee_assoc#,
                   client_assoc=#this.client_assoc#,
                   project_name="#this.project_name#",
                   project_status="#this.project_status#",
                   project_start_date=#this.project_start_date#,
                   project_due_date=#this.project_due_date#,
                   project_description="#this.project_description#",
                   project_priority=#this.project_priority#
            WHERE  id=#this.id#
        </cfquery>

        
        <cfset this.addStakeholder(this.client_assoc, "Client")>
        <cfset this.addStakeholder(this.employee_assoc, "Project Manager")>

        <cfset this.addTag(this.project_name)>
        <cfset this.addTag(this.project_client.longName)>
        <cfset this.addTag(this.project_employee.longName)>

        <cfreturn this>

    </cffunction>

    <cffunction name="getIncompleteTaskCount" returntype="numeric" output="false">
        
        <cfquery name="getIncompleteTaskCount" datasource="webwarecl">
            SELECT id FROM pm_tasks WHERE project_id=#this.id# AND task_complete=0
        </cfquery>
    
        <cfreturn getIncompleteTaskCount.recordCount>

    </cffunction>

    <cffunction name="getCompleteTaskCount" returntype="numeric" output="false">
        
        <cfquery name="getCompleteTaskCount" datasource="webwarecl">
            SELECT id FROM pm_tasks WHERE project_id=#this.id# AND task_complete=1
        </cfquery>
    
        <cfreturn getCompleteTaskCount.recordCount>
        
    </cffunction>

    <cffunction name="getTaskCount" returntype="numeric" output="false">

        <cfreturn this.getTasks().recordCount>

    </cffunction>

    <cffunction name="getPercentComplete" returntype="numeric" output="false">
        <cfreturn this.getPercentage(this.getCompleteTaskCount(), this.getTaskCount())>
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

        <cfset this.removeStakeholder(arguments.assoc_id, arguments.stakeholder_type)>

        <cfquery name="addStakeholder" datasource="webwarecl">
            INSERT INTO pm_stakeholders (create_id, project_id, assoc_id, stakeholder_type)
            VALUES                      ("#createUUID()#", #this.id#, #arguments.assoc_id#, "#arguments.stakeholder_type#")
        </cfquery>

        <cfset this.addTag(this.getUserByAssociationID(arguments.assoc_id).longName)>
    </cffunction>

    <cffunction name="removeStakeholder" returntype="void" output="false">
        <cfargument name="assoc_id" type="numeric" required="true">
        <cfargument name="stakeholder_type" type="string" required="true">

        <cfquery name="removeStakeholder" datasource="webwarecl">
            DELETE FROM pm_stakeholders WHERE project_id=#this.id# AND assoc_id=#arguments.assoc_id# AND stakeholder_type="#arguments.stakeholder_type#"
        </cfquery>

         <cfset this.removeTag(this.getUserByAssociationID(arguments.assoc_id).longName)>
    </cffunction>

    <cffunction name="removeStakeholderByID" returntype="void" output="false">
        <cfargument name="stakeholder_id" type="numeric" required="true">
        
        <cfquery name="removeStakeholderById" datasource="webwarecl">
            DELETE FROM pm_stakeholders WHERE id=#arguments.stakeholder_id#
        </cfquery>
         
    </cffunction>


    <cffunction name="getTasks" returntype="query" output="false">

        <cfquery name="getTasks" datasource="webwarecl">
            SELECT * FROM pm_tasks WHERE project_id=#this.id# ORDER BY task_complete, id
        </cfquery>

        <cfreturn getTasks>

    </cffunction>

    <cffunction name="addTask" returntype="numeric" output="false">
        <cfargument name="task_name" type="string" required="true">

        <cfset create_id = createUUID()>

        <cfquery name="addTask" datasource="webwarecl">
            INSERT INTO pm_tasks (project_id, task_name, create_id)
            VALUES (#this.id#, "#arguments.task_name#", "#create_id#")
        </cfquery>

        <cfquery name="getTaskID" datasource="webwarecl">
            SELECT id FROM pm_tasks WHERE create_id="#create_id#"
        </cfquery>

        <cfreturn getTaskID.id>

    </cffunction>

    <cffunction name="removeTask" returntype="void" output="false">
        <cfargument name="id" type="numeric" required="true">

        <cfquery name="removeTask" datasource="webwarecl">
            DELETE FROM pm_tasks WHERE id=#arguments.id#
        </cfquery>
    </cffunction>

    <cffunction name="setTaskCompletion" returntype="void" output="false">
        <cfargument name="task_id" type="numeric" required="true">
        <cfargument name="completion" type="numeric" required="true">

        <cfquery name="removeTask" datasource="webwarecl">
            UPDATE pm_tasks SET task_complete=#arguments.completion# WHERE id=#arguments.task_id#
        </cfquery>
    </cffunction>

    <cffunction name="getLocations" returntype="query" output="false">

        <cfquery name="getLocations" datasource="webwarecl">
            SELECT * FROM pm_locations WHERE project_id=#this.id# ORDER BY location_name
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
            VALUES      (#this.id#,
                        "#arguments.location_name#",
                        "#arguments.address#",
                        "#arguments.city#",
                        "#arguments.state#",
                        "#arguments.zip#",
                        "#arguments.subdivision#",
                        "#arguments.lot#",
                        "#arguments.block#",
                        "#arguments.trs_section#",
                        "#arguments.trs_township#",
                        "#arguments.trs_range#",
                        "#arguments.trs_meridian#",
                        "#arguments.latitude#",
                        "#arguments.longitude#",
                        "#arguments.elevation#",
                        "#create_id#")
        </cfquery>        
    </cffunction>

    <cffunction name="removeLocation" returntype="void" output="false">
        <cfargument name="location_id" type="numeric" required="true">

        <cfquery name="removeLocation" datasource="webwarecl">
            DELETE FROM pm_locations WHERE id=#arguments.location_id#
        </cfquery>
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
            INSERT INTO pm_project_tags (project_id, tag_text) VALUES (#this.id#, "#arguments.tag_text#")
        </cfquery>

    </cffunction>


    <cffunction name="removeTag" returntype="void" output="false">        
        <cfargument name="tag_text" type="string" required="true">

        <cfquery name="removeTag" datasource="webwarecl">
            DELETE FROM pm_project_tags WHERE project_id=#this.id# AND tag_text="#arguments.tag_text#"
        </cfquery>

    </cffunction>

    <cffunction name="getTaskComments" returntype="array" output="false">
        <cfargument name="id" type="numeric" required="true">
        <cfset result = []>

        <cfquery name="getComments" datasource="webwarecl">
            SELECT id AS post_id FROM posts WHERE recipient_id=#arguments.id# AND post_class="TASK" AND parent_post_id=0 ORDER BY post_date DESC
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





</cfcomponent>