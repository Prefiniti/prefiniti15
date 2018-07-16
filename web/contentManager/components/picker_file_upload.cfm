<cfheader name="Content-Type" value="application/json">
<cfscript>    
    try {
        prefiniti = new Prefiniti.Base();

        fileTypeKey = "cms-picker-" & form["cms-picker-element-name"] & "-file-type";
        baseDir = form[fileTypeKey];

        basePath = prefiniti.cmsUserBasePath(session.user.id) & "/" & baseDir & "/";

        uploadResult = fileUpload(basePath, "file", "*", "makeunique");

        filename = uploadResult.serverfile;

        prefiniti.cmsCreateUserFile(session.user.id, filename, baseDir, filename);

        result = {
            success: true,
            message: "File uploaded successfully.",
            detail: "File " & filename & " uploaded to CMS.",
            fields: form
        };

    }
    catch(any ex) {
        result = {
            success: false,
            message: ex.message,
            detail: ex.detail,
            fields: form
        };
    }
    writeOutput(serializeJSON(result));

</cfscript>

