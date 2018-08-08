<cfset Prefiniti = new Prefiniti.Base()>
<cfset requests = prefiniti.getRequests(session.user.id)>

<!--
    <wwaftitle>Pending Friend Requests</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,Social Networking,Friend Requests</wwafbreadcrumbs>
-->


<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">

        <cfoutput query="requests">
            <cfset user = new Prefiniti.Authentication.UserAccount({id: source_id}, false)>
            <div class="col-lg-4">
                <div class="contact-box">
                    <a class="row" href="##" onclick="Prefiniti.Social.loadProfile('#source_id#');">
                        <div class="col-4">
                            <div class="text-center">
                                <img alt="image" class="rounded-circle m-t-xs img-fluid avatar-lg" src="#user.getPicture()#">
                                <div class="m-t-xs font-bold">#user.status#</div>
                            </div>
                        </div>
                        <div class="col-8">
                            <h3><strong>#user.longName#</strong></h3>

                            <p><i class="fa fa-map-marker"></i> 
                                <cfswitch expression="#user.online#">
                                    <cfcase value="0"><font color="red">User Offline</font></cfcase>
                                    <cfcase value="1"><font color="green">User Online</font></cfcase>
                                </cfswitch>

                            </p>                            
                            <div>
                                <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Social.acceptFriend(#source_id#, #target_id#);"><i class="fa fa-user-plus"></i> Accept</button>
                                <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Social.rejectFriend(#source_id#, #target_id#);"><i class="fa fa-user-minus"></i> Reject</button>
                                
                                <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Mail.writeMessage(#source_id#);"><i class="fa fa-envelope"></i> Send Message</button>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </cfoutput>
        
    </div>
</div>