<%@ page language="java" contentType="text/html; charset=US-ASCII"
    pageEncoding="US-ASCII"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet"
	href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css" />
<link rel="stylesheet" href="/css/datepicker3.css" />
<link rel='stylesheet'
	href='//fonts.googleapis.com/css?family=Quintessential'>
<link rel="stylesheet" href="/css/main1.css" />
<script
	src="//maps.googleapis.com/maps/api/js?sensor=false&amp;libraries=places"></script>
<script
	src="//ajax.googleapis.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
<script
	src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
<script src="/js/jquery.geocomplete.min.js"></script>
<script src="/js/bootstrap-datepicker.js"></script>
<script src="/js/abc.js"></script>
<script type="text/javascript" src="/js/parking_map.js"> </script>
</head>

<body>

	<%@ include file="header_no_login.jsp" %>

	<div id="search-area">
		<div class="container">
			<div class="row">
				<div class="col-md-10">
					<h1 class="text-special">Find a place to park.</h1>
					<h2>Grandpas needn't worry about parking in downtown Vancouver
						for his vintage car.</h2>
			
						<form class="form-inline" action="search_result.jsp" method="get"
						role="form">
						<div class="row">
							<div class="form-group col-md-6">
								<input type="text" class="form-control" id="location"
									autocomplete="off" name="location"
									placeholder="Where do you want to park?" />
							</div>

							<div class="form-group date col-md-2">
								<div class="input-group date">
									<input type="text" class="form-control" autocomplete="off"
										id="startdatepicker" name="startdatepicker"
										placeholder="Start Date" /> <span class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span></span>
								</div>
							</div>


							<div class="form-group date col-md-2">
								<div class="input-group date">
									<input type="text" class="form-control" autocomplete="off"
										id="enddatepicker" name="enddatepicker" placeholder="End Date" />
									<span class="input-group-addon"><span
										class="glyphicon glyphicon-calendar"></span></span>
								</div>
							</div>

							<div class="form-group col-md-2">
								<input type="submit"
									class="form-control btn btn-primary btn-large"
									id="submit_location" value="Search" />
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<div class="container">
		<!-- Example row of columns -->
		<div class="row">
			<div class="col-md-4">
				<h2>Renter's Guide</h2>
				<p>Donec id elit non mi porta gravida at eget metus. Fusce
					dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
					ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
					magna mollis euismod. Donec sed odio dui.</p>
				<p>
					<a class="btn btn-default" href="#" role="button">View details
						&raquo;</a>
				</p>
			</div>
			<div class="col-md-4">
				<h2>Owner's Guide</h2>
				<p>Donec id elit non mi porta gravida at eget metus. Fusce
					dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh,
					ut fermentum massa justo sit amet risus. Etiam porta sem malesuada
					magna mollis euismod. Donec sed odio dui.</p>
				<p>
					<a class="btn btn-default" href="#" role="button">View details
						&raquo;</a>
				</p>
			</div>
			<div class="col-md-4">
				<h2>About Insurance</h2>
				<p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in,
					egestas eget quam. Vestibulum id ligula porta felis euismod semper.
					Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum
					nibh, ut fermentum massa justo sit amet risus.</p>
				<p>
					<a class="btn btn-default" href="#" role="button">View details
						&raquo;</a>
				</p>
			</div>
		</div>

		<%@ include file="footer.jsp" %>
	</div>
</body>