<!--
<wwaftitle>Friend Search Results</wwaftitle>
<wwafbreadcrumbs>Geodigraph PM,Social Networking,Friend Search,Results</wwafbreadcrumbs>
-->

<cfset prefiniti = new Prefiniti.Base()>

<cfset searchRes = prefiniti.searchUsers(url.search_field, url.search_value)>


<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">

        <cfoutput query="searchRes">
            <cfset user = new Prefiniti.Authentication.UserAccount({id: id}, false)>
            <div class="col-lg-4">
                <div class="contact-box">
                    <a class="row" href="##" onclick="Prefiniti.Social.loadProfile('#id#');">
                        <div class="col-4">
                            <div class="text-center">
                                <img alt="image" class="rounded-circle m-t-xs img-fluid avatar-lg" src="#prefiniti.getPicture(id)#">
                                <div class="m-t-xs font-bold">#status#</div>
                            </div>
                        </div>
                        <div class="col-8">
                            <h3><strong>#longName#</strong></h3>

                            <p><i class="fa fa-map-marker"></i> 
                                <cfswitch expression="#online#">
                                    <cfcase value="0"><font color="red">User Offline</font></cfcase>
                                    <cfcase value="1"><font color="green">User Online</font></cfcase>
                                </cfswitch>

                            </p>                            
                            <div onclick="event.stopPropagation();">
                                <cfif session.user.hasPendingFriendRequest(user)>
                                    <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Social.cancelRequest(#session.user.id#, #id#);"><i class="fa fa-user-slash"></i> Cancel Friend Request</button>
                                <cfelse>
                                    <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Social.requestFriend(#session.user.id#, #id#);"><i class="fa fa-user-plus"></i> Add Friend</button>
                                </cfif>
                                <button type="button" class="btn btn-sm btn-primary" onclick="Prefiniti.Mail.writeMessage(#id#);"><i class="fa fa-envelope"></i> Send Message</button>
                            </div>
                        </div>
                    </a>
                </div>
            </div>
        </cfoutput>
        
    </div>
</div>
