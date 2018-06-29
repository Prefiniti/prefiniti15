<cfset prefiniti = new Prefiniti.LegacyAPI()>

<cfset requests = prefiniti.getRequests(session.user.id)>


<cfoutput query="requests">

    <cfset user = new Prefiniti.Authentication.UserAccount({id: requests.source_id}, false)>
    <cfset pic = user.getPicture()>
    

    <div class="container-fluid">
        <div class="row m-1">
            <div class="col-sm-1">
                <div class="text-center mt-3">
                    <a href="##" onclick="Prefiniti.viewProfile(#user.id#);">
                        <img class="rounded-circle avatar-sm" src="#pic#">
                    </a>
                </div>
            </div>
            <div class="col-sm-8">                
                <a class="dropdown-item" href="##" onclick="Prefiniti.viewProfile(#user.id#);"><small><b>#user.longName#</b></small></a>
                <form>
                    <div class="btn-group ml-4">
                        <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.acceptFriend(#source_id#, #target_id#);">Accept</button>
                        <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.rejectFriend(#source_id#, #target_id#);">Reject</button>                
                    </div>
                </form>
            </div>
        </div>
    </div>
    <div role="separator" class="dropdown-divider"></div>
</cfoutput>