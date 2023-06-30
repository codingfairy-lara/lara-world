<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

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

<c:set var="gender" value="${miniHompy.member.gender}"/>

<jsp:include page="/WEB-INF/views/minihompy/common.jsp">
	<jsp:param value='${miniHompy.memberId}님의 미니홈피' name="title"/>
</jsp:include>

            <div class="box content-box">
           	<!-- scrollbox 시작 -->
            <div class="home-scrollbox">
              <div class="box-title">Updated news</div>
              <div class="news-flex-box">
                <div class="news-box">
                <span class="news-box-empty <c:if test="${!empty recentPosts}">d-none</c:if>">최근 3일간 등록된 게시물이 없습니다. <br/> 소식이 뜸한 친구에게 마음의 한마디를<br/> 남겨주세요. 🙂</span>
		  <c:forEach items="${recentPosts}" var="rp" varStatus="vs">
		  
		  
		  <c:if test="${(rp.status == 2 && isIlchon == 0) || (miniHompy.diary == 2 && isIlchon == 0) || (miniHompy.picture == 2 && isIlchon == 0) || (miniHompy.guestbook == 2 && isIlchon == 0)}">
           	 <c:choose>
					<c:when  test="${miniHompy.diary == 2 && rp.category eq 'diary' && isAuthenticated == 0}">
	                  <div class="news-row" onclick="location.href='${pageContext.request.contextPath}/minihompy/diary.do?hompyId=${miniHompy.hompyId}'">
	                    <div class="news-category category-diary">다이어리</div>
	                    <div class="news-title">일촌공개 게시물</div>
	                  </div>
					</c:when>					
					<c:when  test="${miniHompy.picture == 2 && rp.category eq 'picture' && isAuthenticated == 0}">
	                  <div class="news-row" onclick="location.href='${pageContext.request.contextPath}/minihompy/picture.do?hompyId=${miniHompy.hompyId}'">
	                    <div class="news-category category-picture">사진첩</div>
	                    <div class="news-title">일촌공개 게시물</div>
	                  </div>
	                </c:when>
	                <c:when  test="${miniHompy.guestbook == 2 && rp.category eq 'guestBook' && isAuthenticated == 0}">
	                  <div class="news-row" onclick="location.href='${pageContext.request.contextPath}/minihompy/guestbook.do?hompyId=${miniHompy.hompyId}'">
	                    <div class="news-category category-guestbook">방명록</div>
	                    <div class="news-title">일촌공개 게시물</div>
	                  </div>
					</c:when>
              </c:choose>	
           </c:if>
              
		  <c:if test="${miniHompy.diary == 1 || miniHompy.picture == 1 || miniHompy.guestbook == 1 || (rp.status == 2 && isIlchon == 1) || isIlchon == 1 || isAuthenticated == 1}">
           	 <c:choose>
					<c:when  test="${miniHompy.diary == 1 && rp.category eq 'diary' || (miniHompy.diary == 2 && rp.category eq 'diary' && isIlchon == 1) || isAuthenticated == 1 && rp.category eq 'diary' }">
	                  <div class="news-row" onclick="location.href='${pageContext.request.contextPath}/minihompy/diary.do?hompyId=${miniHompy.hompyId}'">
	                    <div class="news-category category-diary">다이어리</div>
	                    <div class="news-title">${rp.title}</div>
	                  </div>
					</c:when>					
					<c:when  test="${miniHompy.picture == 1 && rp.category eq 'picture' || (miniHompy.picture == 2 && rp.category eq 'picture' && isIlchon == 1) || isAuthenticated == 1 && rp.category eq 'picture' }">
	                  <div class="news-row" onclick="location.href='${pageContext.request.contextPath}/minihompy/picture.do?hompyId=${miniHompy.hompyId}'">
	                    <div class="news-category category-picture">사진첩</div>
	                    <div class="news-title">${rp.title}</div>
	                  </div>
	                </c:when>
	                <c:when  test="${miniHompy.guestbook == 1 && rp.category eq 'guestBook' || (miniHompy.guestbook == 2 && rp.category eq 'guestBook' && isIlchon == 1) || isAuthenticated == 1 && rp.category eq 'guestBook' }">
	                  <div class="news-row" onclick="location.href='${pageContext.request.contextPath}/minihompy/guestbook.do?hompyId=${miniHompy.hompyId}'">
	                    <div class="news-category category-guestbook">방명록</div>
	                    <div class="news-title">${rp.title}님의 방명록 글</div>
	                  </div>
					</c:when>
              </c:choose>	
            </c:if>
              
          </c:forEach>
                </div>
                <div class="update-box">
                  <div class="menu-row">
                    <div class="menu-item <c:if test="${miniHompy.diary == 0}">d-none</c:if>">다이어리<span class="menu-num" >
                    	<a class="menu-num"  href="${pageContext.request.contextPath}/minihompy/diary.do?hompyId=${miniHompy.hompyId}">${count.rcntD}/${count.cntD}</a>
                    </span>
                    	<c:if test="${count.rcntD != 0}">
                    		<span class="badge text-bg-danger new-badge">N</span>
                    	</c:if>
                    </div>
                    <div class="menu-item <c:if test="${miniHompy.picture == 0}">d-none</c:if>">사진첩<span class="menu-num" >
                    	<a class="menu-num"  href="${pageContext.request.contextPath}/minihompy/picture.do?hompyId=${miniHompy.hompyId}">${count.rcntP}/${count.cntP}</a>
                    </span>
                    	<c:if test="${count.rcntP != 0}">
                    		<span class="badge text-bg-danger new-badge">N</span>
                    	</c:if>
                    </div>
                  </div>
                  <div class="menu-row">
                    <div class="menu-item <c:if test="${miniHompy.guestbook == 0}">d-none</c:if>">방명록<span class="menu-num" >
                    	<a class="menu-num" href="${pageContext.request.contextPath}/minihompy/guestbook.do?hompyId=${miniHompy.hompyId}">${count.rcntG}/${count.cntG}</a>
                    </span>
                    	<c:if test="${count.rcntG != 0}">
                    		<span class="badge text-bg-danger new-badge" >N</span>
                    	</c:if>
                    </div>
                  </div>
                </div>
              </div>
              
              <!-- 미니룸 시작 -->
              <div class="miniroom <c:if test="${miniHompy.miniroom == 0}">d-none</c:if>">
                <div class="box-title">Miniroom</div>
                <div class="miniroom-gif-box">
                	<div class="miniroom-img">
			<c:choose>
				<c:when test="${fn:contains(gender, 'M')}">
                		<img src="${pageContext.request.contextPath}/resources/images/male.png" alt="아바타" width="40px" class="miniroom-abata"/>
                </c:when>
                <c:when test="${fn:contains(gender, 'F')}">
                		<img src="${pageContext.request.contextPath}/resources/images/female.png" alt="아바타" width="40px" class="miniroom-abata"/>
                </c:when>
			</c:choose>
                	</div>
                </div>
              </div>
              <!-- 미니룸 끝 -->
              
              <!-- 일촌평 시작 -->
              <div class="ilchon-talk <c:if test="${miniHompy.ilchonTalk == 0}">d-none</c:if>">
                <div class="box-title">What friends say</div>
                	<div class="ilchon-talk-container">
	                	<div class="input-group mb-3 ilchon-talk-input">
						  <input type="text" <c:if test="${isIlchon == 0 && isAuthenticated == 0}">disabled</c:if> class="form-control" placeholder="<c:if test="${isIlchon == 1}">일촌과 나누고 싶은 이야기를 남겨보세요~!</c:if>" name="content" id="content" aria-label="Recipient's username" aria-describedby="button-addon2" >
						  <button class="btn btn-outline-secondary" <c:if test="${isIlchon == 0 && isAuthenticated == 0}">disabled</c:if> type="button" id="button-addon2" onclick="enrollIlchonTalk(${myHompyId}, ${ilchonNo}, ${miniHompy.hompyId})">작성</button>
						</div>
						<div>
							<table class="table">
							  <tbody>
							  <c:forEach items="${ilchonTalkList}" var="talk" varStatus="vs">
							  <c:if test="${talk.status > 0}">
							    <tr>
							        <td>${talk.content}
							    <c:choose>
									<c:when test="${talk.writerId == miniHompy.hompyId}">
					                  (<span class="profile-name" onclick="visitMh(${miniHompy.hompyId})" style="font-weight: bold; color: #3b87ab;">${miniHompy.name}</span>)
									</c:when>
									<c:when test="${talk.writerId == talk.ilchon.hompyId1}">
					                  (<span class="ilchon-name">${talk.ilchon.ilchonName1}</span> <span class="profile-name" onclick="visitMh(${talk.ilchon.hompyId1})">${talk.ilchon.name1}</span>)
									</c:when>
									<c:when test="${talk.writerId == talk.ilchon.hompyId2}">
					                  (<span class="ilchon-name">${talk.ilchon.ilchonName2}</span> <span class="profile-name" onclick="visitMh(${talk.ilchon.hompyId2})">${talk.ilchon.name2}</span>)
									</c:when>
								</c:choose>
								      <span class="ilchon-date"><fmt:parseDate value="${talk.createdAt}" pattern="yyyy-MM-dd" var="createdAt"/>
										<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/></span>
								<c:if test="${talk.writerId == myHompyId}">
									<button type="button" class="picture-comment-button btn-close comment-remove" aria-label="Close" data-no="${talk.no}"></button>
								</c:if>
									</td>
							    </tr>
							  </c:if>
							  </c:forEach>
							  </tbody>
							</table>
						</div>
                	</div>
              </div>
              <!-- 일촌평 끝 -->
              
            </div>
          </div>
			<!-- scrollbox 끝 -->            
          </div>

  	<c:if test="${miniHompy.roomColor != null}">
	 	<style>
	 		.miniroom-img {
	 			background-color: #${miniHompy.roomColor} !important;
	 		}
	 	</style>
  	</c:if>

	<script>
	function enrollIlchonTalk(writerId, ilchonNo, hompyId){
		const content = $("#content").val();

		// 미입력 또는 공백입력 방지
		if(content.replace(/\s| /gi, "").length == 0) {
			alert("일촌평 내용을 입력해주세요.");
			$("#content").focus;
		} else {
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
			
			$.ajax({
		    	url: `${pageContext.request.contextPath}/minihompy/ilchontalk/enroll.do`,
		        data: {content : content, hompyId : hompyId, writerId : writerId, ilchonNo : ilchonNo},
		        type: "POST",
		        headers,
		        async: false, 
		        success: function(json){
		        	document.location.reload(true);
		        },
		        error: function(){
		        	window.alert("일촌평 등록 중 오류가 발생했습니다.");
		        },
		    })
		}
	}
	
	$(document).on("click", "button.comment-remove", function(){
		let no = $(this).attr("data-no");
		if(confirm("일촌평을 삭제 하시겠습니까?")){
			delIlchonTalk(no);
		}
	})
	
	function delIlchonTalk(no){
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
 		
		$.ajax({
			url : `${pageContext.request.contextPath}/minihompy/ilchontalk/delete.do`,
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