<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<% pageContext.setAttribute("replaceChar", "\n"); %>

<sec:authentication property="principal" var="principal" />
<fmt:parseNumber var="myHompyId" integerOnly="true" 
                       type="number" value="${principal.hompyId}" />

<c:choose>
	<c:when test="${miniHompy.hompyId == myHompyId}">
		<c:set var="isAuthenticated" value="1"/>
	</c:when>
	<c:otherwise>
		<c:set var="isAuthenticated" value="0"/>
	</c:otherwise>
</c:choose>


<c:set var="isIlchon" value="0"/>
<c:forEach items="${ilchonList}" var="ilchon" varStatus="vs">
<c:if test="${ilchon.status > 0}">
	<c:choose>
		<c:when test="${ilchon.hompyId1 == miniHompy.hompyId}">
			<c:set var="isIlchon" value="1"/>
			<c:set var="ilchonNo" value="${ilchon.no}"/>
		</c:when>
		<c:when test="${ilchon.hompyId2 == miniHompy.hompyId}">
			<c:set var="isIlchon" value="1"/>
			<c:set var="ilchonNo" value="${ilchon.no}"/>
		</c:when>
	</c:choose>
</c:if>
</c:forEach>



<jsp:include page="/WEB-INF/views/minihompy/common.jsp">
	<jsp:param value='${miniHompy.memberId}님의 미니홈피' name="title"/>
</jsp:include>


            <div class="box content-box">
         		<!-- 스크롤 박스 시작 -->
             	<div class="picture-scrollbox <c:if test="${(miniHompy.picture == 2 && isIlchon == 0  && isAuthenticated != 1) || (miniHompy.picture == 3 && isAuthenticated == 0)}">d-none</c:if>">
            
   	            <div class="picture-button-div">
   	            <div class="card privacy-info-tab <c:if test="${isAuthenticated != 1}">d-none</c:if>">
						게시물 공개 :&nbsp;
						<c:choose>
							<c:when test="${miniHompy.picture == 1}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">전체공개</span>
							</c:when>
							<c:when test="${miniHompy.picture == 2}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">일촌공개</span>
							</c:when>
							<c:when test="${miniHompy.picture == 3}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">비공개</span>
							</c:when>
							<c:when test="${miniHompy.picture == 0}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">메뉴 비공개</span>
							</c:when>
						</c:choose>
				</div>
	            <c:if test="${isAuthenticated == 1}">       
	              <button  class="picture-button" onclick="popupPictureFrm(${myHompyId})">작성하기</button>
	 			</c:if> 
	            </div>
                <div class="content-photo picture-List">
