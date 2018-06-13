<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfparam name="mr" default="">
<cfparam name="rw" default="">

<cfif attributes.maxrows EQ 1>
	<style>
		.wwt td {
		background-color:#EFEFEF;
		}
	</style>
<cfelse>
	<style>
		.wwt td {
		background-color:white;
		}
	</style>	
</cfif>    

<cfquery name="gwg" datasource="webwarecl">
	SELECT * FROM webgrams ORDER BY post_date DESC
</cfquery>

<cfif attributes.maxrows EQ "">
	<cfset mr=gwg.RecordCount>
<cfelse>
	<cfset mr=attributes.maxrows>
</cfif>        

<cfif mr EQ 1>
	<cfset rw="370">
<cfelse>
	<cfset rw="100%">
</cfif>     

<cfif gwg.RecordCount EQ 0>
	<div style="padding-left:30px;"><strong>No WebGrams</strong></div>
<cfelse>
	<cfoutput query="gwg" maxrows="#mr#">
    	<table width="#rw#" cellpadding="5" class="wwt">
        	<tr>
            	<td valign="top">
                	<img src="#getPicture(user_id)#" width="80"><br />
                	#getLongname(user_id)#
                </td>
                <td valign="top"><strong>#DateFormat(post_date, "mm/dd/yyyy")# #TimeFormat(post_date, "h:mm tt")#</strong><br>
                	#w_body#
                </td>    
			</tr>                
        </table>
    </cfoutput>
</cfif>    




