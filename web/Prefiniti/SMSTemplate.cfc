<cfcomponent extends="Prefiniti.Base" output="true">

    <cffunction name="init" returntype="Prefiniti.SMSTemplate" output="false">
        <cfargument name="template" type="string" required="true">
        <cfargument name="recipient" type="Prefiniti.Authentication.UserAccount" required="true">        
        <cfargument name="fields" type="struct" required="true">

        <cfset this.template = arguments.template>
        <cfset this.recipient = arguments.recipient>       
        <cfset this.fields = arguments.fields>

        <cfreturn this>
    </cffunction>

    <cffunction name="send" returntype="void" output="false">

        <cfset templatePath = "/notification_templates/sms/" & this.template & ".cfm">

        <cfsavecontent variable="messageBody">
            <cftry>
                <cfmodule template="#templatePath#" attributecollection="#this.fields#">
                <cfcatch type="any">
                    No SMSTemplate template found for <cfoutput>#this.template#</cfoutput>.
                </cfcatch>
            </cftry>
        </cfsavecontent>

        <cfset apiKey = "sUozWEy7Q5ixXoFeOhaWmw==">
        <cfset msgID = createUUID()>

        <cfset deliveryTime = dateFormat(now(), "yyyy-mm-dd") & "T" & timeformat(now(), "HH:mm:ssZ")>

        <cfset msg = {
            content: "Geodigraph PM - " & trim(messageBody),
            to: ["+" & this.recipient.smsNumber],
            from: "1505-445-7169",
            binary: false,
            clientMessageId: msgID,
            scheduledDeliveryTime: deliveryTime
        }>

        <cfhttp url="https://platform.clickatell.com/messages" method="POST">
            <cfhttpparam type="header" name="Content-Type" value="application/json">
            <cfhttpparam type="header" name="Accept" value="application/json">        
            <cfhttpparam type="header" name="Authorization" value="#apiKey#">
            <cfhttpparam type="body" value="#serializeJSON(msg)#">
        </cfhttp>


        <cfset path = expandPath("/logs/sms") & "/" & msgID & ".log">
        <cfset logBody = "Status Code: " & cfhttp.statuscode & chr(10) & "Response: " & cfhttp.fileContent>
        <cfset fileWrite(path, logBody)>


    </cffunction>


</cfcomponent>