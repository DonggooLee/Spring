<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false" %>
<html>
<head>
</head>
<body>
	<form action="/board/list" method="get" id="startForm">
		<input type="hidden" name="pageNum" value="1">
		<input type="hidden" name="amount" value="10">
	</form>
	<script type="text/javascript">
		onload = function() {
			document.getElementById("startForm").submit();
		}
	</script>
</body>
</html>
