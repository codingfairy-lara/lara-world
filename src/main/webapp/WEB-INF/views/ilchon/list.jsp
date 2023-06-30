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

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="일촌 관리" name="title"/>
</jsp:include>

<script>
$(".masthead").hide();
</script>

<section class="bg-image"
  style="background-color: #9b9391; padding: 10rem 0;">
  <div class="mask d-flex align-items-center h-100 gradient-custom-3">
    <div class="container h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-9 col-lg-7 col-xl-6" style="width: 90%">
          <div class="card text-center" style="border-radius: 15px;">
            <div class="card-body p-5" style="padding: 6rem !important">
              <h2 class="text-uppercase text-center mb-5" style="margin-bottom: 4rem !important;">일촌 관리</h2>

<div id="ilchon-container" class="mx-auto text-center">

<div class="accordion" id="accordionPanelsStayOpenExample">
  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingOne">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseOne" aria-expanded="false" aria-controls="panelsStayOpen-collapseOne">
      	일촌 신청 <c:if test="${not empty ilchonRequests}">&nbsp;<span class="badge text-bg-danger">${ilchonRequests.size()}</span></c:if>
      </button>
    </h2>
    <div id="panelsStayOpen-collapseOne" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingOne">
      <div class="accordion-body ilchon-body">
        <c:if test="${empty ilchonRequests}">
			<div style="text-align: center; margin: 7% 0; color: #999;">
				받은 일촌 신청이 없습니다.
			</div>
        </c:if>
        <c:if test="${not empty ilchonRequests}">
			<table class="table table-hover">
			  <thead>
			    <tr>
			      <th scope="col">보낸 사람</th>
			      <th scope="col">일촌명</th>
			      <th scope="col">받는 사람</th>
			      <th scope="col">일촌명</th>
			      <th scope="col" style="width: 45%;">메세지</th>
			    </tr>
			  </thead>
			  <tbody>
			<c:forEach items="${ilchonRequests}" var="request" varStatus="vs">
			    <tr class="ilchon-request-tr" onclick="popupIlchonRequest(${request.no})">
			      <td>${request.name1}</td>
			      <td>(${request.ilchonName1})</td>
			      <td>${request.name2}</td>
			      <td>(${request.ilchonName2})</td>
			      <td>${request.msg}</td>
			    </tr>
			</c:forEach>
			  </tbody>
			</table>
		</c:if>
      </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingTwo">
      <button class="accordion-button collapsed" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseTwo" aria-expanded="false" aria-controls="panelsStayOpen-collapseTwo">
        일촌명 변경 신청 <c:if test="${not empty editRequests}">&nbsp;<span class="badge text-bg-danger">${editRequests.size()}</span></c:if>
      </button>
    </h2>
    <div id="panelsStayOpen-collapseTwo" class="accordion-collapse collapse" aria-labelledby="panelsStayOpen-headingTwo">
      <div class="accordion-body ilchon-body">
        <c:if test="${empty editRequests}">
			<div style="text-align: center; margin: 7% 0; color: #999;">
				받은 일촌명 변경 신청이 없습니다.
			</div>
        </c:if>
        <c:if test="${not empty editRequests}">
        	<table class="table table-hover">
			  <thead>
			    <tr>
			      <th scope="col">보낸 사람</th>
			      <th scope="col">일촌명 변경</th>
			      <th scope="col">받는 사람</th>
			      <th scope="col">일촌명 변경</th>
			    </tr>
			  </thead>
			  <tbody>
			<c:forEach items="${editRequests}" var="request" varStatus="vs">
			    <tr class="ilchon-request-tr" onclick="popupIlchonRequest(${request.no})">
			      <td>${request.name1}</td>
			      <td>(${request.ilchonName1}) -> (${request.newName1})</td>
			      <td>${request.name2}</td>
			      <td>(${request.ilchonName2}) -> (${request.newName2})</td>
			    </tr>
			</c:forEach>
			  </tbody>
			</table>
        </c:if>
      </div>
    </div>
  </div>
  <div class="accordion-item">
    <h2 class="accordion-header" id="panelsStayOpen-headingThree">
      <button class="accordion-button" type="button" data-bs-toggle="collapse" data-bs-target="#panelsStayOpen-collapseThree" aria-expanded="true" aria-controls="panelsStayOpen-collapseThree">
        일촌 목록
      </button>
    </h2>
    <div id="panelsStayOpen-collapseThree" class="accordion-collapse collapse show" aria-labelledby="panelsStayOpen-headingThree">
	<div class="accordion-body ilchon-body">
        <c:if test="${empty ilchonList}">
			<div style="text-align: center; margin: 7% 0; color: #999;">
				일촌 목록이 비어있습니다.
			</div>
        </c:if>
        <c:if test="${not empty ilchonList}">
       		<table class="table table-hover">
			  <thead>
			    <tr class="ilchonList">
			      <th scope="col">나의 일촌명</th>
			      <th scope="col">-</th>
			      <th scope="col">상대의 일촌명</th>
			      <th scope="col" style="width: 45%;">일촌 관리</th>
			    </tr>
			  </thead>
			  <tbody>
			<c:forEach items="${ilchonList}" var="ilchon" varStatus="vs">
			<c:choose>
				<c:when test="${ilchon.name1 == principal.name}">
				    <tr class="ilchonList">
				      <td><span class="profile-name" onclick="visitMh(${ilchon.hompyId1})">${ilchon.name1}</span> (${ilchon.ilchonName1})</td>
				      <td>-</td>
				      <td><span class="profile-name" onclick="visitMh(${ilchon.hompyId2})">${ilchon.name2}</span> (${ilchon.ilchonName2})</td>
				      <td>
				      	<button type="button" class="btn btn-outline-success btn-sm" onclick="visitMh(${ilchon.hompyId2})">미니홈피 방문</button>
				      	<button type="button" class="btn btn-outline-primary btn-sm" onclick="popupIlchonEditFrm(${ilchon.no})">일촌명 변경</button>
				      	<button type="button" class="btn btn-outline-danger btn-sm ilchon-remove" data-no="${ilchon.no}" data-name="${ilchon.name2}">일촌 끊기</button>
				      </td>
				    </tr>
				</c:when>
				<c:when test="${ilchon.name2 == principal.name}">
				    <tr class="ilchonList">
				      <td><span class="profile-name" onclick="visitMh(${ilchon.hompyId2})">${ilchon.name2}</span> (${ilchon.ilchonName2})</td>
   				      <td>-</td>
				      <td><span class="profile-name" onclick="visitMh(${ilchon.hompyId1})">${ilchon.name1}</span> (${ilchon.ilchonName1})</td>
				      <td>
				      	<button type="button" class="btn btn-outline-success btn-sm" onclick="visitMh(${ilchon.hompyId1})">미니홈피 방문</button>
				      	<button type="button" class="btn btn-outline-primary btn-sm" onclick="popupIlchonEditFrm(${ilchon.no})">일촌명 변경</button>
				      	<button type="button" class="btn btn-outline-danger btn-sm ilchon-remove" data-no="${ilchon.no}" data-name="${ilchon.name1}">일촌 끊기</button>
				      </td>
				    </tr>
				</c:when>
			</c:choose>
			
			</c:forEach>
			  </tbody>
			</table>
		</c:if>
      </div>
    </div>
  </div>
</div>



</div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>

<script>

$(document).on("click", "button.ilchon-remove", function(){
	let no = $(this).attr("data-no");
	let name = $(this).attr("data-name");
	if(confirm(name+"님과 맺은 일촌을 끊으시겠습니까?")){
		deleteIlchon(no);
	}
})

function deleteIlchon(no){
	const csrfHeader = "${_csrf.headerName}";
	const csrfToken = "${_csrf.token}";
	const headers = {};
	headers[csrfHeader] = csrfToken;
		
	$.ajax({
		url : `${pageContext.request.contextPath}/ilchon/delete.do`,
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

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
