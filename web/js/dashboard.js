Prefiniti.extend("Dashboard", {

    load: function() {
        let url = "/businessnet/components/dashboard.cfm";

        Prefiniti.loadPage(url, Prefiniti.Dashboard.onLoad);
    },

    viewTask: function(projectId, taskId) {
        Prefiniti.Projects.current = projectId;
        Prefiniti.Projects.viewTask(taskId);
    },

    onLoad: function() {

        $.get("/pm/components/task_stats_week.cfm", function(data) {

            var data1 = data.created;
            var data2 = data.completed;

            $("#flot-dashboard-chart").length && $.plot($("#flot-dashboard-chart"), [
                data1, data2
                ],
                {
                    series: {
                        lines: {
                            show: true,
                            fill: true
                        },
                        splines: {
                            show: false,
                            tension: 0.4,
                            lineWidth: 1,
                            fill: 0.4
                        },
                        points: {
                            radius: 0,
                            show: true
                        },
                        shadowSize: 2
                    },
                    grid: {
                        hoverable: true,
                        clickable: true,
                        tickColor: "#d5d5d5",
                        borderWidth: 1,
                        color: '#d5d5d5'
                    },
                    colors: ["red", "blue"],
                    yaxis:{
                    },
                    xaxis: {
                        ticks: [
                            [1.0, data.dates[0]], 
                            [2.0, data.dates[1]],
                            [3.0, data.dates[2]],
                            [4.0, data.dates[3]],
                            [5.0, data.dates[4]],
                            [6.0, data.dates[5]],
                            [7.0, data.dates[6]],
                            [8.0, data.dates[7]],
                        ]
                    },
                    tooltip: false
                }
                );
        });

            var doughnutData = {
                labels: $("#overdue-projects").attr("data-labels").split(","),
                datasets: [{
                    data: $("#overdue-projects").attr("data-data").split(","),
                    backgroundColor: $("#overdue-projects").attr("data-colors").split(",")
                }]
            } ;            

            var doughnutOptions = {
                responsive: false,
                legend: {
                    display: false
                }
            };


            var ctx4 = document.getElementById("overdue-projects").getContext("2d");
            new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});

            var doughnutData = {
                labels: $("#delinquent-projects").attr("data-labels").split(","),
                datasets: [{
                    data: $("#delinquent-projects").attr("data-data").split(","),
                    backgroundColor: $("#delinquent-projects").attr("data-colors").split(",")
                }]
            } ;


            var doughnutOptions = {
                responsive: false,
                legend: {
                    display: false
                }
            };


            var ctx4 = document.getElementById("delinquent-projects").getContext("2d");
            new Chart(ctx4, {type: 'doughnut', data: doughnutData, options:doughnutOptions});


    } // onLoad
});