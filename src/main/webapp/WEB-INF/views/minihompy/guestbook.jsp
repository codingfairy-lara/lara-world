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

			<!-- content-box 시작 -->
            <div class="box content-box">
            	<!-- scrollbox 시작 -->
                <div class="guestbook-scrollbox <c:if test="${(miniHompy.guestbook == 2 && isIlchon == 0  && isAuthenticated != 1) || (miniHompy.guestbook == 3 && isAuthenticated == 0)}">d-none</c:if>">
                
                <div class="guestbook-button-div">
                <div class="card privacy-info-tab <c:if test="${isAuthenticated != 1}">d-none</c:if>" style="width: 20rem;">
						게시물 공개 :&nbsp;
						<c:choose>
							<c:when test="${miniHompy.guestbook == 1}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">전체공개</span>
							</c:when>
							<c:when test="${miniHompy.guestbook == 2}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">일촌공개</span>
							</c:when>
							<c:when test="${miniHompy.guestbook == 3}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">비공개</span>
							</c:when>
							<c:when test="${miniHompy.guestbook == 0}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">메뉴 비공개</span>
							</c:when>
						</c:choose>
						&nbsp; 방명록 작성 :&nbsp;
						<c:choose>
							<c:when test="${miniHompy.guestbookAccess == 1}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">전체 허용</span>
							</c:when>
							<c:when test="${miniHompy.guestbookAccess == 2}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">일촌만 허용</span>
							</c:when>
							<c:when test="${miniHompy.guestbookAccess == 3}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}'">모두 허용 안함</span>
							</c:when>
						</c:choose>
				</div>
<c:choose>
<c:when test="${miniHompy.guestbookAccess == 2 && isIlchon != 1 && isAuthenticated != 1}">
	<span class="d-inline-block" tabindex="2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-content="방명록 작성 권한이 [일촌만 허용] 상태입니다." data-bs-placement="bottom" data-bs-custom-class="custom-popover" >
</c:when>
<c:when test="${miniHompy.guestbookAccess == 3 && isAuthenticated != 1}">
	<span class="d-inline-block" tabindex="2" data-bs-toggle="popover" data-bs-trigger="hover focus" data-bs-content="방명록 작성 권한이 [모두 비허용] 상태입니다." data-bs-placement="bottom" data-bs-custom-class="custom-popover" >
</c:when>
</c:choose>
				
	              <button class="guestbook-button" data-bs-toggle="modal" data-bs-target="#guestbookModal" data-bs-hompy-id="${miniHompy.hompyId}" data-bs-writer-id="${myHompyId}" data-bs-recipient="${miniHompy.member.name}" data-bs-writer="${principal.name}" data-bs-gender="${principal.gender}"
	              		<c:if test="${(miniHompy.guestbookAccess == 2 && isIlchon != 1  && isAuthenticated != 1) || (miniHompy.guestbookAccess == 3 && isAuthenticated != 1)}">disabled</c:if>
	              >작성하기</button>
