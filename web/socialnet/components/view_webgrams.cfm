<cfset prefiniti = new Prefiniti.Base()>

<cfquery name="gwg" datasource="webwarecl">
	SELECT * FROM webgrams ORDER BY post_date DESC
</cfquery>

<div>
    <cfif gwg.recordCount GT 0>
        <div class="feed-activity-list">
            <cfoutput query="gwg" maxrows="#attributes.maxrows#">
                <div class="feed-element">
                    <a class="float-left" href="##" onclick="Prefiniti.Social.loadProfile(#user_id#);">
                        <img alt="image" class="rounded-circle" src="#prefiniti.getPicture(user_id)#">
                    </a>
                    <div class="media-body ">
                        <small class="float-right">#prefiniti.getFriendlyDuration(post_date)#</small>
                        #w_body#
                        <small class="text-muted">#timeFormat(post_date, "h:mm tt")# - #dateFormat(post_date, "mmmm d, yyyy")#</small>

                    </div>
                </div>
            </cfoutput>
        </div>
    <cfelse>
        <strong>No WebGrams</strong>
    </cfif>
</div>