<%--             		<c:if test="${empty pictureList}">
						<div style="text-align: center; margin: 30% 0 auto; color: #999;">
							사진첩 게시물이 없습니다.
						</div>
					</c:if>	 --%>
            		
           			<c:forEach items="${pictureList}" var="picture" varStatus="vs">
           			<c:if test="${picture.status > 0}">
           			
           			<!-- 사진 게시물 영역 시작 -->
        		    <div class="photo-container">
		                <div class="photo-title font-neo">${picture.title}
	   					 	<c:if test="${isAuthenticated == 1}">
						 		<button type="submit" class="btn-close picture-remove" aria-label="Close" data-no="${picture.no}" style="float:right;"></button> 
						 	</c:if>
						</div>
			                <div class="photo-created-at">작성일 : 
				    			<fmt:parseDate value="${picture.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
								<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd HH:mm"/></div>
					 	
		                <div class="photo-image">
							<div id="picture-${picture.no}" class="carousel slide" data-bs-ride="true">
							
								<div class="carousel-indicators">
  					 		<c:if test="${picture.attachCount > 1}">
								    <button type="button" data-bs-target="#picture-${picture.no}" data-bs-slide-to="0"  class="active" aria-current="true" aria-label="Slide 1" ></button>
								    <button type="button" data-bs-target="#picture-${picture.no}" data-bs-slide-to="1" aria-label="Slide 2"></button>
							</c:if>
							<c:if test="${picture.attachCount > 2}">
								    <button type="button" data-bs-target="#picture-${picture.no}" data-bs-slide-to="2" aria-label="Slide 3"></button>
							<c:if test="${picture.attachCount > 3}">
								    <button type="button" data-bs-target="#picture-${picture.no}" data-bs-slide-to="3" aria-label="Slide 4"></button>
							<c:if test="${picture.attachCount > 4}">
								    <button type="button" data-bs-target="#picture-${picture.no}" data-bs-slide-to="4" aria-label="Slide 5"></button>
							</c:if></c:if></c:if>
								</div>
								<div class="carousel-inner">
        					<c:forEach items="${picture.attachments}" var="attach" varStatus="vs">
							    <div class="carousel-item">
							      <img src="${pageContext.request.contextPath}/picture/images/${attach.renamedFilename}" class="d-block w-100" alt="이미지" style="cursor: pointer;">
							    </div>
							</c:forEach>
							<c:if test="${picture.attachCount > 1}">
							  <button class="carousel-control-prev" type="button" data-bs-target="#picture-${picture.no}" data-bs-slide="prev">
							    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Previous</span>
							  </button>
							  <button class="carousel-control-next" type="button" data-bs-target="#picture-${picture.no}" data-bs-slide="next">
							    <span class="carousel-control-next-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Next</span>
							  </button>
						  	</c:if>
						</div>
							
							</div>
	                </div>
	                <div class="photo-contents">${picture.content}</div>
	                
	                <!-- 댓글 영역 시작 -->
	            	<div class="picture-comment">

		                <div class="picture-comment-list border-bottom" >
			                <c:forEach items="${commentList}" var="comment" varStatus="vs">
	 						<c:if test="${comment.pictureNo == picture.no && comment.status > 0}">
				 						<table id="tbl-comment">
				 						<c:choose>
											<c:when test="${comment.commentLevel == 1}">
												<tr class="level1">
													<td>
														<a class="picture-comment-name" onclick="visitMh(${comment.writerId})" target="blank">${comment.memberName}</a>
							                       		<div class="picture-comment-content">
														: ${fn:replace(comment.content, replaceChar, "<br/>")}
														</div>
							                       		<div class="picture-comment-date">
							                       			<fmt:parseDate value="${comment.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
															<fmt:formatDate value="${regDate}" pattern="(yyyy-MM-dd HH:mm)"/>
														</div>
	
														<c:if test="${myHompyId == comment.writerId}">
														<button type="button" class="picture-comment-button btn-close comment-remove" aria-label="Close" data-comment-no="${comment.no}"></button>
														</c:if>
													</td>
												</tr>
											</c:when>
											<c:when test="${comment.commentLevel == 2}">
												<tr class="level2">
													<td>
														<sub class=comment-writer>${comment.memberName}</sub>
														<sub class=comment-date>${comment.regDate}</sub>
														<br />
														댓글내용
														${comment.content}
													</td>
													<td>
														<button class="picture-comment-button" value="${comment.no}">답글</button>
														<c:if test="${isAuthenticated == 1 || myHompyId == comment.writerId}">
														<button class="picture-comment-button" value="${comment.no}">삭제</button>
														</c:if>
													</td>
												</tr>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
				 						</table>
		                	</c:if>
		                	</c:forEach>
		                </div>

						<div class="picture-comment-frm" >
							<form name="picture-comment-form-${picture.no}" class="picture-comment-frm">
				                <input type="hidden" name="pictureNo" value="${picture.no}" />
				                <input type="hidden" name="hompyId" value="${miniHompy.hompyId}" />
				                <input type="hidden" name="writerId" value="${myHompyId}" />
				                <input type="hidden" name="memberName" value="${principal.name}" />
				                <input type="hidden" name="commentLevel" value="1" />
								<textarea class="form-control picture-comment-content" id="comment-content-${picture.no}" name="content" rows="1" required ></textarea>
				  	            <button  class="picture-button comment" onclick="enrollPictureComment(${picture.no})">확인</button>
		  	              	</form>
						</div>
			 			
			 			</div>
			 			<!-- 댓글 영역 끝 -->
	            	</div>     
	            	<!-- 사진 게시물 영역 끝 -->   
	            	
	            	</c:if>
					</c:forEach>
					
	            </div>
	            
	            
  				<nav aria-label="Page navigation example" class="pagebar" id="pagebar">
					<ul class="pagination justify-content-center pagination-sm">
					${pagebar}
					</ul>
				</nav>
                    
	            </div>
	            <!-- 스크롤 박스 끝 -->
