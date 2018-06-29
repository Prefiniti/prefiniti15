<cfinclude template="/socialnet/socialnet_udf.cfm">

<cfquery name="gwg" datasource="webwarecl">
	SELECT * FROM webgrams ORDER BY post_date DESC
</cfquery>

<cfset mr = attributes.maxrows>

<cfif gwg.RecordCount EQ 0>
	<div style="padding-left:30px;"><strong>No WebGrams</strong></div>
<cfelse>
	<cfoutput query="gwg" maxrows="#mr#">
    	<div class="row mb-3">
            <div class="col-sm-2">
              	<img src="#getPicture(user_id)#" class="rounded-circle avatar-sm">
            </div>
            <div class="col-sm-10">
                <strong>#DateFormat(post_date, "mm/dd/yyyy")# #TimeFormat(post_date, "h:mm tt")#</strong><br>
                	#w_body#
            </div>
        </div>
    </cfoutput>
</cfif>    




