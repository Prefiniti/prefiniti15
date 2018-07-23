<cfcomponent extends="Prefiniti.Base" output="true">

    <cffunction name="init" returntype="Prefiniti.RealtimeNotification" output="false">
        <cfargument name="template" type="string" required="true">
        <cfargument name="recipient" type="Prefiniti.Authentication.UserAccount" required="true">        
        <cfargument name="fields" type="struct" required="true">

        <cfset this.template = arguments.template>
        <cfset this.recipient = arguments.recipient>       
        <cfset this.fields = arguments.fields>

        <cfreturn this>
    </cffunction>

    <cffunction name="send" returntype="void" output="false">

        <cfset templatePath = "/notification_templates/rt/" & this.template & ".cfm">

        <cfsavecontent variable="messageBody">
            <cftry>
                <cfmodule template="#templatePath#" attributecollection="#this.fields#">
                <cfcatch type="any">
                    No RealtimeNotification template found for <cfoutput>#this.template#</cfoutput>
                </cfcatch>
            </cftry>
        </cfsavecontent>

        <cfquery name="savert" datasource="webwarecl">
            INSERT INTO realtime_notifications
            (created_date,
            recipient_id,
            notification_text)
            VALUES
            (<cfqueryparam cfsqltype="cf_sql_timestamp" value="#createODBCDateTime(now())#">,
            <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.recipient.id#">,
            <cfqueryparam cfsqltype="cf_sql_varchar" value="#trim(messageBody)#">)
        </cfquery>
        
    </cffunction>

</cfcomponent>
<!---
realtime_notifications
+-------------------+---------------------+------+-----+---------+----------------+
| Field             | Type                | Null | Key | Default | Extra          |
+-------------------+---------------------+------+-----+---------+----------------+
| id                | bigint(20)          | NO   | PRI | NULL    | auto_increment |
| created_date      | datetime            | NO   |     | NULL    |                |
| delivered         | tinyint(4)          | NO   |     | 0       |                |
| viewed            | tinyint(4)          | NO   |     | 0       |                |
| recipient_id      | bigint(20) unsigned | NO   | MUL | NULL    |                |
| notification_text | text                | YES  |     | NULL    |                |
+-------------------+---------------------+------+-----+---------+----------------+
--->