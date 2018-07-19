<cfcomponent extends="Prefiniti.Base" output="true">

    <cffunction name="init" returntype="Prefiniti.FeedMessage" output="false">
        <cfargument name="template" type="string" required="true">
        <cfargument name="recipient" type="Prefiniti.Authentication.UserAccount" required="true">        
        <cfargument name="fields" type="struct" required="true">

        <cfset this.template = arguments.template>
        <cfset this.recipient = arguments.recipient>       
        <cfset this.fields = arguments.fields>

        <cfreturn this>
    </cffunction>

    <cffunction name="send" returntype="void" output="false">

        <cfset templatePath = "/notification_templates/feed/" & this.template & ".cfm">

        <cfsavecontent variable="messageBody">
            <cftry>
                <cfmodule template="#templatePath#" attributecollection="#this.fields#">

                <cfcatch type="any">
                    No FeedMessage template found for <cfoutput>#this.template#</cfoutput>.
                </cfcatch>
            </cftry>
        </cfsavecontent>

        <cfset this.writeUserEvent(this.recipient.id, "bell.png", messageBody)>

    </cffunction>


</cfcomponent>