<c:if test="${(miniHompy.guestbookAccess == 2 && isIlchon == 0 ) || (miniHompy.guestbookAccess == 3 && isAuthenticated == 0)}"></span></c:if>
					
                	<!-- modal 시작 -->
					<div class="modal fade" id="guestbookModal" tabindex="-1" aria-labelledby="guestbookModalLabel" aria-hidden="true">
					  <div class="modal-dialog">
					    <div class="modal-content">
					      <div class="modal-header">
					        <h1 class="modal-title fs-5" id="guestbookModalLabel">New message</h1>
					        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
					      </div>
					      <div class="modal-body" style="padding: 1.7rem;">
					        <form>
					          <div class="mb-3">
					            <label for="writer-name" class="col-form-label">작성자</label>
					            <input type="text" class="form-control" id="writer-name" disabled readonly >
					          </div>
					          <div class="mb-3">
					            <label for="guestbook-content" class="col-form-label">내용</label>
					            <textarea class="form-control guestbook-content" id="guestbook-content" rows="8"></textarea>
					          </div>
					        </form>
					      </div>
					      <div class="modal-footer">
					        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
					        <button type="button" class="btn btn-primary" id="guestbook-enroll">방명록 남기기</button>
					      </div>
					    </div>
					  </div>
					</div>
		 			<!-- modal 끝 -->
	 			</div>
	 			
	 			<!-- guestbook-List 시작 -->
                <div class="guestbook-List">
                <c:forEach items="${guestbookList}" var="guestbook" varStatus="vs">
                
                    <div class="guestbook-box">
                        <div class="guestbook-title"> 
                        	<div class="guestbook-info">No. ${guestbook.cno} </div>
                            <div class="guestbook-info" ><a class="guestbook-info guestbook-writer-name" onclick="visitMh(${guestbook.writerId})" target="blank">${guestbook.memberName} </a></div>
                       		<div class="guestbook-date guestbook-info">
                       			<fmt:parseDate value="${guestbook.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createdAt"/>
								<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd HH:mm"/>
							</div>
  	   					 	<c:if test="${isAuthenticated == 1 || myHompyId == guestbook.writerId}">
  	   					 	<div class="guestbook-info" >
						 		<button type="submit" class="btn-close guestbook-remove" aria-label="Close" data-no="${guestbook.no}" style="float:right;"></button> 
  	   					 	</div>
						 	</c:if>
                        </div>
                        <div class="guestbook-contents">
                            <div class="guestbook-image background-1">
							<c:choose>
								<c:when test="${fn:contains(guestbook.gender, 'M')}">
				                		<img src="${pageContext.request.contextPath}/resources/images/male.png" alt="아바타"/>
				                </c:when>
				                <c:when test="${fn:contains(guestbook.gender, 'F')}">
				                		<img src="${pageContext.request.contextPath}/resources/images/female.png" alt="아바타"/>
				                </c:when>
							</c:choose>
                            </div>
                            <div class="guestbook-text">
                                <p>${guestbook.content}</p>
                            </div>
                        </div>
		                <!-- 댓글 영역 시작 -->
		                <div class="guestbook-comment">

			                <div class="guestbook-comment-list border-bottom">
				                <c:forEach items="${commentList}" var="comment" varStatus="vs">
			 						<c:if test="${comment.guestbookNo == guestbook.no && comment.status > 0}">
				 						<table id="tbl-comment">
											<tr class="level1">
												<td>
													<a class="guestbook-comment-name" onclick="visitMh(${comment.writerId})" target="blank">${comment.memberName}</a>
						                       		<div class="guestbook-comment-content">
													: ${fn:replace(comment.content, replaceChar, "<br/>")}
													</div>
						                       		<div class="guestbook-comment-date">
						                       			<fmt:parseDate value="${comment.regDate}" pattern="yyyy-MM-dd'T'HH:mm" var="regDate"/>
														<fmt:formatDate value="${regDate}" pattern="(yyyy-MM-dd HH:mm)"/>
													</div>
		
													<c:if test="${myHompyId == comment.writerId}">
													<button type="button" class="guestbook-comment-button btn-close comment-remove" aria-label="Close" data-comment-no="${comment.no}"></button>
													</c:if>
												</td>
											</tr>
				 						</table>
				                	</c:if>
			                	</c:forEach>
			                </div>


<%-- 		                <c:if test="${isAuthenticated == 1 || myHompyId == guestbook.writerId}">  --%>      
							<div class="mb-3 guestbook-comment-frm" >
								<form name="guestbook-comment-form-${guestbook.no}" class="guestbook-comment-frm">
					                <input type="hidden" name="guestbookNo" value="${guestbook.no}" />
					                <input type="hidden" name="hompyId" value="${miniHompy.hompyId}" />
					                <input type="hidden" name="writerId" value="${myHompyId}" />
					                <input type="hidden" name="memberName" value="${principal.name}" />
					                <input type="hidden" name="commentLevel" value="1" />
									<textarea class="form-control guestbook-comment-content" id="comment-content-${guestbook.no}" name="content" rows="2" required></textarea>
					  	            <button  class="guestbook-button comment" onclick="enrollGuestbookComment(${guestbook.no})">확인</button>
			  	              	</form>
							</div>
