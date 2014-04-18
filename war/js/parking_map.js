"use strict";

google.maps.visualRefresh = true;
var mapOptions = {
	zoom : 14
};
var map;
var markers = [];
var geocoder;

function initialize() {

	map = new google.maps.Map(document.getElementById("map-canvas"),
			mapOptions);

	setAllMap(map);

	//geocoder = new google.maps.Geocoder();
//	codeAddress();
	
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
// show position when geolocation is supported and succeeded
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

// if no geolocation is available, display reason and a default map
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

}

function addMarker(coord, id, description, rate, duration){

	var icon = 'https://maps.google.com/mapfiles/kml/shapes/parking_lot_maps.png';

	var title = "$" + rate + " CAD" + " per day"
	
	var marker = new google.maps.Marker({
		map : map,
		position: coord,
		animation : google.maps.Animation.DROP,
		icon: icon,
		title: title
	});
	
	markers.push(marker);
	
	google.maps.event.addListener(marker, 'click', function() {
		$("#description-info").text(description);
		$("#rate-info").text("$" + rate + " CAD" + " per day");
		$("#total-price-info").text("$" +  parseInt(rate) * parseInt(duration) + " CAD");
		$("#parkingInfoModal").modal();
	});
}

function setAllMap(map) {
	for (var i = 0; i < markers.length; i++) {
		markers[i].setMap(map);
	}
} 

google.maps.event.addDomListener(window,'load', initialize);