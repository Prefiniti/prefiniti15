
<cfinclude template="/socialnet/socialnet_udf.cfm">

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>

<cfquery name="c" datasource="#session.datasource#">
	SELECT * FROM users WHERE id='#form.clientID#'
</cfquery>
	
<cfquery name="insertOrder" datasource="#session.datasource#">
	INSERT INTO projects
		(FILINGTYPE,
		CERTIFIEDTO,
		PLATCABINETBOOK,
		DUEDATE,
		SECTION,
		SPECIALINSTRUCTIONS,
		ADDRESS,
		CITY,
		STATE,
		ZIP,
		LATITUDE,
		LONGITUDE,
		STATUS,
		JOBTYPE,
		PAGESLIDE,
		RANGE,
		SUBDIVISION,
		TOWNSHIP,
		SUBDIVISIONORDEED,
		<cfif #form.filingDate# NEQ "">
			FILINGDATE,
		</cfif>
		REQID,
		CLIENTJOBNUMBER,
		CLIENTID,
		BLOCK,
		LOT,
		DESCRIPTION,
		RECEPTIONNUMBER,
		PAGEORSLIDE,
		VIEWED,
		ORDERED_DATE,
		STAGE,
		ALLOW_PUBLICATION,
        REQUEST_PHOTOS,
        SERVICETYPE,
        RFP,
        SITE_ID)
	VALUES
		('#form.filingtype#',
		'#form.certifiedto#',
		'#form.platcabinetbook#',
		#CreateODBCDateTime(form.duedate)#,
		'#form.section#',
		'#form.specialinstructions#',
		'#form.address#',
		'#form.city#',
		'#form.state#',
		'#form.zip#',
		#form.latitude#,
		#form.longitude#,
		'#form.status#',
		'#form.jobtype#',
		'#form.pageslide#',
		'#form.range#',
		#form.subSelect#,
		'#form.township#',
		'#form.subdivisionordeed#',
		<cfif #form.filingDate# NEQ "">
			#CreateODBCDateTime(form.filingdate)#,
		</cfif>
		'#form.reqid#',
		'#form.clientjobnumber#',
		#form.clientid#,
		'#form.block#',
		'#form.lot#',
		'#form.description#',
		'#form.receptionnumber#',
		'#form.pageorslide#',
		0,
		#CreateODBCDateTime(Now())#,
		0,
		#form.allow_publication#,
        <cfif IsDefined("form.request_photos")>
        	1,
        <cfelse>
        	0,
        </cfif>
        '#form.svctype#',
        <cfif IsDefined("form.rfp")>
        	1,
        <cfelse>
        	0,
        </cfif>
        	#session.current_site_id#
        )
		
</cfquery>

<cfquery name="getJobID" datasource="webwarecl">
	SELECT id FROM projects WHERE reqid='#form.reqid#'
</cfquery>    

<!--- willisj 11/28 <cfinsert datasource="#session.datasource#" tablename="projects"> --->
<!---<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	--->
    
<cfoutput>
	#ntBusinessEventNotify("WF_ORDER_PLACED", session.current_site_id, "#getLongname(session.userid)# has placed a new order.", "loadProjectViewer(#getJobID.id#);")#
	#ntNotify(session.userid, "WF_ORDER_PLACED", "You have placed a new order and will be notified as soon as the order is processed.", "loadProjectViewer(#getJobID.id#);")#
</cfoutput>                             
<cfset session.message="Job request submitted.">

<cflocation url="prefiniti_framework_base.cfm" addtoken="no">

</body>
</html>
