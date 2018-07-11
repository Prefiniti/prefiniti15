<cffunction name="getSiteStats" returntype="struct">
	<cfargument name="site_id" type="numeric" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfparam  name="siteStats" default="">
    
    <cfset siteStats=StructNew()>
    
    <cfquery name="unreadMail" datasource="webwarecl">
    	SELECT * FROM messageinbox WHERE touser=#user_id# AND tread='no' AND deleted_inbox=0
    </cfquery>

    <cfquery name="totalMail" datasource="webwarecl">
        SELECT id FROM messageinbox WHERE touser=#user_id#
    </cfquery>
        

    <cfquery name="newFriendRequests" datasource="webwarecl">
    	SELECT id FROM friends WHERE target_id=#user_id# AND confirmed=0
	</cfquery>        
    

    <cfquery name="newPosts" datasource="webwarecl">
        SELECT id FROM posts WHERE recipient_id=#user_id# AND post_read=0
    </cfquery>   
    
    
    <cfset siteStats.unreadMail=#unreadMail.RecordCount#>
    <cfset siteStats.totalMail=totalMail.recordCount>    
    <cfset siteStats.newFriendRequests=#newFriendRequests.RecordCount#>
    <cfset siteStats.newPosts=newPosts.recordCount>
    
    <cfreturn #siteStats#>
 </cffunction>