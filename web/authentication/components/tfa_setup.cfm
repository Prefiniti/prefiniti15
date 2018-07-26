<div class="modal-header">
    <i class="fa fa-shield-alt modal-icon"></i>
    <h4 class="modal-title">Two-Factor Authentication</h4>
    <small class="font-bold">Please scan this barcode with your authenticator app to configure two-factor authentication.</small>
</div>
<div class="modal-body">

    <cfset qrcode = session.user.enableTFA()>
    
    <div class="p-5 text-center">
        <cfoutput>
            <img src="#qrcode#">        
            <h2 class="mt-3 font-bold">
                <cfloop from="1" to="13" step="4" index="i">
                    #mid(session.user.tfa_secret, i, 4)#&nbsp;
                </cfloop>
            </h2>
        </cfoutput>
    </div>

</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" onclick="Prefiniti.Security.disableTfa();">Cancel</button>
    <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="Prefiniti.reload();">Done</button>    
</div>