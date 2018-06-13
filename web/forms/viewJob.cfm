<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>View Order</title>
<link href="forms.css" rel="stylesheet" type="text/css" />
<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=ABQIAAAANDvmFaqAegt0QYIzYW9D3BQrbbefbvA5m5xXBk7G24PUQRKS_hTKg4juhGBMJtJbMi0r8dpOQAfpWg"
      type="text/javascript"></script>
<script type="text/javascript" src="/mapping/mapping.js"></script>
<script type="text/javascript" src="/components/ajax/ajax.js"></script>
<style type="text/css">
.copyrightTable {
	font-family: Tahoma, Verdana, Arial, Helvetica, sans-serif;
	font-size: xx-small;
	color: #999999;
	background-color: #FFFFFF;
	border:none;
	width: 600px;
	padding: 5px;
	margin-top: 20px;
}
</style>
</head>

<body>
<cfquery name="j" datasource="webwarecl">
	SELECT * FROM projects WHERE id='#url.jobid#'
</cfquery>
<cfoutput query="j">
<div class="tableWrap" style="width:600px; border:none;">
<table width="100%" border="0">
	<tr>
		<td rowspan="2"><img src="../graphics/cls.gif" /></td>
		<td align="right" valign="top"><h1 style="font-size:large">PROJECT ORDER</h1></td>
	</tr>
	<tr>
	  <td align="right" valign="bottom">Project No. <strong>#clsJobNumber#</strong></td>
  </tr>
  	<tr>
  	  <td colspan="2"><hr /></td>
    </tr>
    <tr>
			<td>Map:</td>
			<td><div id="inlineMap" style="width:350px; height:200px; border:solid 1px silver">
			</div>							</td>
		<tr>
  	<tr>
  	  <td><strong>Client:</strong> </td>
  	  <td><cfmodule template="/jobViews/components/companyByClientID.cfm" id="#clientid#"></td>
    </tr>
  	<tr>
  	  <td bgcolor="##CCCCCC"><strong>Ordered By: </strong></td>
  	  <td bgcolor="##CCCCCC"><cfmodule template="/jobViews/components/custNameByID.cfm" id="#clientid#"></td>
    </tr>
  	<tr>
		<td><strong>Project Name:</strong></td>
		<td>#description#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Customer's Project Number:</strong></td>
		<td bgcolor="##CCCCCC">#clientJobNumber#</td>
	</tr>
	<tr>
		<td><strong>Project Type:</strong></td>
		<td><cfif ServiceType NEQ "">#ServiceType#: </cfif>#jobType#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Address:</strong></td>
		<td bgcolor="##CCCCCC">#address#<br />#city#, #state#  #zip#</td>
	</tr>
	<tr>
		<td><strong>Due Date:</strong></td>
		<td>#DateFormat(duedate,"mm/dd/yyyy")#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Subdivision:</strong></td>
		<td bgcolor="##CCCCCC">#subdivision#</td>
	</tr>
	<tr>
		<td><strong>Lot:</strong></td>
		<td>#lot#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Block:</strong></td>
		<td bgcolor="##CCCCCC">#block#</td>
	</tr>
	<tr>
		<td><strong>Section:</strong></td>
		<td>#section#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Township:</strong></td>
		<td bgcolor="##CCCCCC">#township#</td>
	</tr>
	<tr>
		<td><strong>Range:</strong></td>
		<td>#range#</td>
	</tr>
	<tr>
		<td bgcolor="##CCCCCC"><strong>Filing Information:</strong></td>
		<td bgcolor="##CCCCCC">#SubdivisionOrDeed# #FilingType#:  #PlatCabinetBook#</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td>#PageOrSlide#:  #PageSlide#</td>
	</tr>
	
	<tr>
		<td bgcolor="##CCCCCC"><strong>Filing Date:</strong></td>
		<td bgcolor="##CCCCCC">#DateFormat(FilingDate, "mm/dd/yyyy")#</td>
	</tr>
	
	<tr>
		<td><strong>Reception Number:</strong></td>
		<td>#ReceptionNumber#</td>
	</tr>
	
	<tr>
		<td bgcolor="##CCCCCC"><strong>Certified To:</strong></td>
		<td bgcolor="##CCCCCC">#CertifiedTo#</td>
	</tr>
	
	
	<tr>
		<td><strong>Other Project Information:</strong></td>
		<td>#specialinstructions#
        <cfif #request_photos# EQ 1>
        	<br />The customer has requested photos of existing structures for this property
        <cfelse>
        	<br />No photos requested
        </cfif> 
        </td>
	</tr>
</table>
</cfoutput>
</div>
<table class="copyrightTable">
	<tr>
		<td>Copyright &copy; 2007 Center Line Services, LLC<br />Powered by <a href="/webware/default.cfm">WebWare 1.0</a> </td>
		<td align="right"><img src="/images/webware.png" /></td>
	</tr>
</table>
<cfoutput query="j">
<script language="javascript">
	var addressString;
	addressString = '#address#' + ',' + '#city#' + ',' + '#state#' + ',' + '#zip#';

	getMapInline('inlineMap', addressString);
</script>
</cfoutput>
</body>
</html>
