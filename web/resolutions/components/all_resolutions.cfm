<div class="wwaf-metadata">
    <wwaftitle>All Resolutions</wwaftitle>
    <wwafbreadcrumbs>Geodigraph Hub,Resolutions,View All</wwafbreadcrumbs>
</div>

<cfset site = new Prefiniti.Authentication.Site(session.current_site_id)>

<cfset resolutions = site.getResolutions()>

<div class="wrapper wrapper-content animated fadeInUp">
    <div class="ibox">
        <div class="ibox-title">
            <h5>All Resolutions</h5>
            <div class="ibox-tools">
                <a href="#" class="btn btn-primary btn-xs" onclick="Prefiniti.Resolutions.create();">Create Resolution</a>
            </div>
        </div>
        <div class="ibox-content">
            <div class="row m-b-sm m-t-sm">
                <div class="col-md-1">
                    <button type="button" id="loading-example-btn" class="btn btn-white btn-sm" onclick="Prefiniti.reloadl();"><i class="fa fa-redo"></i> Refresh</button>
                </div>
                <div class="col-md-11">
                    <div class="input-group">
                        <input type="text" placeholder="Search" class="form-control-sm form-control" id="search-resolutions" onkeyup="Prefiniti.Resolutions.search();">
                        <div class="input-group-append">
                            <button type="button" class="btn btn-sm btn-primary">Search</button> 
                        </div>
                    </div>
                </div>
            </div>
            <div class="project-list">
                <table class="table table-hover">
                    <tbody>
                        <cfoutput query="#resolutions#">   
                            <cfset res = new Prefiniti.Collaboration.Resolution(id)>   
                            <cfset sponsor = res.getUserByAssociationId(sponsor_assoc_id)>   
                            <cfset opensIn = res.daysUntilOpen()> 
                            <cfset repeals = res.repeals()>
                            <cfset repealedBy = res.repealedBy()> 
                            <cfset tally = res.getTally()>                 
                            <tr class="resolution-row" data-resolution-title="#res.res_title#">
                                <td class="project-status">#res.getStatus()#</td>
                                <td class="project-title">
                                    <a href="##" onclick="Prefiniti.Resolutions.view(#id#);">#res_title#</a>
                                        <br/>
                                        <small>Created #dateFormat(res.res_create_date, "m.dd.yyyy")#</small>
                                </td>
                                <td class="project-completion">
                                    <p>
                                        <cfif res.inVotingWindow()>
                                            <strong>Voting Open</strong>
                                        <cfelse>
                                            <cfif opensIn GT 0>
                                                Voting opens in <strong>#opensIn# days.</strong>
                                            <cfelse>
                                                Voting closed <strong>#abs(opensIn)# days ago.</strong>
                                            </cfif>
                                        </cfif>
                                    </p>
                                    <cfif repeals.result>                                        
                                        <strong>Repeals <a href="##" onclick="Prefiniti.Resolutions.view(#repeals.resolution.id#)">#repeals.resolution.res_title#</a></strong>
                                    </cfif>
                                    <cfif repealedBy.result>
                                        <strong>Repealed by <a href="##" onclick="Prefiniti.Resolutions.view(#repealedBy.resolution.id#)">#repealedBy.resolution.res_title#</a></strong>
                                    </cfif>

                                </td>
                                <td class="project-people">
                                    <a href="##" data-toggle="tooltip" data-placement="bottom" onclick="Prefiniti.Social.loadProfile(#sponsor.id#);" title="#sponsor.longName# (#sponsor.longName#)"><img alt="image" class="rounded-circle mr-3" src="#sponsor.getPicture()#"> #sponsor.longName# (Sponsor)</a>

                                </td>
                                <td class="project-actions">
                                    <a href="##" class="btn btn-white btn-sm" onclick="Prefiniti.Resolutions.view(#id#);"><i class="fa fa-folder"></i> View </a>
                                    <a href="/resolutions/components/resolution_view_full.cfm?id=#id#" class="btn btn-white btn-sm" target="_blank"><i class="fa fa-download"></i> View Document</a>
                                </td>
                            </tr>
                        </cfoutput>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>