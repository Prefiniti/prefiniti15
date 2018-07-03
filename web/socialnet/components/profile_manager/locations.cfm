<cfset prefiniti = new Prefiniti.Base()>
<cfset u = prefiniti.getUserLocations(attributes.user_id)>

<button type="button" class="btn btn-primary" onclick="$('#newloc-row').show(); $('#description-new').focus();"><i class="fa fa-map-marker-alt"></i> Add Location</button>
<table class="table table-striped table-bordered table-hover" cellspacing="0">
    <thead>
        <tr>
            <th>Name</th>
            <th>Street</th>
            <th>City</th>
            <th>State</th>
            <th>ZIP</th>            
            <th>Billing</th>
            <th>Mailing</th>
            <th>Public</th>
            <th><i class="fa fa-wrench"></i></th>            
        </tr>
    </thead>
    <tbody>
        <cfoutput query="u">
            
            <form name="#id#_form" id="#id#_form" method="POST" action="/socialnet/components/profile_manager/location_edit_sub.cfm">
                <tr id="location-row-#id#">
                    <input type="hidden" name="location_id" id="location_id" value="#id#">
                    <td>
                        <input type="text" id="description" name="description" value="#description#">
                    </td>
                    <td>
                        <input type="text" id="address" name="address" value="#address#">
                    </td>
                    <td>
                        <input type="text" id="city" name="city" value="#city#">
                    </td>
                    <td>
                        <input type="text" id="state" name="state" value="#state#">
                    </td>
                    <td>
                        <input type="text" id="zip" name="zip" value="#zip#">
                    </td>
                    <td>
                        <input type="checkbox" name="billing" id="billing" value="1" <cfif billing EQ 1>checked</cfif>>
                    </td>
                    <td>
                        <input type="checkbox" name="mailing" id="mailing" value="1" <cfif #mailing# EQ 1>checked</cfif>>
                    </td>
                    <td>
                        <input type="checkbox" name="public_location" id="public_location" <cfif #public_location# EQ 1>checked</cfif>>
                    </td>
                    <td>
                        <button type="button" class="btn btn-sm btn-success" name="submit" onclick="Prefiniti.submitForm('#id#_form');"><i class="fa fa-save"></i></button>
                        <button type="button" class="btn btn-sm btn-danger" name="delete" onclick="Prefiniti.deleteLocation(#id#);"><i class="fa fa-trash-alt"></i></button>
                    </td>
                </tr> 
            </form>
                   
        </cfoutput>
        <tr id="newloc-row" style="display:none;">
            <form name="newloc-form" id="newloc-form" method="POST" action="/socialnet/components/profile_manager/location_add_sub.cfm">
                <td>
                    <input placeholder="Location Name" type="text" id="description-new" name="description">
                </td>
                <td>
                    <input placeholder="Street Address" type="text" id="address" name="address">
                </td>
                <td>
                    <input placeholder="City" type="text" id="city" name="city">
                </td>
                <td>
                    <input placeholder="State" type="text" id="state" name="state">
                </td>
                <td>
                    <input placeholder="ZIP" type="text" id="zip" name="zip">
                </td>
                <td>
                    <input type="checkbox" name="billing" id="billing" value="1">
                </td>
                <td>
                    <input type="checkbox" name="mailing" id="mailing" value="1">
                </td>
                <td>
                    <input type="checkbox" name="public_location" id="public_location">
                </td>
                <td>
                    <button type="button" class="btn btn-sm btn-success" name="submit" onclick="Prefiniti.submitForm('newloc-form');"><i class="fa fa-save"></i></button>
                </td>
            </form>
        </tr>
    </tbody>
</table>
