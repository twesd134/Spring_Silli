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
<title>퀴즈 리스트</title>
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
	var edit=function (_index) {
	console.log(_index);
	var question=$("#question").val();
	var answer=$("#answer").val();
	var dd=$('table#tbl1 tr').eq((_index)).text();
	console.log("aa==",dd);
	
	}
</script>


<c:import url="/WEB-INF/views/include/top_menu.jsp"/>
<body>
<div class="container" style="margin-top:100px">
	<div class="card shadow">
		<div class="card-body" id="view">
		<h4 class="card-title"></h4>
		<table id="tbl1">
			<input type="button" onclick="edit(${status.index})" class="btn btn-dange" value="수정하기"/>
		<c:forEach var="obj" items="${chk.chk}" varStatus="status" >
			<div class="form-group" id="content_div">
				<label for="question">${status.index+1}문제</label>
				<textarea id="question" name="question" class="form-control" rows="30" maxlength='5000' style="resize:none" readonly="readonly">${obj.question }</textarea>
			</div>
		</c:forEach>
		</table>
		<br>
		</div>
	</div>
</div>
</body>
</html>