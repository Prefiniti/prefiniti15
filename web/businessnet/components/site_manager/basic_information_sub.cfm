<cfheader name="Content-Type" value="application/json">
<cfset prefiniti = new Prefiniti.Base()>

<cftry>

    <cfquery name="updateBasic" datasource="sites">
        UPDATE sites
        SET SiteName=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.SiteName#">,
            industry=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.industry#">,
            slogan=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.slogan#">,
            summary=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.summary#">,
            website=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.website#">,
            phone=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.phone#">,
            fax=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.fax#">,
            contact_email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.contact_email#">,
            sales_email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.sales_email#">,
            billing_email=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.billing_email#">,
            facebook_handle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.facebook_handle#">,
            twitter_handle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.twitter_handle#">,
            instagram_handle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.instagram_handle#">,
            linkedin_handle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.linkedin_handle#">,
            youtube_handle=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.youtube_handle#">,
            address=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.address#">,
            city=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.city#">,
            state=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.state#">,
            zip=<cfqueryparam cfsqltype="cf_sql_varchar" value="#form.zip#">,
            about=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.about#">,
            mission_statement=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.mission_statement#">,
            vision_statement=<cfqueryparam cfsqltype="cf_sql_longvarchar" value="#form.vision_statement#">
        WHERE SiteID=<cfqueryparam cfsqltype="cf_sql_bigint" value="#session.current_site_id#">
    </cfquery>

    <cfset result = {
        ok: true,
        message: "General Settings updated."
    }>

    <cfcatch type="any">
        <cfset result = {
            ok: false,
            message: "Error updating general settings."
        }>

    </cfcatch>
</cftry>

<cfoutput>#serializeJSON(result)#</cfoutput>