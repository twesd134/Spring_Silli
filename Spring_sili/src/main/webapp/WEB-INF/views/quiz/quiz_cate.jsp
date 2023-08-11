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
	   // 엔터 키를 눌렀을 때 답 제출 기능 추가
    $("input[name^='answer']").keydown(function (event) {
        if (event.keyCode === 13) { // 엔터 키의 keyCode는 13
            event.preventDefault(); // 기본 동작 막기
            submitAnswer($(this)); // 답 제출 함수 호출
        }
    });
});


function submitAnswer(inputElement) {
    var answer = inputElement.val();
    var quiz_idx = inputElement.closest(".form-group").find("input[name='quiz_idx']").val(); // 해당 문제의 quiz_idx 가져오기
    
    // 서버로 데이터를 전송하여 답을 제출하는 Ajax 로직 추가
    $.ajax({
        url: "${root}submit_answer.do", // 답을 제출하는 서버 API 주소
        type: "post",
        data: { quiz_idx: quiz_idx, answer: answer },
        dataType: "text",
        success: function (data) {
            alert("답이 제출되었습니다.");
        },
        error: function (data) {
            console.log("Error:", data);
            alert("답 제출에 실패했습니다.");
        },
    });
}

</script>
</head>
<script>
	
	var chk = function (_index) {
			
		const question=$("#content_div").eq((_index)).find('#question').val();
		const answer=$("#answer_div").eq((_index)).find('#answer').val();
		const ans=$("#ans_div").eq((_index)).find('#ans').val();
		const user_id=$("#user_id").val();
		const category=$("#category").val();
		const allData={question:question,answer:answer,ans:ans,category:category};
		const faileData={user_id:user_id,question:question,answer:ans,category:category};
		if(answer!=ans)
		 {
			alert("정답이 아닙니다");
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
			const all={question:question,answer:ans,category};
			console.log(all);
			$.ajax({
	    		url : "ans_insert.do",
	    		type : "post",
	    		data:all,
	    		dataType : "text",
	    	success : function(data){
					console.log("rrdata",data);
	    		},
	    		error : function(data) 
	    		{	
	    			console.log("data==",data);
	    		},
    		 });
			location.reload();
		}
		
		var status=$("#status").val();
		console.log("status",status);
		
		if($("#status").val()<=1)
		{
			alert("게임이 모두 끝났습니다");
			var all={category:category};
			$.ajax({
	    		url : "category_del.do",
	    		type : "post",
	    		data:all,
	    		dataType : "text",
	    	success : function(data){
					console.log("rrdata",data);
	    		},
	    		error : function(data) 
	    		{	
	    			console.log("data==",data);
	    		},
    		 });
			
			if (!confirm("다시 시작 하시겠습니까?")) {
				alert("취소 하셨습니다");
				location.href="${root}"
			}
			else {
				location.href="${root}quiz_cate.do?category="+category;
			}
		}
	}
	
	var enterkey=function () {
		if (window.event.keyCode == 13) {
			
		}
	}
	var quiz_write = function() {
		location.href="${root}quiz_write.do";
	}
	
	var quiz_del = function() {
		location.href="${root}quiz_del.do";
	}
	
	var quiz_list = function() {
		location.href="${root}quiz_list.do";
	}
	
	
	var cate_detail=function() {
		var category=$("#category").val();
		var all={category:category};
		console.log("all==",all);
		$.ajax({
    		url : "cate_detail.do",
    		type : "get",
    		data:all,
    		dataType :"json",
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
		<li>${fn:length(chk.cate)} 문제 남았습니다</li>
		<li>${user_id }님 문제 입니다 </li>
		<c:forEach var="obj" items="${chk.cate}" varStatus="status" >
		<div id="dis${status.index+1}" >
			
			<div class="form-group" id="content_div">
				<label for="question">문제</label>
				<textarea id="question" name="question" class="form-control" rows="30" maxlength='5000' style="resize:none" readonly="readonly">${obj.question }</textarea>
			</div>
			<div class="form-group" id="answer_div">
					<label for="answer">답</label>
					<input type="text" id="answer" name="answer" class="form-control" maxlength='150' />
					<input type="hidden" id="category" name="category" class="form-control" maxlength='150' value="${obj.category }">
			</div>
				<div class="form-group" id="ans_div">
				<input type="button" class='btn btn-primary' value="답제출"  id="chk" onkeyup="enterkey()"  onclick="chk(${status.index})" />
				<input type="hidden" name="ans" id="ans" value="${obj.answer}"/>
				</div>
		</div>
		</c:forEach>
		</table>
		<br>
		</div>
		<form action="${root}quiz_faile.do">
			<input type="hidden" name="status" id="status" value="${fn:length(chk.cate)}"/>
			<input type="hidden" name="user_id" id="user_id" value="${user_id}"/>
			<input type="submit"class='btn btn-dange' value="틀린문제 다시 풀기"/>
		</form>
			<input type="button" onclick="quiz_write();" class="btn btn-dange" value="문제추가하기">
			<input type="button" onclick="window.location.href='${root}cate_detail.do?category=${cate}'" class="btn" value="문제목록">
	</div>
</div>
</body>
</html>