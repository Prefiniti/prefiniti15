<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="WF_VIEW">
<cfinclude template="/authentication/authentication_udf.cfm">

<cfquery name="projectInfo" datasource="webwarecl">
    SELECT * FROM projects WHERE id=#url.id# AND site_id=#url.current_site_id#
</cfquery>

<cfquery name="gAU" datasource="webwarecl">
	SELECT * FROM Users WHERE type=1
</cfquery>
		
<cfif #projectInfo.maint_lock# EQ 1 AND #url.calledByUser# NEQ 1>
	<h1>Access Denied</h1>
	<p>This project has been locked for maintenance, and can only be modified by the webmaster.</p>
	<cfabort>
</cfif>

<style>
	.projTabl td
	{
		background-color:#EFEFEF;
	}		
	.cellLabel
	{
		display:block;
		width:320px;
		float:left;
	}
	.cellC
	{
		float:left;
		display:inline;
	}	
</style>

<cfparam name="canEdit" default="0">

<cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
	<cfset canEdit=1>
<cfelse>
	<cfset canEdit=0>
</cfif>

<cfoutput>
<!--
<wwafcomponent>Project View - #projectInfo.clsJobNumber#</wwafcomponent>
<wwafsidebar>sb_ProjectView.cfm?id=#url.id#</wwafsidebar>
<wwafdefinesmap>true</wwafdefinesmap>
<wwafpackage>Workflow Manager</wwafpackage>
<wwaficon>report.png</wwaficon>
-->
</cfoutput>



		

<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> View Project</h3>
        </div>
    </div>
    <cfoutput>
    <div style="clear:both;width:89%; padding-top:-5px; padding-left:5px; padding-bottom:5px;">
    Current View:
    <select name="section" id="project_section" onchange="show_project_section(GetValue('project_section'));">
    	<option value="location_information" selected>Location Information</option>
        <option value="filing_information">Filing Information</option>
        <option value="project_files">Project Files</option>
    </select>
