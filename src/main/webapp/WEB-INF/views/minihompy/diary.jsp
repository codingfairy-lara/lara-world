<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%-- <% pageContext.setAttribute("replaceChar", "\n"); %> --%>
<sec:authentication property="principal" var="principal" />
<fmt:parseNumber var="myHompyId" integerOnly="true" 
                       type="number" value="${principal.hompyId}" />
<%-- <fmt:parseDate value="${diary.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="diaryCreatedAt"/> --%>

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
                <div class="calendar">
	                <div class="sec_cal">
					  <div class="cal_nav date-today" style="width:30%;">
					    <div class="year-month" id="year-month"></div>
						<div class="cal_control">
					    <a href="javascript:;" class="nav-btn go-prev">prev</a>
					     	<div class="cur-day"></div>
					    <a href="javascript:;" class="nav-btn go-next">next</a>
						</div>				    
					  </div>
					  <div class="cal_wrap"  style="width:70%;">
					    <div class="dates"></div>
					  </div>
					</div>
				</div>
				
			<!-- diary-scrollbox 시작 -->
            <div class="diary-scrollbox <c:if test="${(miniHompy.diary == 2 && isIlchon != 1 && isAuthenticated != 1) || (miniHompy.diary == 3 && isAuthenticated != 1)}">d-none</c:if>">         
	            <div class="diary-button-div">
	            	<div class="card privacy-info-tab <c:if test="${isAuthenticated != 1}">d-none</c:if>">
						게시물 공개 :&nbsp;<c:choose>
							<c:when test="${miniHompy.diary == 1}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}#list-content'"> 전체공개</span>
							</c:when>
							<c:when test="${miniHompy.diary == 2}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}#list-content'"> 일촌공개</span>
							</c:when>
							<c:when test="${miniHompy.diary == 3}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}#list-content'"> 비공개</span>
							</c:when>
							<c:when test="${miniHompy.diary == 0}">
										<span class="privacy-info" onclick="location.href='${pageContext.request.contextPath}/minihompy/setting.do?hompyId=${miniHompy.hompyId}#list-content'"> 메뉴 비공개</span>
							</c:when>
						</c:choose>
					</div>
	              <button  class="diary-button" onclick="showDiaryList();">전체보기</button>
	            <c:if test="${miniHompy.hompyId == myHompyId}">       
	              <button  class="diary-button" onclick="popupDiaryFrm(${myHompyId})">작성하기</button>
	 			</c:if> 
	            </div>
	            
	<div id="diaryList">
 	<c:forEach items="${diaryList}" var="diary" varStatus="vs">
		<fmt:parseDate value="${diary.createdAt}" pattern="yyyy-MM-dd'T'HH:mm" var="createdAt"/>
	    <c:set var="diaryCreated"><fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd"/></c:set>
	    <c:if test="${diary.status > 0}">
	    
	 	<c:choose>
		 	<c:when test="${diary.diaryDate eq diaryCreated}">
	        <div class="diary">
		   	 	<%-- <c:if test="${diary.hompyId == myHompyId}"> --%>
		   	 	<c:if test="${isAuthenticated == 1}"> 
		 	 		<button type="submit" class="diary-remove" data-no="${diary.no}">X</button> 
			 	</c:if>
	            <div class="diary-date"><fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd HH:mm"/></div>
