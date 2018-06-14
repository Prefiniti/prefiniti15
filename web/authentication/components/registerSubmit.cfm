<cfinclude template="/authentication/authentication_udf.cfm">

<cfparam name="cid" default="#CreateUUID()#">

<!-- create the user account -->
<cfquery name="createUserAccount" datasource="webwarecl">
	INSERT INTO Users 
		(birthday,
        longName,        
        firstName,
        middleInitial,
        lastName,
        individual_account,
		company,
		email,
		email_billing,
		gender,
		smsnumber,
		phone,
		fax,
		username,
		confirm_id,
		confirmed,
		account_enabled,
		type,
        last_pwchange,
        webware_admin,
        allowSearch)
	VALUES (
    	#CreateODBCDate(url.birthday)#,
        '#url.firstName# #url.middleInitial#. #url.lastName#',
    	'#url.firstName#',
        '#url.middleInitial#',
        '#url.lastName#',
		1,
		0,
		'#url.email#',
		<cfif #url.email_billing# EQ true>
		1,
		<cfelse>
		0,
		</cfif>
		'#url.gender#',
		'#url.smsnumber#',
		'#url.phone#',
		'#url.fax#',
		'#url.reg_username#',
		'#cid#',
		0,
		0,
		0,
        #CreateODBCDateTime(Now())#,
        0,
        <cfif #url.allowSearch# EQ true>
        	1
        <cfelse>
        	0
		</cfif>            
        )
</cfquery>

<!-- retrieve the user id for the new user -->

<cfquery name="UID" datasource="webwarecl">
	SELECT id FROM users WHERE confirm_id='#cid#'
</cfquery>

<cfquery name="cf1" datasource="webwarecl">
	INSERT INTO friends
    	(source_id,
        target_id,
        confirmed,
        request_date)
	VALUES
    	(#UID.id#,
        124,
        1,
        #CreateODBCDateTime(Now())#)     
</cfquery>

<cfquery name="cf2" datasource="webwarecl">
	INSERT INTO friends
    	(source_id,
        target_id,
        confirmed,
        request_date)
	VALUES
    	(124,
        #UID.id#,
        1,
        #CreateODBCDateTime(Now())#)     
</cfquery>

<cfquery name="createMailingAddress" datasource="webwarecl">
	INSERT INTO locations 
		(user_id,
        description,
        address,
		city,
		state,
		zip,
      	mailing,
        billing)
	VALUES 
    	(#UID.id#,
        'Physical Address',
        '#url.mailing_address#',
		'#url.mailing_city#',
		'#url.mailing_state#',
		'#url.mailing_zip#',
     	1,
        <cfif #url.mailEqualsBill# EQ true>
        	1
        <cfelse>
        	0
        </cfif>
        )
</cfquery>

<cfif #url.mailEqualsBill# EQ false>		
	<cfquery name="createBillingAddress" datasource="webwarecl">
    INSERT INTO locations 
		(user_id,
        description,
        address,
		city,
		state,
		zip,
      	mailing,
        billing)
	VALUES
        (#UID.id#,
        'Billing Address',
        '#url.billing_address#',
		'#url.billing_city#',
		'#url.billing_state#',
		'#url.billing_zip#',
		0,
        1)
	</cfquery>
</cfif>

<!-- Create the default association --->
<cfquery name="createAssoc" datasource="sites">
	INSERT INTO site_associations
    	(user_id,
        site_id,
        assoc_type,
        conf_id)
    VALUES
    	(#UID.id#,
        5,
        0,
        '#cid#')
</cfquery>

<!-- Get the id of the association created -->
<cfquery name="acid" datasource="sites">
	SELECT id FROM site_associations WHERE conf_id='#cid#'
</cfquery>

<!-- Grant the basic permissions -->

<cfoutput>
	#grantPermission("AS_LOGIN", acid.id)#
    #grantPermission("MA_VIEW", acid.id)#
    #grantPermission("MA_WRITE", acid.id)#
    #grantPermission("SC_VIEW", acid.id)#
    #grantPermission("SC_DISPATCH", acid.id)#
    #grantPermission("SC_MANAGECREW", acid.id)#
	#grantPermission("RSS_CREATE", acid.id)#
</cfoutput>

<!-- Create the directory structure -->
<cfoutput>
	<cfdirectory action="create" directory="D:\Inetpub\WebWareCL\UserContent\#url.reg_username#">
    <cfdirectory action="create" directory="D:\Inetpub\WebWareCL\UserContent\#url.reg_username#\profile_images">
    <cfdirectory action="create" directory="D:\Inetpub\WebWareCL\UserContent\#url.reg_username#\project_files">
    <cfdirectory action="create" directory="D:\Inetpub\WebWareCL\UserContent\#url.reg_username#\wallpapers">
</cfoutput>

<cfoutput>
<cfmail from="register@webwarecl.com" to="#url.email#" cc="accountnotify@webwarecl.com" subject="WebWare.CL Account Confirmation" type="html">
	<h1>Account Created</h1>
	
	<p>Your WebWare.CL account has been created. Please visit the link below to confirm your new account.</p>
	
	<a href="http://www.webwarecl.com/appBase.cfm?sideBar=Register&contentBar=/authentication/components/setInitialPassword.cfm?cid=#cid#">Confirm My Account</a>
	
	<p>Otherwise, copy the following text to your browser's URL bar:</p>
	
	<pre>http://www.webwarecl.com/appBase.cfm?sideBar=Register&contentBar=/authentication/components/setInitialPassword.cfm?cid=#cid#</pre>
</cfmail>
</cfoutput>

<cfoutput>
<table width="100%">
<tr>
	<td align="center">
		<h3>Account Created.</h3>
		
		<p>An e-mail containing instructions for activating your account has been sent to <strong>#url.email#</strong>.</p>
		
	</td>
</tr>
</table>
</cfoutput>