<cfif getPermissionByKey("WF_VIEWRFP", #url.current_association#) EQ true>
                				<img src="/graphics/zoom.png" align="absmiddle"> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/workFlow/components/viewRFP.cfm?id=#url.id#&viewOnly=1');">Proposal</a> |&nbsp;
							</cfif>
						</cfoutput>
						<cfif getPermissionByKey("WF_DELETE", #url.current_association#) EQ true>
                        	<cfoutput><img src="/graphics/delete.png" align="middle" /> <a href="javascript:deleteProject('#url.id#')">Delete Project</a> |&nbsp;</cfoutput>
                        </cfif>
                        <img src="/graphics/printer.png" align="middle"/> <cfoutput><a href="javascript:viewPrintable('#url.id#')">Printable Order</a></cfoutput> |&nbsp;
                        
                        <cfif getPermissionByKey("TS_VIEW", #url.current_association#) EQ true>
                        	<cfoutput><img src="/graphics/time_go.png" align="middle"/> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '12/31/2999', 'none', 'no', '#projectInfo.clsJobNumber#')">My Timesheets (This Project)</a></cfoutput> |&nbsp;
                        <cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
                        	<cfoutput><img src="/graphics/time_go.png" align="middle"/> <a href="javascript:loadTimesheetView('tcTarget', 'noUserFilter', '1/1/1980', '12/31/2999', 'none', 'no', '#projectInfo.clsJobNumber#')">All Timesheets</a> |&nbsp;</cfoutput>
                        </cfif>
                        </cfif>
                        <cfoutput>
                        <img src="/graphics/map_go.png" align="absmiddle" /> <a href="javascript:popupMap('Project #projectInfo.clsJobNumber#', GetValue('address') + ' ' + GetValue('city') + ', ' + GetValue('state') + ' ' + GetValue('zip'), 'Project #projectInfo.clsJobNumber#', true);">Map &amp; Directions</a></cfoutput>
	</div>
<table width="100%">
<tr>
    <td valign="top" width="250">
    	
    	<div style="width:240px; background-color:#EFEFEF; -moz-border-radius:5px; padding:5px; margin:5px;">
        <strong style="color:#3399CC; padding-bottom:10px; display:block;">Project Summary</strong>
        	<table width="100%" cellspacing="0" class="projTabl">     
	            <tr>
    		        <td><strong>Ordered By:</strong></td>
            		<td><cfmodule template="/jobViews/components/custNameByIDMenu.cfm" id="#projectInfo.clientid#"></td>
            	</tr>
            	<tr>
		            <td><strong>Description:</strong></td>
        	    	<td><cfoutput>#projectInfo.description#</cfoutput></td>
            	</tr>
            	<tr>
            		<td><strong>Project Number:</strong></td>
            		<td>
            			<div id="jobNumRO" style="display:inline">
                            <span id="jnView">
                                <cfoutput>
                                    <cfif #projectInfo.clsJobNumber# EQ "">[None Assigned]</cfif>#projectInfo.clsJobNumber#
                                </cfoutput>
                            </span> 
                            <cfoutput>
                                <cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true><a href="javascript:editProjectNumber();"><img src="graphics/pencil_go.png" border="0" align="absmiddle" /></a></cfif>
                            </cfoutput>
						</div>
            			<div id="jobNumRW" style="display:none">
            				<cfoutput>
                            	<input type="text" class="inputText" value="#projectInfo.clsJobNumber#" id="jobNumEdit"/> <a href="javascript:saveProjectNumber(#url.id#, GetValue('jobNumEdit'));"><img src="/graphics/database_save.png" border="0"/></a>
							</cfoutput>
						</div>
            		</td>
				</tr>
            	<tr>
            		<td><strong>Client Project No.:</strong></td>
            		<td><cfoutput>#projectInfo.clientJobNumber#</cfoutput></td>
            	</tr>
            	<tr>
            		<td><strong>Project Type:</strong></td>
           			<td><cfoutput>#projectInfo.jobtype#</cfoutput></td>
            	</tr>
            	<tr>
            		<td><strong>Order Placed:</strong></td>
            		<td><cfoutput>#DateFormat(projectInfo.ordered_date, 'mm/dd/yyyy')#</cfoutput></td>
            	</tr>
            	<tr>
            		<td ><strong>Due Date:</strong></td>
            		<td ><cfoutput>#DateFormat(projectInfo.duedate, 'mm/dd/yyyy')#</cfoutput></td>
            	</tr>	
            	<tr>
            		<td><strong>Project Status:</strong></td>
            		<td><cfoutput><cfif #projectInfo.status# EQ 0>Incomplete<cfelse>Complete</cfif> <cfif #projectInfo.SubStatus# NEQ ""><br>[#projectInfo.SubStatus#]</cfif></cfoutput></td>
            	</tr>	
            	<cfif url.permissionLevel EQ 1>
            		<tr>
            			<td>Drafter:</td>
            			<td>
            				<span id="cur_drafter">
            					<cfoutput>
            						<cfif projectInfo.drafter_id NEQ "">
            							<cfmodule template="/jobViews/components/custNameByID.cfm" id="#projectInfo.drafter_id#"> <br /><cfif getPermissionByKey("WF_ASSIGNDRAFTER", #url.current_association#) EQ true><a href="javascript:showDiv('drafterSelect');" style="color:blue;">Change Drafter</a></cfif>
            						<cfelse>
            							[No drafter assigned] <br /><cfif getPermissionByKey("WF_ASSIGNDRAFTER", #url.current_association#) EQ true><a href="javascript:showDiv('drafterSelect');"  style="color:blue;">Assign Drafter</a></cfif>
            						</cfif>
            					</cfoutput>
            				</span>
            				<div id="drafterSelect" style="display:none;">
            					<select name="drafter" id="drafter" <cfoutput>onchange="assignDrafter(#projectInfo.id#, GetValue('drafter'));"</cfoutput>>
            						<cfoutput query="gAU">
            							<option value="#id#">#longName#</option>
            						</cfoutput>
            					</select>
            				</div>
            			</td>
            		</tr>
            		<tr>
            			<td>Surveyor:</td>
            			<td>
            				<span id="cur_surveyor">
								<cfoutput>
                                    <cfif projectInfo.surveyor_id NEQ "">
                                        <cfmodule template="/jobViews/components/custNameByID.cfm" id="#projectInfo.surveyor_id#"> <br /><cfif getPermissionByKey("WF_ASSIGNSURVEYOR", #url.current_association#) EQ true><a href="javascript:showDiv('surveyorSelect');" style="color:blue;">Change Surveyor</a></cfif>
                                    <cfelse>
                                        [No surveyor assigned] <br /><cfif getPermissionByKey("WF_ASSIGNSURVEYOR", #url.current_association#) EQ true><a href="javascript:showDiv('surveyorSelect');"  style="color:blue;">Assign Surveyor</a></cfif>
                                    </cfif>
                                </cfoutput>
            				</span>
            				<div id="surveyorSelect" style="display:none;">
            					<select name="surveyor" id="surveyor" <cfoutput>onchange="assignSurveyor(#projectInfo.id#, GetValue('surveyor'));"</cfoutput>>
									<cfoutput query="gAU">
                                        <option value="#id#">#longName#</option>
                                    </cfoutput>
           						</select>
            				</div>
            			</td>
            		</tr>
            	</cfif>
            	<cfif #projectInfo.status# EQ 0>
            		<tr>
            			<td colspan="2">Project has been open for <strong><cfoutput>#DateDiff("d", projectInfo.ordered_date, Now())#</cfoutput> days.</strong></td>
            		</tr>
            		<tr>
            			<td colspan="2">
            				<cfif #DateDiff("d", Now(), projectinfo.duedate)# GT 1>
            					You have <strong><cfoutput>#DateDiff("d", Now(), projectinfo.duedate)#</cfoutput> days remaining</strong> to complete this project on time.
            				<cfelseif #DateDiff("d", Now(), projectinfo.duedate)# EQ 0>
            					You have <strong><cfoutput>#DateDiff("h", Now(), projectinfo.duedate)#</cfoutput> hours remaining</strong> to complete this project on time.
            				<cfelse>
            					<span style="color:red;">This project is past due.</span>
            				</cfif>
						</td>
            		</tr>
            	</cfif>
            </table>
            
          
			
        </div>
        
       
    </td>
    <td valign="top">
    
                			
    
	<cfoutput>
    	<div id="project_files" style="display:none;">
        	<div class="homeHeader"><img src="/graphics/folder_explore.png" align="absmiddle"/> Project Files</div>
            <cfmodule template="/workflow/components/project_files.cfm" project_id="#url.id#">
        </div>
    	<div id="location_information" style="display:inline;">
        <div class="homeHeader"><img src="/graphics/map.png" align="absmiddle" /> Location</div>
        <div style="padding-left:20px;">
			<cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
                <a href="javascript:updateLocationInfo('locStat', #url.id#, GetValue('address'), GetValue('city'), GetValue('state'), GetValue('zip'), GetValue('latitude'), GetValue('longitude'), GetValue('subdivision'), GetValue('lot'), GetValue('block'), GetValue('section'), GetValue('township'), GetValue('range'));">
                    <img src="/graphics/database_save.png" border="0"/>				
                </a>
            </cfif>
            <span id="locStat"><strong>No changes made since last save.</strong></span>
           
        </div>
        <div style="padding-left:20px; padding-top:20px;"> 
        <div class="cellLabel">Street Address:</div>
        <div class="cellC">
			<input name="address" <cfif canEdit EQ 0>readonly</cfif> id="address" type="text" value="#projectInfo.address#"    onkeyup="invalidateSection('locStat');" class="inputText" onblur="calcLatLng();"/>  
		</div>            
		<div class="cellLabel">City:</div>
        <div class="cellC">
        	<input name="city" <cfif canEdit EQ 0>readonly</cfif> id="city" type="text" value="#projectInfo.city#"  onkeyup="invalidateSection('locStat');" class="inputText" onblur="calcLatLng();"/>
		</div>
        <div class="cellLabel">State:</div>
        <div class="cellC">
        	<input name="state" <cfif canEdit EQ 0>readonly</cfif> id="state" type="text" value="#projectInfo.state#"  onkeyup="invalidateSection('locStat');" class="inputText" onblur="calcLatLng();"/>
		</div>
        <div class="cellLabel">ZIP:</div>
        <div class="cellC">
        	<input name="zip" <cfif canEdit EQ 0>readonly</cfif> id="zip" type="text" value="#projectInfo.zip#"  onkeyup="invalidateSection('locStat');" class="inputText" onblur="calcLatLng();"/>
			<cfif #url.permissionLevel# EQ 1>
				<input type="button" class="normalButton" name="cc" value="Calculate Latitude/Longitude" onclick="calcLatLng();" />
			</cfif>
		</div>
        <div class="cellLabel">Latitude:</div>
        <div class="cellC">
        	<input name="latitude" <cfif canEdit EQ 0>readonly</cfif> id="latitude" type="text" value="#projectInfo.latitude#"  onkeyup="invalidateSection('locStat');" class="inputText"/>
		</div>
        <div class="cellLabel">Longitude:</div>
        <div class="cellC">
        	<input name="longitude" <cfif canEdit EQ 0>readonly</cfif> id="longitude" type="text" value="#projectInfo.longitude#"  onkeyup="invalidateSection('locStat');" class="inputText"/>
		</div>
        <div class="cellLabel">Subdivision:</div>
        <div class="cellC">
        	<input name="subdivision" <cfif canEdit EQ 0>readonly</cfif> id="subdivision" type="text" value="#projectInfo.subdivision#"  onkeyup="invalidateSection('locStat');" class="inputText"/>
		</div>
        <div class="cellLabel">Lot:</div>
        <div class="cellC">
        	<input name="lot" <cfif canEdit EQ 0>readonly</cfif> id="lot" type="text" value="#projectInfo.lot#"  onkeyup="invalidateSection('locStat');" class="inputText"/>
        </div>
		<div class="cellLabel">Block:</div>
        <div class="cellC">
			<input name="block" <cfif canEdit EQ 0>readonly</cfif> id="block" type="text" value="#projectInfo.block#"  onkeyup="invalidateSection('locStat');" class="inputText"/>
		</div>
        <div class="cellLabel">Section:</div>
        <div class="cellC">
        	<input name="section" <cfif canEdit EQ 0>readonly</cfif> id="section" type="text" value="#projectInfo.section#"  onkeyup="invalidateSection('locStat');" class="inputText"/>
		</div>            
		<div class="cellLabel">Township:</div>
        <div class="cellC">
        	<input name="township" <cfif canEdit EQ 0>readonly</cfif> id="township" type="text" value="#projectInfo.township#"  onkeyup="invalidateSection('locStat');" class="inputText"/>
		</div>            
		<div class="cellLabel">Range:</div>
        <div class="cellC">
        	<input name="range" <cfif canEdit EQ 0>readonly</cfif> id="range" type="text"  value="#projectInfo.range#" onkeyup="invalidateSection('locStat');" class="inputText"/>
            <cfif #url.permissionLevel# EQ 1>
				<input type="button" class="normalButton" value="Calculate Section/Township/Range" onclick="loadTRS();" />
			</cfif>
    	</div>
	</div>
    </div>
    
    <div id="filing_information" style="display:none;">     
    <div class="homeHeader" style="clear:both"><img src="/graphics/folder_page.png" align="absmiddle" /> Filing Information</div>
    <div style="padding-left:20px;">
		<cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
            <a href="javascript:updateFilingInfo('filingStat', #url.id#, AjaxGetCheckedValue('SubdivisionOrDeed'), AjaxGetCheckedValue('FilingType'), GetValue('PlatCabinetBook'), AjaxGetCheckedValue('PageOrSlide'), GetValue('PageSlide'), GetValue('ReceptionNumber'), GetValue('FilingDate'), GetValue('CertifiedTo'));">
            <img src="/graphics/database_save.png" border="0"/></a>
        </cfif> 
        <span id="filingStat"><strong>No changes made since last save.</strong></span>
    </div>
    <div style="padding-left:20px; padding-top:20px;">         
    <div style="clear:both;">   
        <div class="cellLabel">                        
			<p>
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="SubdivisionOrDeed" value="Subdivision" <cfif #projectInfo.SubdivisionOrDeed# EQ "Subdivision">checked</cfif> onclick="invalidateSection('filingStat');"/>Subdivision
				</label>
				<br />
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="SubdivisionOrDeed" value="Deed" <cfif #projectInfo.SubdivisionOrDeed# EQ "Deed">checked</cfif> onclick="invalidateSection('filingStat');"/>Deed
                </label>
				<br />
			</p>
			<p>
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Plat" <cfif #projectInfo.FilingType# EQ "Plat">checked</cfif> onclick="invalidateSection('filingStat');"/>
Plat
				</label>
				<br />
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Cabinet"  			
						<cfif #projectInfo.FilingType# EQ "Cabinet">checked</cfif> onclick="invalidateSection('filingStat');"/>Cabinet
				</label>
				<br />
				<label>
					<input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="FilingType" value="Book"  <cfif #projectInfo.FilingType# EQ "Book">checked</cfif> onclick="invalidateSection('filingStat');"/>Book
				</label>
				<br />
			</p>          
        </div>
        <div class="cellC" style="clear:right;">
            <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="PlatCabinetBook" name="PlatCabinetBook" value="#projectInfo.PlatCabinetBook#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
        </div>
    </div>
    <div style="clear:both;">
        <div class="cellLabel">
        <p><label>
                                  <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="PageOrSlide" value="Page" <cfif #projectInfo.PageOrSlide# EQ "Page">checked</cfif> onclick="invalidateSection('filingStat');"/>
                                  Page</label>
                                <br />
                                <label>
                                  <input type="radio" <cfif canEdit EQ 0>disabled</cfif> name="PageOrSlide" value="Slide" <cfif #projectInfo.PageOrSlide# EQ "Slide">checked</cfif> onclick="invalidateSection('filingStat');"/>
                                  Slide</label>
                                <br />
                                </p>
        </div>
        <div class="cellC">                            
            <input type="text" <cfif canEdit EQ 0>readonly</cfif> id="PageSlide" name="PageSlide" value="#projectInfo.PageSlide#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
        </div>
    </div>
    <div class="cellLabel" style="clear:left;">Reception or Document Number:</div>
    <div class="cellC">
		<input type="text" <cfif canEdit EQ 0>readonly</cfif> id="ReceptionNumber" name="ReceptionNumber"  value="#projectInfo.ReceptionNumber#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
	</div>
    <div class="cellLabel">Filing Date:</div>
    <div class="cellC">
		<input type="text" <cfif canEdit EQ 0>readonly</cfif> id="FilingDate" name="FilingDate"  value="#DateFormat(projectInfo.FilingDate, 'mm/dd/yyyy')#"  onkeyup="invalidateSection('filingStat');" class="inputText"/> <cfif #url.permissionLevel# EQ 1><a href="javascript:popupDate(AjaxGetElementReference('FilingDate'));"><img src="graphics/date.png" border="0" /></a></cfif>
	</div>
    <div class="cellLabel">Certified To:</div>
    <div class="cellC">
    	<input type="text" <cfif canEdit EQ 0>readonly</cfif> id="CertifiedTo" name="CertifiedTo"  value="#projectInfo.CertifiedTo#" onkeyup="invalidateSection('filingStat');" class="inputText"/>
	</div>        
    </div>
    </div>
    
   	</cfoutput>
    </td>
    
</tr>
</table>    <!---    
 
			
							 				<tr>
		  	
		  
		  <tr>
		  	<th align="left">Other Project Information</th>
			<th align="right" id="otherStat" style="color:##33FF00; font-weight:lighter;">No changes made since last save.</th>
				
		    <th align="right">
				<cfif getPermissionByKey("WF_EDIT", #url.current_association#) EQ true>
				<a href="javascript:updateOtherInfo('otherStat', #url.id#, GetValue('specialinstructions'));">
				<img src="/graphics/database_save.png" border="0"/>				</a></cfif> </th>           						  </tr>
		   <tr>
            <td class="int">Special Instructions:</td>
            <td colspan="2" class="int"><textarea name="specialinstructions" cols="50" rows="8" class="inputText" id="specialinstructions" onkeyup="invalidateSection('otherStat');">#projectInfo.specialinstructions#</textarea></td>
          </tr>
						</table>--->
						

<div id="pageScriptContent">
	last_section_id='location_information';
</div>                           