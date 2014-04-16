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
                       <input type="text" class="form-control" autocomplete="off" value="${param.startdatepicker}"
                           id="startdatepicker" name="startdatepicker" placeholder="Start Date" /> 
                       <span class="input-group-addon">
                           <span class="glyphicon glyphicon-calendar"></span>
                      </span>
                  </div>
               </div>
    
                <div class="form-group date post-parking-date-picker">
                    <div class="input-group date search-result">
                        <input type="text" class="form-control" autocomplete="off" value="${param.enddatepicker}"
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

	   <div id="left_body" style="height:65%;">
	   
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
                            addMarker(new google.maps.LatLng("${parkingSpot.properties.latitude}", "${parkingSpot.properties.longitude}"), "${parkingSpot.properties.owner}"); 
                            addInfoWindow();
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
							    <fmt:formatDate pattern="MM/dd" value="${parkingSpot.properties.startDate}" />
							    <fmt:formatDate pattern="MM/dd" value="${parkingSpot.properties.endDate}" />
						  </footer>
						  <footer>
							    [ <c:out value="${parkingSpot.properties.latitude}" /> , <c:out value="${parkingSpot.properties.longitude}" /> ]
						  </footer>
						  <footer>
						          <c:out value="Accuracy = ${parkingSpot.properties.accuracy}"/>
						  </footer>
					   </blockquote>
				    </c:if>
			    </c:forEach>
		   </c:if>

		</div>
	</div>
	<div id="map-canvas"> </div>
  </body>
</html>