<cfparam name="treq_id" default="">
<cfset treq_id="#CreateUUID()#">
<cfoutput>#url.refJobID#</cfoutput>
<cfquery name="sendMessage" datasource="webwarecl">
	INSERT INTO messageinbox 
		(fromuser,
		touser,
		tsubject,
		tbody,
		tdate,
		tread,
		req_id,
        readReceipt
		<cfif #url.refJobID# NEQ "">
			,refJobID
		</cfif>
		)
	VALUES
		(#url.fromuser#,
		#url.touser#,
		'#url.tsubject#',
		'#url.tbody#',
		#CreateODBCDateTime(Now())#,
		'no',
		'#treq_id#',
        #url.readReceipt#
		<cfif #url.refJobID# NEQ "">
			,#url.refJobID#
		</cfif>
		)		
</cfquery>

<cfif url.attachment_id NEQ "">
<cfquery name="get_msg_id" datasource="webwarecl">
	SELECT id FROM messageinbox WHERE req_id='#treq_id#'
</cfquery>

<cfquery name="write_attachment" datasource="webwarecl">
	INSERT INTO mail_attachments 
    	(msg_id,
        file_id)
	VALUES
    	(#get_msg_id.id#,
        #url.attachment_id#)
</cfquery>
</cfif>
                
<table width="100%">
	<tr>
		<td align="center">
			<h3>Message Sent</h3>
			
			<p class="VPLink"><img src="/centerlineservices/graphics/folder.png" align="absmiddle"> <a href="javascript:viewMailFolder('inbox');">Inbox</a></p>
		</td>
	</tr>
</table>