<cffunction name="getSiteStats" returntype="struct">
	<cfargument name="site_id" type="numeric" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfparam  name="siteStats" default="">
    <cfset siteStats=StructNew()>
    <cfquery name="unreadMail" datasource="webwarecl">
    	SELECT * FROM messageinbox WHERE touser=#user_id# AND tread='no' AND deleted_inbox=0
    </cfquery>
    
    <cfquery name="delinquentJobs" datasource="webwarecl">
    	SELECT clsJobNumber FROM projects WHERE DATE_SUB(CURDATE(), INTERVAL 30 DAY) > duedate AND SubStatus <> 'Closed'  AND site_id=#site_id#
    </cfquery>
    
    <cfquery name="tsNeedApproval" datasource="webwarecl">
    	SELECT id FROM time_card WHERE closed=1  AND site_id=#site_id#
    </cfquery>
    
	<cfquery name="tsNeedSign" datasource="webwarecl">
    	SELECT id FROM time_card WHERE emp_id=#user_id# AND site_id=#site_id# AND closed=0
    </cfquery>
    
    <cfquery name="newJobs" datasource="webwarecl">
    	SELECT viewed FROM projects WHERE viewed=0 AND stage=0 AND site_id=#site_id# AND rfp=0
    </cfquery>

    <cfquery name="newRFP" datasource="webwarecl">
    	SELECT viewed FROM projects WHERE viewed=0 AND stage=0 AND site_id=#site_id# AND rfp=1
    </cfquery>

    <cfquery name="newFriendRequests" datasource="webwarecl">
    	SELECT id FROM friends WHERE target_id=#user_id# AND confirmed=0
	</cfquery>        
    
    <cfquery name="newComments" datasource="webwarecl">
    	SELECT id FROM comments WHERE to_id=#user_id# AND c_read=0
	</cfquery>  
    
    <cfquery name="newPDFs" datasource="webwarecl">
    	SELECT newpdf FROM users WHERE id=#user_id#
    </cfquery>
    
    <cfset siteStats.unreadMail=#unreadMail.RecordCount#>
    <cfset siteStats.delinquentJobs=#delinquentJobs.RecordCount#>
    <cfset siteStats.tsNeedApproval=#tsNeedApproval.RecordCount#>
    <cfset siteStats.tsNeedSign=#tsNeedSign.RecordCount#>
    <cfset siteStats.newOrders=#newJobs.RecordCount#>
    <cfset siteStats.newFriendRequests=#newFriendRequests.RecordCount#>
    <cfset siteStats.newComments=#newComments.RecordCount#>
    <cfset siteStats.newPDF=#newPDFs.newPDF#>
    <cfset siteStats.newRFP=#newRFP.RecordCount#>
    
    <cfreturn #siteStats#>
 </cffunction>