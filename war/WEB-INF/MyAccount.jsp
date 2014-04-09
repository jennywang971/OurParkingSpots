<%@ include file="header.jsp"%>
<script src="js/map.js"> </script>

    <div class="left">
    
        <div class="btn-group btn-group-justified">
            <div class="btn-group">
                <button type="button" class="btn btn-default">My Parking Spots</button>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-default">Parking History</button>
            </div>
        </div>
    
        <div id="left_body">
            <c:choose>
                <c:when test="${fn:length(parkingSpots) eq 0}">
                	<p>You have not posted any parking spots.</p>
                </c:when>
                <c:otherwise>
                    <p>Available parking spots for <c:out value="${user}"/>...</p>
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