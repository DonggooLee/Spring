<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page session="false" %>
<style type="text/css">

</style>
<jsp:include page="/WEB-INF/views/include/header.jsp"/>

		<section class="cont">
			<div class="searchSection">
				get
			</div>
		</section>
		
<script type="text/javascript">
 
	$(function(){
		$(".move").click(function(e){
			 e.preventDefault();
			 actionForm.attr("action", "/pakage/P_get");
			 actionForm.append("<input type='hidden' name='p_num' value='"+$(this).attr("href")+"'>");
			 actionForm.submit();
		})
	});


</script>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>