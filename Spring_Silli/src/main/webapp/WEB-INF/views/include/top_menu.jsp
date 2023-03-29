<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var='root' value="${pageContext.request.contextPath }/"/>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
 <title>전체목록</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.26.0/polyfill.min.js"></script>
</head>
<style>


#tm3 { position:absolute; top:0px; right:0px; background:#e9e9e9; border:1px solid#aaaaaa; padding:3px 10px 3px 10px; text-align:center; }
#tm3 .logged_ii { text-decoration:none;  color:#666666; font:.9em "돋움", Dotum, "굴림", Gulim, AppleGothic, Sans-serif; padding:0 5px 0 5px; }
#tm3 .logged_iid { color:#568666; font:.9em "돋움", Dotum, "굴림", Gulim, AppleGothic, Sans-serif; padding:0 5px 0 5px; }

.menu ::before{
    font-family: 'Material Icons';
    font-size: 1.5em;
    float: left;
    clear: left;
}
.menu label::before{ content: '\e5d2'; }

#expand-menu { /* 체크박스 폼 요소 감춤 */
    display: none;
}


.menu {
    display: block;
    width: 200px;
    background-color: #000;
    color: #fff;
    border-radius: 20px;
    padding: 10px;
    box-sizing: border-box;
    overflow: hidden; /* 반응형 애니메이션용 */
    transition: all 0.5s ease; /* 반응형 애니메이션 */
}
.menu ul {
    list-style: none;
    margin: 0;
    padding: 0;
}
.menu a, .menu > label {
    display: block;
    height: 25px;
    padding: 8px;
    cursor: pointer;
    color: #fff;
    text-decoration: none;
}
.menu a:hover {
    color: #000;
}
.menu ul li:hover, .menu > label:hover {
    background-color: #fff;
    color: #000;
    border-radius: 10px;
}
.menu div {
    line-height: 1.5;
    font-size: 1em;
    font-family: 'Noto Sans KR';
    padding: 0 0 0 50px; /* 아이콘과 텍스트 사이 여백 */
}
</style>
<script>

var logout=function (para) {
	console.log("파라미터 = ==",para);
	if(para == null || para=="")
	{
		alert("로그인이 되어 있지 않은 상태입니다");
	} 
	else  {
		console.log("rr",para);
	$.ajax({
		url : "logout.do",
		type : "get",
		data:para,
		dataType : "json",
	success : function(para){ 
		},
		error : function(para) 
		{
			alert("로그아웃 성공")
			location.href="${root}"
		},
	 });
	}
}

var quiz_main=function (user_id) {
	if(user_id!="")
	{
	location.href="${root}quiz_main.do";		
	}else {
		alert("회원 가입후 진행할수 있습니다");
		location.href="${root}loginForm.do";
	}
}

</script>
<body>
	<div class="menu">
		  	<div>메뉴얼목록</div>
		    <input type="checkbox" id="expand-menu" name="expand-menu">
		    <ul>
		    	<li><a href="${root}" class="item">홈으로</a></li>
		        <li><a href="${root}company_list.do" class="item">회사 소개관리</a></li>
		        <li><a href="${root}procedure_list.do" class="item">생산방안 관리</a></li>
		        <li><a href="javascript:quiz_main('${user_id}');" class="item">퀴즈게임</a></li>
		    </ul>
   	</div>
   	<div id="tm3">
			<c:choose>
			<c:when test="${!empty user_id}">
	   		<ul>
	   			<li>${user_id}님 반갑습니다</li>
			</ul>
			<a href="javascript:logout('${user_id}');" class="logged_ii">로그아웃</a>
			</c:when>
			<c:otherwise>
			<a href="loginForm.do" class="logged_ii">로그인</a>
			<a href="joinForm.do" class="logged_ii">회원가입</a>
			</c:otherwise>
			</c:choose>
 		</div>
	</body>
</html>