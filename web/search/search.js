let Search = {
    
    currentMode: "Projects",

    showProjects: function() {
        $("#timesheet-locator").hide();
        $("#project-locator").show();

        $("#current-search-type").html("Projects");

        Search.currentMode = "Projects";
    },

    showTimesheets: function() {
        $("#project-locator").hide();
        $("#timesheet-locator").show();

        $("#current-search-type").html("Time Entry");

        Search.currentMode = "Time Entry";
    }


};