<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">

    <title>Prefiniti</title>

    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.0.13/css/all.css" integrity="sha384-DNOHZ68U8hZfKXOrtjWvjxusGo9WQnrNx2sqG0tfsghAvtVlRW3tvkXWZh58N9jp" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.css">
    <link rel="stylesheet" href="css/app.css">
    <!---<link href="css/prefiniti.css" rel="stylesheet" type="text/css">--->
    
    <cfinclude template="configRSS.cfm">
</head>
<body onload="Prefiniti.onLoad();">

    <cfif session.userid EQ "">
        <cflocation url="/default.cfm" addtoken="no">
    </cfif>

    <cfif #session.loggedin# EQ "yes">
        <cfinclude template="webwareConfigLoad.cfm">
    </cfif>

    <cfinclude template="fragments/navbar.cfm">


    <main role="main" class="container-fluid mt-0 mb-0 ml-0 mr-0">
        <div class="mt-0 mb-0 ml-0 mr-0" style="padding-top: 80px; padding-left: 0;">
            <div class="row">
                
                <div class="col-sm-12" id="tcTarget"></div>
            </div>
        </div>
    </main>


    <script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>   
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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script src="js/app.js"></script>
</body>    
</html>