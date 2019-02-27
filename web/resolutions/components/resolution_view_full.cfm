<!DOCTYPE html>
<html>

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>View Resolution</title>

    <!-- Google Fonts (for resolution text) -->
    <link href="https://fonts.googleapis.com/css?family=EB+Garamond" rel="stylesheet">
    
    <link href="/css/bootstrap.min.css" rel="stylesheet">
    <link href="/font-awesome/css/font-awesome.css" rel="stylesheet">

    <!-- Toastr style -->
    <link href="/css/plugins/toastr/toastr.min.css" rel="stylesheet">

    <link href="/css/animate.css" rel="stylesheet">
    <!---<link href="/css/style.css" rel="stylesheet">--->
    <link href="/css/app.css" rel="stylesheet">
    <!-- Mainly scripts -->
    <script src="/js/jquery-3.1.1.min.js"></script>
    <script src="/js/popper.min.js"></script>
    <script src="/js/bootstrap.js"></script>
    <script src="/js/app.js"></script>
    <script src="/js/showdown.min.js"></script>

</head>

<body onload="Prefiniti.renderMarkdown();">
    <div class="wrapper">
        <cfmodule template="/resolutions/components/format_resolution.cfm" id="#url.id#">
    </div>
</body>
                            