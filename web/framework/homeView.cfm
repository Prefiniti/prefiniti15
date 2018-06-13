<!--
<wwafcomponent>Prefiniti Home</wwafcomponent>
<wwafsidebar>sb_Home.cfm</wwafsidebar>
<wwafdefinesmap>false</wwafdefinesmap>
<wwafpackage>Prefiniti Network</wwafpackage>
<wwaficon>pi-16x16.png</wwaficon>
-->
<cfquery name="profile" datasource="webwarecl">
	SELECT * FROM Users WHERE id=#url.calledByUser#
</cfquery>

<cfoutput query="profile">
	<div style="width:100%; background:url(/graphics/binary-bg.jpg); background-repeat:no-repeat; height:80px; border-bottom:2px solid ##EFEFEF; ">
        <div style="float:left">
            <h3 class="stdHeader" style="padding:10px;"><img src="/graphics/globe-compass-48x48.png" align="top"> #longName#</h3>
        </div>
    </div>
    <cfparam name="bdayMonth" default="">
    <cfparam name="bdayDay" default="">
    <cfparam name="nowMonth" default="">
    <cfparam name="nowDay" default="">
    
    <cfset bdayMonth=DatePart("m", birthday)>
    <cfset bdayDay=DatePart("d", birthday)>
    <cfset nowMonth=DatePart("m", Now())>
    <cfset nowDay=DatePart("d", Now())>
    
    <cfif bdayMonth EQ nowMonth and bdayDay EQ nowDay>
    	<div style="clear:both;" class="homeHeader"><img src="/graphics/cake.png" align="absmiddle"/> Happy Birthday, #firstName#!
        </div>
        <div style="margin-left:30px;">Birthday wishes from the Prefiniti Team to you. We hope it's a happy one!</div>
	</cfif>        
    <div class="homeHeader" style="clear:both;"><img src="/graphics/sound.png" align="absmiddle"/> WebGrams</div>
    <div style="margin-left:30px; background-color:##EFEFEF; padding:5px; -moz-border-radius:5px; width:375px;">
    <cfmodule template="/socialnet/components/view_webgrams.cfm" maxrows="1">
    <div style="width:100%; text-align:right;">
	    <img src="/graphics/zoom.png" align="absmiddle" />&nbsp;
        <a href="javascript:AjaxLoadPageToDiv('tcTarget', '/socialnet/components/view_all_webgrams.cfm');">View All WebGrams</a>
    </div>
    </div>
    <!---<div class="homeHeader"><img src="graphics/calendar_view_day.png" align="absmiddle" /> My Schedule</div>
    <div style="padding-left:30px;">
        <cfmodule template="/scheduling/components/getSchedule.cfm" userid="#url.calledByUser#">
    </div>--->
    
    <div class="homeHeader"><a href="/news/rss.cfm?current_site_id=#url.current_site_id#" target="_blank"><img src="graphics/feed.png" align="absmiddle" border="0"/></a> Site News</div>
    <div style="padding-left:30px;">
    <cfmodule template="/news/components/newsView.cfm"  site_id="#url.current_site_id#">
    </div>
    <div class="homeHeader"><img src="/graphics/newspaper.png" align="absmiddle" /> My Friends' News</div>		<div id="fre">
    <cfmodule template="/socialnet/components/view_friend_events.cfm" user_id="#url.calledByUser#" start_row="1" records_per_page="5" load_to="fre"></div>
    <div class="homeHeader"><img src="/graphics/heart.png" align="absmiddle" /> Friends</div>
    <div id="frl"> 
    <cfmodule template="/socialnet/components/friends_list.cfm"  user_id="#url.calledByUser#" calledByUser="#url.calledByUser#" start_row="1" records_per_page="10" load_to="frl" >
    </div>     	
</cfoutput>