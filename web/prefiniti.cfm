<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Prefiniti 1.5.2 (BETA)</title>

    <link href="/css/bootstrap.min.css" rel="stylesheet">

    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <!---<link href="/font-awesome/css/font-awesome.css" rel="stylesheet">--->

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

    <!-- Custom and plugin javascript -->
    <script src="js/inspinia.js"></script>
    <script src="js/plugins/pace/pace.min.js"></script>

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

</body>

</html>
