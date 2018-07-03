<cfset person = new Prefiniti.Authentication.UserAccount({id: url.user_id}, false)>
<cfset prefiniti = new Prefiniti.Base()>
<cfset userEvents = prefiniti.getUserEvents(url.user_id)>

<cfoutput>
    <div class="row m-b-lg">
        <div class="col-lg-4 text-center">
            <h2>#person.longName#</h2>

            <div class="m-b-sm">
                <img alt="image" class="rounded-circle" src="#person.getPicture()#"
                style="width: 62px">
            </div>
        </div>
        <div class="col-lg-8">
            <strong>
                Status
            </strong>

            <p>#person.status#</p>
            <p>#prefiniti.getOnline(person.id)#</p>

            <div class="button-group">
                <button type="button" class="btn btn-primary btn-sm"><i class="fa fa-user"></i> View Profile</button>
                <button type="button" class="btn btn-primary btn-sm"><i
                    class="fa fa-envelope"></i> Send Message
                </button>
            </div>
        </div>
    </div>
    <div class="client-detail">
        
        
        <hr/>
        <strong>Timeline activity</strong>
        <div id="vertical-timeline" class="vertical-container dark-timeline">
            <cfoutput query="userEvents" maxrows="10">
                <div class="vertical-timeline-block">
                    <div class="vertical-timeline-icon gray-bg">
                        <img src="/graphics/#event_icon#">
                    </div>
                    <div class="vertical-timeline-content">
                        <p>#event_text#</p>
                        <span class="vertical-date small text-muted">#prefiniti.getFriendlyDuration(event_date)#</span>
                    </div>
                </div>
            </cfoutput>           
        </div>        
    </div>
</cfoutput>