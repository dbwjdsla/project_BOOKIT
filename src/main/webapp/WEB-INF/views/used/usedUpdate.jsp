<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/used.css"/>
<script>
function goUsedList(){
	location.href = "${pageContext.request.contextPath}/board/used.do";
}
function boardValidate(){
	var $content = $("[name=content]");
	if(/^(.|\n)+$/.test($content.val()) == false){
		alert("내용을 입력하세요");
		return false;
	}
	return true;
}

$(() => {
	$("[name=upFile]").change((e) => {
		const file = $(e.target).prop('files')[0];
		const $label = $(e.target).next();
		
		if(file != undefined)
			$label.html(file.name);
		else
			$label.html("파일을 선택하세요.");
	});
});
</script>
<div class="container">
  <form 		
  		name="communityFrm" 
		action="${pageContext.request.contextPath}/board/usedEnroll?${_csrf.parameterName}=${_csrf.token}" 
		method="post"
		enctype="multipart/form-data" 
		onsubmit="return boardValidate();">
     <div class="row" >
       	<h2 >글 쓰기</h2>
       <div class="buttons" style="margin-left: 70%;">
      <input type="submit" value="등록" >
      <input type="button" id="cancel" value="취소" onclick="goUsedList();">
    </div>
    </div>
        <input type="text" id="title" name="title" placeholder="제목">
        
        <select id="category" name="category">
          <option value="sell">팝니다</option>
          <option value="buy">삽니다</option>
        </select>
        
        <div class="select">
        <div class="price">
         <label for="price">판매 가격</label>
        <input type="text" id="price" name="price" placeholder="가격을 입력해주세요">
         </div>
         
         <div class="trade-method">
          <label for="method">거래 방법: </label>
          <input type="checkbox" id="direct" name="method" checked>
  		  <label for="direct">직거래</label>
  		  <input type="checkbox" id="post" name="method" checked>
  		  <label for="post">택배</label>
        </div>
        
        <div class="book-state">
        <label for="method">책 상태 : </label>
  		<input type="radio" id="A" name="book-state" value="A" checked>
  		<label for="A">최상</label>
  		<input type="radio" id="B" name="book-state" value="B" checked>
  		<label for="B">상</label>
  		<input type="radio" id="C" name="book-state" value="C" checked>
  		<label for="C">중</label>
  		<input type="radio" id="D" name="book-state" value="D" checked>
  		<label for="D">하</label>
		</div>
		</div>
        
           <div class="input-group mb-3" style="padding:0px;" >
		  <div class="input-group-prepend" style="padding:0px;">
		    <span class="input-group-text">첨부파일</span>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		  <div class="custom-file">
		    <input type="file" class="custom-file-input" name="upFile" id="upFile1" multiple>
		    <label class="custom-file-label" for="upFile1">파일을 선택하세요</label>
		  </div>
		</div>
        <textarea id="content" name="content" placeholder="내용" style="height:250px"></textarea>
  </form>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>