<cfset res = new Prefiniti.Collaboration.Resolution(url.id)>
<cfset sponsor = res.getUserByAssociationID(res.sponsor_assoc_id)>
<cfset site = new Prefiniti.Authentication.Site(res.site_id)>
<cfset voters = res.getEligibleVoters()>
<cfset myVote = res.getMemberVote(session.current_association)>
<cfset tally = res.getTally()>
<cfset repeals = res.repeals()>
<cfset repealedBy = res.repealedBy()>

<cfoutput>
<!--
<wwaftitle>Resolution</wwaftitle>
<wwafbreadcrumbs>Geodigraph Hub,Resolutions,#res.res_title#</wwafbreadcrumbs>
-->    
</cfoutput>

<cfoutput>

    <div class="row">
        <div class="col-lg-9">
            <div class="wrapper wrapper-content animated fadeInUp">
                <div class="ibox">
                    <div class="ibox-content">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="m-b-md">
                                    <!---<a href="##" class="btn btn-white btn-xs float-right">Edit project</a>--->
                                    <h2 style="text-transform: capitalize;">#res.res_title#</h2>
                                </div>

                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-4">
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Status:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#res.getStatus()#</dd></div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Sponsor:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#sponsor.longName#</dd> </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Carry Threshold:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#res.getCarryThreshold()#</dd> </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Eligibility:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#res.getEligibility()#</dd> </div>
                                </dl>     
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right"><dt>Quorum:</dt> </div>
                                    <div class="col-sm-8 text-sm-left"><dd class="mb-1">#res.res_quorum#</dd> </div>
                                </dl>                        
                            </div>
                            <div class="col-lg-4" id="cluster_info">

                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Created:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">#dateFormat(res.res_create_date, "mm.dd.yyyy")#</dd>
                                    </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Voting Window:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">#dateFormat(res.res_voting_open, "mm.dd.yyyy")#-#dateFormat(res.res_voting_close, "mm.dd.yyyy")#</dd>
                                    </div>
                                </dl>
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Repeals:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">
                                            <cfif repeals.result EQ true>
                                                <a href="##" onclick="Prefiniti.Resolutions.view(#repeals.resolution.id#)">#repeals.resolution.res_title#</a>
                                            <cfelse>
                                                N/A
                                            </cfif>                                
                                        </dd>
                                    </div>
                                </dl>       
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Repealed By:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">
                                            <cfif repealedBy.result EQ true>
                                                <a href="##" onclick="Prefiniti.Resolutions.view(#repealedBy.resolution.id#)">#repealedBy.resolution.res_title#</a>
                                            <cfelse>
                                                N/A
                                            </cfif>                                            
                                        </dd>
                                    </div>
                                </dl>                                
                            </div>
                            <div class="col-lg-4">                                
                                <canvas id="vote-tally" 
                                        data-labels="Undecided - #tally.undecided#,Yea - #tally.yea#,Nay - #tally.nay#,Abstain - #tally.abstain#" 
                                        data-colors="##efefef,##1c84c6,##1ab394,##5a6268" 
                                        data-data="#tally.undecided#,#tally.yea#,#tally.nay#,#tally.abstain#"  
                                        width="220" 
                                        height="80" 
                                        style="margin: 0"></canvas>
                            </div>
                        </div>
                        
                        <div class="row m-t-sm">
                            <div class="col-lg-12">
                                <div class="panel blank-panel">
                                    <div class="panel-heading">
                                        <div class="panel-options">
                                            <ul class="nav nav-tabs">
                                                <li><a class="nav-link active" href="##tab-restext" data-toggle="tab"><i class="fa fa-ballot"></i> Resolution Text</a></li>
                                                <li><a class="nav-link" href="##tab-amendments" data-toggle="tab"><i class="fa fa-pencil-alt"></i> Amendments</a></li>
                                                <li><a class="nav-link" href="##tab-discussion" data-toggle="tab"><i class="fa fa-comments"></i> Discussion</a></li>
                                            </ul>
                                        </div>
                                    </div>

                                    <div class="panel-body">

                                        <div class="tab-content">
                                            <div class="tab-pane active" id="tab-restext">                                                
                                                <cfmodule template="/resolutions/components/format_resolution.cfm" id="#res.id#">
                                            </div>
                                            <div class="tab-pane" id="tab-amendments">


                                            </div>
                                            <div class="tab-pane" id="tab-discussion">

                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-3">
            <div class="wrapper wrapper-content project-manager">
                <p class="text-center mb-8">
                    <img class="rounded-circle" src="#session.user.getPicture()#" width="75"><br>
                    <h5 class="text-center" style="text-transform: capitalize;"><strong>#session.user.longName#</strong></h5>
                </p>
                <cfif (myVote.code EQ -1) AND (res.inVotingWindow()) AND (res.tabled EQ 0)>
                    <div class="row mt-6">
                        <div class="col-sm-4">
                            <button class="btn btn-success btn-lg btn-block" onclick="Prefiniti.Resolutions.castVote(#res.id#, 1);">
                                <h1><i class="fa fa-vote-yea"></i></h1>
                                Vote <strong>Yea</strong>
                            </button>
                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-primary btn-lg btn-block" onclick="Prefiniti.Resolutions.castVote(#res.id#, 2);">
                                <h1><i class="fa fa-vote-nay"></i></h1>
                                Vote <strong>Nay</strong>
                            </button>
                        </div>
                        <div class="col-sm-4">
                            <button class="btn btn-secondary btn-lg btn-block" onclick="Prefiniti.Resolutions.castVote(#res.id#, 0);">
                                <h1><i class="fa fa-circle"></i></h1>
                                <strong>Abstain</strong>
                            </button>
                        </div>
                    </div>
                <cfelse>
                    <cfif (NOT tally.carried) AND (NOT tally.failed)>                        
                        <cfif res.inVotingWindow()>
                            <div class="row mt-6">
                                <div class="col-sm-4"></div>
                                <div class="col-sm-4">
                                    <button class="btn #myVote.class# btn-lg btn-block" disabled>
                                        <h1><i class="fa #myVote.icon#"></i></h1>
                                        <strong style="text-transform: capitalize;">#myVote.desc#</strong>
                                    </button>
                                </div>
                                <div class="col-sm-4"></div>
                            </div>
                        </cfif>
                    <cfelse>
                        <cfif repealedBy.result EQ false>
                            <cfif tally.carried EQ true>
                                <div class="row mt-6">
                                    <div class="col-lg-12 text-center btn-success">
                                        <h1><i class="fa fa-vote-yea"></i><br/><strong>Resolution Adopted</strong></h1>
                                        <p style="text-transform: capitalize;"><em>#session.user.longName# #myVote.desc#</em></p>
                                    </div>
                                </div>
                            </cfif>
                            <cfif tally.failed EQ true>
                                <div class="row mt-6">
                                    <div class="col-lg-12 text-center btn-primary">
                                        <h1><i class="fa fa-vote-nay"></i><br/><strong>Resolution Failed</strong></h1>
                                        <p style="text-transform: capitalize;"><em>#session.user.longName# #myVote.desc#</em></p>
                                    </div>
                                </div>
                            </cfif>
                        <cfelse>
                            <div class="row mt-6">
                                <div class="col-lg-12 text-center btn-danger">
                                    <h1><i class="fa fa-vote-nay"></i><br/><strong>Resolution Repealed</strong></h1>
                                    <p><em>Repealed by <a href="##" onclick="Prefiniti.Resolutions.view(#repealedBy.resolution.id#);">#repealedBy.resolution.res_title#</a></em></p>
                                </div>
                            </div>
                        </cfif>
                    </cfif>
                </cfif>

                <div class="row mt-3 mb-5">
                    
                    <div class="col-lg-12">
                        <cfif res.daysUntilOpen() GT 0>
                            <cfif res.inVotingWindow()>
                                <small class="text-center"><strong>Cannot propose amendments once voting has begun.</strong></small>
                            <cfelse>
                                <button class="btn btn-warning btn-lg btn-block">
                                    <strong>Propose Amendment</strong>
                                </button>
                            </cfif>    
                        </cfif>                        
                    </div>
                   
                </div>

                <cfif (res.sponsor_assoc_id EQ session.current_association) AND (res.daysUntilOpen() GT 0)>
                    <h5>Sponsor Tools</h5>
                    <hr/>

                    <div class="row mt-3 mb-5">
                        <div class="col-lg-6">
                            <cfif res.res_tabled EQ 0>
                                <button class="btn btn-secondary btn-lg btn-block" onclick="Prefiniti.Resolutions.table(#res.id#);">
                                    <strong>Table</strong> Resolution
                                </button>
                            <cfelse>
                                <button class="btn btn-secondary btn-lg btn-block" onclick="Prefiniti.Resolutions.reopen(#res.id#);">
                                    <strong>Reopen</strong> Resolution
                                </button>
                            </cfif>
                        </div>
                        <div class="col-lg-6">
                            <button class="btn btn-secondary btn-lg btn-block" onclick="Prefiniti.Resolutions.withdraw(#res.id#);">                            
                                <strong>Withdraw</strong> Resolution
                            </button>
                        </div>
                    </div>
                </cfif>

                <h5>Roll Call</h5>
                <hr/>

                <div class="feed-activity-list">
                    <cfloop array="#voters#" item="voter">
                        <cfset vote = res.getMemberVote(voter.association.id)>
                        <div class="feed-element">
                            <a class="float-left" href="##" onclick="Prefiniti.Social.loadProfile(#voter.user.id#);">
                                <img alt="image" class="rounded-circle" src="#res.getPicture(voter.user.id)#">
                            </a>
                            <div class="media-body ">
                                <small class="float-right"><i class="fa #vote.icon#"></i></small>
                                <p><strong>#voter.user.longName# #vote.desc#</strong></p>
                                <small class="text-muted">#timeFormat(vote.date, "h:mm tt")# - #dateFormat(vote.date, "mmmm d, yyyy")#</small>
                            </div>
                        </div>
                    </cfloop>
                </div>

            </div>
        </div>
    </div>
</cfoutput>