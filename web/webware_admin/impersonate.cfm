<cfif session.impersonating EQ false>
    <cfif session.user.webware_admin NEQ 1>
        <h1>Must be Global Administrator</h1>
        <cfabort>
    </cfif>
</cfif>
<cfset tgt_site = new Prefiniti.Authentication.SiteAssociation(url.assoc_id)>

<cfset session.current_association = tgt_site.id>
<cfset session.user = new Prefiniti.Authentication.UserAccount({id: tgt_site.user_id}, false)>

<cfif url.assoc_id NEQ session.originating_assoc_id>
    <cfset session.impersonating = true>
    <div class="wrapper wrapper-content animated fadeInUp">
        <div class="row">
            <div class="col-lg-4">
            </div>
            <div class="col-lg-4">
                <div class="ibox m-5">            
                    <div class="ibox-content text-center p-5">
                        <h1>Identity Changed</h1>
                        <h1><i class="fa fa-mask"></i></h1>
                        <p>You will need to reload Geodigraph Hub for this change to take effect.</p>
                        <button type="button" class="btn btn-primary btn-lg" onclick="window.location.reload();"><i class="fa fa-redo"></i> Reload</button>
                    </div>
                </div>
            </div>
            <div class="col-lg-4"></div>
        </div>
    </div>
<cfelse>
    <cfset session.impersonating = false>
    <div class="wrapper wrapper-content animated fadeInUp">
        <div class="row">
            <div class="col-lg-4">
            </div>
            <div class="col-lg-4">
                <div class="ibox m-5">            
                    <div class="ibox-content text-center p-5">
                        <h1>Identity Restored</h1>
                        <h1><i class="fa fa-mask"></i></h1>
                        <p>You will need to reload Geodigraph Hub for this change to take effect.</p>
                        <button type="button" class="btn btn-primary btn-lg" onclick="window.location.reload();"><i class="fa fa-redo"></i> Reload</button>
                    </div>
                </div>
            </div>
            <div class="col-lg-4"></div>
        </div>
    </div>

</cfif>

