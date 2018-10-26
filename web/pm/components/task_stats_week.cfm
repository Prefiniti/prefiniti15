<cfheader name="Content-Type" value="application/json">
<cfsilent>
    <cfset prefiniti = new Prefiniti.Base()>

    <cfset dow = prefiniti.daysOfWeek()>

    <cfset res = {
        created: [],
        completed: [],
        dates: duplicate(dow)
    }>

    <cfloop array="#res.dates#" index="i" item="itm">
        <cfset res.dates[i] = dateFormat(res.dates[i], "dddd")>
    </cfloop>


    <cfloop array="#dow#" item="dt" index="i">
        <cfset realDt = createODBCDate(dt)>

        <cfset res.created.append([i, session.site.tasksCreatedByDay(realDt)])>
        <cfset res.completed.append([i, session.site.tasksCompletedByDay(realDt)])>
    </cfloop>

   
</cfsilent>
<cfoutput>#serializeJSON(res)#</cfoutput>

