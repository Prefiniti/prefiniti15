<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>

<div class="modal-header">
    <i class="fa fa-user modal-icon"></i>
    <h4 class="modal-title">Add Stakeholder</h4>
    <cfoutput><small class="font-bold">This will add a stakeholder to project <em>#project.project_name#</em>.</small></cfoutput>
</div>
<div class="modal-body">
    <form id="form-add-stakeholder" method="POST" action="/pm/components/add_stakeholder_sub.cfm"> 
        <cfoutput><input type="hidden" name="project_id" value="#url.id#"></cfoutput>
        <div class="form-group row">
            <label class="col-lg-2 col-form-label">Role:</label>
            <div class="col-lg-10">
                <select name="stakeholder_type" class="custom-select">
                    <option value="Accountant">Accountant</option>
                    <option value="Account Manager">Account Manager</option>                    
                    <option value="Architect">Architect</option>
                    <option value="Bookkeeper">Bookkeeper</option>
                    <option value="Client">Client</option>
                    <option value="Committer">Committer</option>
                    <option value="Comptroller">Comptroller</option>
                    <option value="Crew Chief">Crew Chief</option>
                    <option value="Crew Member" selected>Crew Member</option>
                    <option value="Customer Service Representative">Customer Service Representative</option>
                    <option value="Developer">Developer</option>
                    <option value="Designer">Designer</option>
                    <option value="DevOps Engineer">DevOps Engineer</option>
                    <option value="Drafter">Drafter</option>
                    <option value="Engineer">Engineer</option>
                    <option value="Escrow Officer">Escrow Officer</option>
                    <option value="Executive">Executive</option>
                    <option value="Field Service Agent">Field Service Agent</option>
                    <option value="Government">Government</option>
                    <option value="Inspector (Municipal/Utility/Building)">Inspector (Municipal/Utility/Building)</option>
                    <option value="Legal">Legal</option>
                    <option value="Loan Officer">Loan Officer</option>
                    <option value="Medical">Medical</option>
                    <option value="Network Administrator">Network Administrator</option>
                    <option value="Project Manager">Project Manager</option>                    
                    <option value="Repository Manager">Repository Manager</option>
                    <option value="Quality Assurance">Quality Assurance</option>
                    <option value="Sales Representative">Sales Representative</option>
                    <option value="Subcontractor">Subcontractor</option>
                    <option value="Surveyor">Surveyor</option>
                    <option value="Technical Support Representative">Technical Support Representative</option>
                    <option value="Technician (General)">Technician (General)</option>
                    <option value="Technician (Photogrammetry)">Technician (Photogrammetry)</option>                            
                    <option value="Vendor Representative">Vendor Representative</option>                    
                </select>
            </div>
        </div>
        <div class="form-group row">                                       
            <label class="col-lg-2 col-form-label">Person:</label>
            <div class="col-lg-10">
                <cfmodule template="/businessnet/components/user_picker.cfm" height="200" element_name="assoc_id">
            </div>
        </div>                                        
    </form>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-white" data-dismiss="modal">Cancel</button>
    <button type="button" class="btn btn-primary" name="submit" onclick="Prefiniti.submitForm('form-add-stakeholder', Prefiniti.Projects.itemCreated);">Add Stakeholder</button>
</div>