<!--- Configure the Prefiniti Cold Fusion application --->
<cfapplication name="Prefiniti15" sessionmanagement="yes">

<!--- Declare session variables --->
<cfparam name="session.username" default="">
<cfparam name="session.userid" default="">
<cfparam name="session.usertype" default="0">
<cfparam name="session.longname" default="0">
<cfparam name="session.loggedin" default="no">
<cfparam name="session.message" default="">
<cfparam name="session.datasource" default="webwarecl">
<cfparam name="session.jobreceiver" default="">
<cfparam name="session.maintenance" default="0">
<cfparam name="session.logins_disabled" default="0">
<cfparam name="session.site_maintainer" default="0">
<cfparam name="session.role" default="">
<cfparam name="session.order_processor" default="0">
<cfparam name="session.email" default="">
<cfparam name="session.unread" default="0">
<cfparam name="session.overdue" default="0">
<cfparam name="session.urlparm" default="">
<cfparam name="session.tcadmin" default="no">
<cfparam name="session.tcsigned" default="0">
<cfparam name="session.tcopen" default="0">
<cfparam name="session.newJobs" default="0">
<cfparam name="session.itemAttention" default="true">
<cfparam name="session.browserType" default="">
<cfparam name="session.companyID" default="">
<cfparam name="session.pwdiff" default="">
<cfparam name="session.last_loaded_page" default="">
<cfparam name="session.remember_page" default="">
<cfparam name="session.current_site_id" default="0">
<cfparam name="session.current_association" default="0">
<cfparam name="session.webware_admin" default="0">
<cfparam name="session.framework_loaded" default="0">
<cfparam name="session.impersonating" default="false">
<cfparam name="session.originating_user" default="">
<cfparam name="session.originating_assoc_id" default="0">

<cfinclude template="/authentication/authentication_udf.cfm">
<cfinclude template="/notifications/notification_udf.cfm">