<cffunction name="scItemsByBlock" returntype="void" output="yes">
	<cfargument name="block_id" type="numeric" required="yes">
    <cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="date" type="date" required="yes">
    
    <cfquery name="scibb" datasource="webwarecl">
    	SELECT * FROM schedule_entries 
        WHERE	#block_id# >= start_block
        AND		#block_id# <= end_block 
        AND		user_id = #user_id#
        AND		date = #CreateODBCDate(date)#
	</cfquery>
    
    <cfparam name="blk_ind" default="">
    
    <cfoutput query="scibb">
    	<cfif block_id EQ start_block>
        	<!--- set the indent --->
            <cfset blk_ind=(scibb.RecordCount * 150) + 10>
        	<div class="itemBlock" style="-moz-border-radius-topleft:5px; -moz-border-radius-topright:5px; margin-left:#blk_ind#;"><a href="javascript:scViewEvent(#id#);">#event_title#</a></div>
        <cfelse>
        	<cfif scibb.RecordCount EQ 1>
            <div class="itemBlock" style="margin-left:#blk_ind#;">&nbsp;</div>
            </cfif>
        </cfif>
	</cfoutput>
    
    <cfif scibb.RecordCount EQ 0>
    	<div style="min-height:10px;"></div>
	</cfif>        
</cffunction>  

<!--scCreateEvent(user_id, date, start_block, end_block, event_description,
					   address, city, state, zip)-->
<cffunction name="scCreateIndividualEvent" returntype="boolean">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="date" type="date" required="yes">
    <cfargument name="start_block" type="numeric" required="yes">
    <cfargument name="end_block" type="numeric" required="yes">
    <cfargument name="event_description" type="string" required="yes">
    <cfargument name="event_title" type="string" required="yes">
    <cfargument name="address" type="string" required="yes">
    <cfargument name="city" type="string" required="yes">
    <cfargument name="state" type="string" required="yes">
    <cfargument name="zip" type="string" required="yes">
	<cfargument name="scheduler_id" type="numeric" required="yes">
    
    <cfif scDeconflictEvent(user_id, date, start_block, end_block, 0) GT 0>
    	<strong>The block of time you have requested for scheduling has conflicts with other items in the schedule.<br />Please modify this item to remove any conflicts and then try saving the schedule again.</strong>
    
    	<cfreturn false>
	</cfif>
    
    <cfquery name="sccie" datasource="webwarecl">
    	INSERT INTO schedule_entries 
        	(user_id,
            date,
            start_block,
            end_block,
            event_description,
            event_title,
    		address,
            city,
            state,
            zip,
            scheduler_id,
            scheduled_on)
		VALUES
        	(#user_id#,
            #CreateODBCDate(date)#,
            #start_block#,
            #end_block - 1#,
            '<p>#event_description#</p>',
            '#event_title#',
            '#address#',
            '#city#',
            '#state#',
            '#zip#',
            #scheduler_id#,
            #CreateODBCDateTime(Now())#)
                                
	</cfquery>
    
    <cfreturn true>
</cffunction> 

<cffunction name="scUpdateIndividualEvent" returntype="boolean">
	<cfargument name="event_id" type="numeric" required="yes">
    <cfargument name="date" type="date" required="yes">
    <cfargument name="start_block" type="numeric" required="yes">
    <cfargument name="end_block" type="numeric" required="yes">
    <cfargument name="event_description" type="string" required="yes">
    <cfargument name="event_title" type="string" required="yes">
    <cfargument name="address" type="string" required="yes">
    <cfargument name="city" type="string" required="yes">
    <cfargument name="state" type="string" required="yes">
    <cfargument name="zip" type="string" required="yes">
    
    <cfparam name="ei" default="">
    <cfset ei = scItem(event_id)>
    
    <cfif scDeconflictEvent(ei.user_id, date, start_block, end_block, event_id) GT 0>
    	<strong>The block of time you have requested for scheduling has conflicts with other items in the schedule.<br />Please modify this item to remove any conflicts and then try saving the schedule again.</strong>
    
    	<cfreturn false>
	</cfif>
    
    <cfquery name="scuie" datasource="webwarecl">
    	UPDATE schedule_entries 
       	SET		date=#CreateODBCDate(date)#,
        		start_block=#start_block#,
                end_block=#end_block - 1#,
                event_description='#event_description#',
                event_title='#event_title#',
                address='#address#',
                city='#city#',
                state='#state#',
                zip='#zip#'
		WHERE
        		id=#event_id#                      
	</cfquery>
    
    <cfreturn true>
</cffunction> 

<cffunction name="scDeconflictEvent" returntype="numeric">
	<cfargument name="user_id" type="numeric" required="yes">
    <cfargument name="date" type="date" required="yes">
    <cfargument name="start_block" type="numeric" required="yes">
    <cfargument name="end_block" type="numeric" required="yes">
    <cfargument name="exclude_event" type="numeric" required="yes">
    
    <cfparam name="bi" default="0">
    <cfparam name="existing_blocks" default="">
    <cfparam name="proposed_blocks" default="">
    <cfparam name="conflict_count" default="0">
    
    <cfset existing_blocks=ArrayNew(1)>
    <cfset proposed_blocks=ArrayNew(1)>
    
    <cfquery name="get_all_user_blocks" datasource="webwarecl">
    	SELECT start_block, end_block 
        FROM 	schedule_entries 
        WHERE 	user_id = #user_id# 
        AND 	date = #CreateODBCDate(date)#
        <cfif exclude_event NEQ 0>
        	AND		id != #exclude_event#
		</cfif>            
	</cfquery>        
    
    <!-- initialize proposed blocks -->
    <cfset bi = 0>
    <cfloop from="#start_block#" to="#end_block#" index="i">
    	<cfset bi = bi + 1>
		<cfset proposed_blocks[bi] = i>
    </cfloop>
    
    <!-- get all blocks currently used in user's schedule -->
    <cfset bi = 0>
	<cfoutput query="get_all_user_blocks">
    	<cfloop from="#get_all_user_blocks.start_block#" to="#get_all_user_blocks.end_block#" index="i">
        	<cfset bi = bi + 1>
            <cfset existing_blocks[bi] = #i#>
        </cfloop>
    </cfoutput>
    
    <!-- compare used blocks to proposed blocks... if any match, increment the conflict count -->
    <cfloop from="1" to="#ArrayLen(proposed_blocks) - 1#" index="i">
    	<cfloop from="1" to="#ArrayLen(existing_blocks)#" index="j">
        	<cfif proposed_blocks[i] EQ existing_blocks[j]>
            	<cfset conflict_count = conflict_count + 1>
			</cfif>
		</cfloop>
	</cfloop>
    
    <cfreturn #conflict_count#>
</cffunction>              

<cffunction name="scItem" returntype="query">
	<cfargument name="item_id" type="numeric" required="yes">
    
    <cfquery name="sci" datasource="webwarecl">
    	SELECT * FROM schedule_entries WHERE id=#item_id#
    </cfquery>
    
    <cfreturn #sci#>
</cffunction>

<cffunction name="scTimeByBlock" returntype="string">
	<cfargument name="block_id" type="numeric" required="yes">
    
    <cfquery name="sctbb" datasource="webwarecl">
    	SELECT * FROM time_lookup WHERE block_id=#block_id#
	</cfquery>
    
    <cfreturn #sctbb.time_12hour#>
</cffunction>            

