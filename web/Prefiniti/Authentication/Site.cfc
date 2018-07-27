<cfcomponent extends="Prefiniti.Base" output="false">

    <cffunction name="init" returntype="Prefiniti.Authentication.Site" output="false">
        <cfargument name="site_id" type="numeric" required="true">

        <cfquery name="getSite" datasource="sites">
            SELECT * FROM sites WHERE SiteID=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.site_id#">
        </cfquery>

        <cfoutput query="getSite">
            <cfscript>
                this.SiteID = SiteID;
                this.SiteName = SiteName;
                this.industry = industry;
                this.logo_file_id = logo_file_id;
                this.admin_id = admin_id;
                this.enabled = enabled;
                this.summary = summary;
                this.about = about;
                this.mission_statement = mission_statement;
                this.vision_statement = vision_statement;
                this.slogan = slogan;
                this.billing_plan = billing_plan;
                this.conf_id = conf_id;
                this.salestax_rate = salestax_rate;
                this.address = address;
                this.city = city;
                this.state = state;
                this.zip = zip;
                this.phone = phone;
                this.fax = fax;
                this.website = website;
                this.contact_email = contact_email;
                this.sales_email = sales_email;
                this.billing_email = billing_email;
                this.facebook_handle = facebook_handle;
                this.twitter_handle = twitter_handle;
                this.instagram_handle = instagram_handle;
                this.linkedin_handle = linkedin_handle;
                this.youtube_handle = youtube_handle;
            </cfscript>
        </cfoutput>

        <cfreturn this>

    </cffunction>

    <cffunction name="employees" returntype="array" output="false">

        <cfset result = []>

        <cfquery name="emp" datasource="sites">
            SELECT  user_id, id FROM site_associations
            WHERE site_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.SiteID#">
            AND assoc_type=1
        </cfquery>  

        <cfoutput query="emp">
            <cfset result.append({
                user: new Prefiniti.Authentication.UserAccount({id: user_id}, false),
                association: new Prefiniti.Authentication.SiteAssociation(id)
            })>
        </cfoutput>

        <cfreturn result>

    </cffunction>

    <cffunction name="clients" returntype="array" output="false">

        <cfset result = []>

        <cfquery name="cli" datasource="sites">
            SELECT user_id, id FROM site_associations
            WHERE site_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.SiteID#">
            AND assoc_type=0
        </cfquery>  

        <cfoutput query="cli">
            <cfset result.append({
                user: new Prefiniti.Authentication.UserAccount({id: user_id}, false),
                association: new Prefiniti.Authentication.SiteAssociation(id)
            })>
        </cfoutput>

        <cfreturn result>

    </cffunction>

    <cffunction name="everyone" returntype="array" output="false">

        <cfset result = []>

        <cfquery name="cli" datasource="sites">
            SELECT user_id, id FROM site_associations
            WHERE site_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.SiteID#">            
        </cfquery>  

        <cfoutput query="cli">
            <cfset result.append({
                user: new Prefiniti.Authentication.UserAccount({id: user_id}, false),
                association: new Prefiniti.Authentication.SiteAssociation(id)
            })>
        </cfoutput>

        <cfreturn result>

    </cffunction>

    <cffunction name="projects" returntype="struct" output="false">

        <cfscript>
            var result = {};
        </cfscript> 
        
        <cfset people = this.everyone()>

        <cfloop array="#people#" item="person">
            <cfset personProjects = person.association.getProjects()>

            <cfloop struct="#personProjects#" item="id">
                <cfif NOT structKeyExists(result, id)>
                    <cfset result["#id#"] = {}>
                </cfif>
                <cfset result[id]["project"] = new Prefiniti.ProjectManagement.Project(id)>
            </cfloop>

        </cfloop>

        <cfreturn result>

    </cffunction>

</cfcomponent>