<cfinclude template="/authentication/authentication_udf.cfm">
<cfquery name="projectInfo" datasource="webwarecl">
	SELECT * FROM projects WHERE id=#url.id#
</cfquery>



<cfif #url.permissionLevel# EQ 1>
	<cfmodule template="/MyCL/components/Collapse.cfm" DivName="projectStatus" HeaderText="Project Status" InitialState="none" URL="/workFlow/components/projectStatus.cfm" SideImage="wrench.png">
</cfif>
<!---<cfmodule template="/MyCL/components/Collapse.cfm" DivName="fileList" HeaderText="Project Files" InitialState="none" URL="/contentManager/components/fileList.cfm" SideImage="application_view_list.png">--->

<cfmodule template="/MyCL/components/Collapse.cfm" DivName="searchBar" HeaderText="Project Locator" InitialState="none" URL="/search/components/search.cfm" SideImage="zoom.png">
<cfif getPermissionByKey("TS_VIEW", #url.current_association#) EQ true>
<cfmodule template="/MyCL/components/Collapse.cfm" DivName="timeEntryBar" HeaderText="Time Entry" InitialState="none" URL="/framework/sb_TimeEntry.cfm" SideImage="time_go.png">
</cfif>



<div class="OptionsBox" style="display:none;">
	<div class="OptionBoxHeading">Options</div>
	<label class="SettingsCheckBox"><input type="checkbox" name="KeepTabsOpen" id="KeepTabsOpen" align="absmiddle" /> Keep sidebars open until I close them</label>
</div>