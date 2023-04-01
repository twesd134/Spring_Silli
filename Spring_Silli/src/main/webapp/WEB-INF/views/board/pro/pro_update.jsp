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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js"></script>
</head>
<script>

	const reset=function(){
		
		
	var titleGird="";
	titleGird+="<label for='board_subject'>제목</label>";
	titleGird+="<input type='text' id='title' name='title' class='form-control' value='${get_com.title }' /";
	titleGird+="</div>";
	
	var contentGrid="";
	contentGrid+="<label for='board_content'>내용</label>";
	contentGrid+="<textarea id='content' name='content' class='form-control' rows='10' style='resize:none'>${get_com.content }</textarea>";
	contentGrid+="</div>"
	$("#title_l").html(titleGird);
	$("#content_l").html(contentGrid);	
	}
	const edit=function(){
		var maxSize=1024*1024*10;
		const title=$("#title").val();
		const writer=$("#writer").val();
		const content=$("#content").val();
		const alldata=$("#all").serialize();
		
		var con=[];
		 for(var ii=1;ii<=5;ii++) {
			var mul = document.getElementById("multi_"+ii);
   			if(mul.value != "") {
   				const upload_size_ii = mul.files[0].size;
       				if(upload_size_ii<=maxSize)
       				{
       				con.push(upload_size_ii);
       				} 
       				else {
   					alert(ii+"번 파일 10m 이하만 첨부가능 합니다");
   					$("#multi_"+ii+"").val('');
   					return false;
   					}
   				}
			} 
		 
		const gong="";
			
		if (!confirm("수정하시겠습니까?")) {
					alert("취소 하셨습니다");
		}
		else {
				const allData = new FormData(document.getElementById("allForm"));
				for(var i=1;i<=5;i++) {	
		    		var fileName = $("#multi_"+i+"").val();
		    			fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
		        		if(fileName!="")
		        		{
		        		
		        			const FileExt=["png","jpg","gif","bmp","pdf","docx","xlsx","xls","pptx","ppt","exe"];
	 	        			if(fileName != "" && FileExt.indexOf(fileName)<0)
				        		{
				           		alert("이미지 파일은  형식에 맞지 않습니다.");
				           		$("#multi_"+i+"").val("");
				    			return false;
				           		}
		        		}
	    	     }
			 	$.ajax({
		    		url : "pro_updatesucess.do",
		    		type : "post",
		    		processData: false,
		    	    contentType: false,
		    		data:allData,
			    	success : function(data){
			    			if(data.chk == "ERROR") {
	    	    				alert(data.message);
	    	    				$("#multi_"+data.ii+"").val("");
	    	    			} else {
			    				if(data.code == "OK") {
			   					alert("수정성공");
			   	    		    location.href="${root}pro_detail.do?board_idx="+data.boardIdx+"";
		    	    			}
			    				
			    				else if(data.code == "ERROR_FILE") {
		    	    				alert(data.message);
			    				}
			    					else {
		    	    				alert(data.message);
			    					}
	    	    		    }
			    		},
		    		error : function(data) {
		    			  alert("실패");
		    		}
	    	   	 });
			  }
		   }
		
		const list_back=function() {
				alert("취소되었습니다");
				location.href="${root}procedure_list.do";
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
					<form  id="allForm"  name="allForm" method='post' accept=".gif, .jpg, .png .pdf .exe .html" accept-charset="UTF-8" enctype="multipart/form-data">
					<div class="form-group">
						<label for="board_writer_name">작성자</label>
						<input type="text" id="writer" name="writer" class="form-control" value="${get_com.writer }(작성자는 수정 불가능)" disabled="disabled"/>
					</div>
					<div class="form-group" id="title_l">
						<label for="title">제목</label>
						<input type="text" id="title" name="title" class="form-control" value="${get_com.title }" />
					</div>
					<div class="form-group" id="content_l">
						<label for="content">내용</label>
						<textarea id="content" name="content" class="form-control" rows="10" style="resize:none">${get_com.content }</textarea>
					</div>
					
					<div class="form-group">
						<label for="upload_1">첨부파일</label>
						${get_com.upload_1 }
						<input type="file" id="multi_1" name="multi_1" class="form-control" />
					</div>
					
					<div class="form-group">
						<label for="upload_2">첨부파일2</label>
						${get_com.upload_2 }
						<input type="file" id="multi_2" name="multi_2" class="form-control" value="${get_com.upload_2 }" />
					</div>
					
					<div class="form-group">
						<label for="upload_3">첨부파일3</label>
						${get_com.upload_3 }
						<input type="file" id="multi_3" name="multi_3" class="form-control" value="${get_com.upload_3 }" />
					</div>
					
					<div class="form-group">
						<label for="upload_4">첨부파일4</label>
						${get_com.upload_4 }
						<input type="file" id="multi_4" name="multi_4" class="form-control" value="${get_com.upload_4 }" />
					</div>
					
					<div class="form-group">
						<label for="upload_5">첨부파일5</label>
						${get_com.upload_5 }
						<input type="file" id="multi_5" name="multi_5" class="form-control" value="${get_com.upload_5 }" />
					</div>
					
					<input type="hidden" name="board_idx" class="form-control" value="${get_com.board_idx}" />
					
					</form>
					<div class="form-group">
						<div class="text-right">
							<input type="button" class="btn btn-primary" onclick="list_back();" value="취소하기"/>
							<a href="javascript:edit();" class="btn btn-info">수정완료</a>
							<input type="button" class="btn btn-danger" onclick="reset()" value="초기화"/>
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