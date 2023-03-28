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
<title>과제</title>
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
</head>
<body>
<script>
$(document).ready(function(){
	document.getElementById('now_date').valueAsDate = new Date();
	var result='${result}'; 
	checkModal(result); 
	//페이지 번호 클릭시 이동 하기
	var pageFrm=$("#pageFrm");
	$(".paginate_button a").on("click", function(e){
		e.preventDefault(); // a tag의 기능을 막는 부분
		var page=$(this).attr("href"); // 페이지번호
		pageFrm.find("#pagenm").val(page);
		pageFrm.submit(); // /sp08/board/list   		
	});    	
	// 상세보기 클릭시 이동 하기
	$(".move").on("click", function(e){
		e.preventDefault(); // a tag의 기능을 막는 부분
		var idx=$(this).attr("href");
		var tag="<input type='hidden' name='idx' value='"+idx+"'/>";
		pageFrm.append(tag);
		pageFrm.attr("action","${root}/company_list.do");
		pageFrm.submit();
	});	
 });

</script>
<script>
		const search=function(pageNo) {
		const start=$("#start").val();
		const now_date=$("#now_date").val();
		const keyword=$("#keyword").val();
		
		const allData ={start:start,now_date:now_date,keyword:keyword,"page":pageNo};
		if(start=="") {
			alert("시작일을 선택해 주세요");
		}
		else if(now_date=="") {
			alert("종료일을 선택해 주세요")
		}
		else {
		if(keyword=="") {
			alert("검색어를 입력해주세요")
			}
		else {
			console.log("allData===",allData);
			$.ajax({
	    		url : "company_list.do",
	    		type : "post",
	    		data:allData,
	    		dataType : "json",
	    	success : function(data){ 
				view(data);
	    		},
	    		error : function(data) 
	    		{
	    			console.log("data==",data);
	    			alert("실패");
	    		},
    		 });
			}
	      }
		}
		
	function delete_select_com(){
		var board_idx = [];
		$("input[name='board_idx']:checked").each(function(i) {
			board_idx.push($(this).val());
 	    });
		
		var allData={"board_idx" : board_idx};
		if(board_idx==0)
		{
			alert("글을 선택해 주세요");	
		}
		else{
		$.ajax({
    		url : "delete_select_com.do",
    		type : "get",
    		data:allData,
    	success : function(data){
   			alert("선택영역 삭제 성공");
   		    location.href="${root}company_list.do"; 		
    		},
    		error : function(data) 
    		{
   			alert("실패");
    		},
    	  })};
	     } 
	
	function view(data) {
		
		var listHTML="";
		var countHTML="";
		var pageHTML="";
		var next=(data.pageMaker.endPage)+1;
		var prev=(data.pageMaker.endPage)-1;
		var last=data.pageMaker.lastPage;
		
		if(data.totalCount == 0)
		{
		listHTML+="<tr>";
		listHTML+="<td class='text-center d-none d-md-table-cell' colspan='6'>게시글이 없습니다.</td> ";
		listHTML+="</tr>";
		}
		else {
		countHTML+="<td>Total "+data.totalCount+"</td>";
		$.each(data.com_list, function(index,obj){
			listHTML+="<tr>";
			listHTML+="<td class='text-center d-none d-md-table-cell'>";
			listHTML+="<input type='checkbox' value="+obj.board_idx+" name='board_idx'></td>";
			listHTML+="<td class='text-center d-none d-md-table-cell'>"+obj.board_idx+"</td>";
			listHTML+="<td class='text-center d-none d-md-table-cell'><a href='${root}com_detail.do?board_idx="+obj.board_idx+"'>"+obj.title+"</a></td>";
			listHTML+="<td class='text-center d-none d-md-table-cell'>"+obj.writer+"</td>";
			listHTML+="<td class='text-center d-none d-md-table-cell'>"+obj.reg_date+"</td>";
			listHTML+="</tr>";
		})};
		/*Page Start*/
		pageHTML+=" <ul class='pagination'>";
		if(data.pageMaker.prev)
			{
			pageHTML+="<li class=\"paginate_button previous\">";
			pageHTML+="<a href=\"javascript:search(1)\">◀◀      </a>";
			pageHTML+="<a href=\"javascript:search("+prev+")\">◀ </a></li>";
			}
		for(var i=data.pageMaker.startPage; i<=data.pageMaker.endPage;i++)
		{
			if(data.pageMaker.cri.page==i)
			{
	 		pageHTML+="<li class='paginate_button "+data.pageMaker.cri.page+"=="+i+"? active :''><a href=javascript:search("+i+")>"+i+"</a></li>";

			}else{
		 		pageHTML+="<li class='paginate_button "+data.pageMaker.cri.page+"=="+i+"'><a href=javascript:search("+i+")>"+i+"</a></li>";
			}
		}
		if(data.pageMaker.next)
			{
			pageHTML+="<li class=\"paginate_button next\">";
			pageHTML+="<a href=\"javascript:search("+next+")\"> ▶</a>";
			pageHTML+="<a href=\"javascript:search("+data.pageMaker.lastPage+")\">▶▶</a></li>";
			}
			pageHTML+="</ul>";
			pageHTML+="</div>";
			$("#board_list tbody").html(listHTML);
			$("#tcount").html(countHTML);
			$("#pagenm").html(pageHTML);
		}
	
		function move() {
			var board_idx = [];
			$("input[name='board_idx']:checked").each(function(i) {
				board_idx.push($(this).val());
	 	    });
			if(board_idx!=0)
			{
				alert("게시물 선택을 해제해주세요");	
			}else{
				location.href="${root}com_write.do"
			}	
		} 
		
		function selectAll(selectAll)  {
			  const checkboxes 
			       = document.getElementsByName('board_idx');
			  
			  checkboxes.forEach((checkbox) => { 
			    checkbox.checked = selectAll.checked;
			  })
		}

