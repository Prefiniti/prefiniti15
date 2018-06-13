function loadHelp(topic, text, image)
{
	var url;
	url = "/help/components/viewHelp.cfm?topic=" + escape(topic);
	url += "&text=" + escape(text);
	url += "&image=" + escape(image);
	
	showDiv('helpWrapper');
	
	AjaxLoadPageToDiv('helpWrapper', url);
	
}