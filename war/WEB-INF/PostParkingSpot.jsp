<%@ include file="header.jsp"%>
<script src="js/post_parking.js"> </script>
<script src="js/serach_field.js"> </script>

<div class="left">

	<label for="latitude"> POST A SPOT!! <br /> Click on the map to specify a location </label>

	<form action="/post_parking_spot" method="post" role="form">

		<div class="row">
			<div class="input-group post-parking">
				<span class="input-group-addon">
				    <span class="glyphicon glyphicon-map-marker"></span>
				</span> 
				<input id="latitude" name="latitude" type="text" class="form-control col-xs-3" placeholder="Latitude">
				<input id="longitude" name="longitude" type="text" class="form-control col-xs-3" placeholder="Longitude">
			</div>
		</div>

		<label for="startdatepicker">AVAILABLE TIME</label>

		<div class="row">
			<div class="form-group date post-parking-date-picker">
				<div class="input-group date post-parking">
					<input type="text" class="form-control" autocomplete="off"
						id="startdatepicker" name="startdatepicker" placeholder="Start Date" /> 
					<span class="input-group-addon">
					    <span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div>

			<div class="form-group date post-parking-date-picker">
				<div class="input-group date post-parking">
					<input type="text" class="form-control" autocomplete="off"
						id="enddatepicker" name="enddatepicker" placeholder="End Date" />
					<span class="input-group-addon">
					   <span class="glyphicon glyphicon-calendar"></span>
					</span>
				</div>
			</div>
		</div>

		<label for="startdatepicker">RENTAL OPITON</label>
		<div class="row">
			<div class="input-group post-parking">
				<div class="input-group-btn">
					<button type="button" class="btn btn-default dropdown-toggle"
						data-toggle="dropdown" style="padding: 10px 12px;">
						Rate Option <span class="caret"></span>
					</button>
					<ul class="dropdown-menu">
						<li class="disabled"><a href="#">Hourly</a></li>
						<li><a href="#">Daily</a></li>
						<li class="disabled"><a href="#">Weekly</a></li>
						<li class="disabled"><a href="#">Monthly</a></li>
					</ul>
				</div>
				<!-- /btn-group -->
				<span class="input-group-addon">$</span>
				<input id="rate" name="rate" type="text" step="any" min="0" class="form-control"> 
			</div>
		</div>

		<label for="content">DESCRIPTION</label>
		<div class="row input-group post-parking">
			<textarea class="form-control" name="content" rows="5" cols="100" style="resize: none"></textarea>
		</div>
	    <div class="row input-group post-parking" style="float: right;">
			<button class="btn btn-default" type="submit" >Post Parking Spot</button>
		</div>
	</form>
</div>
<div id="map-canvas"></div>
</body>
</html>