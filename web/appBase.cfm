<link href="css/gecko.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="/centerlineservices/framework/framework.js"></script>
<div style="padding-left:30px; padding-top:20px;">
<div id="statTarget">
</div>
<div id="framework_status"></div>

<div class="sidebarBlock"  style="height:300px; display:none;">
<span style="background-color:#EFEFEF; display:block; padding:5px; -moz-border-radius-topleft:10px;">

			<span id="packageIcon" style="padding-left:10px;"></span><span id="packageName" style="padding-left:3px; padding-right:3px;"></span>
</span>
<div id="sbTarget" style="display:none;">

</div>
</div>


<div id="tabBars" class="tabBar" style="display:none;">
	<span class="tabButtonActive" id="listViewBtn"><a href="javascript:setListView();"><span id="documentName">List View</span></a></span>
	
</div>
				
<div id="stWrapper" class="orderListBlock" style="padding:0px; width:800px; border:none;">
	<div id="stT">
		
	</div>
	
	<div id="tcTarget" style="width:800px;">
	
	</div>

</div>
</div>


<cfoutput>
	<script language="javascript">
		
		loadContentBar('#URL.contentBar#');
		shiftOpacity('plogo', 6000);
	</script>
</cfoutput>

