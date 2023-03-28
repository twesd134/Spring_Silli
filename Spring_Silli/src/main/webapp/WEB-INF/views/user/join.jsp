<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>미니 프로젝트</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<script>
	function checkUserIdExist() {
		
		var user_id = $("#user_id").val();
		const allData={user_id:user_id};
		console.log("allData",allData);
		$.ajax({
			url : "checkUserIdExist",
    		datatype : "json",
    		data:allData,
   		 success : function(data){
				if(data==0){
					alert('사용할 수 있는 아이디입니다');
				} else {
					alert('사용할 수 없는 아이디 입니다')
				}					
    		},						
		  	error : function(data) {
    			  alert("실패");
    			  console.log("data==",data);
    		}
       });
    }
	
	var enroll=function() {
		var user_id = $("#user_id").val();
		var user_name=$("#user_name").val();
		var user_pw = $("#user_pw").val();
		var user_pw2= $("#user_pw2").val();
		console.log(user_id);
		const allData={
				user_id:user_id
				,user_pw:user_pw
				,user_name:user_name
				}
		console.log("Alldata",allData);
		if(user_pw != user_pw2)
		{
			alert("비밀번호가 같지 않습니다");
			return false;
		} else {
			$.ajax({
				url : "join.do",
	    		datatype : "text",
	    		data:allData,
	   		 success : function(data){
					if(data.chk == "ERROR") {
						alert(data.message);
					} else {
						alert(data.success);
						location.href="${root}"
					}
	    		},
			  	error : function(data) {
	    			  alert("실패");
	    			  console.log("data==",data);
	    		}
	       });
		} 
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
					<form  method='post' >
						<div class="form-group">
							<label for="user_name">이름</label>
							<input type="text" id="user_name" class='form-control'/>
						</div>
						<div class="form-group">
							<label for="user_id">아이디</label>
							<div class="input-group">
								<input type="text" id="user_id" class='form-control' onkeypress=""/>
								<div class="input-group-append">
									<input type="button" class="btn btn-primary" onclick='checkUserIdExist()' value="중복확인"/>
								</div>
							</div>
						</div>
						
						<div class="form-group">
							<label for="user_pw">비밀번호</label>
							<input type="password" id="user_pw" class='form-control'/>
						</div>
						
						
						<div class="form-group">
							<label for="user_pw2">비밀번호 확인</label>
							<input type="password" id="user_pw2" class='form-control'/>
						</div>
						
						<div class="form-group">
							<div class="text-right">
								<input type="button" class="btn btn-primary" onclick='enroll()' value="회원가입"/>
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
