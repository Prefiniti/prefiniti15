<script type="text/javascript" src="/framework/framework.js"></script>
<script type="text/javascript" src="/tc/timecard.js"></script>
<script type="text/javascript" src="/calendar2.js"></script>
<script type="text/javascript" src="/workFlow/components/projectStatus.js"></script>
<script type="text/javascript" src="/workFlow/projects.js"></script>
<script type="text/javascript" src="/MyCL/components/collapse.js"></script>
<!--<script type="text/javascript" src="/formValidate.js"></script>-->
<script type="text/javascript" src="/contentManager/contentManager.js"></script>
<script type="text/javascript" src="/contentManager/swfupload.js"></script>
<script type="text/javascript" src="/contentManager/handlers.js"></script>

<cfif cgi.HTTP_HOST EQ "www.webwarecl.com">
	<!--Google Maps API key for webwarecl.com-->
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BS9InrnI581krHDS1IjuwzeaQviEhQBz53weq4VDYr1p0Sz1v1fM1skIA"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.webwarecl.net">
	<!--Google Maps API key for webwarecl.net-->	
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BTjBSsxbgXyRVXCz3Y1iKPokBykHhQlDq4lMFFgzKoxkPrLb2CAxQNfDw"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.com">
	<!--Google Maps API key for prefiniti.com-->
	<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQSPiOpE8kHJZIw4xDccjP9KUdOfRTsJgLdrnSOHIxyCRSU6QBKZCQ1qQ"
      type="text/javascript"></script>      
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.net">
	<!--Google Maps API key for prefiniti.net-->
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BRvWbUCKD0fBD63QbLGzCRB1qPvoxS-oPj5SWW_XVANygFvcFE0OmdFKg"
      type="text/javascript"></script>
<cfelseif cgi.HTTP_HOST EQ "www.prefiniti.mobi">
	<!--Google Maps API key for prefiniti.mobi-->
    <script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQG9--bzDoENeb2oUAu-TVJT4rODxRlV0_TON-qVKMhrTAgqvlcDngVYA"
      type="text/javascript"></script>            
</cfif>      
      
<script type="text/javascript" src="/mapping/mapping.js"></script>
<script type="text/javascript" src="/legalSection/legalsection.js"></script>
<script type="text/javascript" src="/news/news.js"></script>
<script type="text/javascript" src="/authentication/authentication.js"></script>
<cfinclude template="/authentication/authentication_udf.cfm">
<script type="text/javascript" src="/globals.js"></script>
<script type="text/javascript" src="/mail/mail.js"></script>
<script type="text/javascript" src="/scheduling/scheduling.js"></script>
<!--<script type="text/javascript" src="/orderWizard/orderwizard.js"></script>-->
<script type="text/javascript" src="/help/help.js"></script>
<script type="text/javascript" src="/soundmanager.js"></script>
<script type="text/javascript" src="/netsearch/netsearch.js"></script>
<script type="text/javascript" src="/chat/chat.js"></script>
<script type="text/javascript" src="/socialnet/socialnet.js"></script>
<script language="javascript" type="text/javascript" src="/datetimepicker.js"></script>
<script type="text/javascript" src="/controls/date_picker.js"></script>
<script type="text/javascript" src="/controls/record_scroller.js"></script>
<!--<script type="text/javascript" src="/FCKeditor/fckeditor.js"></script>-->
<script type="text/javascript" src="/notifications/notifications.js"></script>