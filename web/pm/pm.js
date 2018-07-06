Prefiniti.Projects = {

    current: null,

    view: function(projectId) {
        let url = "/pm/components/view_project.cfm?id=" + projectId;

        Prefiniti.Projects.current = projectId;

        Prefiniti.loadPage(url);
    },

    addTask: function() {
        let url = "/pm/components/add_task.cfm?id=" + Prefiniti.Projects.current;

        AjaxLoadPageToWindow(url, '');
    },

    itemCreated: function() {
        $("#generic-window").modal('hide');
        Prefiniti.reload();
    },

    setTaskComplete: function(taskId, complete) {
        let url = "/pm/components/set_task_complete.cfm";

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: taskId,
                complete: complete,
                project_id: Prefiniti.Projects.current
            },
            dataType: "json",
            encode: true,
            success: function(data) {
                if(data.ok) {
                    Prefiniti.Projects.itemCreated();
                }
                else {

                }
            }
        });
    },

    setWorkflow: function(stage) {
        let url = "/pm/components/set_workflow.cfm";

        $.ajax({
            url: url,
            method: "POST",
            data: {
                stage: stage,
                project_id: Prefiniti.Projects.current
            },
            dataType: "json",
            encode: true,
            success: function(data) {
                if(data.ok) {
                    Prefiniti.Projects.itemCreated();
                }
                else {
                    console.log(data);
                }
            }
        });
    },

    commentTask: function(taskId) {
        $('#task-comment-' + taskId).show();
    }

}