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

<!-- json List 값을 JS 배열에 담기  -->
<script>	
  var ilchonIdList = new Array();
  var myHompyId = ${myHompyId};
</script>
<c:forEach items="${ilchonList}" var="ilchon" varStatus="vs">
<script>
    ilchonIdList.push(${ilchon.hompyId1});
    ilchonIdList.push(${ilchon.hompyId2});
</script>
</c:forEach>



<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원 검색" name="title"/>
</jsp:include>

<script>
$(".masthead").hide();
</script>

<section class="bg-image"
  style="background-color: #8c9298; padding: 13rem 0;">
  <div class="mask d-flex align-items-center gradient-custom-3">
    <div class="container">
      <div class="row d-flex justify-content-center align-items-center">
        <div class="col-12 col-md-9 col-lg-7 col-xl-6" style="width: 90%">
          <div class="card text-center" style="border-radius: 15px;">
            <div class="card-body p-5" style="padding: 6rem !important">
              <h2 class="text-uppercase text-center mb-5" style="margin-bottom: 4rem !important;">회원 검색</h2>
<!-- 컨테이너 시작 -->
<div id="ilchon-container" class="mx-auto text-center">

<!-- 검색 collapse btn box 시작 -->
<p style="margin: 2.5rem;">
  <button class="btn btn-primary search-btn" type="button" data-bs-toggle="collapse" data-bs-target="#searchById" aria-expanded="false" aria-controls="collapseExample">
    회원 ID 검색
  </button>
  <button class="btn btn-primary search-btn" type="button" data-bs-toggle="collapse" data-bs-target="#searchByName" aria-expanded="false" aria-controls="collapseExample">
    회원명 검색
  </button>
  <button class="btn btn-primary search-btn" type="button" data-bs-toggle="collapse" data-bs-target="#searchByEmail" aria-expanded="false" aria-controls="collapseExample">
    이메일 주소 검색
  </button>
</p>
<!-- 검색 collapse btn box 끝 -->

<div class="collapse" id="searchById">
  <div class="card card-body search-body">
	<h5>회원 ID로 검색</h5>
		<div class="input-group mb-3 search-input-box">
   		  <input type="text" class="form-control" placeholder="회원 ID 입력 (예: member)" name="searchId" id="searchId" aria-describedby="button-addon1" required>
		  <button class="btn btn-outline-secondary" type="submit" id="button-addon1" onclick="searchMember('searchId');">검색</button>
		</div>
     	<div id="searchIdRender">

        </div>
  </div>
<br/>
</div>
<div class="collapse" id="searchByName">
  <div class="card card-body search-body">
	<h5>회원명으로 검색</h5>
		<div class="input-group mb-3 search-input-box">
   		  <input type="text" class="form-control" placeholder="회원명 입력 (예: 홍길동)" name="searchName" id="searchName" aria-describedby="button-addon3" required>
		  <button class="btn btn-outline-secondary" type="submit" id="button-addon3" onclick="searchMember('searchName');">검색</button>
		</div>
     	<div id="searchNameRender">

        </div>
  </div>
<br/>
</div>
<div class="collapse" id="searchByEmail">
  <div class="card card-body search-body">
	<h5>이메일 주소로 검색</h5>
	<p class="card-text search-card-text"><i class="bi bi-exclamation-circle " style="color: #999;"></i> 이메일 공개 범위가 [비공개]로 설정되어 있을 경우, 검색 결과에 나타나지 않습니다.</p>
		<div class="input-group mb-3 search-input-box" style="width: 23rem;">
   		  <input type="email" class="form-control" placeholder="이메일 입력 (예: mail@java.com)" name="searchEmail" id="searchEmail" aria-describedby="button-addon2" required>
		  <button class="btn btn-outline-secondary" type="submit" id="button-addon2" onclick="searchMember('searchEmail');">검색</button>
		</div>
     	<div id="searchEmailRender">

        </div>
  </div>
<br/>
</div>



</div>
<!-- 컨테이너 끝 -->
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>




<script>

