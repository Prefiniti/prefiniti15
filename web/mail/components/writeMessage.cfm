<cfset prefiniti = new Prefiniti.Base()>

<div class="wwaf-metadata">
    <wwaftitle>Compose Mail</wwaftitle>
    <wwafbreadcrumbs>Geodigraph PM,Mailbox,Compose Mail</wwafbreadcrumbs>
</div>

<cfset friends = session.user.getFriends()>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="MA_WRITE">
<div class="wrapper wrapper-content">
    <div class="row">
        <div class="col-lg-3">
            <div class="ibox ">
                <div class="ibox-content mailbox-content">
                    <cfinclude template="/mail/components/mail_sidebar.cfm">
                </div>
            </div>
        </div>
        <div class="col-lg-9 animated fadeInRight">
            <div class="mail-box-header">
                <div class="float-right tooltip-demo">
                    <a href="##" onclick="viewMailFolder('inbox', 1);" class="btn btn-danger btn-sm" data-toggle="tooltip" data-placement="top" title="Discard email"><i class="fa fa-times"></i> Discard</a>
                </div>
                <h2>
                    Compose Mail
                </h2>
            </div>
            <div class="mail-box">


                <div class="mail-body">

                    <form method="get">
                        <div class="form-group row"><label class="col-sm-2 col-form-label">To:</label>

                            <div class="col-sm-10">
                                <select class="form-control" name="touser" id="touser">
                                    <cfloop array="#friends#" item="friend">
                                        <cfoutput>
                                            <option value="#friend.id#">#friend.longName#</option>
                                        </cfoutput>
                                    </cfloop>
                                </select>
                            </div>
                        </div>
                        <div class="form-group row"><label class="col-sm-2 col-form-label">Subject:</label>

                            <div class="col-sm-10"><input type="text" class="form-control" value=""></div>
                        </div>
                    </form>

                </div>

                <div class="mail-text h-200">

                    <div class="summernote">
                        

                    </div>
                    <div class="clearfix"></div>
                </div>
                <div class="mail-body text-right tooltip-demo">
                    <a href="mailbox.html" class="btn btn-sm btn-primary" data-toggle="tooltip" data-placement="top" title="Send"><i class="fa fa-reply"></i> Send</a>
                    <a href="##" onclick="viewMailFolder('inbox', 1);" class="btn btn-white btn-sm" data-toggle="tooltip" data-placement="top" title="Discard email"><i class="fa fa-times"></i> Discard</a>
                </div>
                <div class="clearfix"></div>



            </div>
        </div>
    </div>
</div>
        