</script>

<c:import url="/WEB-INF/views/include/top_menu.jsp"/>

<!-- 게시글 리스트 -->
<div class="container" style="margin-top:100px">
<h2>회사소개 게시판</h2>
<form  id="allForm"  name="allForm" method='post' accept=".gif, .jpg, .png .pdf" accept-charset="UTF-8" enctype="multipart/form-data">
<label for="start">게시일:</label>
<input type="date" id="start" name="start" value="">  ~ 
	<input type="date" id="now_date" name="now_date">
	  <input type="text" placeholder="타이틀을 입력해주세요"  name="keyword" id="keyword" />
		<input type="button" value="검색"  onclick="search(1);" />
			</form>
	 	<div class="card shadow">
			<div class="card-body" id="view">
				<h4 class="card-title"></h4>
					<table class="table table-hover" id='board_list'>
				<thead>
					<tr id="tcount">
						<td>Total ${com_list.totalCount}</td>
					</tr>
					<tr>
						<th class="text-center d-none d-md-table-cell">글 전체선택 &nbsp;&nbsp;
						<input type='checkbox' name="board_idx" value="${obj.board_idx }" onclick="selectAll(this)" class="text-center d-none d-md-table-cell"/></th>
						<th class="text-center d-none d-md-table-cell">글번호</th>
						<th class="text-center d-none d-md-table-cell">제목</th>
						<th class="text-center d-none d-md-table-cell">작성자</th>
						<th class="text-center d-none d-md-table-cell">등록일</th>
					</tr>
				</thead>
				<tbody>
					<c:if test = "${fn:length(com_list.com_list) eq 0}">
					<td colspan="6">게시글이 없습니다.</td> 
					</c:if>
 					<c:forEach var='obj' items="${com_list.com_list}"> 
				   <tr>
						<td class="text-center d-none d-md-table-cell">
						<input type="checkbox" id="board_idx" name="board_idx" value="${obj.board_idx }"/></td>
						<td class="text-center d-none d-md-table-cell">${obj.board_idx}</td>
						<td class="text-center d-none d-md-table-cell"><a href="${root}com_detail.do?board_idx=${obj.board_idx}">${obj.title}</a></td>
						<td class="text-center d-none d-md-table-cell">${obj.writer}</td>
						<td class="text-center d-none d-md-table-cell">${obj.reg_date}</td>
					</tr>
					</c:forEach>
				</tbody>
			</table>
	 	<div class="d-none d-md-block" style="text-align: center" id="pagenm">
			<ul class="pagination justify-content-center pagination">
				<!-- 페이징 START -->
     	 <!-- 이전처리 -->
    	<c:if test="${com_list.pageMaker.prev}">
        <li class="paginate_button previous">
          <a href="${root}company_list.do?page=1">◀◀</a>
          <a href="${root}company_list.do?page=${com_list.pageMaker.startPage-1}">◀</a>
        </li>
      </c:if>      
      <!-- 페이지번호 처리 -->
          <c:forEach var="pageNum" begin="${com_list.pageMaker.startPage}" end="${com_list.pageMaker.endPage}">
	         <li class="paginate_button ${com_list.pageMaker.cri.page==pageNum ? 'active' : ''}"><a href="${root}company_list.do?page=${pageNum}">${pageNum}　</a></li>
	      </c:forEach>
	 <!-- 다음처리 -->
      <c:if test="${com_list.pageMaker.next}">
        <li class="paginate_button next">
          <a href="${root}company_list.do?page=${com_list.pageMaker.endPage+1}">▶</a>
          <a href="${root}company_list.do?page=${com_list.pageMaker.lastPage}">▶▶</a>
        </li>
      </c:if> 
		</ul>
      </div> 
      <!-- END -->
	</div>
     	 <form id="pageFrm" action="${root}company_list?page" method="post">
         <!-- 게시물 번호(idx)추가 -->         
         <input type="hidden" id="page" name="page" value="${pageMaker.cri.page}"/>
         <input type="hidden" id="perPageNum" name="perPageNum" value="${pageMaker.cri.perPageNum}"/>
      	</form>   
      		<div class="text-left">
				<a href="javascript:delete_select_com()" class="btn btn-primary">선택된글 삭제</a>
			</div>
			<div class="text-right">
				<button type="button" onclick="move();" class="btn btn-primary">글쓰기</button>
			</div>
		</div>
	</div>
</body>
</html>
