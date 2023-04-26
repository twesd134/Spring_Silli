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
	
	<c:forEach var="obj" items="${chk.fail_chk}" varStatus="status" >
	$("#dis${status.index+2}").hide();
	</c:forEach>
});

function hideTr(_index) {
			console.log(_index);
			$("#content_div").eq((_index)).hide();
			$("#content_div").eq((_index + 1)).show();
			
}
</script>
</head>
<script>
// 'table#tbl1 tr'
	var chk = function (_index) {
		const question=$("#content_div").eq((_index)).find('#question').val();
		const answer=$("#answer_div").eq((_index)).find('#answer').val();
		const ans=$("#ans_div").eq((_index)).find('#ans').val();
		const user_id=$("#user_id").val();
		const allData={question:question,answer:answer,ans:ans};
		console.log(allData);
		const faileData={user_id:user_id,question:question,answer:ans};
		if(answer!=ans)
		 {
			alert("정답이 아닙니다");
			console.log("faileData==",faileData);
			$("#answer_div").eq((_index)).find('#answer').focus();
			console.log("faileData===",faileData);
			$.ajax({
	    		url : "faile_insert.do",
	    		type : "post",
	    		data:faileData,
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
		
		else if(answer==ans) {
			alert("정답입니다");
			$("#content_div").eq((_index)).hide();
			$("#content_div").eq((_index + 1)).show();
			$("#answer_div").eq((_index + 1)).find('#answer').focus();
			console.log("question==",question);
			const all={question:question};
			$.ajax({
	    		url : "faile_delete.do",
	    		type : "get",
	    		data:all,
	    		dataType : "text",
	    	success : function(data){
					console.log("rrdata",data);
	    		},
	    		error : function(data) 
	    		{
	    			alert("실패");
	    			console.log("data==",data);
	    		},
    		 });
			location.reload();
		}
		
		var status=$("#status").val();
		console.log("status",status);
		
		if($("#status").val()==1)
		{
			alert("게임이 모두 끝났습니다");
			if (!confirm("다시 시작 하시겠습니까?")) {
				alert("취소 하셨습니다");
				location.href="${root}"
				}
			else {
				location.href="${root}quiz_main.do";
			} 
		}
	}
	
</script>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>
<body> 
<div class="container" style="margin-top:100px">
	<div class="card shadow">
		<div class="card-body" id="view">
			<h4 class="card-title"></h4>
		<table id="tbl1">
		<li>${fn:length(chk.fail_chk)} 문제 남았습니다</li>
		<li>${user_id }님 문제 입니다 </li>
		<c:forEach var="obj" items="${chk.fail_chk}" varStatus="status" >
		<div id="dis${status.index+1}" >
			
			<div class="form-group" id="content_div">
				<label for="question">문제</label>
				<textarea id="question" name="question" class="form-control" rows="30" maxlength='5000' style="resize:none" readonly="readonly">${obj.question }</textarea>
			</div>
			<div class="form-group" id="answer_div">
					<label for="answer">답</label>
					<input type="text" id="answer" name="answer" class="form-control" maxlength='150' />
			</div>
				<div class="form-group" id="ans_div">
				<input type="button" class='btn btn-primary' value="답제출"  id="chk"  onclick="chk(${status.index})" />
				<input type="hidden" name="ans" id="ans" value="${obj.answer}"/>
				</div>
		</div>
		</c:forEach>
		</table>
		<br>
		</div>
		<c:choose>
			<c:when test = "${fn:length(chk.fail_chk) eq 0}">
			<li>문제를 다 푸셨습니다</li> 
				<form action="${root}quiz_main.do">
				<input type="hidden" name="user_id" id="user_id" value="${user_id }"/>
				<input type="submit" value="처음 문제로 돌아가기"/>
				</form>
			</c:when>
		<c:otherwise>
			<form action="${root}quiz_faile.do">
				<input type="hidden" name="user_id" id="user_id" value="${user_id }"/>
				<input type="submit" value="틀린문제 다시 풀기"/>
			</form>
		</c:otherwise>
		</c:choose>
	</div>
</div>
</body>
</html>