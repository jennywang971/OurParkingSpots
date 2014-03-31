"use strict";

google.maps.visualRefresh = true;

var map;
var marker = null;
var geocoder;
var infowindow = new google.maps.InfoWindow( { 
			size: new google.maps.Size(150,50)
		});

function initialize() {

	var mapOptions = {
			zoom: 12,
			timeout : 5000,
			maximumAge : 0,
			enableHighAccuracy : true,
			mapTypeControl: true,
			mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
			navigationControl: true,
			mapTypeId: google.maps.MapTypeId.ROADMAP
	};

	map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

	google.maps.event.addListener(map, 'click', function() {
		infowindow.close();
	});

	google.maps.event.addListener(map, 'click', function(event) {
		//call function to create marker
		if (marker) {
			marker.setMap(null);
			marker = null;
		}
		marker = createMarker(event.latLng, "name", "<b>Location</b><br>"+event.latLng);
	});

//	use HTML5 geolocation
	if(navigator.geolocation){

//		specify the geolocation success and error callback functions
//		HTML5: navigator.geolocation.getCurrentPosition(success, error, options)
		navigator.geolocation.getCurrentPosition(showPosition, handleNoGeolocation(true));

	}
	else{
		handleNoGeolocation(false);
	}
}

//show position when geolocation is supported and succeeded
function showPosition(position){
	var map_position = new google.maps.LatLng(position.coords.latitude,
			position.coords.longitude);

	var currentLoc = new google.maps.InfoWindow({
		map: map,
		position: map_position,
		content: 'Your current location. Powered by HTML5.'
	});   

	// now we can set the map with current position
	map.setCenter(map_position);

	// set current Latitude and Longitude for guestbook entry
	/*	document.getElementById("latitude").value =  position.coords.latitude; 
	document.getElementById("longitude").value = position.coords.longitude;
	document.getElementById("accuracy").value = position.coords.accuracy; */
}

//if no geolocation is available, display reason and a default map
function handleNoGeolocation(isSupported){
	if(isSupported){
		var content = 'Error: The Geolocation service failed';
	}
	else{
		var content = 'Your browser doesn\'t support geolocation.';
	}

	var options = {
			map : map,
			position : new google.maps.LatLng(60, 105), // shows map at a default location
			content : content
	};

	var infowindow = new google.maps.InfoWindow(options);

	map.setCenter(options.positions);

	// no need to set Latitude and Longitude for guestbook entry
}


//A function to create the marker and set up the event window function 
function createMarker(latlng, name, html) {
	var contentString = html;
	var marker = new google.maps.Marker({
		position: latlng,
		map: map,
		zIndex: Math.round(latlng.lat()*-100000)<<5
	});

	google.maps.event.addListener(marker, 'click', function() {
		infowindow.setContent(contentString); 
		infowindow.open(map,marker);
	});
	google.maps.event.trigger(marker, 'click');    
	return marker;
}

google.maps.event.addDomListener(window, 'load', initialize);
