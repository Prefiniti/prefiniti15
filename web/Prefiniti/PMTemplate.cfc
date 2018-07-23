<cfcomponent extends="Prefiniti.Base" output="true">

    <cffunction name="init" returntype="Prefiniti.PMTemplate" output="false">
        <cfargument name="template" type="string" required="true">
        <cfargument name="recipient" type="Prefiniti.Authentication.UserAccount" required="true"> 
        <cfargument name="subject" type="string" required="true">       
        <cfargument name="fields" type="struct" required="true">

        <cfset this.template = arguments.template>
        <cfset this.recipient = arguments.recipient>       
        <cfset this.fields = arguments.fields>
        <cfset this.subject = arguments.subject>

        <cfreturn this>
    </cffunction>

    <cffunction name="send" returntype="void" output="false">

        <cfset templatePath = "/notification_templates/pm/" & this.template & ".cfm">

        <cfsavecontent variable="messageBody">
            <cftry>
                <cfmodule template="#templatePath#" attributecollection="#this.fields#">
                <cfcatch type="any">
                    No private message template found for <cfoutput>#this.template#</cfoutput>.
                </cfcatch>
            </cftry>
        </cfsavecontent>

        <cfset pm = new Prefiniti.PrivateMessage()>

        <cfset pm.fromuser = 143>
        <cfset pm.touser = this.recipient.id>
        <cfset pm.tsubject = this.subject>
        <cfset pm.tbody = messageBody>

        <cfset pm.save()>
        <cfset pm.send()>

    </cffunction>


</cfcomponent>