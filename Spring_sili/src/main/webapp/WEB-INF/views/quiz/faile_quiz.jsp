<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>퀴즈</title>
<!-- Bootstrap CDN -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.26.0/polyfill.min.js"></script>
<style>
.find-btn{
	text-align: center;
}
.find-btn1{
	display :inline-block;
}
	
</style>
<script>
$(document).ready(function(){
	
	$("#answer").focus();
	$("#dis1").show();
	
	<c:forEach var="obj" items="${chk.re_chk}" varStatus="status" >
	$("#dis${status.index+2}").hide();
	</c:forEach>
	
});


</script>
</head>
<script>
	
	
	var enterkey=function () {
		if (window.event.keyCode == 13) {
			
		}
	}
	
	var quiz_list = function() {
		location.href="${root}quiz_main.do";
	}
	
	
	var cate=function() {
		const category=$("#category").val();
		const all={category:category}
		$.ajax({
    		url : "faile_cate.do",
    		type : "get",
    		data:category,
    		dataType : "text",
    	success : function(data){
				console.log("rrdata",data);
    		},
    		error : function(data) 
    		{	
    			console.log("data==",data);
    		},
		 });
	}
</script>

<c:import url="/WEB-INF/views/include/top_menu.jsp"/>
<body>
<div class="container" style="margin-top:100px">
	<div class="card shadow">
		<div class="card-body" id="view">
		<h4 class="card-title"></h4>
		<table id="tbl1">
			<div class="form-group" id="content_div">
				<label for="category">카테고리</label><br>
			<c:if test = "${fn:length(chk.fail_chk) eq 0}">
					<td colspan="6">틀린 문제가 없습니다.</td> 
			</c:if>
		<c:forEach var="obj" items="${chk.fail_chk}" varStatus="status" >
				<a href="${root}faile_cate.do?category=${obj.category}">${obj.category}</a>
		</c:forEach>
		</table>
		<br>
		</div>
		<form action="${root}quiz_faile.do">
			<input type="hidden" name="status" id="status" value="${fn:length(chk.fail_chk)}"/>
			<input type="hidden" name="user_id" id="user_id" value="${user_id}"/>
		</form>
			<input type="button" onclick="quiz_list();" class="btn btn-dange" value="문제목록">
	</div>
</div>
</body>
</html>