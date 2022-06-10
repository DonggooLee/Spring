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
	<!-- 온로드를 통해서 페이지가 시작될 때 바로 실행 될 수 있게 만들기! -->
	<script type="text/javascript">
		onload = function() {
			document.getElementById("startForm").submit();
		}
	</script>
</body>
</html>