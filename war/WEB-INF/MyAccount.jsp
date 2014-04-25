<%@ include file="header.jsp"%>
<script src="/js/map.js"> </script>

    <div class="left">
    
        <div class="btn-group btn-group-justified">
            <div class="btn-group">
                <button type="button" class="btn btn-default">My Parking Spots</button>
            </div>
            <div class="btn-group">
                <button type="button" class="btn btn-default">My Reservation</button>
            </div>
        </div>
    
        <div id="my_account" class="left_body">
            <c:choose>
                <c:when test="${fn:length(parkingSpots) eq 0}">
                	<p>You have not posted any parking spots.</p>
                </c:when>
                <c:otherwise>
                    <p>Parking spots for <c:out value="${user}"/>...</p>
                </c:otherwise>
            </c:choose>
                
            <c:if test="${! empty parkingSpots}">
                <c:forEach items="${parkingSpots}" var="parkingSpot">
                    <c:if test="${!empty parkingSpot.key}">
                        <script> 
                            addMarker(new google.maps.LatLng("${parkingSpot.properties.latitude}", "${parkingSpot.properties.longitude}"), "${user}"); 
                        </script>
                        <div class="input-group">
                            <blockquote>
                                <p><c:out value="${parkingSpot.properties.description}"/></p>
                                <footer>
                                    <fmt:formatDate pattern="MM/dd/yyyy" value="${parkingSpot.properties.startDate}" /> ~
                                    <fmt:formatDate pattern="MM/dd/yyyy" value="${parkingSpot.properties.endDate}" />
                                </footer>
                                <footer>
                                    [<c:out value="${parkingSpot.properties.latitude}"/>, <c:out value="${parkingSpot.properties.longitude}"/>]
                                </footer>
                            </blockquote>
                            <input type="hidden" value="${parkingSpot.properties.id}" />
                            <span class="input-group-addon trash glyphicon glyphicon-trash">
                            </span>             
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
        </div>
        
        <div id="my_reservation" class="right_body">
            <c:choose>
                <c:when test="${fn:length(reservedSpots) eq 0}">
                    <p>You have not reserved any parking spots.</p>
                </c:when>
                <c:otherwise>
                    <p>Reserved parking spots for <c:out value="${user}"/>...</p>
                </c:otherwise>
            </c:choose>
                
            <c:if test="${! empty reservedSpots}">
                <c:forEach items="${reservedSpots}" var="parkingSpot">
                    <c:if test="${!empty parkingSpot.key}">
                        <script> 
                            addReservation(new google.maps.LatLng("${parkingSpot.properties.latitude}", "${parkingSpot.properties.longitude}"), "${user}"); 
                        </script>
                        <div class="input-group">
                            <blockquote>
                                <p><c:out value="${parkingSpot.properties.description}"/></p>
                                <footer>
                                    <fmt:formatDate pattern="MM/dd/yyyy" value="${parkingSpot.properties.startDate}" /> ~
                                    <fmt:formatDate pattern="MM/dd/yyyy" value="${parkingSpot.properties.endDate}" />
                                </footer>
                                <footer>
                                    [<c:out value="${parkingSpot.properties.latitude}"/>, <c:out value="${parkingSpot.properties.longitude}"/>]
                                </footer>
                            </blockquote>
                            <input type="hidden" value="${parkingSpot.properties.reservationId}" />
                            <span class="input-group-addon trash glyphicon glyphicon-trash">
                            </span>             
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
            
            <p></p>
            
            <c:choose>
                <c:when test="${fn:length(parkingHistory) eq 0}">
                    <p>Your parking history is empty.</p>
                </c:when>
                <c:otherwise>
                    <p>Expired parking for <c:out value="${user}"/>...</p>
                </c:otherwise>
            </c:choose>
                
            <c:if test="${! empty parkingHistory}">
                <c:forEach items="${parkingHistory}" var="parkingSpot">
                    <c:if test="${!empty parkingSpot.key}">
                        <script> 
                            addReservation(new google.maps.LatLng("${parkingSpot.properties.latitude}", "${parkingSpot.properties.longitude}"), "${user}"); 
                        </script>
                        <div class="input-group">
                            <blockquote>
                                <p><c:out value="${parkingSpot.properties.description}"/></p>
                                <footer>
                                    <fmt:formatDate pattern="MM/dd" value="${parkingSpot.properties.startDate}" /> ~
                                    <fmt:formatDate pattern="MM/dd" value="${parkingSpot.properties.endDate}" />
                                </footer>
                                <footer>
                                    [<c:out value="${parkingSpot.properties.latitude}"/>, <c:out value="${parkingSpot.properties.longitude}"/>]
                                </footer>
                            </blockquote>
                        </div>
                    </c:if>
                </c:forEach>
            </c:if>
             
        </div>
    </div>
    <div id="map-canvas"> </div>
  </body>
</html>