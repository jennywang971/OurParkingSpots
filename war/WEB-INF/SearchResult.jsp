<%@ include file="header.jsp"%>
<script src="/js/search_field.js"> </script>
<script src="/js/parking_map.js"> </script>
<script>codeAddress("${param.location}");</script>

	<div class="left">
	
	   <label for="location"> Location Entered: </label>
	   <form action="/search_result" method="get" role="form">
	       <div class="row">
	           <div class="form-group col-md-6">
                   <input type="text" class="form-control" id="location"
                       autocomplete="off" name="location" value="${param.location}"
                       placeholder="Where do you want to park?" />
               </div>
           </div>
               <div class="form-group date post-parking-date-picker">
                   <div class="input-group date search-result">
                       <input type="text" class="form-control" autocomplete="off" value="${startDate}"
                           id="startdatepicker" name="startdatepicker" placeholder="Start Date" /> 
                       <span class="input-group-addon">
                           <span class="glyphicon glyphicon-calendar"></span>
                      </span>
                  </div>
               </div>
    
                <div class="form-group date post-parking-date-picker">
                    <div class="input-group date search-result">
                        <input type="text" class="form-control" autocomplete="off" value="${endDate}"
                            id="enddatepicker" name="enddatepicker" placeholder="End Date" />
                        <span class="input-group-addon">
                            <span class="glyphicon glyphicon-calendar"></span>
                        </span>
                    </div>
                </div>
            <div class="row">
	    <div class="row input-group" style="float: right; margin-right: 16px;">
			<button class="btn btn-default" type="submit" >Search</button>
		</div>
            </div>
	    </form>

	   <div class="left_body" style="height:65%;">
	   
	       <c:choose>
                <c:when test="${fn:length(parkingSpots) eq 0}">
                    <p>There is no parking spots available nearby.</p>
                </c:when>
                <c:otherwise>
                    <p>Available parking spots near ${param.location}</p>
                </c:otherwise>
           </c:choose>

		   <c:if test="${! empty parkingSpots}">
			    <c:forEach items="${parkingSpots}" var="parkingSpot">
				    <c:if test="${!empty parkingSpot.key}">
					   <script> 
                            addMarker(new google.maps.LatLng("${parkingSpot.properties.latitude}", "${parkingSpot.properties.longitude}"),  
                            		"${parkingSpot.properties.id}",
                            		"${parkingSpot.properties.description}",
                            		"${parkingSpot.properties.rate}",
                            		"${duration}",
                            		"${param.startdatepicker}",
                            		"${param.enddatepicker}"); 
                       </script>
                       <b><c:out value="${parkingSpot.properties.owner}"/></b> posted a parking spot...
					   <blockquote>
					      <p>
							    <c:out value="${parkingSpot.properties.description}" />
						  </p>
						  <footer>
						        <c:out value="ID = ${parkingSpot.properties.id}" />
						  </footer>
						  <footer>
							    <fmt:formatDate pattern="MM/dd/yyyy" value="${parkingSpot.properties.startDate}" /> ~
							    <fmt:formatDate pattern="MM/dd/yyyy" value="${parkingSpot.properties.endDate}" />
						  </footer>
						  <footer>
							    [ <c:out value="${parkingSpot.properties.latitude}" /> , <c:out value="${parkingSpot.properties.longitude}" /> ]
						  </footer>
					   </blockquote>
				    </c:if>
			    </c:forEach>
		   </c:if>

		</div>
	</div>
	<div id="map-canvas"> </div>
	
	<!-- Modal -->
	<div class="modal fade" id="parkingInfoModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
	    <div class="modal-content">
	      <div class="modal-header">
	        <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	        <h4 class="modal-title" id="myModalLabel">Parking Spot Info</h4>
	      </div>
	      <div class="modal-body">
	      	<div><p id="description-info"></p></div>
	        <div><label>Start Date</label>${param.startdatepicker}</div>
	        <div><label>End Date</label>${param.enddatepicker}</div>
	        <div><label>Duration</label>${duration} days</div>
	        <div><label>Rate</label><span id="rate-info"></span></div>
	        <div><label>Total Price</label><span id="total-price-info"></span></div>
	      </div>
	      <div class="modal-footer">
	        <button id="detail-btn" type="button" class="btn btn-default">View detail</button>
	        <button id="reserve-btn" type="button" class="btn btn-success">Book this spot</button>
	      </div>
	    </div>
	  </div>
    </div>
  </body>
</html>