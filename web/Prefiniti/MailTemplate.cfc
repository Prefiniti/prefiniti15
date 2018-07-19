<cfcomponent extends="Prefiniti.Base" output="true">

    <cffunction name="init" returntype="Prefiniti.MailTemplate" output="false">
        <cfargument name="template" type="string" required="true">
        <cfargument name="recipient" type="string" required="true">
        <cfargument name="subject" type="string" required="true">
        <cfargument name="fields" type="struct" required="true">

        <cfset this.template = arguments.template>
        <cfset this.recipient = arguments.recipient>
        <cfset this.subject = arguments.subject>
        <cfset this.fields = arguments.fields>

        <cfreturn this>
    </cffunction>

    <cffunction name="send" returntype="void" output="false">

        <cfset templatePath = "/notification_templates/mail/" & this.template & ".cfm">

        <cfmail from="noreply@geodigraph.com" to="#this.recipient#" subject="#this.subject#" type="text/html">
            <cftry>
                <cfinclude template="/notification_templates/mail/header.cfm">
                <cfmodule template="#templatePath#" attributecollection="#this.fields#">
                <cfinclude template="/notification_templates/mail/footer.cfm">
                <cfcatch type="any">
                    No MailTemplate template found for <cfoutput>#this.template#</cfoutput>.
                </cfcatch>
            </cftry>
        </cfmail>

    </cffunction>


</cfcomponent>