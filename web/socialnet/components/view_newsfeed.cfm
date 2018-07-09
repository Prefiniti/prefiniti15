<cfset prefiniti = new Prefiniti.Base()>
<cfset events = prefiniti.getFriendEvents(session.user.id)>

<div>
    <cfif events.recordCount GT 0>
        <div class="feed-activity-list">
            <cfoutput query="events" maxrows="#attributes.count#">
                <div class="feed-element">
                    <a class="float-left" href="##" onclick="viewProfile(#user_id#);">
                        <img alt="image" class="rounded-circle" src="#prefiniti.getPicture(user_id)#">
                    </a>
                    <div class="media-body ">
                        <small class="float-right">#prefiniti.getFriendlyDuration(event_date)#</small>
                        <p>#event_text#</p>
                        <small class="text-muted">#timeFormat(event_date, "h:mm tt")# - #dateFormat(event_date, "mmmm d, yyyy")#</small>

                    </div>
                </div>
            </cfoutput>
        </div>
    <cfelse>
        <strong>No news!</strong>
    </cfif>
</div>
