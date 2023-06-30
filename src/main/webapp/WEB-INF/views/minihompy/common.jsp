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
<c:set var="gender" value="${miniHompy.member.gender}"/>
<c:choose>
	<c:when test="${miniHompy.hompyId == myHompyId}">
		<c:set var="isAuthenticated" value="1"/>
	</c:when>
	<c:otherwise>
		<c:set var="isAuthenticated" value="0"/>
	</c:otherwise>
</c:choose>

<c:forEach items="${ilchonList}" var="ilchon" varStatus="vs">
	<c:choose>
		<c:when test="${(ilchon.hompyId1 == miniHompy.hompyId || ilchon.hompyId2 == miniHompy.hompyId) && ilchon.status > 0}">
			<c:set var="isIlchon" value="1"/>
		</c:when>
		<c:otherwise>
			<c:set var="isIlchon" value="0"/>
		</c:otherwise>
	</c:choose>
</c:forEach>

                       
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
	<title>${param.title}</title>

	<!-- SimpleLightbox plugin JS-->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
	<link href="${pageContext.request.contextPath}/resources/css/minihompy/layout.css" rel="stylesheet" />
	<link href="${pageContext.request.contextPath}/resources/css/minihompy/font.css" rel="stylesheet" />
	<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
	
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">



  </head>
  <c:choose>
  	<c:when test="${miniHompy.background == null}">
	 <body>
  	</c:when>
  	<c:otherwise>
  	<body style="background-color: #${miniHompy.background} !important; background-image: none;"> 
  	</c:otherwise>
  </c:choose>
  
  <c:choose>
  	<c:when test="${miniHompy.borderColor == null}">
	 <div class="bookcover">
  	</c:when>
  	<c:otherwise>
  	<div class="bookcover" style="background-color: #${miniHompy.borderColor} !important;"> 
  	</c:otherwise>
  </c:choose>

      <div class="bookdot">
        <div class="page">
          <div class="profile-container">
            <div class="header profile-title font-neo">
              TODAY<span class="color-red">&nbsp;${miniHompy.visitToday}</span>&nbsp;| TOTAL ${miniHompy.visitTotal}
            </div>
            <div class="box profile-box">
            <div class="profile-image">
		    <c:choose>
				<c:when test="${profile.attachment.renamedFilename eq null}">
		              <img
		                  class="profile-image-img"
		                  src="${pageContext.request.contextPath}/resources/upload/profile_default.jpeg"
		                  alt="프로필 이미지"
		              />
				</c:when>
				<c:otherwise> 
		                <img 
		                  class="profile-image-img" 
		                  src="${pageContext.request.contextPath}/profile/images/${profile.attachment.renamedFilename}"
		                  alt="프로필 이미지" />
				</c:otherwise>
			</c:choose>
              </div>
              <div class="profile-text font-kyobohand" style="overFlow : auto;">
                ${profile.content}
              </div>
			 <div style="margin-bottom: 5rem;">
              <a onclick="popupHistory(${miniHompy.hompyId})" target="blank" style="font-size: 80%; cursor: pointer;">&gt; 프로필 히스토리</a>
              
            <c:if test="${miniHompy.hompyId == myHompyId}">
              <br/>
              <a onclick="popupUpload(${myHompyId})" target="blank" style="font-size: 80%; cursor: pointer;">&gt; 프로필 작성</a>             
			</c:if>
              
			 </div>
              <div class="profile-info">
                <div class="dropend profile-username" >
               	  <span class="dropdown-toggle profile-name" data-bs-toggle="dropdown" aria-expanded="false">${miniHompy.member.name}</span>
                  <ul class="dropdown-menu profile-dropdown">
			        <li><a class="dropdown-item ilchon-request 
   			        	<c:forEach items="${ilchonList}" var="ilchon" varStatus="vs">
				        	<c:if test="${isAuthenticated == 1 || ilchon.hompyId1 == miniHompy.hompyId || ilchon.hompyId2 == miniHompy.hompyId}">
				        		disabled
				        	</c:if>
			        	</c:forEach>
			        " href="#" 
			        	data-member-id-1="${principal.memberId}" data-member-id-2="${miniHompy.memberId}"
			        	data-hompy-id-1="${principal.hompyId}" data-hompy-id-2="${miniHompy.hompyId}"
			        	data-member-name-1="${principal.name}" data-member-name-2="${miniHompy.member.name}">일촌 신청</a></li>
				    <li><a class="dropdown-item" href="#"  onclick="popupHistory(${miniHompy.hompyId})" target="blank" >프로필 보기</a></li>
				  </ul>
				</div>
		<c:choose>
			<c:when test="${fn:contains(gender, 'M')}">
               	<span class="profile-gender" >(&#9794;)</span>
               </c:when>
               <c:when test="${fn:contains(gender, 'F')}">
               	<span class="profile-gender" >(&#9792;)</span>
               </c:when>
		</c:choose>
                <span class="profile-birthday <c:if test="${miniHompy.birthdayPrivacy == 0 && isAuthenticated == 0}">invisible</c:if>" >
	                <fmt:parseDate value="${miniHompy.member.birthday}" pattern="yyyy-MM-dd" var="birthday"/>
					<fmt:formatDate value="${birthday}" pattern="yyyy.MM.dd"/>
				<c:if test="${miniHompy.birthdayPrivacy == 0 && isAuthenticated == 1}">
	                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" fill="currentColor" width="12px" height="12px" viewBox="0 0 401.998 401.998" style="enable-background:new 0 0 401.998 401.998;" xml:space="preserve">
						<g><path d="M357.45,190.721c-5.331-5.33-11.8-7.993-19.417-7.993h-9.131v-54.821c0-35.022-12.559-65.093-37.685-90.218   C266.093,12.563,236.025,0,200.998,0c-35.026,0-65.1,12.563-90.222,37.688C85.65,62.814,73.091,92.884,73.091,127.907v54.821   h-9.135c-7.611,0-14.084,2.663-19.414,7.993c-5.33,5.326-7.994,11.799-7.994,19.417V374.59c0,7.611,2.665,14.086,7.994,19.417   c5.33,5.325,11.803,7.991,19.414,7.991H338.04c7.617,0,14.085-2.663,19.417-7.991c5.325-5.331,7.994-11.806,7.994-19.417V210.135   C365.455,202.523,362.782,196.051,357.45,190.721z M274.087,182.728H127.909v-54.821c0-20.175,7.139-37.402,21.414-51.675   c14.277-14.275,31.501-21.411,51.678-21.411c20.179,0,37.399,7.135,51.677,21.411c14.271,14.272,21.409,31.5,21.409,51.675V182.728   z"/></g>
					</svg>
                </c:if>
				</span>
                <span class="profile-email <c:if test="${miniHompy.emailPrivacy == 0 && isAuthenticated == 0}">invisible</c:if>" >
                ${miniHompy.member.email} 
                <c:if test="${miniHompy.emailPrivacy == 0 && isAuthenticated == 1}">
	                <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" id="Capa_1" fill="currentColor" width="12px" height="12px" viewBox="0 0 401.998 401.998" style="enable-background:new 0 0 401.998 401.998;" xml:space="preserve">
						<g><path d="M357.45,190.721c-5.331-5.33-11.8-7.993-19.417-7.993h-9.131v-54.821c0-35.022-12.559-65.093-37.685-90.218   C266.093,12.563,236.025,0,200.998,0c-35.026,0-65.1,12.563-90.222,37.688C85.65,62.814,73.091,92.884,73.091,127.907v54.821   h-9.135c-7.611,0-14.084,2.663-19.414,7.993c-5.33,5.326-7.994,11.799-7.994,19.417V374.59c0,7.611,2.665,14.086,7.994,19.417   c5.33,5.325,11.803,7.991,19.414,7.991H338.04c7.617,0,14.085-2.663,19.417-7.991c5.325-5.331,7.994-11.806,7.994-19.417V210.135   C365.455,202.523,362.782,196.051,357.45,190.721z M274.087,182.728H127.909v-54.821c0-20.175,7.139-37.402,21.414-51.675   c14.277-14.275,31.501-21.411,51.678-21.411c20.179,0,37.399,7.135,51.677,21.411c14.271,14.272,21.409,31.5,21.409,51.675V182.728   z"/></g>
					</svg>
                </c:if></span>
              </div>
              <div class="profile-dropdown" >
                <div class="dropdown-button">
                  <div class="dropdown-title">파도타기</div>
                  <div class="triangle-down"></div>
                </div>
                <div class="dropdown-content">
                  <a onclick="visitRandomMh(${principal.hompyId})" target="blank">파도타기🌊</a>
                  <a onclick="visitMh(${principal.hompyId})" target="blank">나의 미니홈피로🏠</a>
                <c:if test="${not empty ilchonList}"><a herf="#" target="blank">---- 나의 일촌👥 ----</a></c:if>
                <c:forEach items="${ilchonList}" var="ilchon" varStatus="vs">
	                <c:choose>
						<c:when test="${ilchon.hompyId1 == myHompyId && ilchon.status > 0}">
		                  <a onclick="visitMh(${ilchon.hompyId2})" target="blank">${ilchon.name2} (${ilchon.ilchonName2})</a>
						</c:when>
						<c:when test="${ilchon.hompyId2 == myHompyId && ilchon.status > 0}">
		                  <a onclick="visitMh(${ilchon.hompyId1})" target="blank">${ilchon.name1} (${ilchon.ilchonName1})</a>
						</c:when>
					</c:choose>
              	</c:forEach>
                </div>
              </div>
            </div>
          </div>
          <div class="content-container">
            <div class="header content-title">
            <a style="text-decoration: none; color:black;" href="${pageContext.request.contextPath}/minihompy/home.do?hompyId=${miniHompy.hompyId}">
			<c:choose>
				<c:when test="${miniHompy.title == '님의 미니홈피'}">
              		<div class="content-title-name">${miniHompy.memberId}${miniHompy.title}</div>
              	</c:when>
              	<c:otherwise>
              		<div class="content-title-name">${miniHompy.title}</div>
              	</c:otherwise>
          	</c:choose>
            </a>
              <div class="content-title-url">https://laraworld/minihompy/${miniHompy.memberId}</div>            
            </div>
      
      