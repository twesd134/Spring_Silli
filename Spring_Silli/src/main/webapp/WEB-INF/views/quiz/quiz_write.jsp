<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var='root' value='${pageContext.request.contextPath}/'/>    
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
</head>
 <script type="text/javascript">	
 function regit() {
	 var question=$("#question").val();
	 var answer=$("#answer").val();
	 var user_id=$("#user_id").val();
	 const all={question:question,answer:answer,user_id:user_id};
	 
	 if (!confirm("등록 하시겠습니까?")) {
			alert("취소 하셨습니다");
			location.href="${root}quiz_main.do"
		} else {
	$.ajax({
		url : "quiz_write.do",
		type : "post",
		data:all,
		dataType : "text",
	success : function(data){
			alert("등록완료");
			location.href="${root}quiz_main.do";
		},
		error : function(data) 
		{
			console.log("data==",data);
		},
	 });
	}
 }
</script>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>
<body>
<div class="container" style="margin-top:100px">
<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form  id="allForm"  name="allForm" method='post' accept-charset="UTF-8" enctype="multipart/form-data" onsubmit="return false;">
					<div class="form-group" id="content_l">
						<label for="question">문제</label>
						<textarea id="question" name="question" class="form-control" rows="10" maxlength='2000' style="resize:none"></textarea>
					</div>
					<div class="form-group" id="title_l">
						<label for="answer">답</label>
						<input type="text" id="answer" name="answer" class="form-control" maxlength='150' value="" />
					</div>
					<input type="hidden" name="user_id" id="user_id" value="${user_id }"/>
					<div class="form-group">
						<div class="text-right">
							<a href="${root}quiz_main.do" class="btn btn-primary">목록보기</a>
							<input type="button" onclick="regit(); return false;" class="btn btn-info" value="등록완료" />
							<input type="reset" class="btn btn-danger"  value="초기화"/>
						</div>
					 </div>
					</form>
				</div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
</body>
</html>