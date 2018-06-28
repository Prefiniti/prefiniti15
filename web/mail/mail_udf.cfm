<cfinclude template="/contentmanager/cm_udf.cfm">

<cffunction name="mailGetAttachments" returntype="query">
	<cfargument name="msg_id" type="numeric" required="yes">
    
   	<cfquery name="mga" datasource="webwarecl">
    	SELECT * FROM mail_attachments WHERE msg_id=#msg_id#
	</cfquery>
    
    <cfreturn #mga#>
</cffunction>            

<cffunction name="getMailbox" returntype="query">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="mailbox" type="string" required="yes">
    <cfargument name="limit" type="numeric" required="no">

    <cfquery name="mail" datasource="webwarecl">
        <cfswitch expression="#arguments.mailbox#">
            <cfcase value="inbox">
                SELECT      messageinbox.id AS msgid, 
                            messageinbox.tbody, 
                            messageinbox.tsubject, 
                            messageinbox.tdate, 
                            messageinbox.tread, 
                            users.id AS sender_id, 
                            users.username, 
                            users.longName 
                FROM        messageinbox 
                INNER JOIN  users 
                ON          users.id=messageinbox.fromuser 
                WHERE       messageinbox.touser=#arguments.user_id# 
                AND         messageinbox.deleted_inbox=0                 
                ORDER BY    messageinbox.tdate 
                DESC
                <cfif isDefined("arguments.limit")>
                    LIMIT #arguments.limit#
                </cfif>
            </cfcase>
            <cfcase value="sent messages">
                SELECT      messageinbox.id AS msgid, 
                            messageinbox.tbody, 
                            messageinbox.tsubject, 
                            messageinbox.tdate, 
                            messageinbox.tread, 
                            messageinbox.touser,
                            users.username, 
                            users.longName, 
                            users.id AS sender_id 
                FROM        messageinbox 
                INNER JOIN  users 
                ON          users.id=messageinbox.fromuser 
                WHERE       messageinbox.fromuser=#arguments.user_id# 
                AND         messageinbox.deleted_outbox=0                
                ORDER BY    messageinbox.tread, 
                            messageinbox.tdate 
                DESC
                <cfif isDefined("arguments.limit")>
                    LIMIT #arguments.limit#
                </cfif>
            </cfcase>
        </cfswitch> 
        
    </cfquery>

    <cfreturn mail>

</cffunction> 

