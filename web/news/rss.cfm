<cfheader name="Content-Type" value="application/xml">
<cfprocessingdirective suppressWhitespace="true">
<cfsilent>
<cfset prefiniti = new Prefiniti.Base()>
<cfquery name="gNews" datasource="webwarecl">
	SELECT * FROM news_items WHERE site_id=#session.current_site_id# ORDER BY date DESC
</cfquery>
</cfsilent>
<cfoutput><?xml version="1.0"?>
<rss version="2.0">
	<channel>
		<title>#prefiniti.getSiteNameByID(session.current_site_id)# News</title>
		<link>http://www.webwarecl.com/news/rss.cfm</link>
		<description>#prefiniti.getSiteNameByID(session.current_site_id)# News</description>
		<language>en-us</language>
		<pubDate>#DateFormat(now(), "ddd, dd mmm yyyy")# #TimeFormat(now(), "HH:mm:ss")# MST</pubDate>
		<lastBuildDate>#DateFormat(now(), "ddd, dd mmm yyyy")# #TimeFormat(now(), "HH:mm:ss")# MST</lastBuildDate>
</cfoutput>
<cfoutput query="gNews">
<item>
	<title>#XmlFormat(headline)#</title>
	<description>#XmlFormat(body)#</description>
	<link>http://www.webwarecl.com/news/getArticle.cfm?id=#id#</link>
	<pubDate>#DateFormat(date, "ddd, dd mmm yyyy")# #TimeFormat(date, "HH:mm:ss")# MST</pubDate>
</item>
</cfoutput>
<cfoutput>
</channel>
</rss>
</cfoutput>
</cfprocessingdirective>