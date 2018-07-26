<cfset prefiniti = new Prefiniti.Base()>
<cfset taskCodes = prefiniti.getTaskCodes()>

<button type="button" class="btn btn-white float-right" onclick="Prefiniti.Business.addTaskCode();"><i class="fa fa-list-alt"></i> Add Service</button>
<table class="table table-striped table-hover">
    <thead>
        <tr>
            <th>Service</th>
            <th>Accounting Code</th>
            <th>Rate</th>
            <th>Billable</th>
            <th><i class="fa fa-cogs"></i></th>
        </tr>
    </thead>
    <tbody>
        <cfoutput query="taskCodes">
            <tr>                
                <td>#item#</td>
                <td>#task_id#</td>
                <td>#LSCurrencyFormat(rate, "local")#/#charge_type#</td>
                <td>
                    <input type="checkbox" <cfif billable EQ 1>checked</cfif> disabled>
                </td>
                <td class="text-right">
                    <button type="button" class="btn btn-primary btn-sm dropdown-toggle" data-toggle="dropdown"><i class="fa fa-cogs"></i></button>
                    <div class="dropdown-menu">   
                        <button class="dropdown-item" type="button" onclick="Prefiniti.Business.editTaskCode(#id#);">Edit Service...</button>  
                        <div class="dropdown-divider"></div>
                        <button class="dropdown-item" type="button" onclick="Prefiniti.Business.deleteTaskCode(#id#);"><span class="text-danger">Delete Service</span></button>
                    </div>
                </td>
            </tr>
        </cfoutput>
    </tbody>
</table>