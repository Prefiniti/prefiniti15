<cfcomponent extends="Prefiniti.Base" output="false">

    <cffunction name="init" returntype="Prefiniti.ProjectManagement.Project" output="false">
        <cfargument name="id" type="numeric" required="yes" default="0">
        <cfargument name="template_id" type="numeric" required="yes" default="0">

        <cfscript>
            this.id = arguments.id;
            this.employee_assoc = session.current_association;
            this.client_assoc = session.current_association;
            this.template_id = arguments.template_id;
            this.project_name = "";
            this.project_start_date = createODBCDate(now());
            this.project_due_date = createODBCDate(now());
            this.project_description = "";
            this.project_created = createODBCDate(now());
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
                    this.project_start_date = project_start_date;
                    this.project_due_date = project_due_date;
                    this.project_description = project_description;
                    this.project_created = project_created;
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
                   project_start_date=#this.project_start_date#,
                   project_due_date=#this.project_due_date#,
                   project_description="#this.project_description#"
            WHERE  id=#this.id#
        </cfquery>

        <cfreturn this>

    </cffunction>



</cfcomponent>