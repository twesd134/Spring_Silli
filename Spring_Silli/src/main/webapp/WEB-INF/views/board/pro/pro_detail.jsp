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
						<input type="text" id="writer" name="writer" class="form-control" value="${get_com.writer }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_date">작성날짜</label>
						<input type="text" id="reg_date" name="reg_date" class="form-control" value="${get_com.reg_date }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_subject">제목</label>
						<input type="text" id="title" name="title" class="form-control" value="${get_com.title }" disabled="disabled"/>
					</div>
					<div class="form-group">
						<label for="board_content">내용</label>
						<textarea id="content" name="content" class="form-control" rows="10" style="resize:none" disabled="disabled">${get_com.content }</textarea>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_1">1번파일 </label>
						<a href="${root}download.do?upload=${get_com.upload_1}">${get_com.upload_1}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_2">2번파일 </label>
						<a href="${root}download.do?upload=${get_com.upload_2}">${get_com.upload_2}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_3">3번파일 </label>
						<a href="${root}download.do?upload=${get_com.upload_3}">${get_com.upload_3}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_4">4번파일 </label>
						<a href="${root}download.do?upload=${get_com.upload_4}">${get_com.upload_4}</a>
					</div>
					
					<div class="form-group down_btn">
						<label for="upload_5">5번파일 </label>
						<a href="${root}download.do?upload=${get_com.upload_5}">${get_com.upload_5}</a>
					</div>
					<div class="form-group" id="pw_grid">
						
					</div>
					<input type="hidden" id="board_idx" name="board_idx" class="form-control" value="${get_com.board_idx}" />
					<div class="form-group">
						<div class="text-right">
							<a href="${root}procedure.do" class="btn btn-primary">목록보기</a>
					<c:choose>
						<c:when test="${empty user_id}">
					<input type="hidden" id="gue_pw" name="gue_pw" class="form-control" value="${get_com.gue_pw}" />
							<a href="javascript:com_update()" class="btn btn-info">수정하기</a>
						</c:when>
						<c:otherwise>
							<a href="javascript:com_user_update();" class="btn btn-info">수정하기(회원용)</a>
						</c:otherwise>
					</c:choose>
							<a href="javascript:del();" class="btn btn-danger">삭제하기</a>
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