<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <title>Table Check</title>
</head>
<body>

    <cfquery name="webwareclTables" datasource="webwarecl">
        SHOW TABLES
    </cfquery>

    <cfquery name="webwarecmsTables" datasource="webware_cms">
        SHOW TABLES
    </cfquery>

    <cfquery name="sitesTables" datasource="sites">
        SHOW TABLES
    </cfquery>

    <h1>Table Examiner</h1>
    <form method="POST" action="/DevTools/TableExaminer.cfm">
        <table border="1" width="100%" cellpadding="3">
            <tbody>
                <tr>
                    <td align="right"><strong>Table:</strong></td>
                    <td>
                        <label><input type="radio" name="database" value="webwarecl" checked> Main Database</label>
                        <select name="webwareTable">
                            <cfoutput query="webwareclTables">
                                <option value="#Tables_in_webwarecl#">#Tables_in_webwarecl#</option>
                            </cfoutput>
                        </select><br>

                        <label><input type="radio" name="database" value="sites"> Sites Database</label>
                        <select name="sitesTable">
                            <cfoutput query="sitesTables">
                                <option value="#Tables_in_sites#">#Tables_in_sites#</option>
                            </cfoutput>
                        </select><br>

                        <label><input type="radio" name="database" value="webware_cms"> CMS Database</label>
                        <select name="cmsTable">
                            <cfoutput query="webwarecmsTables">
                                <option value="#Tables_in_webware_cms#">#Tables_in_webware_cms#</option>
                            </cfoutput>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td align="right"><strong>CFC Name:</strong></td>
                    <td><input type="text" name="cfcName"></td>
                </tr>
                <tr>
                    <td colspan="2" align="right">
                        <input type="submit" name="submit" value="Submit">
                    </td>
                </tr>
            </tbody>
        </table>
    </form>

    <hr>
    <cfif isDefined("form.submit")>
        <cfswitch expression="#form.database#">
            <cfcase value="webwarecl">
                <cfquery name="describer" datasource="webwarecl">
                    DESCRIBE #form.webwareTable#
                </cfquery>
                <cfset table = form.webwareTable>
            </cfcase>
            <cfcase value="webware_cms">
                <cfquery name="describer" datasource="webware_cms">
                    DESCRIBE #form.cmsTable#
                </cfquery>
                <cfset table = form.cmsTable>
            </cfcase>
            <cfcase value="sites">
                <cfquery name="describer" datasource="sites">
                    DESCRIBE #form.sitesTable#
                </cfquery>
                <cfset table = form.sitesTable>
            </cfcase>
        </cfswitch>

        <h2><cfoutput>#form.database#.#table#</cfoutput></h2>

        <table border="1" width="100%">
            <thead>
                <tr>
                    <th>Field Name</th>
                    <th>Data Type</th>
                    <th>Accepts Null</th>
                    <th>Default Value</th>
                    <th>Key</th>
                    <th>Flags</th>
                </tr>
            </thead>
            <tbody>
                <cfoutput query="describer">
                    <tr>
                        <td>#Field#</td>
                        <td>#Type#</td>
                        <td>#Null#</td>
                        <td>#Default#</td>
                        <td>#Key#</td>
                        <td>#Extra#</td>
                    </tr>
                </cfoutput>
            </tbody>
        </table>
    <cfelse>
        <h2>Please select a database and table above.</h2>
    </cfif>

</body>
</html>