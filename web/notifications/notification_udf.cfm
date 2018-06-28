<cffunction name="ntAllTypes" returntype="query">
	
    <cfquery name="ntat" datasource="webwarecl">
    	SELECT * FROM notifications ORDER BY n_key
    </cfquery>
    
    <cfreturn #ntat#>
</cffunction>

<cffunction name="ntIDByKey" returntype="numeric">
    <cfargument name="notify_key" type="string" required="yes">
        
    <cfquery name="ntibk" datasource="webwarecl">
    	SELECT id FROM notifications WHERE n_key='#notify_key#'
	</cfquery>
    
    <cfreturn #ntibk.id#>
</cffunction>

<cffunction name="ntUserMethods" returntype="query">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_id" type="numeric" required="yes">
    
    <cfquery name="ntum" datasource="webwarecl">
    	SELECT * FROM notification_entries 
        WHERE 	user_id=#user_id#
        AND		notification_id=#event_id#
	</cfquery>        
    
    <cfreturn #ntum#>	
</cffunction>    
                 
<cffunction name="ntNotify" returntype="void">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">
    
    <cfquery name="ntn_contact" datasource="webwarecl">
    	SELECT email, smsNumber FROM users WHERE id=#user_id#
	</cfquery>        
        
    <cfparam name="nt_header" default="">
    <cfparam name="event_id" default="">
    <cfparam name="methods" default="">
    <cfparam name="event_name" default="">
    
	<cfset event_id = ntIDByKey(event_key)>
    <cfset methods = ntUserMethods(user_id, event_id)>
    
    <cfquery name="ntn_eventname" datasource="webwarecl">
    	SELECT description FROM notifications WHERE id=#event_id#
	</cfquery>
    
    <cfset event_name = ntn_eventname.description>        
        
    <cfoutput query="methods">
    	<cfswitch expression="#method#">
        	<cfcase value="0">		<!--Prefiniti Mail-->
            
            	<cfquery name="ntn_write_message" datasource="webwarecl">
                    INSERT INTO messageinbox 
                        (fromuser,
                        touser,
                        tsubject,
                        tbody,
                        tdate,
                        tread,
                        req_id,
                        readReceipt
                        )
                    VALUES
                        (0,
                        #user_id#,
                        '#event_name#',
                        '#body_text# <br><a href="javascript:#event_link#">View Event</a>',
                        #CreateODBCDateTime(Now())#,
                        'no',
                        '',
                        0)
				</cfquery>                        
            
            </cfcase>
            <cfcase value="1">		<!--Internet E-Mail-->
            	<cfmail from="notifications@prefiniti.com" to="#ntn_contact.email#" subject="#event_name#" type="html">
                	<cfmodule template="/notifications/components/notify_header.cfm" 
                    		event_name="#event_name#" 
                            event_link="#event_link#"
                            body_text="#body_text#">
                </cfmail>
            </cfcase>
            <cfcase value="2">		<!--SMS Text Message-->
            	<cfmail from="sms@prefiniti.com" to="#ntn_contact.smsNumber#" subject="Prefiniti: #event_name#">
                	<cfoutput>#body_text#</cfoutput>
                </cfmail>
            </cfcase>
        </cfswitch>
    </cfoutput>
    
</cffunction>    

<cffunction name="ntNotifyDepartment" returntype="void">
	<cfargument name="department_id" type="numeric" required="yes">
    <cfargument name="event_key" type="string" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	
    
    <cfparam name="dp" default="">
    <cfset dp=wwGetDepartmentMembers(department_id)>
    
    <cfoutput query="dp">
    	#ntNotify(user_id, event_key, body_text, event_link)#
	</cfoutput>         
</cffunction>  

<cffunction name="ntBusinessEventNotify" returntype="void">
	<cfargument name="business_event_key" type="string" required="yes">
    <cfargument name="site_id" type="numeric" required="yes">
    <cfargument name="body_text" type="string" required="yes">
    <cfargument name="event_link" type="string" required="no">	
    
    <cfparam name="be_id" default="">
    <cfquery name="gbeid" datasource="sites">
    	SELECT * FROM department_events WHERE event_key='#business_event_key#'
	</cfquery>
    <cfset be_id=#gbeid.id#>
    
    
    <cfquery name="geds" datasource="sites">
    	SELECT * FROM event_entries WHERE event_id=#be_id# AND site_id=#site_id#
	</cfquery>

    <cfoutput query="geds">
    	#ntNotifyDepartment(department_id, business_event_key , body_text, event_link)#
	</cfoutput>
                    
</cffunction>

<cffunction name="ntMigrateBusinessToIndividual" returntype="void">
	
    <cfquery name="gbe" datasource="sites">
    	SELECT * FROM department_events
	</cfquery>
    
    <cfoutput query="gbe">
    	<cfquery name="ioe" datasource="webwarecl">
        	INSERT INTO notifications
            	(n_key,
                description)
			VALUES
            	('#event_key#',
                '#event_name#')
		</cfquery>
	</cfoutput>
</cffunction>                                           
        