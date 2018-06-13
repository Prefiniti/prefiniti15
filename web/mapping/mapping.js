var map;
var markers = new Array();
var mi = 0;

function popupMap(mapTitle, address, boxMessage, geocode)
{
	hideDiv('gen_window_frame');
	map = null;
	mi = 0;
	SetInnerHTML('m_directions', '<strong>No waypoints have been selected.</strong>');
	
	showDiv('mapWrapper');
	
	
	getMap('mapPopup', address, boxMessage, geocode);
	SetValue('project_loc', address);
}

function get_directions(source_address, destination_address) {
	SetInnerHTML('m_directions', '');
	var directionsPanel;
	var dirStr;
	
	dirStr = source_address + ' to ' + destination_address;
	
  	directionsPanel = document.getElementById("m_directions");
  	
  	directions = new GDirections(map, directionsPanel);
  	directions.load(dirStr);
	showDiv('m_directions');
	
}

function getMap(targetCtl, address, boxMessage, geocode) 
{
	var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="300px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		
		showAddress(address, boxMessage, geocode);
      }
}

function showAddress(address, bm, geocode) 
{

	if (geocode) {
		var geocoder = new GClientGeocoder();
	  geocoder.getLatLng(
		address,
		function(point) {
		  if (!point) {
			alert(address + " not found");
		  } else {
			map.setCenter(point, 13);
			var marker = new GMarker(point);
			map.addOverlay(marker);
			marker.openInfoWindowHtml(bm);
		  }
		}
	  );
	}
	else {
		try {
		var marker = new GMarker(new GLatLng(address));
		map.addOverlay(marker);
		marker.openInfoWindowHtml(bm);
		}
		catch (e)
		{
			
		}
	}
}

function showLatLong(point_name, latitude, longitude, elevation) 
{
	var point_html;
	point_html = "<strong>Point Name: </strong> " + point_name;
	if (elevation != 0) {
		point_html += "<br><strong>Point Elevation: </strong> " + elevation;
	}
	point_html += '<br><input type="button" class="normalButton" value="Directions" onclick="popupMap(\'' + point_name + '\', \'' + latitude + ', ' + longitude + '\',\'' + point_name + '\', false);">';
	
	markers[mi] = new GMarker(new GLatLng(latitude, longitude));
	map.setCenter(new GLatLng(latitude, longitude), 13);
	map.addOverlay(markers[mi]);
	var trafficInfo = new GTrafficOverlay();
	map.addOverlay(trafficInfo);
	//markers.openInfoWindowHtml(point_html);     
	
	//alert(point_html);
	
	GEvent.addListener(markers[mi], "click", function() {
    		SetInnerHTML('point_info', point_html);
			markers[mi].showMapBlowup();
			//alert('marker ' + bm);
			//location.replace("projectView.cfm?id=" + id);
  		});
	mi++;
}


function getMapByLatLng(targetCtl, lat, lng, boxMessage)
{
	SetInnerHTML('mapViewText', 'Map View: ' + lat + ', ' + lng);
		var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="400px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GLargeMapControl());
		map.addControl(new GMapTypeControl());
		map.addControl(new GScaleControl());
		map.enableScrollWheelZoom();
		
		
		map.setCenter(new GLatLng(lat, lng), 13);
		var marker = new GMarker(new GLatLng(lat, lng));
        map.addOverlay(marker);
        marker.openInfoWindowHtml(boxMessage);
      }
	
}

//

function getMapInline(targetCtl, address) 
{
	var ct=AjaxGetElementReference(targetCtl);
	
	//ct.style.height="200px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
		
		showAddressInline(address);
      }
}

function getMapNoMsg(targetCtl) 
{
	var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="400px";
	
	  if (GBrowserIsCompatible()) 
	  {
        map = new GMap2(document.getElementById(targetCtl));
		map.addControl(new GSmallMapControl());
		map.addControl(new GMapTypeControl());
      }
	mi=0;
}

function disableMap(targetCtl)
{
	var ct=AjaxGetElementReference(targetCtl);
	
	ct.style.height="auto";
}


function showHideMarker(marker_idx, shown)
{
	if (shown) {
		markers[marker_idx].show();
		
	}
	else {
		markers[marker_idx].hide();
	}
}

function centerToMarker(marker_idx)
{
	map.setCenter(markers[marker_idx].getPoint());
}

function showAddressInline(address) {
	var geocoder = new GClientGeocoder();
  geocoder.getLatLng(
    address,
    function(point) {
      if (!point) {
        //alert(address + " not found");
      } else {
        map.setCenter(point, 13);
        var marker = new GMarker(point);
        map.addOverlay(marker);
        
      }
    }
  );
}

function getLatitude(address) 
{
	var geocoder = new GClientGeocoder();
	geocoder.getLatLng(
    address,
    function(point) 
	{
		if(point)
		{
			
			SetValue('latitude', point.lat());
		}
		else
		{
			getLatitude('Las Cruces,NM,88001');
		}
	}
	);
}

function getLongitude(address) 
{
	var geocoder = new GClientGeocoder();
	geocoder.getLatLng(
    address,
    function(point) 
	{
		if(point)
		{
			SetValue('longitude', point.lng());
		}
		else
		{
			getLongitude('Las Cruces,NM,88001');
		}
	}
	);
}


function addAddress(address, bm, id) {
	var geocoder = new GClientGeocoder();
  geocoder.getLatLng(
    address,
    function(point) {
      if (!point) {
        //alert(address + " not found");
      } else {
        map.setCenter(point, 13);
        markers[mi] = new GMarker(point);
        map.addOverlay(markers[mi]);
        
		GEvent.addListener(markers[mi], "mouseover", function() {
    		//alert('marker ' + bm);
			SetInnerHTML('mapInfo', bm);
  		});
		GEvent.addListener(markers[mi], "mouseout", function() {
    		//alert('marker ' + bm);
			SetInnerHTML('mapInfo', '<strong>No project selected.</strong>');
  		});
		GEvent.addListener(markers[mi], "click", function() {
    		//alert('marker ' + bm);
			location.replace("projectView.cfm?id=" + id);
  		});

		mi++;
      }
	  map.setZoom(11);
    }
  );
}

function calcLatLng()
{
	var addressString;
	addressString = GetValue('address') + ',' + GetValue('city') + ',' + GetValue('state') + ',' + GetValue('zip');
	
	getLatitude(addressString);
	getLongitude(addressString);
	
	
}

function updateMap()
{
	var addressString;
	addressString = GetValue('address') + ',' + GetValue('city') + ',' + GetValue('state') + ',' + GetValue('zip');

	getMapInline('inlineMap', addressString);
}

function getLocation(id)
{
	var url;
	url = '/mapping/location_details.cfm?id=' + escape(id);
	
	AjaxLoadPageToDiv('locTarget', url);
}

function load_field_map(notes_file_id, mode, project_lat, project_lng)
{
	var url;
	url = '/workflow/components/field_map.cfm?notes_file_id=' + escape(notes_file_id);
	url += '&mode=' + escape(mode);
	url += '&project_lat=' + escape(project_lat);
	url += '&project_lng=' + escape(project_lng);
	
	AjaxLoadPageToWindow(url, 'Field Map');
}