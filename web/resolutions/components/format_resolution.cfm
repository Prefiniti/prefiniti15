<cfset res = new Prefiniti.Collaboration.Resolution(attributes.id)>
<cfset sponsor = res.getUserByAssociationID(res.sponsor_assoc_id)>
<cfset site = new Prefiniti.Authentication.Site(res.site_id)>
<cfset voters = res.getEligibleVoters()>
<cfset myVote = res.getMemberVote(session.current_association)>
<cfset tally = res.getTally()>
<cfset repeals = res.repeals()>
<cfset repealedBy = res.repealedBy()>
<cfset resClass ="Draft Resolution">

<cfif tally.carried>
    <cfset resClass = "Resolution">
</cfif>

<cfoutput>
    <div class="resolution-print">
        <div class="resolution-header-block">
            <h1 class="resolution-heading"><strong>#res.res_title#</strong></h1>
            <h4><em>#site.SiteName# #resClass# #res.getResolutionNumber()#</em></h4>
            <p>
                Proposed by #sponsor.longName#<br/>
                #dateFormat(res.res_create_date, "mmmm d, yyyy")#
            </p>
            <cfif tally.carried>
                <p>
                    Adopted #dateFormat(res.res_voting_close, "mmmm d, yyyy")#
                </p>
            </cfif>
            <cfif repeals.result>
                <p>
                    <em>Repeals #site.SiteName# #resClass# #repeals.resolution.getResolutionNumber()#: #repeals.resolution.res_title#</em>
                </p>
            </cfif>
        </div>
        <hr style="width: 470px;"/>
        #res.res_text#
        <cfif tally.carried>
            <hr style="width: 470px;"/>
            <div style="text-align: center;">
                <div class="row">
                    <div class="col-md-12 mb-5">
                        <p style="width: 55%; font-weight: bold; margin: 0 auto;"><em>This Resolution, having been duly debated, voted upon, and signed by the following members of #site.SiteName# of their own free will, agency, and accord, being convened in quorum, is hereby adopted.</em></p>
                    </div>
                    <cfloop array="#voters#" item="voter">                        
                        <cfset vote = res.getMemberVote(voter.association.id)>
                        <cfif vote.code EQ 1>
                            <div class="col-md-4">
                                <h3>#voter.user.longName#<br/><em style="font-size: xx-small;">#dateFormat(vote.date, "mmmm d, yyyy")#</em></h3>
                            </div>
                        </cfif>
                    </cfloop>
                </div>
            </div>
        </cfif>
    </div>
</cfoutput>