<cfinclude template="/authentication/authentication_udf.cfm">
	
    <cfquery name="gUsers" datasource="webwarecl">
		SELECT longName, id FROM users WHERE type=1 ORDER BY lastName, firstName
	</cfquery>

				<cfquery name="qjnv" datasource="webwarecl">
	SELECT clsJobNumber, description FROM projects
	</cfquery>
				<table width="100%">
					
					
					<tr>
						<td><cfoutput>
							<img src="graphics/time_add.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', 'tc/timesheet.cfm?action=add&userid=#url.calledByUser#')">New Timesheet</a><br />
							 <img src="graphics/time_go.png" align="absmiddle" /> <a href="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, '1/1/1980', '1/1/2999', 'Open', '#url.isTCAdmin#', '')">My Open Timesheets</a>
							
							<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) NEQ true>
								<form name="dateSelEmp">
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<th colspan="2"><cfoutput>View by Date</cfoutput></th>
									</tr>
									
									<tr>
										<td align="right">From</td>
										<td align="left" nowrap><input name="startDateEmp" id="startDateEmp" type="text" size="15" readonly> 
										<a href="javascript:popupDate(AjaxGetElementReference('startDateEmp'));"><img src="graphics/date.png" border="0"></a></td>
									</tr>
									<tr>
										<td align="right">Until</td>
										<td align="left" nowrap><input name="endDateEmp" id="endDateEmp" type="text" size="15" readonly> 
										<a href="javascript:popupDate(AjaxGetElementReference('endDateEmp'));;"><img src="graphics/date.png" border="0"></a></td>
									</tr>
									<tr>
									<td align="right"></td>
									<td align="left">
										<input type="button" class="normalButton" onclick="javascript:loadWeekToCtls('startDateEmp', 'endDateEmp');" value="Use Current Week" /><br />&nbsp;
									</td>
								</tr>
									<tr>
										<td colspan="2" align="right">
											<input type="button" class="normalButton" name="printByUserEmp" value="View All Printable" 
											onclick="javascript:loadTimesheetPrint('tcTarget', #url.calledByUser#, GetValue('startDateEmp'), GetValue('endDateEmp'), 'None', 'no', '')"/>
											<input type="button" class="normalButton" name="getByUser" value="View Editable" 
											onclick="javascript:loadTimesheetView('tcTarget', #url.calledByUser#, GetValue('startDateEmp'), GetValue('endDateEmp'), 'Open', 'no', '')"/>
										</td>
									</tr>
									
								</table>
								</form>
								<script language="javascript">
									var startDateEmpCal = new calendar2(document.forms['dateSelEmp'].elements['startDateEmp']);
									var endDateEmpCal = new calendar2(document.forms['dateSelEmp'].elements['endDateEmp']);
								</script>
							</cfif>
							
							<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
								<br />
								<img src="graphics/book_edit.png" align="absmiddle" /> <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/tc/taskCodes.cfm')">Manage Task Codes</a><br />&nbsp;
							</cfif>
							</cfoutput>
							<cfif getPermissionByKey("TS_VIEWALL", #url.current_association#) EQ true>
							<form name="dateSel">
							<table width="100%" cellpadding="0" cellspacing="0">
								<tr>
									<th colspan="2"><cfoutput>View by Employee</cfoutput></th>
								</tr>
								<tr>
									<td align="right">Employee</td>
									<td>
										<select name="byUser" id="byUser">
												<option value="noUserFilter">All Users</option>
											<cfoutput query="gUsers">
												<option value="#id#">#longName#</option>
											</cfoutput>	
										</select>
									</td>
								</tr>
								<tr>
									<td align="right">From</td>
									<td align="left" nowrap><input name="startDate" id="startDate" type="text" size="15" readonly> 
									<a href="javascript:popupDate(AjaxGetElementReference('startDate'));"><img src="graphics/date.png" border="0"></a></td>
								</tr>
								<tr>
									<td align="right">Until</td>
									<td align="left" nowrap><input name="endDate" id="endDate" type="text" size="15" readonly> 
									<a href="javascript:popupDate(AjaxGetElementReference('endDate'));"><img src="graphics/date.png" border="0"></a></td>
								</tr>
								<tr>
									<td align="right"></td>
									<td align="left">
										<input type="button" class="normalButton" onclick="javascript:loadWeekToCtls('startDate', 'endDate');" value="Use Current Week" />
									</td>
								</tr>
								<tr>
									<td align="right">Filter By</td>
									<td align="left" nowrap><p>
									  <label>
									    <input name="filterBy" type="radio" value="None" checked="checked" />
									    View All</label>
									  <br />
									  <label>
									    <input type="radio" name="filterBy" value="Signed" />
									    Signed Only</label>
									  <br />
									  <label>
									    <input type="radio" name="filterBy" value="Open" />
									    Open Only</label>
									  <br />
									  <label>
									    <input type="radio" name="filterBy" value="Approved" />
									    Approved Only</label>
									  <br />
									  </p>									</td>
								</tr>
								<tr>
									<td>Project Number:</td>
									<td>
										<select name="projectNumber" id="projectNumber">
												<option value="" selected="selected">No filter</option>
											<cfoutput query="qjnv">
												<option value="#clsJobNumber#">#clsJobNumber#</option>
											</cfoutput>
											
										</select>
									</td>
								</tr>
								<tr>
									<td colspan="2" align="right">
										<cfoutput>
										  <input type="button" class="normalButton" name="printByUser" value="View Printable" 
											onclick="javascript:loadTimesheetPrint('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), 'no', GetValue('projectNumber'))"/>
									    <input type="button" class="normalButton" name="getByUser" value="View Editable" 
										onclick="javascript:loadTimesheetView('tcTarget', GetValue('byUser'), GetValue('startDate'), GetValue('endDate'), AjaxGetCheckedValue('filterBy'), '#url.isTCAdmin#', GetValue('projectNumber'))"/></cfoutput>									</td>
								</tr>
								
							</table>
							</form>
							
							</cfif>
							
							
						</td>
				</table>
			
			