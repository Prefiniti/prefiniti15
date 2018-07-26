<div class="modal-header">
    <img src="graphics/login-header.png">
    <!---<i class="fa fa-home-heart modal-icon"></i>--->
    
</div>
<div class="modal-body">
    <h3>Welcome to Geodigraph PM!</h3>
    <p class="font-bold">With Geodigraph PM, you can manage Geo-Business projects, send and receive private mail, connect with other Geo-Business professionals, and manage your employees and clients.</p>
    <hr>
     
    <div class="row">
        <div class="col-lg-8">
            <h4 class="text-success">Take a Guided Tour</h4>
            <p>The tour will give you a basic overview of Geodigraph PM navigation.</p>
                        
        </div> 
        <div class="col-lg-4">
            <button type="button" class="btn btn-primary block full-width m-b" onclick="$('#generic-window').modal('hide'); Prefiniti.Tour.begin()">Take the Tour</button>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <hr>
        </div>
    </div>
    <div class="row"> 
        <div class="col-lg-8">
            <h4 class="text-success">Go to your Account Settings</h4>
            <p>From account settings, you can fill in more details about yourself and set up such features as two-factor authentication.</p>
        </div>        
        <div class="col-lg-4">
            <cfoutput>
                <button type="button" class="btn btn-primary block full-width m-b" onclick="$('##generic-window').modal('hide'); editUser(#session.user.id#, 'basic_information.cfm');">Go to Account Settings</button>
            </cfoutput>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <hr>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-8">
            <h4 class="text-success">Go to My Files</h4>
            <p>From My Files, you can upload documents and images, and set up a profile photo.</p>            
        </div>
        <div class="col-lg-4">
            <cfoutput>
                <button type="button" class="btn btn-primary block full-width m-b" onclick="$('##generic-window').modal('hide'); cmsBrowseFolder(#session.userid#, 'project_files', '', 'user', '');">My Files</button>
            </cfoutput>
        </div>
    </div>
   
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>