
<cfscript>

if(!isDefined("attributes.all_users")) {
    people = [];

    prefiniti = new Prefiniti.Base();

    employees = prefiniti.wwGetEmployeesBySite(session.current_site_id);
    clients = prefiniti.wwGetCustomersBySite(session.current_site_id);

    for(employee in employees) {
        tmp = {
            type: "Employee",
            assoc_id: employee.id,
            user: new Prefiniti.Authentication.UserAccount({id: employee.user_id}, false)
        };

        people.append(tmp);
    }

    for(p_client in clients) {
        tmp = {
            type: "Client",
            assoc_id: p_client.id,
            user: new Prefiniti.Authentication.UserAccount({id: p_client.user_id}, false)
        };

        people.append(tmp);
    }
}
else {
    people = [];

    prefiniti = new Prefiniti.Base();

    user_ids = prefiniti.getUserIDs();

    for(id in user_ids) {
        tmp = {
            type: "User",
            assoc_id: id,
            user: new Prefiniti.Authentication.UserAccount({id: id}, false)
        };

        people.append(tmp);
    }
}

</cfscript>

<cfoutput>
    <input type="hidden" name="#attributes.element_name#" id="user-picker-#attributes.element_name#-selection" value="">

    <div style="height: #attributes.height#px; overflow-y: scroll;" id="user-picker-#attributes.element_name#-choices">
        <table class="table table-striped table-hover">
            <tbody>
                <cfloop array="#people#" item="person">
                    <tr>
                        <td class="client-avatar"><img alt="image" src="#person.user.getPicture()#"></td>
                        <td><a class="client-link" href="##" onclick="Prefiniti.Social.loadProfile(#person.user.id#)">#person.user.longName#</a></td>
                        <td class="client-status">
                            <span class="label label-primary">#person.type#</span>          
                            <cfif person.user.id EQ session.user.id>
                                <span class="label label-info">Me</span>
                            </cfif>              
                        </td>
                        <td class="text-right">
                            <button type="button" class="btn btn-primary btn-sm" onclick="Prefiniti.UserPicker.choose('#attributes.element_name#', '#person.user.longName#', #person.assoc_id#);"><i class="fa fa-check"></i> Select</button>                        
                        </td>
                    </tr>                                                            
                </cfloop> 
            </tbody>
        </table>
    </div>
    
    <div class="row" id="user-picker-#attributes.element_name#-display-container" style="display: none;">
        <div class="col-lg-12">
            <div class="input-group">
                <input type="text" class="form-control" id="user-picker-#attributes.element_name#-display" readonly>
                <div class="input-group-append">
                    <button type="button" class="btn btn-primary" onclick="Prefiniti.UserPicker.undo('#attributes.element_name#');"><i class="fa fa-redo"></i> Change Selection</button>
                </div>
            </div>
        </div>
    </div>

</cfoutput>