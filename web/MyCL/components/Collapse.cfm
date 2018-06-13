<!---
	Collapse.cfm
	Expanding/Collapsing div widget
	
	John Willis
	Authored 3/9/2007

	Attributes:
		Name			The name of this box
		URL				URL of content to load inside of the box
		HeaderText		Header Text to display at the top of the box
		InitialState	Initial state of the box-"inline" or "none"
--->




<cfoutput>
	<div class="cWrap">

				<span class="HeaderBox" id="#attributes.DivName#Btn" align="left" ><cfif IsDefined("attributes.SideImage")>
						<img src="http://www.webwarecl.com/graphics/#attributes.SideImage#" align="absmiddle"/>
					</cfif>
					<a href="javascript:SwapShown('#attributes.DivName#')" >
						#attributes.HeaderText#
					</a>
				</span>
			
			
				<div id="#attributes.DivName#" style="display:none; z-index:300;position:absolute; border-bottom: 1px solid ##EFEFEF;	border-left: 1px solid ##EFEFEF;	border-right: 1px solid ##EFEFEF; background-color: ##EFEFEF; width:240px; -moz-opacity:.90;">
					
					<cfinclude template="#attributes.URL#">
				</div>
			
	</div>


</cfoutput>