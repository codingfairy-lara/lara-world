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


<jsp:include page="/WEB-INF/views/minihompy/common.jsp">
	<jsp:param value='${miniHompy.memberId}님의 미니홈피' name="title"/>
</jsp:include>

			<!-- content-box 시작 -->
            <div class="box content-box">
            	<!-- scrollbox 시작 -->
                <div class="setting-scrollbox">
                
                <div class="row">
				  <div class="col-4">
				    <div class="list-group sticky-top" id="list-tab" role="tablist">
				      <a class="list-group-item list-group-item-action active" id="list-home-list" data-bs-toggle="list" href="#list-home" role="tab" aria-controls="list-home">기본정보 관리</a>
				      <a class="list-group-item list-group-item-action" id="list-privacy-list" data-bs-toggle="list" href="#list-privacy" role="tab" aria-controls="list-privacy">개인정보 관리</a>
				      <a class="list-group-item list-group-item-action" id="list-profilmenu-list" data-bs-toggle="list" href="#list-menu" role="tab" aria-controls="list-menu">메뉴 관리</a>
				      <a class="list-group-item list-group-item-action" id="list-theme-list" data-bs-toggle="list" href="#list-theme" role="tab" aria-controls="list-theme">꾸미기</a>
				      <a class="list-group-item list-group-item-action" id="list-content-list" data-bs-toggle="list" href="#list-content" role="tab" aria-controls="list-content">게시물 관리</a>
				    </div>
				  </div>
				  
				  <!-- 관리 탭 콘텐츠 시작 -->
				  <div class="col-8 setting-tabContent">
				    <div class="tab-content" id="nav-tabContent">
				    
			          <div class="tab-pane fade show active" id="list-home" role="tabpanel" aria-labelledby="list-home-list">
						  <h4 id="list-item-1" class="border-bottom">기본정보 관리</h4>
					      	<div class="card setting-card">
							  <div class="card-header">미니홈피 설정</div>
							  <div class="card-body">
								  <p class="card-text setting-card-text">미니홈피 이름 변경</p>
									<div class="input-group mb-3">
									<c:choose>
										<c:when test="${miniHompy.title == '님의 미니홈피'}">
						              		<input type="text" class="form-control" placeholder="${miniHompy.memberId}${miniHompy.title}" name="hompy-title" id="hompy-title" aria-describedby="button-addon2" required>
						              	</c:when>
						              	<c:otherwise>
						              		<input type="text" class="form-control" placeholder="${miniHompy.title}" name="hompy-title" id="hompy-title" aria-describedby="button-addon2" required>
						              	</c:otherwise>
						          	</c:choose>
									  <button class="btn btn-outline-secondary" type="submit" id="button-addon2" onclick="editMhTitle(${myHompyId})">변경</button>
									</div>
							  </div>
							</div>
					      	<div class="card setting-card">
							  <div class="card-header">홈화면 설정</div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">미니룸 사용</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="miniroom" onclick="editHompy(event, ${myHompyId}, 'miniroom')" value="1" <c:if test="${miniHompy.miniroom == 1}">checked</c:if>>
									  <label class="form-check-label" for="miniroom">사용</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="miniroom" onclick="editHompy(event, ${myHompyId}, 'miniroom')" value="0" <c:if test="${miniHompy.miniroom == 0}">checked</c:if> >
									  <label class="form-check-label" for="miniroom">사용 안함</label>
									</div>
							  </div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">일촌평 사용</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="ilchonTalk"  onclick="editHompy(event, ${myHompyId}, 'ilchonTalk')"  value="1" <c:if test="${miniHompy.ilchonTalk == 1}">checked</c:if> >
									  <label class="form-check-label" for="ilchonTalk">사용</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="ilchonTalk"  onclick="editHompy(event, ${myHompyId}, 'ilchonTalk')"  value="0" <c:if test="${miniHompy.ilchonTalk == 0}">checked</c:if> >
									  <label class="form-check-label" for="ilchonTalk">사용 안함</label>
									</div>
							  </div>
							</div>

					  </div>
					  
				      <div class="tab-pane fade" id="list-menu" role="tabpanel" aria-labelledby="list-menu-list">
					      <h4 id="list-item-2" class="border-bottom">메뉴 관리</h4>
					      	<div class="card setting-card">
							  <div class="card-header">미니홈피 메뉴 설정</div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">다이어리 메뉴</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="diary"  onclick="editHompy(event, ${myHompyId}, 'diary')"  value="1" <c:if test="${miniHompy.diary != 0}">checked</c:if> >
									  <label class="form-check-label" for="diary">사용</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="diary"  onclick="editHompy(event, ${myHompyId}, 'diary')"  value="0" <c:if test="${miniHompy.diary == 0}">checked</c:if> >
									  <label class="form-check-label" for="diary">사용 안함</label>
									</div>
							  </div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">사진첩 메뉴</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="picture"  onclick="editHompy(event, ${myHompyId}, 'picture')"  value="1" <c:if test="${miniHompy.picture != 0}">checked</c:if> >
									  <label class="form-check-label" for="picture">사용</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="picture"  onclick="editHompy(event, ${myHompyId}, 'picture')"  value="0" <c:if test="${miniHompy.picture == 0}">checked</c:if> >
									  <label class="form-check-label" for="picture">사용 안함</label>
									</div>
							  </div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">방명록 메뉴</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="guestbook"  onclick="editHompy(event, ${myHompyId}, 'guestbook')"  value="1" <c:if test="${miniHompy.guestbook != 0}">checked</c:if> >
									  <label class="form-check-label" for="guestbook">사용</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="guestbook"  onclick="editHompy(event, ${myHompyId}, 'guestbook')"  value="0" <c:if test="${miniHompy.guestbook == 0}">checked</c:if> >
									  <label class="form-check-label" for="guestbook">사용 안함</label>
									</div>
							  </div>
							</div>
				      </div>
				      
				      <div class="tab-pane fade" id="list-content" role="tabpanel" aria-labelledby="list-content-list">
   					      <h4 id="list-item-3" class="border-bottom">게시물 관리</h4>
  					      	<div class="card setting-card">
							  <div class="card-header">게시물 공개 범위 설정</div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">다이어리 게시물</p>
								  <div class="setting-content-container">
									<select class="form-select setting-content-select" aria-label="Default select example" id="diary">
									  <option value="1" <c:if test="${miniHompy.diary == 1}">selected</c:if>>전체공개</option>
									  <option value="2" <c:if test="${miniHompy.diary == 2}">selected</c:if>>일촌공개</option>
									  <option value="3" <c:if test="${miniHompy.diary == 3}">selected</c:if>>비공개</option>
									</select>
								  	<button type="button" class="btn btn-outline-secondary btn-sm" onclick="editContent(event, ${myHompyId}, 'diary')">적용</button>
								  </div>
							  </div>
							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">사진첩 게시물</p>
								  <div class="setting-content-container">
									<select class="form-select setting-content-select" aria-label="Default select example" id="picture">
									  <option value="1" <c:if test="${miniHompy.picture == 1}">selected</c:if>>전체공개</option>
									  <option value="2" <c:if test="${miniHompy.picture == 2}">selected</c:if>>일촌공개</option>
									  <option value="3" <c:if test="${miniHompy.picture == 3}">selected</c:if>>비공개</option>
									</select>
								  	<button type="button" class="btn btn-outline-secondary btn-sm" onclick="editContent(event, ${myHompyId}, 'picture')">적용</button>
								  </div>
							  </div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">방명록 게시물</p>
								  <div class="setting-content-container">
									<select class="form-select setting-content-select" aria-label="Default select example" id="guestbook">
									  <option value="1" <c:if test="${miniHompy.guestbook == 1}">selected</c:if>>전체공개</option>
									  <option value="2" <c:if test="${miniHompy.guestbook == 2}">selected</c:if>>일촌공개</option>
									  <option value="3" <c:if test="${miniHompy.guestbook == 3}">selected</c:if>>비공개</option>
									</select>
								  	<button type="button" class="btn btn-outline-secondary btn-sm" onclick="editContent(event, ${myHompyId}, 'guestbook')">적용</button>
								  </div>
							  </div>
							</div>
					      	<div class="card setting-card">
							  <div class="card-header">방명록 관리</div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">방명록 작성 권한</p>
								  <div class="setting-content-container">
									<select class="form-select setting-content-select" aria-label="Default select example" id="guestbookAccess" style="width: 9rem !important;">
									  <option value="1" <c:if test="${miniHompy.guestbookAccess == 1}">selected</c:if>>전체 허용</option>
									  <option value="2" <c:if test="${miniHompy.guestbookAccess == 2}">selected</c:if>>일촌만 허용</option>
									  <option value="3" <c:if test="${miniHompy.guestbookAccess == 3}">selected</c:if>>모두 허용 안함</option>
									</select>
								  	<button type="button" class="btn btn-outline-secondary btn-sm" onclick="editContent(event, ${myHompyId}, 'guestbookAccess')">적용</button>
								  </div>
							  </div>
							</div>
				      </div>
				      
				      <div class="tab-pane fade" id="list-theme" role="tabpanel" aria-labelledby="list-theme-list">
   					      <h4 id="list-item-4" class="border-bottom">꾸미기</h4>
  					      	<div class="card setting-card">
							  <div class="card-header">미니홈피 색상</div>
							  <div class="card-body setting-color-card" style="display: flex; flex-direction: column;">
							  <p class="card-text setting-card-text">배경 색상 선택</p>
							 	<div class="setting-color-container">
							  <c:choose>
								<c:when test="${miniHompy.background == null}">
									<input type="color" class="form-control form-control-color setting-color" id="background" value="#FFFFFF" title="Choose your color">
				              	</c:when>
				              	<c:otherwise>
									<input type="color" class="form-control form-control-color setting-color" id="background" value="#${miniHompy.background}" title="Choose your color">
				              	</c:otherwise>
				              </c:choose>
          				      <button type="button" class="btn btn-outline-secondary btn-sm" onclick="editColor(${myHompyId}, 'background')">적용</button>
							 </div>
				              <br/>
				               <p class="card-text setting-card-text">테두리 색상 선택</p>
				              <div class="setting-color-container">
							  <c:choose>
								<c:when test="${miniHompy.borderColor == null}">
									<input type="color" class="form-control form-control-color setting-color" id="borderColor" value="#FFFFFF" title="Choose your color">
				              	</c:when>
				              	<c:otherwise>
									<input type="color" class="form-control form-control-color setting-color" id="borderColor" value="#${miniHompy.borderColor}" title="Choose your color">
				              	</c:otherwise>
				              </c:choose>
				              <button type="button" class="btn btn-outline-secondary btn-sm" onclick="editColor(${myHompyId}, 'borderColor')">적용</button>
				              </div>
							  </div>
							</div>
  					      	<div class="card setting-card">
							  <div class="card-header">메뉴 & 버튼 색상</div>
							  <div class="card-body setting-color-card">
							  <c:choose>
								<c:when test="${miniHompy.indexColor == null}">
									<input type="color" class="form-control form-control-color setting-color" id="indexColor" value="#FFFFFF" title="Choose your color">
				              	</c:when>
				              	<c:otherwise>
									<input type="color" class="form-control form-control-color setting-color" id="indexColor" value="#${miniHompy.indexColor}" title="Choose your color">
				              	</c:otherwise>
				              </c:choose>
				              <button type="button" class="btn btn-outline-secondary btn-sm" onclick="editColor(${myHompyId}, 'indexColor')">적용</button>
							  </div>
							</div>
  					      	<div class="card setting-card">
							  <div class="card-header">미니룸 색상</div>
							  <div class="card-body setting-color-card">
							  <c:choose>
								<c:when test="${miniHompy.roomColor == null}">
									<input type="color" class="form-control form-control-color setting-color" id="roomColor" value="#FFFFFF" title="Choose your color">
				              	</c:when>
				              	<c:otherwise>
									<input type="color" class="form-control form-control-color setting-color" id="roomColor" value="#${miniHompy.roomColor}" title="Choose your color">
				              	</c:otherwise>
				              </c:choose>
				              <button type="button" class="btn btn-outline-secondary btn-sm" onclick="editColor(${myHompyId}, 'roomColor')">적용</button>
							  </div>
							</div>
				      </div>
				      
 				      <div class="tab-pane fade" id="list-privacy" role="tabpanel" aria-labelledby="list-privacy-list">
  					      <h4 id="list-item-5" class="border-bottom">개인정보 관리</h4>
  					      	<div class="card setting-card">
							  <div class="card-header">정보 공개 설정</div>
   							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">생년월일 공개</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="birthdayPrivacy" onclick="editHompy(event, ${myHompyId}, 'birthdayPrivacy')"  value="1" <c:if test="${miniHompy.birthdayPrivacy == 1}">checked</c:if> >
									  <label class="form-check-label" for="birthdayPrivacy">공개</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="birthdayPrivacy" onclick="editHompy(event, ${myHompyId}, 'birthdayPrivacy')"  value="0"  <c:if test="${miniHompy.birthdayPrivacy == 0}">checked</c:if>>
									  <label class="form-check-label" for="birthdayPrivacy">비공개</label>
									</div>
							  </div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">프로필 이메일 공개</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="emailPrivacy" onclick="editHompy(event, ${myHompyId}, 'emailPrivacy')"  value="1" <c:if test="${miniHompy.emailPrivacy == 1}">checked</c:if> >
									  <label class="form-check-label" for="emailPrivacy">공개</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="emailPrivacy" onclick="editHompy(event, ${myHompyId}, 'emailPrivacy')"  value="0"  <c:if test="${miniHompy.emailPrivacy == 0}">checked</c:if>>
									  <label class="form-check-label" for="emailPrivacy">비공개</label>
									</div>
							  </div>
							</div>
					      	<div class="card setting-card">
							  <div class="card-header">파도타기 관리</div>
  							  <div class="card-body text-center">
								  <p class="card-text setting-card-text">타인의 파도타기 방문</p>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="wave"  onclick="editHompy(event, ${myHompyId}, 'wave')"  value="1" <c:if test="${miniHompy.wave == 1}">checked</c:if> >
									  <label class="form-check-label" for="ilchonTalk">허용</label>
									</div>
									<div class="form-check form-check-inline">
									  <input class="form-check-input" type="radio" name="wave"  onclick="editHompy(event, ${myHompyId}, 'wave')"  value="0" <c:if test="${miniHompy.wave == 0}">checked</c:if> >
									  <label class="form-check-label" for="ilchonTalk">비허용</label>
									</div>
							  </div>
							</div>
					  </div> 
					  
				    </div>
				  </div>
				    <!-- 관리 탭 콘텐츠 끝 -->
				</div>
            
                    
                </div>  
                <!-- scrollbox 끝 -->
            </div>
            <!-- content-box 끝 -->
        </div>
	
	<script>
	function editMhTitle(hompyId){
		const title = $("#hompy-title").val();

		// 미입력 또는 공백입력 방지
		if(title.replace(/\s| /gi, "").length == 0) {
			alert("변경할 미니홈피 이름을 입력해주세요.");
			$("#hompy-title").focus;
		} else {
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
			
			$.ajax({
		    	url: `${pageContext.request.contextPath}/minihompy/setting/title.do`,
		        data: {title : title, hompyId : hompyId},
		        type: "POST",
		        headers,
		        async: false, 
		        success: function(json){
		        	document.location.reload(true);
		        },
		        error: function(){
		        	window.alert("미니홈피 이름 변경 중 오류가 발생했습니다.");
		        },
		    })
		}
	}
	
	function editColor(hompyId, param){
		const colorVal = $("#"+param).val();
		const color = colorVal.replace(/#/ig, ''); 
		console.log(color, param);
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
	    	url: `${pageContext.request.contextPath}/minihompy/setting/color.do`,
	        data: {color : color, hompyId : hompyId, param : param},
	        type: "POST",
	        headers,
	        async: false, 
	        success: function(json){
	        	document.location.reload(true);
	        },
	        error: function(){
	        	window.alert("색상 변경 중 오류가 발생했습니다.");
	        },
	    })
	}
	
	function editContent(event, hompyId, param){
		const val = $("#"+param).val();
		console.log(val, hompyId, param);
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
	    	url: `${pageContext.request.contextPath}/minihompy/setting/hompy.do`,
	        data: {val : val, hompyId : hompyId, param : param},
	        type: "POST",
	        headers,
	        async: false, 
	        success: function(json){
	        	document.location.reload(true);
	        },
	        error: function(){
	        	window.alert("게시물 공개 설정 중 오류가 발생했습니다.");
	        },
	    })
	}
	
	function editHompy(event, hompyId, param){
		const val = event.target.value;
		console.log(val, hompyId, param);
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
		
		$.ajax({
	    	url: `${pageContext.request.contextPath}/minihompy/setting/hompy.do`,
	        data: {val : val, hompyId : hompyId, param : param},
	        type: "POST",
	        headers,
	        async: false, 
	        success: function(json){
	        	document.location.reload(true);
	        },
	        error: function(){
	        	window.alert("미니홈피 설정 중 오류가 발생했습니다.");
	        },
	    })
	}
	
	
	</script>


<jsp:include page="/WEB-INF/views/minihompy/common_menu.jsp"></jsp:include>