<cfcomponent extends="Prefiniti.Base">

    <cffunction name="init" returntype="Prefiniti.PrivateMessage" output="false">
        <cfargument name="id" type="numeric" required="false">

        <cfset this.reset()>

        <cfif isDefined("arguments.id")>
            <!--- open existing message --->
            <cfquery name="openMessage" datasource="webwarecl">
                SELECT * FROM messageinbox WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.id#">
            </cfquery>

            <cfif openMessage.recordCount EQ 0>
                <cfthrow message="Invalid message ID" detail="Invalid message ID. No such message in database.">
            </cfif>

            <cfif openMessage.touser NEQ session.user.id AND openMessage.fromuser NEQ session.user.id>
                <cfthrow message="Access Denied" detail="You must be either the sender or the recipient of a message in order to view it.">
            </cfif>

            <cfoutput query="openMessage">
                <cfscript>
                    this.id = id;
                    this.fromuser = fromuser;
                    this.from = new Prefiniti.Authentication.UserAccount({id: this.fromuser}, false);
                    this.touser = touser;
                    this.to = new Prefiniti.Authentication.UserAccount({id: this.touser}, false);
                    this.tsubject = tsubject;
                    this.tbody = tbody;
                    this.draft = draft;
                    this.tdate = tdate;
                    this.tread = tread;
                    this.read_receipt = read_receipt;
                    this.deleted_recipient_inbox = deleted_recipient_inbox;
                    this.deleted_sender_outbox = deleted_sender_outbox;
                    this.req_id = req_id;

                    this.opened = true;

                    this.attachments = this.getAttachments();
                    
                </cfscript>
            </cfoutput>

        </cfif>            

        <cfreturn this>
    </cffunction>

    <cffunction name="reset" returntype="void" output="false">
        <cfscript>
            this.id = 0;
            this.fromuser = 0;
            this.touser = 0;
            this.tsubject ="";
            this.tbody = "";
            this.draft = 0;
            this.tdate = createODBCDateTime(now());
            this.tread = 0;
            this.read_receipt = 0;
            this.deleted_recipient_inbox = 0;
            this.deleted_sender_outbox = 0;
            this.req_id = createUUID();
            this.from = "";
            this.to = "";
            this.attachments = [];

            this.opened = false;
        </cfscript>
    </cffunction>

    <cffunction name="save" returntype="Prefiniti.PrivateMessage" output="false">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfset this.req_id = createUUID()>

        <cfquery name="createMessage" datasource="webwarecl">
            INSERT INTO messageinbox
                (fromuser,
                touser,
                tsubject,
                tbody,
                tdate,
                read_receipt,
                req_id)
            VALUES
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.fromuser#">,
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#this.touser#">,
                <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#this.tsubject#">,
                <cfqueryparam cfsqltype="cf_sql_longvarchar" value="#this.tbody#">,
                <cfqueryparam cfsqltype="cf_sql_timestamp" value="#createODBCDateTime(now())#">,
                <cfqueryparam cfsqltype="cf_sql_tinyint" value="#this.read_receipt#">,
                <cfqueryparam cfsqltype="cf_sql_varchar" value="#this.req_id#" maxlength="255">)
        </cfquery>

        <cfquery name="getMsgID" datasource="webwarecl">
            SELECT id FROM messageinbox WHERE req_id=<cfqueryparam cfsqltype="cf_sql_varchar" value="#this.req_id#" maxlength="255">
        </cfquery>

        <cfset this.id = getMsgID.id>
        <cfreturn this>

    </cffunction>



    <cffunction name="deleteFromInbox" returntype="Prefiniti.PrivateMessage" output="false">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="deleteFromInbox" datasource="webwarecl">
            UPDATE messageinbox SET deleted_recipient_inbox=1 WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.deleted_recipient_inbox = 1>

        <cfset this.garbageCollect()>

        <cfreturn this>
    </cffunction>

    <cffunction name="deleteFromOutbox" returntype="Prefiniti.PrivateMessage" output="false">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="deleteFromOutbox" datasource="webwarecl">
            UPDATE messageinbox SET deleted_sender_outbox=1 WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.deleted_sender_outbox = 1>

        <cfset this.garbageCollect()>

        <cfreturn this>
    </cffunction>

    <cffunction name="markAsRead" returntype="Prefiniti.PrivateMessage" output="false">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="markAsRead" datasource="webwarecl">
            UPDATE messageinbox SET tread=1 WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.tread = 1>

        <cfreturn this>
    </cffunction>

    <cffunction name="markAsUnread" returntype="Prefiniti.PrivateMessage" output="false">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="markAsUnread" datasource="webwarecl">
            UPDATE messageinbox SET tread=0 WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.tread = 0>

        <cfreturn this>
    </cffunction>

    <cffunction name="send" returntype="Prefiniti.PrivateMessage" output="false">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="send" datasource="webwarecl">
            UPDATE messageinbox SET draft=0 WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.draft = 0>

        <cfreturn this>
    </cffunction>

    <cffunction name="getAttachments" returntype="array" output="false">
        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfreturn []>
    </cffunction>

    <cffunction name="addAttachment" returntype="void" output="false">
        <cfargument name="file_id" type="numeric" required="true">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="addAttachment" datasource="webwarecl">
            INSERT INTO mail_attachments 
                (msg_id, 
                file_id) 
            VALUES
                (<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">,
                <cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.file_id#">)
        </cfquery>

    </cffunction>

    <cffunction name="removeAttachment" returntype="void" output="false">
        <cfargument name="file_id" type="numeric" required="true">

        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="removeAttachment" datasource="webwarecl">
            DELETE FROM mail_attachments 
            WHERE   msg_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
            AND     file_id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#arguments.file_id#">
        </cfquery>

    </cffunction>

    <cffunction name="garbageCollect" returntype="void" output="false">
        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfif this.deleted_recipient_inbox EQ 1 AND this.deleted_sender_outbox EQ 1>
            <cfset this.expunge()>
        </cfif>
    </cffunction>

    <cffunction name="expunge" returntype="Prefiniti.PrivateMessage" output="false">
        <cfif NOT this.opened>
            <cfthrow message="Not opened.">
        </cfif>

        <cfquery name="expunge" datasource="webwarecl">
            DELETE FROM messageinbox WHERE id=<cfqueryparam cfsqltype="cf_sql_bigint" value="#this.id#">
        </cfquery>

        <cfset this.reset()>

        <cfreturn this>
    </cffunction>
</cfcomponent>