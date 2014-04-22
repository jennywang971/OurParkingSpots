"use strict";

google.maps.visualRefresh = true;
var map;
var markers = [];
var geocoder;
var xmlHttpReq = null;

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

	setAllMap(map);

	if(navigator.geolocation){
		navigator.geolocation.getCurrentPosition(showPosition, handleNoGeolocation(true));
	} else {
		handleNoGeolocation(false);
	}

	$(".glyphicon-trash").each(function(index) {
		$(this).on("click", function() {
			alert(index);
			postAjaxRequest($(this).prev().val(), $(this).parent(), index);
		});
	}); 
}

//get map to display around the specified address
function codeAddress(sAddress){
	geocoder = new google.maps.Geocoder();

	geocoder.geocode( { 'address': sAddress}, function(results, status) { 
		if(status == google.maps.GeocoderStatus.OK){
			map.setCenter(results[0].geometry.location);
			var marker = new google.maps.Marker({  
				map: map,  
				position: results[0].geometry.location }); 
		}
		else{
			alert("Geocode was not successful for the following reason: " + status); 
		}
	}); 
}

//show position when geolocation is supported and succeeded
function showPosition(position){
	var map_position = new google.maps.LatLng(position.coords.latitude,
			position.coords.longitude);

	var infowindow = new google.maps.InfoWindow({
		map: map,
		position: map_position,
		content: 'Your current location. Powered by HTML5.'
	});

	var marker = new google.maps.Marker({
		position: map_position,
		map: map
	});

	// now we can set the map with current position
	map.setCenter(map_position);

}

//if no geolocation is available, display reason and a default map
function handleNoGeolocation(isSupported){
	if(isSupported){
		var content = 'Error: The Geolocation service failed';
	} else {
		var content = 'Your browser doesn\'t support geolocation.';
	}

	var options = {
			map : map,
			position : new google.maps.LatLng(60, 105), // shows map at a default location
			content : content
	};

	var infowindow = new google.maps.InfoWindow(options);

	map.setCenter(options.positions);

}

function addMarker(coord, title){

	var icon = 'https://maps.google.com/mapfiles/kml/shapes/parking_lot_maps.png';

	var marker = new google.maps.Marker({
		map : map,
		position: coord,
		animation : google.maps.Animation.DROP,
		icon: icon,
		title: title
	});

	markers.push(marker);
}

function setAllMap(map) {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
} 

google.maps.event.addDomListener(window,'load', initialize);

function postAjaxRequest(id, container, index) {

	$.post( "/delete_parking",
			{id: id},
			function() {
				container.remove();
				markers[index].setMap(null);
			});
}

