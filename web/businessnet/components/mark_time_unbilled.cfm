<cfheader name="Content-Type" value="application/json">
<cfscript>
    prefiniti = new Prefiniti.Base();
    result = {};

    try {
        prefiniti.markTimeUnbilled(url.id);

        result = {
            success: true
        };
    }
    catch(any ex) {
        result = {
            success: false
        };
    }

    writeOutput(serializeJSON(result));
</cfscript>