function searchMember(param){

	if (param == 'searchId' || param == 'searchName'){
		const argument = $("#"+param).val();
		// 미입력 또는 공백입력 방지
		if(argument.replace(/\s| /gi, "").length == 0) {
			alert("검색할 회원의 ID를 입력해주세요.");
			 $("#"+param).focus;
		} else {
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
			
			$.ajax({
		    	url: `${pageContext.request.contextPath}/member/search.do?param=`+param+`&argument=`+argument,
		        type: "GET",
				dataType : "json",
	 			headers, 
				async: false, 
		        error: function(){
		        	window.alert("회원 검색 중 오류가 발생했습니다.");
		        },
				success: function(data){
					console.log(data);
	  				renderList(data, param); 
	 				$('#'+param+'Render').show();
				}
		    })
		}
	}
	if (param == 'searchEmail'){
		const argument = $("#"+param).val();
		let exptext = /^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/;

		// 미입력 또는 공백입력 방지
		if(argument.replace(/\s| /gi, "").length == 0 || exptext.test(argument)==false ) {
			alert("이메일 주소 형식에 맞게 입력해주세요.");
			 $("#"+param).focus;
		} else {
			const csrfHeader = "${_csrf.headerName}";
			const csrfToken = "${_csrf.token}";
			const headers = {};
			headers[csrfHeader] = csrfToken;
			
			$.ajax({
				url: `${pageContext.request.contextPath}/member/search.do?param=`+param+`&argument=`+argument,
		        type: "GET",
				dataType : "json",
	 			headers, 
				async: false, 
		        error: function(){
		        	window.alert("회원검색 중 오류가 발생했습니다.");
		        },
				success: function(data){
					console.log(data);
					/* 검색 결과 렌더링 */
	  				renderList(data, param); 
	 				$('#'+param+'Render').show();
				}
		    })
		}
	}
	
}

/* 검색 결과 렌더링 */
function renderList(data, param) {
	const container = document.querySelector('#'+param+'Render');
	let html = `<table class="table table-hover" style="text-align: center;">
		<thead>
		  <tr class="memberList" style="border-bottom: hidden;">
		    <th colspan="4">검색 결과</th>
		  </tr>
		  <tr class="memberList ">
		    <td>회원명 (ID)</td>
		    <td>성별</td>
		    <td colspan="2">메뉴</td>
		  </tr>
		</thead>
		<tbody id="`+param+`Result">`
	 
	// 반복처리
	for(let i = 0; i< data.length; i++) {
		let resultId = data[i].hompyId;
		html += `<tr>
				<td><span class="profile-name" onclick="visitMh(`+data[i].hompyId+`)">`+data[i].name+`</span> (`+data[i].memberId+`)</td>
			    <td>`+data[i].gender+`</td>
			    <td style="width: 20%"><button type="button" class="btn btn-outline-success btn-sm" onclick="visitMh(`+data[i].hompyId+`)">미니홈피 방문</button></td>
			    <td style="width: 15%">
				<a type="button" class="btn btn-outline-primary btn-sm ilchon-request `;
		
		/* ilchonIdList에 hompyId가 있을 경우, 일촌신청 버튼을 비활성화하여 중복신청 막기 */
		if (ilchonIdList.includes(resultId) == true || myHompyId == resultId) {
			html += `disabled disabled-btn`;
		}
		      
		html += `" data-member-id-1="${principal.memberId}" data-member-id-2="`+data[i].memberId+`"
			     data-hompy-id-1="${principal.hompyId}" data-hompy-id-2="`+resultId+`"
			     data-member-name-1="${principal.name}" data-member-name-2="`+data[i].name+`"
			     >일촌 신청</a></td>
		     </tr>`;

	}
	
	html+= `</tbody></table>`;
	
	container.innerHTML = html;
	
	const container2 = document.querySelector('#'+param+'Result');
	/* console.log(container.innerText); */
	if (container2.innerText == ``) {
		let html = `<td colspan="4" class="empty-tbody">검색 결과가 없습니다.</td>`;
		container2.innerHTML = html;
	}

	
}


</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