<c:choose>
<c:when test="${miniHompy.picture == 2 && isIlchon != 1  && isAuthenticated != 1}">
	<div class="picture-scrollbox">
		<div class="content-photo">
			<div class="diary-empty-content">게시물 공개 범위가 <span style="color: #ff8463;">일촌공개</span> 상태입니다.</div>
		</div>
	</div>
</c:when>
<c:when test="${miniHompy.picture == 3 && isAuthenticated != 1}">
	<div class="picture-scrollbox">
		<div class="content-photo">
			<div class="diary-empty-content">게시물 공개 범위가 <span style="color: #ff8463;">비공개</span> 상태입니다.</div>
		</div>
	</div>
</c:when>
</c:choose>
	            
	       	</div>
        </div>
	
	<script>

	    $(document).ready(function() {
	    	$(".carousel-inner div.carousel-item:first-child").addClass('active');
	        checkEmptyPicture();
	    });

	    function checkEmptyPicture(){
	    	const container = document.querySelector('.picture-List');
	    	/* console.log(container.innerText); */
	    	if (container.innerText == ``) {
	    		let html = `<div style="text-align: center; margin: 30% 0 auto; color: #999;">사진첩 게시물이 없습니다.</div>`;
	    		container.innerHTML = html;
	    		$('#pagebar').hide();
	    	}
	    	
	    	$('.picture-comment-list').each(function() {
	    		console.log($(this).text());
	    	    if (!$(this).text().match(":")) {
	    	        $(this).hide();
	    	    }
	    	});
	    }
	    
	    var img = document.getElementsByTagName("img");
	    for (var x = 0; x < img.length; x++) {
	      img.item(x).onclick=function() {window.open(this.src)}; 
	    }
	    
		$(document).on("click", "button.picture-remove", function(){
			let no = $(this).attr("data-no");
			if(confirm("사진 게시물을 삭제 하시겠습니까?")){
				delPicture(no);
			}
		})
		
		function delPicture(no){
			
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
	 		
			$.ajax({
				url : `${pageContext.request.contextPath}/picture/delete.do`,
				data : {no : no},
				type : "POST",
				headers,
	 			async: false, 
				error : function(request, status, error){
					console.log("Code:"+request.status+" / Message:"+request.responseText+" / Error: "+error);
				},
				success: function(data){
						document.location.reload(true);
				}
			})
		}
		

		function enrollPictureComment(no){
			if($("#comment-content-"+no).val() == ``) {
				return;
			} else {
				const csrfHeader = "${_csrf.headerName}";
				const csrfToken = "${_csrf.token}";
				const headers = {};
				headers[csrfHeader] = csrfToken;
				
				const formValues = $("form[name=picture-comment-form-"+no+"]").serialize();
	
				$.ajax({
			    	url: `${pageContext.request.contextPath}/picture/comment/enroll.do`,
			        data: formValues,
			        type: "POST",
			        headers,
			        async: false, 
			        success: function(json){
			        	window.alert("댓글이 등록되었습니다.");
			        },
			        error: function(){
			        	window.alert("댓글 등록 중 오류가 발생했습니다.");
			        },
			    })
			}
		}
		$(document).on("click", "button.comment-remove", function(){
			let no = $(this).attr("data-comment-no");
			if(confirm("댓글을 삭제 하시겠습니까?")){
				delComment(no);
			}
		})
		
		function delComment(no){
			
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
	 		
			$.ajax({
				url : `${pageContext.request.contextPath}/picture/comment/delete.do`,
				data : {no : no},
				type : "POST",
				headers,
	 			async: false, 
				error : function(request, status, error){
					console.log("Code:"+request.status+" / Message:"+request.responseText+" / Error: "+error);
				},
				success: function(data){
	 					document.location.reload(true);

				}
			})
			
		}
		
	</script>


<jsp:include page="/WEB-INF/views/minihompy/common_menu.jsp"></jsp:include>