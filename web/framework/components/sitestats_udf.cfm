<cffunction name="getSiteStats" returntype="struct">
	<cfargument name="site_id" type="numeric" required="yes">
	<cfargument name="user_id" type="numeric" required="yes">
    
	<cfparam  name="siteStats" default="">
    
    <cfset siteStats=StructNew()>
        

    <cfquery name="newFriendRequests" datasource="webwarecl">
    	SELECT id FROM friends WHERE target_id=#user_id# AND confirmed=0
	</cfquery>        
    

    <cfquery name="newPosts" datasource="webwarecl">
        SELECT id FROM posts WHERE recipient_id=#user_id# AND post_read=0
    </cfquery>   
    
    
    <cfset siteStats.unreadMail = session.user.getUnreadMessageCount()>
    <cfset siteStats.totalMail = session.user.getInboxMessages().len()>    
    <cfset siteStats.newFriendRequests = newFriendRequests.recordCount>
    <cfset siteStats.newPosts = newPosts.recordCount>
    
    <cfreturn #siteStats#>
 </cffunction>