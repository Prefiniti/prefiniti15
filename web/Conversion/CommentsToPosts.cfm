<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Convert Comments to Posts</title>

    <cfquery name="c" datasource="webwarecl">
        SELECT * FROM comments
    </cfquery>
</head>
<body>
    <h1>Converting comments to posts...</h1>

    <cfoutput query="c">

        <ul>
            <li>id: #id#</li>
            <li>from_id: #from_id#</li>
            <li>to_id: #to_id#</li>
            <li>c_read: #c_read#</li>
            <li>body: #body#</li>
        </ul>

        <cfset p = new Prefiniti.SocialNetworking.Post()>

        <cfset p.post_class = "USER">
        <cfset p.parent_post_id = 0>
        <cfset p.author_id = from_id>
        <cfset p.recipient_id = to_id>
        <cfset p.post_read = c_read>
        <cfset p.body_copy = body>

        <cfset p.create()>

    </cfoutput>

</body>
</html>