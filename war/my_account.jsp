<%@ include file="header1.jsp"%>
<script src="js/map.js"> </script>

<%
    // Get parking spots from the system
            
    Query query = new Query("ParkingSpot", parkingSpotsKey)
        .addSort("startDate", Query.SortDirection.DESCENDING)
        .addSort("endDate", Query.SortDirection.ASCENDING);
                        
    // Add a filter that checks the start and end date
    Filter startDateFilter = new FilterPredicate("owner", FilterOperator.EQUAL, user);
    query.setFilter(startDateFilter);
    
    List<Entity> parkingSpots = datastore.prepare(query).asList(FetchOptions.Builder.withLimit(10));
    pageContext.setAttribute("parkingSpots", parkingSpots); 
%>

    <div class="left">
    
        <div class="btn-group btn-group-justified">
            <div class="btn-group">
                <button type="button" class="btn btn-default">My Parking Spots</button>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-default">Spots I Have Parked</button>
            </div>
        </div>
    
        <div id="left_body">
            <c:choose>
                <c:when test="${fn:length(parkingSpots) eq 0}">
                	<p>You have not posted any parking spots.</p>
                </c:when>
                <c:otherwise>
                    <p>Available parking spots for <c:out value="${user}"/>:</p>
                </c:otherwise>
            </c:choose>
                
            <c:if test="${! empty parkingSpots}">
        
                <c:forEach items="${parkingSpots}" var="parkingSpot">
                    <c:if test="${!empty parkingSpot.key}">
                        <script> 
                            addMarker(new google.maps.LatLng("${parkingSpot.properties.latitude}", "${parkingSpot.properties.longitude}"), "${user}"); 
                        </script>
                        <blockquote>
                            <p><c:out value="${parkingSpot.properties.description}"/></p>
                            <footer>
                                <fmt:formatDate pattern="MM/dd" value="${parkingSpot.properties.startDate}" /> ~
                                <fmt:formatDate pattern="MM/dd" value="${parkingSpot.properties.endDate}" />
                            </footer>
                            <footer>
                                [<c:out value="${parkingSpot.properties.latitude}"/>, <c:out value="${parkingSpot.properties.longitude}"/>]</footer>
                        </blockquote>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
    </div>
    <div id="map-canvas"> </div>
  </body>
</html>