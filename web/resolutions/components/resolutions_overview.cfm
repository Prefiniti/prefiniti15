<cfset site = new Prefiniti.Authentication.Site(session.current_site_id)>

<cfset resolutions = site.getResolutions()>

<table class="table table-striped">
    <thead>
        <tr>            
            <th>Title</th>
            <th>Created</th>
            <th>Voting Window</th>
            
            <th>Yea</th>
            <th>Nay</th>
            <th>Abs</th>
            <th>Status</th>
            <th><i class="fa fa-wrench"></i></th>
        </tr>
    </thead>
    <tbody>
        <cfoutput query="resolutions">
            <cfset res = new Prefiniti.Collaboration.Resolution(id)>
            <cfset tally = res.getTally()>
            <tr>
                <td>
                    <a href="##" onclick="Prefiniti.Resolutions.view(#id#);">#res_title#</a>                        
                </td>                            
                <td>
                    #dateFormat(res_create_date, "m.dd.yyyy")#
                </td>
                <td>
                    #dateFormat(res_voting_open, "m.dd.yyyy")#-#dateFormat(res_voting_close, "m.dd.yyyy")#
                </td>
                <td>#tally.yea#</td>
                <td>#tally.nay#</td>
                <td>#tally.abstain#</td>
                <td>
                    #res.getStatus()#
                </td>
                <td>
                    <a href="##" class="btn btn-white btn-sm" onclick="Prefiniti.Resolutions.view(#id#);"><i class="fa fa-folder"></i> View </a>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</table>
