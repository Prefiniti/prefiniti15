<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<head>
    <!-- Configure the Prefiniti Cold Fusion application -->
    <cfapplication name="WebWareCL" sessionmanagement="yes">
    
    <!-- Declare session variables -->
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
    
    
    <!-- Include the WebWare API files -->
    <cfinclude template="scriptIncludes.cfm">
    
    <!-- Detect the browser type -->
    <cfinclude template="browserDetection.cfm">
    
    <!-- Load the appropriate stylesheet -->
    <cfinclude template="styleConfig.cfm">

	<!-- Configure the exception handler -->
	<!---<cferror type="exception" template="/error.cfm" mailto="johnwillis@centerlineservices.biz">--->
	
    <!-- Configure the shortcut icon and site RSS feed -->
	<cfinclude template="configRSS.cfm">
</head>
<body onresize="handleAppResize();" onunload="handleAppUnload();">
	<!-- Load the SoundManager div -->
    <cfinclude template="soundManagerDiv.cfm">

    <!-- Load the title bar -->
    <cfinclude template="headBar.cfm">

    <!-- Configure this Prefiniti session -->
    <cfif #session.loggedin# EQ "yes">
        <cfinclude template="webwareConfigLoad.cfm">
    </cfif>
    
    <!-- 	This script must be loaded seperately from 
    		scriptIncludes.cfm because it depends on 
            configuration being complete in webwareConfigLoad.cfm		-->
    <script type="text/javascript" src="menus/menus.js"></script>
    
    <!-- Load the menu bar -->
    <cfoutput>
        <cfif #session.loggedin# EQ "yes">
            <!--<cfinclude template="menus/menubar.cfm">-->
            <cfinclude template="/generateMenus.cfm">
            <cfinclude template="miniSiteSelect.cfm">
        </cfif>
    </cfoutput>
        
    <!-- Check for maintenance condition -->	
    <cfinclude template="maintCheck.cfm">
    
    <!-- Load the session message as appropriate -->
    <cfinclude template="sessionMessage.cfm">
    
    <!-- Load the generic message template -->
    <cfinclude template="genericMessage.cfm">
        
    <!-- Load the help window resources -->
    <cfinclude template="/help/components/helpWrapper.cfm">
    
    <!-- Load the map window resources -->
    <cfinclude template="/mapping/mapWrapper.cfm">
    
    <!-- Load the SmartDesk Info Manager resources -->
    <cfinclude template="/contentManager/components/fileBrowserWrapper.cfm">
    
    <!-- Load the upload wrapper -->
    <cfinclude template="/uploadWrapper.cfm">
    
    <!-- Load the file association wrapper -->
    <cfinclude template="/cms_add_file_assoc_wrapper.cfm">
    
    <!-- Load the CMS minibrowser wrapper -->
    <cfinclude template="/cms_minibrowser_wrapper.cfm">
    
    <!-- Load the generic window wrapper -->
    <cfinclude template="/windowWrapper.cfm">
    
    <!-- Open the div element for the main client area -->    
    <div class="bodyWrapper" id="appArea" style="height:auto; width:100%; padding:0px; margin:0px; background-image:url(); background-repeat:repeat; ">