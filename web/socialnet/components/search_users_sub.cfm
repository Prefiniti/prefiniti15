<!--
<wwafcomponent>search results</wwafcomponent>
-->
<cfinclude template="/socialnet/socialnet_udf.cfm">
<h3 class="stdHeader">Search Results</h3>

<cfparam name="searchRes" default="">
<cfset searchRes=StructNew()>
<cfset searchRes=searchUsers('#url.search_field#', '#url.search_value#')>

<cfoutput><strong>#searchRes.RecordCount# users found.</strong></cfoutput>



<cfoutput query="searchRes">
	<div style="padding:5px; margin:10px; background-color:##EFEFEF; -moz-border-radius:5px; width:200px; float:left;">
    	<table width="100%" cellspacing="0">
        	<tr>
            	<td width="50" rowspan="2" style="background-color:##EFEFEF">
        			<img src="#getPicture(searchRes.id)#" width="50" height="50" />  
                    <cfswitch expression="#online#">
					<cfcase value="0"><font color="red">User offline</font></cfcase>
					<cfcase value="1"><font color="green">User online</font></cfcase>
				</cfswitch>
                      		</td>
				<td align="right" valign="top">              
                    <strong><a href="javascript:viewProfile('#id#');">#longName#</a></strong><br>
                    #DateDiff("yyyy", birthday, Now())# years old
                    				</td>
			</tr>
        	<tr>
        	  <td align="right" valign="bottom"><span id="frBlock_#id#"><a href="javascript:requestFriend(#id#);">Add Friend</a></span> | <a href="javascript:mailTo(#id#, '#longName#');">Send Message</a></td>
      	  </tr>
		</table>                                            
	</div>

</cfoutput>