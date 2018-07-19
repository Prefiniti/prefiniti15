<cfcomponent extends="Prefiniti.Base">

    <cffunction name="getNotificationMethods" returntype="struct" output="false">
        <cfargument name="user" type="Prefiniti.Authentication.UserAccount" required="true">
        <cfargument name="n_key" type="string" required="true">

        <cfset result = {
            pm: false,
            mail: false,
            sms: false
        }>

        <cfquery name="getNotificationMethods" datasource="webwarecl">
            SELECT method FROM notification_entries WHERE user_id=#arguments.user.id#
        </cfquery>

        <cfoutput query="getNotificationMethods">
            <cfswitch expression="#method#">
                <cfcase value="0">
                    <cfset result.pm = true>
                </cfcase>
                <cfcase value="1">
                    <cfset result.mail = true>
                </cfcase>
                <cfcase value="2">
                    <cfset result.sms = true>
                </cfcase>
            </cfswitch>
        </cfoutput>

        <cfreturn result>

    </cffunction>

    <cffunction name="getNotificationName" returntype="string" output="false">
        <cfargument name="n_key" type="string" required="true">

        <cfquery name="getNotificationName" datasource="webwarecl">
            SELECT description FROM notifications WHERE n_key="#arguments.n_key#"
        </cfquery>

        <cfreturn getNotificationName.description>
    </cffunction>

</cfcomponent>