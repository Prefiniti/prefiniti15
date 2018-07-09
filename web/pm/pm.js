Prefiniti.extend("Projects", {

    current: null,

    view: function(projectId) {
        let url = "/pm/components/view_project.cfm?id=" + projectId;

        Prefiniti.Projects.current = projectId;

        Prefiniti.loadPage(url);
    },

    create: function(clientAssoc) {
        let url = "/pm/components/create_project.cfm";
        
        if(clientAssoc) {
            url += "?client_assoc_id=" + clientAssoc;
        }

        AjaxLoadPageToWindow(url, '');
    },

    addTask: function() {
        let url = "/pm/components/add_task.cfm?id=" + Prefiniti.Projects.current;

        AjaxLoadPageToWindow(url, '');
    },

    deleteTask: function(taskId) {

        let url = "/pm/components/delete_task_sub.cfm?id=" + taskId;

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: taskId,
                project_id: Prefiniti.Projects.current
            },
            dataType: "json",
            encode: true,
            success: function(data) {
                if(data.ok) {
                    Prefiniti.Projects.itemCreated();
                }
            }
        });

    },

    addStakeholder: function() {
        let url = "/pm/components/add_stakeholder.cfm?id=" + Prefiniti.Projects.current;

        AjaxLoadPageToWindow(url, '');
    },

    deleteStakeholder: function(stakeholderId) {

        let url = "/pm/components/delete_stakeholder_sub.cfm?id=" + stakeholderId;

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: stakeholderId,
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

    addDeliverable: function() {
        let url = "/pm/components/add_deliverable.cfm?id=" + Prefiniti.Projects.current;

        AjaxLoadPageToWindow(url, '');
    },

    addFiledDocument: function() {
        let url = "/pm/components/add_filed_document.cfm?id=" + Prefiniti.Projects.current;

        AjaxLoadPageToWindow(url, '');
    },

    addLocation: function() {
        let url = "/pm/components/add_location.cfm?id=" + Prefiniti.Projects.current;

        AjaxLoadPageToWindow(url, '');
    },

    deleteLocation: function(locationId) {

        let url = "/pm/components/delete_location_sub.cfm?id=" + locationId;

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: locationId,
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

});