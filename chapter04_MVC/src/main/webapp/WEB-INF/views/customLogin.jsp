<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Login Page</title>
<!-- Bootstrap Core CSS -->
<link href="/resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="/resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="/resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="/resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<style type="text/css">
	.wrap-div {
		width: 500px;
		margin: auto;
		text-align: center;
		margin-top: 50px;
	}
</style>
</head>
<body>

	<%-- <h1>Custom Login Page</h1>
	<h2>${error }</h2>
	<h2>${logout }</h2>
   
	<form action="/login" method="post">
		아이디 : <input type="text" name="username"><br>
		비밀번호 : <input type="password" name="password" ><br>
		<input type="checkbox" name="remember-me">아이디 기억하기<br>
		<input type="submit" value="로그인">
		<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token }">         
	</form> --%>
   
	<div class="wrap-div">
		<form role="form" method="post" action="/login">
			<fieldset>
				<div class="form-group">
					<input class="form-control" placeholder="아이디" name="username"
						type="text" autofocus>
				</div>
				<div class="form-group">
					<input class="form-control" placeholder="비밀번호" name="password"
						type="password">
				</div>
				<div class="checkbox">
					<label> <!-- name 을 시큐리티 컨텍스트.xml 파일과 일치 시켜야 한다 --> <input
						name="remember-me" type="checkbox">아이디 기억하기
					</label>
				</div>
				<!-- Change this to a button or input when using this as a form -->
				<a href="index.html" class="btn btn-lg btn-success btn-block">Login</a>
				<input type="hidden" name="${_csrf.parameterName}"
					value="${_csfr.token }">
			</fieldset>
		</form>
	</div>
	
	<!-- jQuery -->
	<script src="/resources/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="/resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="/resources/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="/resources/dist/js/sb-admin-2.js"></script>

	<script type="text/javascript">
		$(function() {

			$("a").click(function(e) {
				e.preventDefault(); // 이벤트 막아주기
				$("form").submit();
			});

		});
	</script>

</body>
</html>