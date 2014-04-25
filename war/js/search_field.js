$(document).ready(function() {
	
	loadCalendars();
	$("#location").geocomplete();
});

function loadCalendars() {
	
	var nowTemp = new Date();
	var now = new Date(nowTemp.getFullYear(), nowTemp.getMonth(), nowTemp.getDate(), 0, 0, 0, 0);

	var checkin = $('#startdatepicker').datepicker({

	    beforeShowDay: function (date) {
	        return date.valueOf() >= now.valueOf();
	    },
	    autoclose: true

	}).on('changeDate', function (ev) {
	    if (ev.date.valueOf() >= checkout.datepicker("getDate").valueOf() || !checkout.datepicker("getDate").valueOf()) {

	        var newDate = new Date(ev.date);
	        newDate.setDate(newDate.getDate());
	        checkout.datepicker("update", newDate);

	    }
	    $('#enddatepicker')[0].focus();
	});

	var checkout = $('#enddatepicker').datepicker({
	    beforeShowDay: function (date) {
	        if (!checkin.datepicker("getDate").valueOf()) {
	            return date.valueOf() >= new Date().valueOf();
	        } else {
	            return date.valueOf() >= checkin.datepicker("getDate").valueOf();
	        }
	    },
	    autoclose: true

	}).on('changeDate', function (ev) {});
	
}

