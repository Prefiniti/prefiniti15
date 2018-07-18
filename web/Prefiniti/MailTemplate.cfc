<cfcomponent extends="Prefiniti.Base" output="true">

    <cffunction name="init" type="Prefiniti.MailTemplate" output="false">
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

    <cffunction name="send" type="void" output="false">

        <cfset templatePath = "/mail_templates/" & this.template & ".cfm">

        <cfmail from="noreply@geodigraph.com" to="#this.recipient#" subject="#this.subject#" type="text/html">
            <cfinclude template="/mail_templates/header.cfm">
            <cfmodule template="#templatePath#" attributecollection="#this.fields#">
            <cfinclude template="/mail_templates/footer.cfm">
        </cfmail>

    </cffunction>


</cfcomponent>