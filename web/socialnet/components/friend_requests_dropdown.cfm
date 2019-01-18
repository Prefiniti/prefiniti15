<cfif isDefined("session.user")>
    <cfif isDefined("session.user.id")>
        <cfset prefiniti = new Prefiniti.Base()>
        <cfset requests = prefiniti.getRequests(session.user.id)>

        <cfoutput query="requests">
            <cfset user = new Prefiniti.Authentication.UserAccount({id: requests.source_id}, false)>
            <cfset pic = user.getPicture()>

            <li>
                <div class="dropdown-item">
                    <div class="row">
                        <div class="col-xs-1">
                            <img class="rounded-circle avatar-sm float-left" onclick="Prefiniti.Social.loadProfile(#user.id#);" src="#pic#">                 
                        </div>
                        <div class="col-xs-8">
                            <a href="##" onclick="Prefiniti.Social.loadProfile(#user.id#);">#user.longName#</small></a><br>
                            <span class="text-muted small ml-3">#prefiniti.getFriendlyDuration(request_date)#</span>
                        </div>
                        <div class="col-xs-3 text-right">
                            <div class="btn-group float-right">
                                    <button type="button" class="btn btn-xs btn-white" onclick="Prefiniti.Social.acceptFriend(#source_id#, #target_id#);">Accept</button>
                                    <button type="button" class="btn btn-xs btn-white" onclick="Prefiniti.Social.rejectFriend(#source_id#, #target_id#);">Reject</button>                
                            </div>
                        </div>
                        
                    </div>
                </div>
            </li>
            <li class="dropdown-divider"></li>
        </cfoutput>
    </cfif>
</cfif>