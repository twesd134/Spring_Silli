<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미니 프로젝트</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<script>
	var login=function() {
		const user_id=$("#user_id").val();
		const user_pw=$("#user_pw").val();
		const allData={user_id : user_id,user_pw : user_pw};
		console.log(allData);
		$.ajax({
    		url : "login.do",
    		type : "get",
    		datatype : "json",
    		data:allData,
    	success : function(data){
    			if(data.chk=="ERROR")
    			{
    				alert(data.message);
    			}
    			else if(data.chk=="overlap")
    			{
    				alert("회원이 존재하지 않습니다");
    			}
    			else {
    				alert(data.ok);
    				location.href="${root}"
    			}
    		},
    		error : function(data) 
    		{
   			alert("실패");
   			console.log(data);
    		},
    	  });
	}
	
	
</script>
<body>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>
<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<c:if test="${fail == true }">
					<div class="alert alert-danger">
						<h3>로그인 실패</h3>
						<p>아이디 비밀번호를 확인해주세요</p>
					</div>
					</c:if>
					<form method='post'>
						<div class="form-group">
							<label for="board_writer_name">아이디</label>
							<input type="text" id="user_id" name="user_id" class="form-control"/>
						</div>
						
						<div class="form-group">
							<label for="board_writer_name">비밀번호</label>
							<input type="password" id="user_pw" name="user_pw" class="form-control"/>
						</div>
						
						<div class="form-group text-right">
							<a href="javascript:login();"class='btn btn-primary' class="btn btn-danger">로그인</a>
							<a href="${root }joinForm.do" class="btn btn-danger">회원가입</a>
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