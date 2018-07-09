<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="MA_WRITE">

<cfinclude template="/contentmanager/cm_udf.cfm">
<!--
<wwafcomponent>Write a Message</wwafcomponent>
-->

	<cfquery name="usr" datasource="webwarecl">
		SELECT * FROM friends WHERE source_id=#url.calledByUser# AND confirmed=1
	</cfquery>
	<cfquery name="jobs" datasource="webwarecl">
		SELECT id, clsJobNumber 
		FROM projects 
		WHERE clsJobNumber != '' 
		<cfif #url.permissionLevel# EQ 0>
			AND clientID=#url.calledByUser#
		</cfif>
		ORDER BY clsJobNumber
	</cfquery>
	<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; clear:right; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> Write Message</h3>
        </div>
    </div>
    <br />
    <br />

<div id="pageScriptContent" style="display:none">
// 
		/*	*/
        var glob_editor = new FCKeditor( 'bodyV' ) ;
        glob_editor.BasePath = "/FCKeditor/" ;
        glob_editor.ToolbarSet = "Basic" ;
		glob_editor.ReplaceTextarea() ;
// 
</div>

<div style="padding:30px;">
<div style="padding-bottom:3px;">
<span class="MailButton">
	<img src="/graphics/email.png" align="absmiddle"> <a style="color:white;" href="javascript:viewMailFolder('inbox')">Return to Inbox</a>   
</span>
</div>
			
	<div style="padding:0px; border:1px solid #EFEFEF">
	<form name="newmail" action="sendmail.cfm" method="post">
	
	<table width="100%">

		<tr>
			<td valign="top"><img src="/graphics/user.png" align="absmiddle"/> Recipient:</td>
			<td>
            	
            	<cfif IsDefined("url.reply")>
                	<cfoutput>
                    <input type="hidden" name="touser" id="touser" value="#url.toID#" />
                 	#getLongName(url.toID)#					</cfoutput>
                <cfelse>
                	<cfif IsDefined("url.toID")> 
						<select name="touser" id="touser">

						<cfoutput query="usr">
							<option value="#target_id#" <cfif target_id EQ url.toID>selected</cfif>>#getLongName(target_id)#</option>
						</cfoutput>
			  			<fselect>
					<cfelse>
                    	<select name="touser" id="touser">

						<cfoutput query="usr">
							<option value="#target_id#"selected>#getLongName(target_id)#</option>
						</cfoutput>
			  			<fselect>
                   	</cfif>
				</cfif>                                           
                        <label><input type="checkbox" name="readReceipt" id="readReceipt" />Request read receipt</label>			</td>
		</tr>
		<tr>
			<td valign="top" ><img src="/graphics/email_edit.png" align="absmiddle"/> Subject:</td>
			<td valign="top" >
			<cfoutput>
            <cfif IsDefined("url.reply")>
	            <input name="subject" id="subject" type="text" size="30" value="RE: #url.subject#"/>
			<cfelse>
            	<input name="subject" id="subject" type="text" size="30"/>
			</cfif>                
			</cfoutput>            </td>
		</tr>
		<tr>
		  <td valign="top"><img src="/graphics/wrench.png" align="absmiddle" /> Reference Project:</td>
		  <td valign="top"><select name="jobid" id="jobid">
		  				<option value="" selected>None</option>
					<cfoutput query="jobs">
						<option value="#id#">#clsJobNumber#</option>
					</cfoutput>
			  	</select></td>
	  </tr>
		<tr>
		  <td valign="top"><img src="/graphics/email_attach.png" align="absmiddle"/> Attachment:</td>
		  <td valign="top">
          <cfif IsDefined("url.attachment_file_id")>
          		<cfoutput><input type="text" id="attachment" name="attachment" value="#cmsUserFileName(url.attachment_file_id)#" readonly /> <input type="hidden" id="attachment_file_id" name="attachment_file_id" value="#url.attachment_file_id#"/> 
            	<input type="button" class="normalButton" onclick="cmsLoadMiniBrowser('attachment_file_id', 'attachment');" value="Choose File" /></cfoutput>
           <cfelse>
           		<input type="text" id="attachment" name="attachment" readonly /> <input type="hidden" id="attachment_file_id" name="attachment_file_id"/> 
            	<input type="button" class="normalButton" onclick="cmsLoadMiniBrowser('attachment_file_id', 'attachment');" value="Choose File" />
			</cfif>                
           
           </td>
	    </tr>
		<tr>
			<td valign="top" ><img src="/graphics/email.png" align="absmiddle"/> Body:</td>
			<td valign="top" >
            <textarea name="bodyV" id="bodyText" cols="40" rows="10">
				<cfif IsDefined("url.reply")>
					<cfoutput>
                    	<p style="padding-bottom:20px;">&nbsp;</p>
                        
                        <p style="margin-bottom:0px; padding-bottom:0px; color:blue;">#getLongName(url.toID)# said:</p>
                        <blockquote style="margin-top:0px; padding-top:0px; color:blue; margin-left:2px; text-indent:2px; border-left:1px solid blue;">#url.body#</blockquote>
					</cfoutput>
				</cfif>
             </textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="right">
			<!--function sendMessage(fromUser, toUser, refJobID, subject, bodyText)-->
				<input type="button" name="sendMail" class="normalButton" value="Send Message" onclick="checkEditor(); sendMessage(glob_userid, GetValue('touser'), GetValue('jobid'), GetValue('subject'), GetValue('bodyText'), IsChecked('readReceipt'), GetValue('attachment_file_id'));">
                <!--<input type="button" name="sendMail" class="normalButton" value="Check Editor" onclick="checkEditor();">-->			</td>
		</tr>
	</table>
	</form>
    </div>
</div>

