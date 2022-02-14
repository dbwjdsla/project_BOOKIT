<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<jsp:include page="/WEB-INF/views/common/header.jsp"/>

	<!-- 등록 폼 시작 -->
    <div class="roberto-contact-form-area" data-wow-delay="100ms">

        <!-- 검색결과 -->
        <div class="container wow fadeInUp">
            <div class="row align-items-center mt-50">
                <div class="col-12 col-lg-12">
                    <h3>도서 상세 정보</h3>
                    <!-- Single Room Details Area -->
                    <div class="single-room-details-area mb-50">
                        <hr class="my-2">
                        <div class="title mt-40">
                            <h4>${book.title}</h4>
                        </div>
                        <div class="single-blog-post d-flex align-items-center mb-50">

                            <img src="${book.cover}" class="d-block w-40 mx-5" alt="" id="cover">
                            <div class="post-content mx-5">
                                <!-- booking Title -->
                                <!-- <h4>${book.title}</h4> -->
                                <p></p>
                                <!-- 분류 -->
                                <p id="categoryName"></p>
                                <!-- 저자, 출판사, 출판일 -->
                                <table class="table table-borderless table-sm">
                                    <tr>
                                        <td>분류</td>
                                        <td>${book.categoryName}</td>
                                    </tr>
                                    <tr>
                                        <td>저자</td>
                                        <td>${book.author}</td>
                                    </tr>
                                    <tr>
                                        <td>출판사</td>
                                        <td>${book.publisher}</td>
                                    </tr>
                                    <tr>
                                        <td>출판일</td>
                                        <td><fmt:formatDate value="${book.pubdate}" pattern="yyyy년 MM월"/></td>
                                    </tr>
                                    <tr>
                                        <td>ISBN</td>
                                        <td>${book.isbn13}</td>
                                    </tr>
                                    <tr>
                                        <td>쪽수</td>
                                        <td>${book.itemPage} 쪽</td>
                                    </tr>
                                </table>
                                
                            </div>
                        </div>
                        <h5>간략 소개</h5>
                        <p>${book.description}</p>
                        
                        <div class="review mt-100">
                            
                            <h3>별점 및 100자 평</h3>
                            <hr class="my-2">
                            <div class="col-lg-12 mt-30 mb-30">
                                <textarea class="form-control" id="content" name="content" aria-label="With textarea" rows="3" placeholder="100자 평을 남겨주세요 :-)" style="resize: none;"></textarea>
                                <div class="float-right mt-2">
                                    <span id="count">0</span><span>/100</span>
                                </div>
                                
                                <div class="col-12 mt-30 p-0">
                                    <button type="button" class="btn roberto-btn" id="enrollBtn" onclick="enrollBooking();">대여 글 등록</button>
                                </div>
                            </div>
                            <input type="hidden" name="isbn" value="">
                            <input name="${_csrf.parameterName}" type="hidden" value="${_csrf.token}"/>
                            
                            <div class="comment_area mt-50 clearfix">
                                <ol>
                                    <h2>리뷰</h2>
                                    <hr class="my-2">
                                    <!-- Single Comment Area -->
                                    <c:forEach var="review" items="${list}" varStatus="status">
                                        <li class="single_comment_area mt-30">
                                            <!-- Comment Content -->
                                            <div class="comment-content d-flex">
                                                <!-- Comment Author -->
                                                <div class="comment-author ml-40">
                                                    <!-- 수정필요 -->
                                                    <!-- <img src="${review.member.profileImage == null ? '${pageContext.request.contextPath}/resources/img/default_profile.png' : '${pageContext.request.contextPath}/resources/img/profile/${review.member.profileImage}'}" alt="author"> -->
                                                </div>
                                                <!-- Comment Meta -->
                                                <div class="comment-meta">
                                                    <a href="#" class="post-date"><fmt:formatDate value="${review.regDate}" pattern="yyyy년 MM월 dd일"/></a>
                                                    <h5>${review.member.nickname}(${review.member.id})</h5>
                                                    <p>${review.content}</p>
                                                </div>
                                            </div>
                                        </li>
                                    </c:forEach>
                                    <c:if test="${empty list}">
                                        <li class="single_comment_area mt-30">
                                            <h4>리뷰가 없습니다. 리뷰를 작성해보세요!</h4>
                                        </li>
                                    </c:if>
                                </ol>
                                <nav class="roberto-pagination wow fadeInUp mb-100" data-wow-delay="100ms">
                                    <ul class="pagination">
                                        <c:if test="${page.prev}"> 
                                            <li class="page-item"><a class="page-link" href="${page.startPage - 1}"> 이전 <i class="fa fa-angle-left"></i></a></li>
                                        </c:if>
                                        <c:forEach var="num" begin="${page.startPage }" end="${page.endPage }">
                                            <li class="page-item ${page.cri.pageNum == num ? 'active' : ''}"><a class="page-link" href="${num}">${num}</a></li>
                                        </c:forEach>
                                        <c:if test="${page.next}">
                                            <li class="page-item"><a class="page-link" href="${page.endPage + 1}"> 다음 <i class="fa fa-angle-right"></i></a></li>
                                        </c:if>
            
                                    </ul>
                                </nav>
                                <form id='actionForm' action="${pageContext.request.contextPath}/search/bookDetail.do" method="get"> 
                                    <input type="hidden" name="isbn" value="">  
                                    <input type="hidden" name="pageNum" value="${page.cri.pageNum}"> 
                                    <input type="hidden" name="amount" value="${page.cri.amount}"> 
                                </form>
                            </div>
                        </div>

                    </div>

                    
                </div>

                
            </div>
        </div>
    </div>

    <!-- Rooms Area End -->
<script>

    //글내용 글자갯수 제한 코드
    $(document).ready(function() {
        $('#content').on('keyup', function() {
            
            $('#count').html($(this).val().length);
            
            if($(this).val().length > 100) {
                alert("100자까지만 입력할 수 있습니다.");
                $(this).val($(this).val().substring(0, 100));
                $('#count').html("100");
            }
        });
    });

    var actionForm = $('#actionForm'); 
	$('.page-item a').on('click', function(e) { e.preventDefault(); 
		//걸어둔 링크로 이동하는 것을 일단 막음 
		actionForm.find('input[name="pageNum"]').val($(this).attr('href')); 

		const url = new URL(window.location.href);
		const urlParams = url.searchParams;

		const isbn = urlParams.get('isbn');

		$('input[name=isbn').attr('value', isbn);

		actionForm.submit(); 
	});







</script>
	

<!-- Partner Area End -->
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>