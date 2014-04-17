<%@ include file="header.jsp" %>
<script src="/js/search_field.js"></script>

	<div id="search-area">
		<div class="container">
			<div class="row">
				<div class="col-md-10">
					<h1 class="text-special">Find a place to park.</h1>
					<h2>Grandpas needn't worry about parking in downtown Vancouver
						for his vintage car.</h2>
			
						<form class="form-inline" action="/search_result" method="get" id="search_form" role="form">

						<div class="row">
							<div class="form-group col-md-6">
								<input type="text" class="form-control" id="location"
									autocomplete="off" name="location" required
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
									id="search_btn" value="Search" />
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