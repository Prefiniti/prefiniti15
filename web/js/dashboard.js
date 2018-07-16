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

        var data1 = [
        [0,4],[1,8],[2,5],[3,10],[4,4],[5,16],[6,5],[7,11],[8,6],[9,11],[10,30],[11,10],[12,13],[13,4],[14,3],[15,3],[16,6]
        ];
        var data2 = [
        [0,1],[1,0],[2,2],[3,0],[4,1],[5,3],[6,1],[7,5],[8,2],[9,3],[10,2],[11,1],[12,0],[13,2],[14,8],[15,0],[16,0]
        ];
        $("#flot-dashboard-chart").length && $.plot($("#flot-dashboard-chart"), [
            data1, data2
            ],
            {
                series: {
                    lines: {
                        show: false,
                        fill: true
                    },
                    splines: {
                        show: true,
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
                colors: ["#1ab394", "#1C84C6"],
                xaxis:{
                },
                yaxis: {
                    ticks: 4
                },
                tooltip: false
            }
            );

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