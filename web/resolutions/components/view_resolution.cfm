<cfset res = new Prefiniti.Collaboration.Resolution(url.id)>
<cfset sponsor = res.getUserByAssociationID(res.sponsor_assoc_id)>
<cfset site = new Prefiniti.Authentication.Site(res.site_id)>
<cfset voters = res.getEligibleVoters()>
<cfset myVote = res.getMemberVote(session.current_association)>
<cfset tally = res.getTally()>

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
                                        <dd class="mb-1">N/A</dd>
                                    </div>
                                </dl>       
                                <dl class="row mb-0">
                                    <div class="col-sm-4 text-sm-right">
                                        <dt>Repealed By:</dt>
                                    </div>
                                    <div class="col-sm-8 text-sm-left">
                                        <dd class="mb-1">N/A</dd>
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

                                                <div style="text-align: center;">
                                                    <h2 style="text-transform: capitalize;"><strong>#res.res_title#</strong></h2>
                                                    <h4><em>#site.SiteName# Draft Resolution #res.getResolutionNumber()#</em></h4>
                                                    <p>
                                                        Proposed by #sponsor.longName#<br/>
                                                        #dateFormat(res.res_create_date, "mmmm d, yyyy")#
                                                    </p>

                                                </div>

                                                #res.res_text#

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
                <cfif (myVote.code EQ -1) AND (res.inVotingWindow())>
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

                <div class="row mt-3 mb-5">
                    
                    <div class="col-lg-12">
                        <cfif res.inVotingWindow()>
                            <small class="text-center"><strong>Cannot propose amendments once voting has begun.</strong></small>
                        <cfelse>
                            <button class="btn btn-warning btn-lg btn-block">
                                <strong>Propose Amendment</strong>
                            </button>
                        </cfif>    
                        
                    </div>
                   
                </div>

                <h5>Sponsor Tools</h5>
                <hr/>

                <div class="row mt-3 mb-5">
                    <div class="col-lg-6">
                        <button class="btn btn-secondary btn-lg btn-block">
                            <strong>Table</strong> Resolution
                        </button>
                    </div>
                    <div class="col-lg-6">
                        <button class="btn btn-secondary btn-lg btn-block">                            
                            <strong>Withdraw</strong> Resolution
                        </button>
                    </div>
                </div>

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