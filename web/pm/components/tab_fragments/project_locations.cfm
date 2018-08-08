<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>
<cfset locations = project.getLocations()>

<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Location</th>
            <th>Address</th>
            <th>City</th>
            <th>State</th>
            <th>ZIP</th>
            <th>Subdivision</th>
            <th>Lot</th>
            <th>Block</th>
            <th>PLSS</th>
            <th>Geographic</th>
            <th><i class="fa fa-cogs"></i></th>
        </tr>
    </thead>
    <tbody>
        <cfoutput query="locations">
            <tr>
                <td>#location_name#</td>
                <td>#address#</td>
                <td>#city#</td>
                <td>#state#</td>
                <td>#zip#</td>
                <td>#subdivision#</td>
                <td>#lot#</td>
                <td>#block#</td>
                <td>
                    <cfif trs_township NEQ "" AND trs_section NEQ "" AND trs_range NEQ "">
                        T#trs_township#S#trs_section#R#trs_range#; #trs_meridian# Meridian
                    <cfelse>
                        Not Supplied
                    </cfif>
                </td>
                <td>
                    <cfif latitude NEQ "" AND longitude NEQ "">
                        Lat: #latitude#, Lon: #longitude#
                        <cfif elevation NEQ "">
                        , Elev: #elevation#
                        </cfif>
                    <cfelse>
                        Not Supplied
                    </cfif>
                </td>

                <td>
                    <cfif project.checkPermission(session.user.id, "LOC_DELETE")>
                        <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                        <div class="dropdown-menu">
                            <button class="dropdown-item" type="button" onclick="Prefiniti.Projects.deleteLocation(#id#);">Delete Location</button>
                        </div>  
                    </cfif>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</table>