<%-- 	            <div class="diary-contents">${fn:replace(diary.content, replaceChar, "<br/>")}</div> <!-- text 개행처리 : \n을 <br/>태그로 대체 --> --%>
	            <div class="diary-contents">${diary.content}</div>
	        </div> 
		 	</c:when>
		 	<c:otherwise>
	        <div class="diary">
	   	   	 	<c:if test="${isAuthenticated == 1}"> 
		 	 		<button type="submit" class="diary-remove" data-no="${diary.no}">X</button> 
			 	</c:if>
	            <div class="diary-date">${diary.diaryDate}
	            	<div class="diary-created-date">&nbsp;(작성일시 : <fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd HH:mm"/>)</div>
	            </div>
	            <div class="diary-contents">${diary.content}</div>
	        </div> 
	        </c:otherwise>
	 	</c:choose>
	 	
	 	</c:if>
	</c:forEach>
    </div>		
    
     	<div id="diaryRender">

        </div>

                </div> 
                <!-- diary-scrollbox 끝 -->
<c:choose>
<c:when test="${miniHompy.diary == 2 && isIlchon != 1 && isAuthenticated != 1}">
	<div class="diary-scrollbox">
		<div id="diaryList">
			<div class="diary-empty-content">게시물 공개 범위가 <span style="color: #ff8463;">일촌공개</span> 상태입니다.</div>
		</div>
	</div>
</c:when>
<c:when test="${miniHompy.diary == 3 && isAuthenticated != 1}">
	<div class="diary-scrollbox">
		<div id="diaryList">
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
        calendarInit(${miniHompy.hompyId});
        checkEmptyDiary();
    });
    
    function checkEmptyDiary(){
    	const container = document.querySelector('#diaryRender');
    	const container2 = document.querySelector('#diaryList');
    	/* console.log(container.innerText); */
    	if (container2.innerText == `` || container.innerText == `` && $('#diaryList').css("display") == "none") {
    		let html = `<div class="diary-empty-content">선택된 일자에 작성된 게시물이 없습니다.</div>`;
    		container.innerHTML = html;
    		if (container2.innerText == ``) {
    			$('#diaryRender').show();
    			$('#diaryList').hide();
    		} 
    	}
    }

	$(document).on("click", "button.diary-remove", function(){
		let no = $(this).attr("data-no");
		if(confirm("선택한 게시물을 삭제 하시겠습니까?")){
			deleteDiary(no);
		}
	})
    
	function deleteDiary(no){
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
 		
		$.ajax({
			url : `${pageContext.request.contextPath}/minihompy/diary/delete.do`,
			data : {no : no},
			type : "POST",
			headers,
 			async: false, 
			error : function(request, status, error){
				console.log("Code:"+request.status+" / Message:"+request.responseText+" / Error: "+error);
			},
			success: function(data){
					window.alert("다이어리 삭제가 완료되었습니다.");
					document.location.reload(true);
			}
		})
	}
    
	const getDiary = (date, hompyId) => {
		$('div').removeClass('today');
		$('div[data-date='+date+']').addClass('today');
		
		let diaryDate = getYearMonth()+'.'+date;  // 2023.5.8
		diaryDate = diaryDate.replace(/\./g, '-'); 	// 정규표현식으로 치환 -> 2023-5-8
		// alert(diaryDate);
		
		var week = new Array('SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT');
	    const dayOfWeek = week[new Date(diaryDate).getDay()];
        $('.cur-day').text(dayOfWeek);
 		
 		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken; 
		
		$.ajax({
			url : `${pageContext.request.contextPath}/minihompy/diary/date.do?diaryDate=`+diaryDate+`&hompyId=`+hompyId,
			type : "GET",
			dataType : "json",
 			headers, 
			async: false, 
			error : function(request, status, error){
				console.log("Code:"+request.status+" / Message:"+request.responseText+" / Error: "+error);
			},
			success: function(data){
 				/* document.location.reload(true);  */
				$('#diaryList').hide();
				console.log(data);
  				renderDiary(data); 
 				$('#diaryRender').show();
			}
		})
	};
		

	const renderDiary = (data) => {
		const container = document.querySelector('#diaryRender');
		let html = ``
		
		// 반복처리
		if(data.length){		
			data.forEach((diary) => {
				const {no, hompyId, content, createdAt, status, diaryDate} = diary;
				
				if (status > 0) {
					if(createdAt.substring(0, 10) == diaryDate) {
					html += `
	                <div class="diary">
						<c:if test="${isAuthenticated == 1}"> 
			 	 			<button type="submit" class="diary-remove" data-no="\${no}">X</button> 
 						</c:if>
	                    <div class="diary-date">\${createdAt}</div>
	                    <div class="diary-contents">\${content}</div>
 	                </div>
					`;
					} else {
					html += `
	                <div class="diary">
						<c:if test="${isAuthenticated == 1}"> 
			 	 			<button type="submit" class="diary-remove" data-no="\${no}">X</button> 
 						</c:if>
			            <div class="diary-date">\${diaryDate}
			            	<div class="diary-created-date">&nbsp;(작성일시 : \${createdAt})</div>
			            </div>
	                    <div class="diary-contents">\${content}</div>
	                </div>
	                `;
	                }
				}
			});
		}
		
		container.innerHTML = html;
		checkEmptyDiary();
	};

    </script>

<jsp:include page="/WEB-INF/views/minihompy/common_menu.jsp"></jsp:include>