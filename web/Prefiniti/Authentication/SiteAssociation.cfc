<cfcomponent output="false">

    <cffunction name="init" returntype="Prefiniti.Authentication.SiteAssociation" output="false">
        <cfargument name="assoc_id" type="numeric" required="true">

        <cfquery name="getAssoc" datasource="sites">
            SELECT * FROM site_associations WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.assoc_id#">
        </cfquery>

        <cfoutput query="getAssoc">
            <cfscript>
                this.id = id;
                this.user_id = user_id;
                this.user = new Prefiniti.Authentication.UserAccount({id: this.user_id}, false);
                this.site_id = site_id;
                this.site = new Prefiniti.Authentication.Site(this.site_id);
            </cfscript>
        </cfoutput>

        <cfreturn this>
    </cffunction>

    <cffunction name="getProjects" returntype="struct" output="false">

        <cfset result = {}>

        <cfquery name="getProjectsBase" datasource="webwarecl">
            SELECT id 
            FROM pm_projects 
            WHERE employee_assoc=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            OR client_assoc=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfoutput query="getProjectsBase">
            <cfif NOT structKeyExists(result, id)>
                <cfset result["#id#"] = {}>
            </cfif>
            <cfset result[id]["project"] = new Prefiniti.ProjectManagement.Project(id)>
        </cfoutput>

        <cfquery name="getProjectsByStakeholder" datasource="webwarecl">
            SELECT DISTINCT project_id AS id
            FROM pm_stakeholders
            WHERE assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfoutput query="getProjectsByStakeholder">
            <cfif NOT structKeyExists(result, id)>
                <cfset result["#id#"] = {}>
            </cfif>
            <cfset result[id]["project"] = new Prefiniti.ProjectManagement.Project(id)>
        </cfoutput>

        <cfreturn result>

    </cffunction>

    <cffunction name="getUnbilledHours" returntype="query" output="false">

        <cfquery name="getUH" datasource="webwarecl">
            SELECT * FROM pm_time_entries 
            WHERE assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> 
            AND billed=0
            AND closed=1
        </cfquery>

        <cfreturn getUH>

    </cffunction>

    <cffunction name="getBilledHours" returntype="query" output="false">

        <cfquery name="getBH" datasource="webwarecl">
            SELECT * FROM pm_time_entries 
            WHERE assoc_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#"> 
            AND billed=1
            AND closed=1
        </cfquery>

        <cfreturn getBH>

    </cffunction>

</cfcomponent>