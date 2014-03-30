<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="header1.jsp" %> 
<%-- <jsp:include page="/header1.jsp">
    <jsp:param name="post_parking" value="true"/>
</jsp:include> --%>
 <script src="js/post_parking.js"> </script>
 <script src="js/abc.js"> </script>

    <div class="left">

	POST A SPOT!!

    <div class="row">
		<div class="form-group date post-parking-date-picker">
			<div class="input-group date">
				<input type="text" class="form-control" autocomplete="off"
					id="startdatepicker" name="startdatepicker"
					placeholder="Start Date" /> <span class="input-group-addon"><span
					class="glyphicon glyphicon-calendar"></span></span>
			</div>
		</div>

		<div class="form-group date post-parking-date-picker">
			<div class="input-group date">
				<input type="text" class="form-control" autocomplete="off"
					id="enddatepicker" name="enddatepicker" placeholder="End Date" />
				<span class="input-group-addon"><span
					class="glyphicon glyphicon-calendar"></span></span>
			</div>
		</div>
	</div>

	<form action="/post_parking_spot" method="post">
          <div><textarea name="content" rows="5" cols="75" style="resize:none"></textarea></div>
          <div><input type="submit" value="Post Parking Spot" /></div>
          <input type="hidden" id="latitude" name="latitude" value="0"/>
          <input type="hidden" id="longitude" name="longitude" value="0"/>
          <input type="hidden" id="accuracy" name="accuracy" value="0"/>
        </form>
    </div>
    <div id="map-canvas"> </div>
  </body>
</html>