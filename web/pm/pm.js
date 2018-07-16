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

        Prefiniti.dialog(url);
    },

    viewTask: function(taskId) {
        Prefiniti.loadPage("/pm/components/view_task.cfm?id=" + taskId + "&project_id=" + Prefiniti.Projects.current);
    },

    addTask: function() {
        let url = "/pm/components/add_task.cfm?id=" + Prefiniti.Projects.current;

        Prefiniti.dialog(url);
    },

    taskAdded: function() {
        $("#generic-window").modal('hide');

        if($("#create-another").is(":checked")){
            Prefiniti.Projects.addTask();
        }
        else {
            Prefiniti.reload();
        }
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

    logTime: function(taskId) {
        let url = "/pm/components/add_time_entry.cfm?project_id=" + Prefiniti.Projects.current + "&task_id=" + taskId;

        Prefiniti.dialog(url);
    },

    checkTimeOpen: function() {
        if($("#time-open").is(":checked")) {
            $("#time-end-container").hide();
        }
        else {
            $("#time-end-container").show();
        }
    },

    closeTimeEntry: function(timeEntryId) {
        let url = "/pm/components/close_time_entry_sub.cfm?id=" + timeEntryId;

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: timeEntryId,
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

    deleteTimeEntry: function(timeEntryId) {
        let url = "/pm/components/delete_time_entry_sub.cfm?id=" + timeEntryId;

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: timeEntryId,
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

    logTravel: function(taskId) {
        let url = "/pm/components/add_travel_entry.cfm?project_id=" + Prefiniti.Projects.current + "&task_id=" + taskId;

        Prefiniti.dialog(url);
    },

    deleteTravelEntry(travelId) {
        let url = "/pm/components/delete_travel_entry_sub.cfm";

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: travelId,
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

        Prefiniti.dialog(url);
    },

    updateSHPerms: function() {

        var perms = 0;

        $(".sh-perms").each(function(index) {
            var chk = $(this);

            if(chk.is(":checked")) {
                perms = perms | chk.val();
            }

        });

        $("#stakeholder-permissions").val(perms);

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

        Prefiniti.dialog(url);
    },

    deleteDeliverable: function(deliverableId) {
        let url = "/pm/components/delete_deliverable_sub.cfm?id=" + deliverableId;

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: deliverableId,
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

    chooseDeliverable: function(deliverableId, caption) {

        let url = "/pm/components/upload_deliverable.cfm?id=" + deliverableId + "&caption=" + caption + "&project_id=" + Prefiniti.Projects.current;

        Prefiniti.dialog(url);

    },

    addFiledDocument: function() {
        let url = "/pm/components/add_filed_document.cfm?id=" + Prefiniti.Projects.current;

        Prefiniti.dialog(url);
    },

    addLocation: function() {
        let url = "/pm/components/add_location.cfm?id=" + Prefiniti.Projects.current;

        Prefiniti.dialog(url);
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

    saveAsNewTemplate: function() {
        let url = "/pm/components/save_as_template.cfm?id=" + Prefiniti.Projects.current;

        Prefiniti.dialog(url);
    },

    updateTemplate: function() {
        let url = "/pm/components/update_template_sub.cfm";

        $.ajax({
            url: url,
            method: "POST",
            data: {
                project_id: Prefiniti.Projects.current
            },
            dataType: "json",
            encode: true,
            success: function(data) {
                if(data.ok) {
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

    internalProjectClicked: function() {
        if($("#internal-project").is(":checked")) {
            $("#client_assoc").hide();
        }
        else {
            $("#client_assoc").show();
        }
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

    setTaskPriority: function(taskId, priority) {
        let url = "/pm/components/set_task_priority.cfm";

        $.ajax({
            url: url,
            method: "POST",
            data: {
                id: taskId,
                priority: priority,
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

    assignTask: function(taskId) {
        let url = "/pm/components/reassign_task.cfm?id=" + taskId + "&project_id=" + Prefiniti.Projects.current;

        Prefiniti.dialog(url);
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