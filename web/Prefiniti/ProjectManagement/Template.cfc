<cfcomponent extends="Prefiniti.Base">

    <cffunction name="init" returntype="Prefiniti.ProjectManagement.Template" output="false">

        <cfscript>
            this.id = -1;
            this.template_name = "";
            this.template_site = session.current_site_id;
            this.saved = false;
        </cfscript>

        <cfreturn this>

    </cffunction>

    <cffunction name="open" returntype="Prefiniti.ProjectManagement.Template" output="false">
        <cfargument name="template_id" type="numeric" required="true">

        <cfquery name="openTpl" datasource="webwarecl">
            SELECT * FROM pm_templates WHERE id=#arguments.template_id#
        </cfquery>

        <cfoutput query="openTpl">
            <cfset this.id = id>
            <cfset this.template_name = template_name>
            <cfset this.template_site = template_site>
        </cfoutput>

        <cfreturn this>

    </cffunction>

    <cffunction name="save" returntype="Prefiniti.ProjectManagement.Template" output="false">

        <cfset create_id = createUUID()>

        <cfquery name="saveTpl" datasource="webwarecl">
            INSERT INTO pm_templates (template_site, template_name, create_id)
            VALUES (#this.template_site#, "#this.template_name#", "#create_id#")
        </cfquery>

        <cfquery name="getTplId" datasource="webwarecl">
            SELECT id FROM pm_templates WHERE create_id="#create_id#"
        </cfquery>

        <cfset this.id = getTplId.id>
        <cfset this.saved = true>

        <cfreturn this>
    </cffunction>

    <cffunction name="update" returntype="Prefiniti.ProjectManagement.Template" output="false">

        <cfquery name="updateTpl" datasource="webwarecl">
            UPDATE pm_templates 
            SET     template_name="#this.template_name#",
                    template_site=#this.template_site#
        </cfquery>

        <cfset this.saved = true>

        <cfreturn this>

    </cffunction>

    <cffunction name="addTask" returntype="void" output="false">
        <cfargument name="task_name" type="string" required="true">
        <cfargument name="task_priority" type="string" required="true">

        <cfquery name="addTask" datasource="webwarecl">
            INSERT INTO pm_template_tasks (template_id, task_name, task_priority, create_id)
            VALUES (#this.id#, "#arguments.task_name#", "#arguments.task_priority#", "#createUUID()#")
        </cfquery>
    </cffunction>

    <cffunction name="getTasks" returntype="array" output="false">

        <cfset result = []>

        <cfquery name="getTasks" datasource="webwarecl">
            SELECT * FROM pm_template_tasks WHERE template_id=#this.id#
        </cfquery>

        <cfoutput query="getTasks">

            <cfset result.append({
                task_name: task_name,
                task_priority: task_priority
            })>

        </cfoutput>

        <cfreturn result>

    </cffunction>

    <cffunction name="addDeliverable" returntype="void" output="false">
        <cfargument name="deliverable_name" type="string" required="true">
       
        <cfquery name="addDeliverable" datasource="webwarecl">
            INSERT INTO pm_template_deliverables (template_id, deliverable_name, create_id)
            VALUES (#this.id#, "#arguments.deliverable_name#",  "#createUUID()#")
        </cfquery>
    </cffunction>

    <cffunction name="getDeliverables" returntype="array" output="false">

        <cfset result = []>

        <cfquery name="getDeliverables" datasource="webwarecl">
            SELECT * FROM pm_template_deliverables WHERE template_id=#this.id#
        </cfquery>

        <cfoutput query="getDeliverables">

            <cfset result.append({
                deliverable_name: deliverable_name
            })>

        </cfoutput>

        <cfreturn result>

    </cffunction>

    <cffunction name="removeAllElements" returntype="Prefiniti.ProjectManagement.Template" output="false">

        <cfquery name="rmTasks" datasource="webwarecl">
            DELETE FROM pm_template_tasks WHERE template_id=#this.id#
        </cfquery>

        <cfquery name="rmDeliverables" datasource="webwarecl">
            DELETE FROM pm_template_deliverables WHERE template_id=#this.id#
        </cfquery>

        <cfreturn this>

    </cffunction>

</cfcomponent>