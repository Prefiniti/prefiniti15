<cfcomponent>

    <cffunction name="init" returntype="component">
        <cfreturn this>
    </cffunction>

    <cfinclude template="/framework/components/sitestats_udf.cfm">
    <cfinclude template="/menus/menu_udf.cfm">
    <cfinclude template="/authentication/authentication_udf.cfm">
    <cfinclude template="/mail/mail_udf.cfm">
    <cfinclude template="/scheduling/scheduling_udf.cfm">
    <cfinclude template="/notifications/notification_udf.cfm">
    <cfinclude template="/socialnet/socialnet_udf.cfm">
    <cfinclude template="/businessnet/businessnet_udf.cfm">
    <cfinclude template="/contentManager/cm_udf.cfm">
    
</cfcomponent>