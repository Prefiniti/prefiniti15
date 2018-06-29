<cfset prefiniti = new Prefiniti.LegacyAPI()>

<cfset friends = session.user.getFriends()>
<cfset events = prefiniti.getUserEvents(session.user.id)>


<div class="container-fluid">    
    <div class="row">
        <div class="col-md-2">
            <div class="card">
                <div class="card-header">
                    <i class="fa fa-bullhorn"></i> Friends Online
                </div>
                <div class="card-body">
                    <cfloop array="#friends#" item="friend">
                        <cfoutput>

                            <cfif friend.online EQ 1>
                                <cfset friendPic = friend.getPicture()>
                                <cfset friendName = friend.longName>
                                
                                <div class="row mb-3">
                                    <div class="col-sm-2">
                                        <img src="#friendPic#" class="rounded-circle avatar-sm">
                                    </div>
                                    <div class="col-sm-10">
                                        <a href="##" onclick="Prefiniti.viewProfile(#friend.id#);">
                                            <small>#friendName#</small>
                                        </a>
                                    </div>
                                </div>

                                <hr>
                            </cfif>
                           
                        </cfoutput>
                    </cfloop>
                </div>
            </div> <!-- friends -->
        </div>
        <div class="col-md-6">
            
            
            <cfoutput query="events" maxrows="50">

                <cfset u = new Prefiniti.Authentication.UserAccount({id: user_id}, false)>
                
                
                <p><img src="/graphics/#event_icon#" class="img-thumbnail"> #event_text#</p>                        
                
                <hr>
            </cfoutput>            
        </div>
        <div class="col-md-4">
            <div class="card">
                <div class="card-header">
                    <i class="fa fa-bullhorn"></i> Prefiniti Announcements
                </div>
                <div class="card-body">
                    <cfmodule template="/socialnet/components/view_webgrams.cfm" maxrows="10">
                </cfmodule>
            </div>
        </div>

    </div>
</div>
