<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Prefiniti 1.5.2 (BETA)</title>

    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <!---<link href="/font-awesome/css/font-awesome.css" rel="stylesheet">--->
    <link href="css/plugins/dataTables/datatables.min.css" rel="stylesheet">
    <link href="css/plugins/steps/jquery.steps.css" rel="stylesheet">

    <!-- Toastr style -->
    <link href="css/plugins/toastr/toastr.min.css" rel="stylesheet">
    <link href="css/plugins/iCheck/custom.css" rel="stylesheet">
    <link href="css/plugins/summernote/summernote-bs4.css" rel="stylesheet">
    <link href="css/plugins/bootstrap-tagsinput/bootstrap-tagsinput.css" rel="stylesheet">

    <link href="/css/animate.css" rel="stylesheet">
    <link href="/css/style.css" rel="stylesheet">
    <link rel="stylesheet" href="/css/app.css">
    <cfinclude template="configRSS.cfm">
</head>

<body class="" onload="Prefiniti.onLoad();">

    <cfif session.userid EQ "">
        <cflocation url="/default.cfm" addtoken="no">
    </cfif>

    <cfif #session.loggedin# EQ "yes">
        <cfinclude template="webwareConfigLoad.cfm">
    </cfif>

    <div id="wrapper">

        <cfinclude template="fragments/navbar_side.cfm">


        <div id="page-wrapper" class="gray-bg">

            <cfinclude template="fragments/navbar_top.cfm">

            <cfinclude template="fragments/page_heading.cfm">

            <div class="wrapper wrapper-content" id="tcTarget">
                
            </div>
            <div class="footer">
                <div class="float-right">
                    
                </div>
                <div>
                    Copyright &copy; 2018 Coherent Logic Development LLC 
                </div>
            </div>

        </div>
    </div>

    <!-- Mainly scripts -->
    <script src="js/jquery-3.1.1.min.js"></script>
    <script src="js/popper.min.js"></script>
    <script src="js/bootstrap.js"></script>
    <script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>
    <script src="js/plugins/slimscroll/jquery.slimscroll.min.js"></script>

    <!-- Flot -->
    <script src="js/plugins/flot/jquery.flot.js"></script>
    <script src="js/plugins/flot/jquery.flot.tooltip.min.js"></script>
    <script src="js/plugins/flot/jquery.flot.spline.js"></script>
    <script src="js/plugins/flot/jquery.flot.resize.js"></script>
    <script src="js/plugins/flot/jquery.flot.pie.js"></script>
    <script src="js/plugins/flot/jquery.flot.symbol.js"></script>
    <script src="js/plugins/flot/jquery.flot.time.js"></script>

    <!-- Peity -->
    <script src="js/plugins/peity/jquery.peity.min.js"></script>
    <script src="js/demo/peity-demo.js"></script>

    <!-- Custom and plugin javascript -->
    <script src="js/inspinia.js"></script>
    <script src="js/plugins/pace/pace.min.js"></script>

    <!-- GITTER -->
    <script src="js/plugins/gritter/jquery.gritter.min.js"></script>

    <!-- Sparkline -->
    <script src="js/plugins/sparkline/jquery.sparkline.min.js"></script>

    <!-- Sparkline demo data  -->
    <script src="js/demo/sparkline-demo.js"></script>

    <!-- ChartJS-->
    <script src="js/plugins/chartJs/Chart.min.js"></script>

    <!-- iCheck -->
    <script src="js/plugins/iCheck/icheck.min.js"></script>

    <!-- Jvectormap -->
    <script src="js/plugins/jvectormap/jquery-jvectormap-2.0.2.min.js"></script>
    <script src="js/plugins/jvectormap/jquery-jvectormap-world-mill-en.js"></script>

    <!-- EayPIE -->
    <script src="js/plugins/easypiechart/jquery.easypiechart.js"></script>

    <!-- Sparkline -->
    <script src="js/plugins/sparkline/jquery.sparkline.min.js"></script>

    <!-- Sparkline demo data  -->
    <script src="js/demo/sparkline-demo.js"></script>

    <!-- SUMMERNOTE -->
    <script src="js/plugins/summernote/summernote-bs4.js"></script>

    <!-- DataTables -->
    <script src="js/plugins/dataTables/datatables.min.js"></script>
    <script src="js/plugins/dataTables/dataTables.bootstrap4.min.js"></script>

    <!-- Toastr -->
    <script src="js/plugins/toastr/toastr.min.js"></script>
    <script src="js/plugins/bootstrap-tagsinput/bootstrap-tagsinput.js"></script>
    
    <!-- Steps -->
    <script src="js/plugins/steps/jquery.steps.min.js"></script>

    <!-- Prefiniti javascript -->
    <script src="/framework/framework.js"></script>
    <script src="/search/search.js"></script>
    <script src="/tc/timecard.js"></script>
    <script src="/calendar2.js"></script>
    <script src="/workFlow/components/projectStatus.js"></script>
    <script src="/workFlow/projects.js"></script>
    <script src="/MyCL/components/collapse.js"></script>
    <script src="/contentManager/contentManager.js"></script>
    <script src="/contentManager/swfupload.js"></script>
    <script src="/contentManager/handlers.js"></script>     
    <script src="/mapping/mapping.js"></script>
    <script src="/legalSection/legalsection.js"></script>
    <script src="/news/news.js"></script>
    <script src="/authentication/authentication.js"></script>
    <script src="/globals.js"></script>
    <script src="/mail/mail.js"></script>
    <script src="/scheduling/scheduling.js"></script>
    <script src="/help/help.js"></script>
    <script src="/soundmanager.js"></script>
    <script src="/netsearch/netsearch.js"></script>
    <script src="/chat/chat.js"></script>
    <script src="/socialnet/socialnet.js"></script>
    <script src="/datetimepicker.js"></script>
    <script src="/controls/date_picker.js"></script>
    <script src="/controls/record_scroller.js"></script>
    <script src="/notifications/notifications.js"></script>

    <script src="js/app.js"></script>
    <script src="js/social.js"></script>
    <script src="pm/pm.js"></script>
    <script src="js/user_picker.js"></script>
    <script src="js/dashboard.js"></script>

    <cfinclude template="cms_add_file_assoc_wrapper.cfm">
    <cfinclude template="cms_minibrowser_wrapper.cfm">
    <cfinclude template="windowWrapper.cfm">


</body>

</html>
