<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var='root' value='${pageContext.request.contextPath}/'/>    
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-standalone/6.26.0/babel.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/babel-polyfill/6.26.0/polyfill.min.js"></script>

<title>글쓰기</title>
<style>
*{margin:0; padding:0;}
ul{list-style: none;}
a{color: inherit; text-decoration: none;}
#wrap{width:100%; height: 100%; display:flex; flex-direction:row;flex-wrap: wrap; justify-items:flex-start;  align-items : stretch}
img{max-width:100%;}
#nav{flex-basis: 20vw;flex-grow: 1; flex-shrink: 4; text-align:center;}
#nav ul li{line-height: 50px; font-weight:bold; font-size: 20px; }
.logoli{padding: 20px 0;}
.content{flex-basis: 20vw; height : 100vh; flex-grow: 4; flex-shrink: 1; overflow:auto;}

</style>
</head>
      <script type="text/javascript">				
      	function regit(){
          	var maxSize=1024*1024*10;
      		const title=$("#title").val();
       		const writer=$("#writer").val();
       		const content=$("#content").val();
       		const upload_1=$("#multi_1").val();
       		const upload_2=$("#multi_2").val();
       		const upload_3=$("#multi_3").val();
       		const upload_4=$("#multi_4").val();
       		const upload_5=$("#multi_5").val();
       		
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
       		
       		const gong='';
            if(writer==gong) {
            	alert("작성자를 입력해주세요")
        		}
           		 else if(title==gong)
            	{
            	alert("제목을 입력해 주세요")
            	}
          		  else if(content==gong)
            	{
            	alert("내용을 입력해 주세요")
            	}
            	else {
        			if (!confirm("글을 등록 하시겠습니까?")) {
    	    			alert("취소 하셨습니다");
    	    			}
        		   else {
        		const allData = new FormData(document.getElementById("allForm"));
        		for(var i=1;i<=5;i++) {	
    	    		var fileName = $("#multi_"+i+"").val();
    	    			files = fileName.slice(fileName.lastIndexOf(".") + 1).toLowerCase();
    	    			const FileExt=["png","jpg","gif","bmp","pdf","docx","xlsx","xls","pptx","ppt"];
    	    			if(files!="" && FileExt.indexOf(files)<0)
    	        		{
    			           		alert("이미지 파일은  형식에 맞지 않습니다.");
    			           		$("#multi_"+i+"").val("");
    			    			return false;
    	        		}
        		}
        		$.ajax ({
        	    		url : "pro_writeSuccess.do",
        	    		type : "post",
        	    		data:allData,
        	    		datatype: 'text',
    		    		processData: false,
    		    	    contentType: false,
        	    	success : function(data){
        	    		if(data.chk == "ERROR") {
        	    			alert(data.message);
        	    			$("#multi_"+data.ii+"").val("");
        	    		} else {
        	    			if(data.code == "OK") {
    	   					alert("등록성공");
    	   	    		    location.href="${root}pro_detail.do?board_idx="+data.boardIdx+"";
        	    			}    	    		
        	    			else if(data.code == "ERROR_FILE") {
        	    			alert(data.message)
        	    			}
	        	    			else {
	        	    			alert(data.message)
        	    				}
        	    	     }
       	    		},
       	    		error : function(data) 
       	    		{
       	    			  alert("용량초과");
      	    		}
    		  	   });
        		}
       		  } 
          	}
      	
      	var back=function() {		
          	location.href = '${root}procedure_list.do';
          	}
  
   </script>
<c:import url="/WEB-INF/views/include/top_menu.jsp"/>
<body>
<h2>생산 방안 글쓰기</h2>
<div class="container" style="margin-top:100px">
	<div class="row">
		<div class="col-sm-3"></div>
		<div class="col-sm-6">
			<div class="card shadow">
				<div class="card-body">
					<form  id="allForm"  name="allForm" method='post' accept=".gif, .jpg, .png .pdf .exe" accept-charset="UTF-8" enctype="multipart/form-data">
					<div class="form-group">
					<c:choose>
						<c:when test="${!empty mvo }">
							<label for="board_writer_name">작성자</label>
							<input type="text" id="writer" name="writer" class="form-control" maxlength='30'  value="${mvo.user_name }" readonly="readonly"/>
					<div class="form-group" id="title_l">
						<label for="title">제목</label>
						<input type="text" id="title" name="title" class="form-control" maxlength='150' value="" />
					</div>
					<div class="form-group" id="content_l">
						<label for="content">내용</label>
						<textarea id="content" name="content" class="form-control" rows="10" maxlength='2000' style="resize:none"></textarea>
					</div>
					
					
					<div class="form-group">
						<label for="upload_1">첨부파일</label>
						<input type="file" id="multi_1" name="multi_1" class="form-control" />
					</div>			
					<div class="form-group">
						<label for="upload_2">첨부파일2</label>
						<input type="file" id="multi_2" name="multi_2" class="form-control" value="" />
					</div>
					
					<div class="form-group">
						<label for="upload_3">첨부파일3</label>
						<input type="file" id="multi_3" name="multi_3" class="form-control" value="" />
					</div>
					
					<div class="form-group">
						<label for="upload_4">첨부파일4</label>
						<input type="file" id="multi_4" name="multi_4" class="form-control" value="" />
					</div>
					
					<div class="form-group">
						<label for="upload_5">첨부파일5</label>
						<input type="file" id="multi_5" name="multi_5" class="form-control" value="" />
					</div>
						</c:when>
					<c:otherwise>
						<label for="board_writer_name">작성자</label>
							<input type="text" id="writer" name="writer" class="form-control" maxlength='30'/>
						<div class="form-group" id="que_pw_l">
							<label for="content">비밀번호</label>
							<input type="password" id="gue_pw" name="gue_pw" class="form-control" maxlength='150' />
						</div>
						<div class="form-group" id="title_l">
							<label for="title">제목</label>
							<input type="text" id="title" name="title" class="form-control" maxlength='150' value="" />
						</div>
						<div class="form-group" id="content_l">
							<label for="content">내용</label>
							<textarea id="content" name="content" class="form-control" rows="10" maxlength='2000' style="resize:none"></textarea>
						</div>
						
						
						<div class="form-group">
							<label for="upload_1">첨부파일</label>
							<input type="file" id="multi_1" name="multi_1" class="form-control" />
						</div>			
						<div class="form-group">
							<label for="upload_2">첨부파일2</label>
							<input type="file" id="multi_2" name="multi_2" class="form-control" value="" />
						</div>
						
						<div class="form-group">
							<label for="upload_3">첨부파일3</label>
							<input type="file" id="multi_3" name="multi_3" class="form-control" value="" />
						</div>
						
						<div class="form-group">
							<label for="upload_4">첨부파일4</label>
							<input type="file" id="multi_4" name="multi_4" class="form-control" value="" />
						</div>
						
						<div class="form-group">
							<label for="upload_5">첨부파일5</label>
							<input type="file" id="multi_5" name="multi_5" class="form-control" value="" />
						</div>
						</c:otherwise>
						</c:choose>
					</div>
					
					<div class="form-group">
						<div class="text-right">
							<a href="${root}procedure_list.do" class="btn btn-primary">목록보기</a>
							<a href="javascript:regit();" class="btn btn-info">등록완료</a>
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