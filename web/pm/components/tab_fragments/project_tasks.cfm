<cfset project = new Prefiniti.ProjectManagement.Project(url.id)>
<cfset tasks = project.getTasks()>
<cfset todoTasks = project.getTasksByCompletion(0)>
<cfset inProgressTasks = project.getTasksByCompletion(1)>
<cfset doneTasks = project.getTasksByCompletion(2)>

<div class="row">
    <div class="col-sm-4">
        <div class="ibox">
            <div class="ibox-content">
                <h3>To-Do</h3>

                <ul class="sortable-list connectList agile-list" id="todo">
                    <cfoutput query="todoTasks">
                        <cfmodule template="/pm/components/agile_view_task.cfm" id="#id#" project_id="#url.id#">
                    </cfoutput>
                </ul>

            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="ibox">
            <div class="ibox-content">
                <h3>In Progress</h3>

                <ul class="sortable-list connectList agile-list" id="in-progress">
                    <cfoutput query="inProgressTasks">
                        <cfmodule template="/pm/components/agile_view_task.cfm" id="#id#" project_id="#url.id#">
                    </cfoutput>
                </ul>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div class="ibox">
            <div class="ibox-content">
                <h3>Done</h3>

                <ul class="sortable-list connectList agile-list" id="done">
                    <cfoutput query="doneTasks">
                        <cfmodule template="/pm/components/agile_view_task.cfm" id="#id#" project_id="#url.id#">
                    </cfoutput>
                </ul>
            </div>
        </div>
    </div>

</div>