<cfinclude template="/authentication/authentication_udf.cfm">

							
								
							
							<cfif getPermissionByKey("WF_SEARCH", #url.current_association#) EQ true>
								<cfmodule template="/MyCL/components/Collapse.cfm" DivName="searchBar" HeaderText="Project Locator" InitialState="none" URL="/search/components/search.cfm" SideImage="zoom.png">
							</cfif>
							
							
							<cfif getPermissionByKey("TS_VIEW", #url.current_association#) EQ true>
							<cfmodule template="/MyCL/components/Collapse.cfm" DivName="timeEntryBar" HeaderText="Time Entry" InitialState="none" URL="/framework/sb_TimeEntry.cfm" SideImage="time_go.png">	
							</cfif>
						<div class="OptionsBox" style="display:none;">
		  						<div class="OptionBoxHeading">Options</div>
									<label class="SettingsCheckBox"><input type="checkbox" name="KeepTabsOpen" id="KeepTabsOpen" align="absmiddle"/> Keep sidebars open until I close them</label>
							</div> 
	