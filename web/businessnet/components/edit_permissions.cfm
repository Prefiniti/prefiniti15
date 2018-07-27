<cfset prefiniti = new Prefiniti.Base()>
<cfset user = prefiniti.getUserByAssociationID(url.id)>

<cfmodule template="/authentication/components/requirePerm.cfm" perm_key="AS_EDIT">

<cfquery name="getAssoc" datasource="sites">
    SELECT * FROM site_associations WHERE id=#url.id#
</cfquery>

<cfquery name="getAssocPerms" datasource="sites">
    SELECT * FROM permission_entries WHERE assoc_id=#url.id#
</cfquery>

<cfquery name="getAllPerms" datasource="sites">
    SELECT * FROM permissions ORDER BY perm_key
</cfquery>    

<h4>
    <cfif getAssoc.assoc_type EQ 0>
        <cfset header = "Client Permissions">
    <cfelse>
        <cfset header = "Employee Permissions">
    </cfif>
</h4>

<div class="modal-header">
    <i class="fa fa-shield-alt modal-icon"></i>
    <h4 class="modal-title"><cfoutput>#header#</cfoutput></h4>
    <cfoutput>
        <small class="font-bold">You are editing #lcase(header)# for #user.longName#.</small>
    </cfoutput>
</div>
<div class="modal-body">
    <cfoutput>
        <div class="row m-b-lg">
            <div class="col-lg-12" style="height: 200px; overflow-y: scroll;">
                <table class="table table-striped">
                    <tbody>
                        <cfoutput query="getAllPerms">                  
                            <tr>
                                <td>#name#</td>
                                <td align="right">
                                    <cfmodule template="/businessnet/components/permissions_checkbox.cfm" assoc_id="#getAssoc.id#" perm_id="#id#">                    
                                </td>
                            </tr>                        
                        </cfoutput>                
                    </tbody>
                </table>                
            </div>
        </div>
    </cfoutput>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Close</button>
</div>
            