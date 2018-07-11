<!doctype html>
<html lang="en">
<head>
	<meta charset="utf-8">
	<title>Select Site</title>
	
	<link href="/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <!---<link href="/font-awesome/css/font-awesome.css" rel="stylesheet">--->
    <link href="css/plugins/dataTables/datatables.min.css" rel="stylesheet">
    <link href="css/plugins/steps/jquery.steps.css" rel="stylesheet">

    <!-- Toastr style -->
    <link href="css/plugins/toastr/toastr.min.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/plugins/summernote/summernote-bs4.css" rel="stylesheet">
    <link href="css/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet">

    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/app.css">
    <cfinclude template="configRSS.cfm">

	<cfquery name="getSites" datasource="sites">
		SELECT * FROM site_associations WHERE user_id=#session.userid#
	</cfquery>

	<cfquery name="getLastSite" datasource="webwarecl">
		SELECT last_site_id FROM users WHERE id=#session.userid# 
	</cfquery>    
</head>
<body class="gray-bg">
	<div class="middle-box text-center loginscreen animated fadeInDown" style="width:800px;">
		
				<img src="/graphics/login-header.png" style="padding-bottom:20px;" />
				<h3>Select Site</h3>
				<p class="text-small">Your Geodigraph PM account is valid for the web sites listed below. Please choose one.</p>
			
				<form name="chooseSite" action="/siteSelectSubmit.cfm" method="post">
					<table class="table table-striped table-hover text-left">
						<tr>
					    	<th style="-moz-border-radius-topleft:5px;">&nbsp;</th>
					    	<th style="text-align:left">Site Name</th>
					        <th style="-moz-border-radius-topright:5px; text-align:left;">Account Type</th>
					    </tr>
					    <cfoutput query="getSites">
					    <tr>
					    	<td><input type="radio" name="siteAssociation" value="#id#" <cfif id EQ getLastSite.last_site_id>checked</cfif> /></td>
					    	<td><cfmodule template="/authentication/components/siteNameByID.cfm" id="#site_id#"></td>
					        <td>
					        	<cfif #assoc_type# EQ 0>
					           		Client
					            <cfelse>
					            	Employee
								</cfif>
					        </td>
					    </tr>
					    </cfoutput>
					    <tr>
					    	<td colspan="3" align="right">
					        	<br>
					            <br>
					            <br>
					        	<button type="submit" class="btn btn-primary" name="submit">Continue to Dashboard</button>
					        </td>
						</tr>       
					</table>
				</form>
			
	</div>
	
</body>
</html>