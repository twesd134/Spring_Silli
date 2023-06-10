<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<c:set var="root" value="${pageContext.request.contextPath }/"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>상세화면</title>
<!-- Bootstrap CDN -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/css/bootstrap.min.css">
 	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
 	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.26.0/polyfill.min.js"></script>
</head>
<script>

	var del=function() {
		var listHTML="";
		listHTML+="<label for='content'>등록비밀번호 입력(방문자전용)</label>";	
		listHTML+="<input type='password' id='gue_chk' name='gue_chk' class='form-control' maxlength='150'/>";
		const gue_chk=$("#gue_chk").val();
		const gue_pw=$("#gue_pw").val();
		$("#pw_grid").html(listHTML);
		if(gue_pw==gue_chk)
		{
		if (!confirm("삭제하시겠습니까?")) {
			alert("취소 하셨습니다");
			}
			const board_idx=$("#board_idx").val();
		 	const all= {"board_idx": board_idx };
				$.ajax({
		    		url : "pro_delete.do",
		    		type : "get",
		    		data:all,
		    		success : function(data){
					alert("삭제성공");
	    		    location.href="${root}procedure_list.do";						
	    			},
	    		  error : function(data) 
	    		   {
	    			  alert("실패");
	    			  console.log("data==",data);
	    			}
	    	 	});
			} else if(gue_pw!=gue_chk && gue_chk !=null && gue_chk !="")
			{
			alert("비밀번호가 틀립니다");
			}
		}
	
	var pro_update=function() {
		var listHTML="";
		listHTML+="<label for='content'>등록비밀번호 입력(방문자전용)</label>";	
		listHTML+="<input type='password' id='gue_chk' name='gue_chk' class='form-control' maxlength='150'/>";
		const gue_chk=$("#gue_chk").val();
		const gue_pw=$("#gue_pw").val();
		$("#pw_grid").html(listHTML);
		const board_idx=$("#board_idx").val();
		const all={board_idx:board_idx};
		if(gue_pw==gue_chk)
			{
		 $.ajax({
    		url : "pro_update.do",
    		type : "post",
    		data:all,
    		success : function(data){
			alert("수정페이지 진입");
			location.href="${root}pro_update.do?board_idx="+board_idx
			},
		  error : function(data) 
		   {
			  alert("실패");
			  console.log("data==",data);
			}
			}); 
		} else if(gue_pw!=gue_chk && gue_chk !=null && gue_chk !="")
			{
			alert("비밀번호가 틀립니다");
			}
		console.log(gue_chk);
	 	console.log(gue_pw);
	}
	
	var pro_user_update=function () {
		const board_idx=$("#board_idx").val();
		const all={board_idx:board_idx};
		$.ajax({
	    		url : "pro_update.do",
	    		type : "post",
	    		data:all,
    		success : function(data){
				alert("수정페이지 진입");
				location.href="${root}pro_update.do?board_idx="+board_idx
				},
			  error : function(data) 
			   {
				  alert("실패");
				  console.log("data==",data);
			   }
		}); 		
		
	}
	
	var re_regit=function() {
		
		const board_idx=$("#board_idx").val();
		const re_user_id=$("#user_id").val();
		const re_con=$("#re_con").val();
		const all={re_user_id:re_user_id,re_con:re_con,board_idx:board_idx};
		console.log("dd==",all);
		if(re_user_id=="" || user_id==null)
		{
			alert("로그인해주세요");	
		}
		else if(re_con=="" || re_con==null)
		{
			alert("내용을 입력해주세요");
		}
		else { 
			if (!confirm("글을 등록 하시겠습니까?")) {
	    		alert("취소 하셨습니다");
	    		 }
			else{
				$.ajax({
		    		url : "re_write.do",
		    		type : "post",
		    		data:all,
				success : function(data){
					alert("답글 등록 완료 ");
					location.href="${root}pro_detail.do?board_idx="+board_idx
					},
				  error : function(data) 
				   {
					  alert("실패");
					  console.log("data==",data);
				   }
				});
			 }
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
					<div class="form-group">
						<label for="board_writer_name">작성자</label>
						<input type="text" id="writer" name="writer" class="form-control" value="${get_detail.writer }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_date">작성날짜</label>
						<input type="text" id="reg_date" name="reg_date" class="form-control" value="${get_detail.reg_date }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" id="title" name="title" class="form-control" value="${get_detail.title }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="content" name="content" class="form-control" rows="10" style="resize:none" disabled="disabled">${get_detail.content }</textarea>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_1">1번파일 </label>
						<a href="${root}download.do?upload=${get_detail.upload_1}">${get_detail.upload_1}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_2">2번파일 </label>
						<a href="${root}download.do?upload=${get_detail.upload_2}">${get_detail.upload_2}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_3">3번파일 </label>
						<a href="${root}download.do?upload=${get_detail.upload_3}">${get_detail.upload_3}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_4">4번파일 </label>
						<a href="${root}download.do?upload=${get_detail.upload_4}">${get_detail.upload_4}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_5">5번파일 </label>
						<a href="${root}download.do?upload=${get_detail.upload_5}">${get_detail.upload_5}</a>
					</div>
					<div class="form-group" id="pw_grid">
						
					</div>
					<input type="hidden" id="board_idx" name="board_idx" class="form-control" value="${get_detail.board_idx}" />
					<div class="form-group">
						<div class="text-right">
							<a href="${root}company_list.do" class="btn btn-primary">목록보기</a>
					<c:choose>
						<c:when test="${user_id eq get_detail.writer}">
							<a href="javascript:pro_user_update();" class="btn btn-info">수정하기(회원용)</a>
						</c:when>
						
						<c:otherwise>
							
						</c:otherwise>					
					</c:choose>
							<a href="javascript:del();" class="btn btn-danger">삭제하기</a>
						</div>
					</div>
				</div>
			<div class="form-group">
			<div>댓글쓰기</div>
			<div class="text-right"><a href="javascript:re_regit();" class="btn btn-primary">댓글등록</a></div>
			<form id="allForm"  name="allForm" method='post' accept-charset="UTF-8" enctype="multipart/form-data">
			<c:choose>
				<c:when test="${empty user_id}">
					<textarea id="re_con" name="re_con" class="form-control" placeholder="로그인후에 이용 가능 합니다" rows="5" style="resize:none" disabled="disabled"></textarea>
				</c:when>
				<c:otherwise>
					<textarea id="re_con" name="re_con" class="form-control" rows="5" style="resize:none"></textarea>
				</c:otherwise>
			</c:choose>
			<input type="hidden" id="user_id" name="user_id" value="${user_id}"/>
			</form>
			<div class="card shadow">
				<div class="card-body">
			<c:forEach var='obj' items="${re_list}"> 
					<div class="form-group">
						<label class="form-control" readonly >댓글 작성자 : ${obj.re_user_id}</label>
						<label> ${obj.re_con}</label>
					</div>
			 </c:forEach>
				</div>
			 </div>
		   </div>
			</div>
		</div>
		<div class="col-sm-3"></div>
	</div>
</div>
</body>
</html>