<%-- 			 			</c:if> 
			 			 --%>
			 			</div>
			 			<!-- 댓글 영역 끝 -->
                    </div>


               </c:forEach>
                 </div>
                 <!-- guestbook-List 끝 -->
                 
				 <nav aria-label="Page navigation example" class="pagebar" id="pagebar">
					<ul class="pagination justify-content-center pagination-sm">
					${pagebar}
					</ul>
				</nav>
                    
                </div>  
                <!-- scrollbox 끝 -->
                
<c:choose>
<c:when test="${miniHompy.guestbook == 2 && isIlchon != 1  && isAuthenticated != 1}">
	<div class="guestbook-scrollbox">
		<div id="guestbook-List">
			<div class="diary-empty-content">게시물 공개 범위가 <span style="color: #ff8463;">일촌공개</span> 상태입니다.</div>
		</div>
	</div>
</c:when>
<c:when test="${miniHompy.guestbook == 3 && isAuthenticated != 1}">
	<div class="guestbook-scrollbox">
		<div id="guestbook-List">
			<div class="diary-empty-content">게시물 공개 범위가 <span style="color: #ff8463;">비공개</span> 상태입니다.</div>
		</div>
	</div>
</c:when>
</c:choose>

            </div>
            <!-- content-box 끝 -->
        </div>
	
	<script>
    $(document).ready(function() {
        checkEmptyGuestbook();
        var popover = new bootstrap.Popover(document.querySelector('.d-inline-block'), {
        	  container: 'body'
        	})
    });
    
    function checkEmptyGuestbook(){
    	const container = document.querySelector('.guestbook-List');
    	/* console.log(container.innerText); */
    	if (container.innerText == ``) {
    		let html = `<div style="text-align: center; margin: 30% 0 auto; color: #999">등록된 방명록이 없습니다.	</div>`;
    		container.innerHTML = html;
    		$('#pagebar').hide();
    	}
    	
    	$('.guestbook-comment-list').each(function() {
    		console.log($(this).text());
    	    if (!$(this).text().match(":")) {
    	        $(this).hide();
    	    }
    	});
    }
	
	const guestbookModal = document.getElementById('guestbookModal');
	guestbookModal.addEventListener('show.bs.modal', event => {
		
	  const button = event.relatedTarget
	  const recipient = button.getAttribute('data-bs-recipient')
	  const writer = button.getAttribute('data-bs-writer')
	  const hompyId = button.getAttribute('data-bs-hompy-id')
	  const writerId = button.getAttribute('data-bs-writer-id')
	  const gender = button.getAttribute('data-bs-gender')
	  const modalTitle = guestbookModal.querySelector('.modal-title')
	  const modalBodyInput = guestbookModal.querySelector('.modal-body input')
	  const modalBodyText = guestbookModal.querySelector('.modal-body textarea')

	  modalTitle.textContent = recipient+`님 방명록에 글 작성하기`
	  modalBodyInput.value = writer
	
	$(document).on("click", "button#guestbook-enroll", function(){
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		const memberName = writer;
		const content = modalBodyText.value;
 		
		$.ajax({
			url : `${pageContext.request.contextPath}/minihompy/guestbook/enroll.do`,
			data : {hompyId : hompyId, writerId : writerId, memberName : memberName, content : content, gender : gender},
			type : "POST",
			headers,
 			async: false, 
			error : function(request, status, error){
				console.log("Code:"+request.status+" / Message:"+request.responseText+" / Error: "+error);
			},
			success: function(data){
					window.alert("방명록이 등록되었습니다.");
					document.location.reload(true);
			}
		})
	})

	});
	

	$(document).on("click", "button.guestbook-remove", function(){
		let no = $(this).attr("data-no");
		if(confirm("방명록을 삭제 하시겠습니까?")){
			delGuestbook(no);
		}
	})
	
	function delGuestbook(no){
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
 		
		$.ajax({
			url : `${pageContext.request.contextPath}/guestbook/delete.do`,
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

	function enrollGuestbookComment(no){
		if($("#comment-content-"+no).val() == ``) {
			return;
		} else {
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
			
			const formValues = $("form[name=guestbook-comment-form-"+no+"]").serialize();
			
			$.ajax({
		    	url: `${pageContext.request.contextPath}/guestbook/comment/enroll.do`,
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
			url : `${pageContext.request.contextPath}/guestbook/comment/delete.do`,
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