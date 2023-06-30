<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<sec:authentication property="principal" var="principal" />
<%-- <c:if test="${principal.hompyId != null}">
	<<fmt:parseNumber var="myHompyId" integerOnly="true" 
                       type="number" value="${principal.hompyId}" />
</c:if> --%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${param.title}</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="${pageContext.request.contextPath}/resources/assets/favicon.ico" />
<!-- Bootstrap Icons-->
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" />
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Merriweather+Sans:400,700" rel="stylesheet" />
<link href="https://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic" rel="stylesheet" type="text/css" />
<!-- SimpleLightbox plugin CSS-->
<link href="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.css" rel="stylesheet" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- SimpleLightbox plugin JS-->
<script src="https://cdnjs.cloudflare.com/ajax/libs/SimpleLightbox/2.1.0/simpleLightbox.min.js"></script>
<!-- Core theme JS-->
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>

<c:if test="${not empty msg}">
	<script>
	alert('${msg}');
	</script>	
</c:if>

</head>

<body id="page-top">
<div id="container">

        <!-- Navigation 시작 -->
        <nav class="navbar navbar-expand-lg navbar-light fixed-top py-3" id="mainNav">
            <div class="container px-4 px-lg-5">
	            <a class="navbar-brand" href="${pageContext.request.contextPath}/#page-top">
					<img src="${pageContext.request.contextPath}/resources/images/logo.png" alt="로고" width="40px" />
				</a>
                <a class="navbar-brand" href="${pageContext.request.contextPath}/#page-top">Lara World</a>
                <button class="navbar-toggler navbar-toggler-right" type="button" data-bs-toggle="collapse" data-bs-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ms-auto my-2 my-lg-0">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/#service">Lara World</a></li>
                <sec:authorize access="isAuthenticated()">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/#portfolio">Menu</a></li>
                </sec:authorize>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/ilchon/list.do">My Ilchon</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/member/memberSearch.do">Search</a></li>
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/#contact">Contact</a></li>
                <sec:authorize access="isAnonymous()">
                        <li class="nav-item"><a class="nav-link" href="${pageContext.request.contextPath}/#signUp">Sign Up</a></li>
               	</sec:authorize>
				<sec:authorize access="isAuthenticated()">
                        <li class="nav-item">
                        <form:form action="${pageContext.request.contextPath}/member/memberLogout.do" method="POST" id="LOfrm">
                        	<a class="nav-link" href="#" onclick="delCookie('visit'); document.getElementById('LOfrm').submit();">Log Out</a>		    		
			    		</form:form>
                        </li>
			    </sec:authorize>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Navigation 끝 -->
        <!-- Masthead 시작 -->
        <header class="masthead">
            <div class="container px-4 px-lg-5 h-100">
                <div class="row gx-4 gx-lg-5 h-100 align-items-center justify-content-center text-center">
                    <div class="col-lg-8 align-self-end">
                        <h1 class="text-white font-weight-bold">사이 좋은 사람들, <br/>라라 월드 :)</h1>
                        <hr class="divider" />
                    </div>
                    
			    <sec:authorize access="isAnonymous()">
                    <div class="col-lg-8 align-self-baseline">
                        <p class="text-white-75 mb-5">라라월드는 소셜 네트워킹 웹 서비스입니다. 라라월드에서는 자신의 미니홈피를 만들고,<br/>일상과 관심사를 공유하며, 다른 사람들과 소통할 수 있습니다. :)<br/>
                        Lara World is social networking web service. At Lara World, users are able to create their own home page, share their daily lives and interests, and communicate with others. :)</p>
                        <!-- Button for non-login-user -->
                        <a class="btn btn-primary btn-xl" href="#signUp">Get Started | 시작하기</a>
                    </div>
		        </sec:authorize>
		        
			    <sec:authorize access="isAuthenticated()">
                    <div class="col-lg-8 align-self-baseline">
                        <p class="text-white-75 mb-5">
                        	<a data-bs-toggle="modal" data-bs-target="#staticBackdrop">
				    		<sec:authentication property="principal.name"/></a>님, 어서오세요. 😁<br/>
				    		Welcome, <sec:authentication property="principal.name"/></a>. 😁
<%--  				    		<sec:authentication property="authorities"/> --%>
                        </p>
                        <!-- Button for mini-hompy -->
                        <a class="btn btn-primary btn-xl" onclick='popupMh(${principal.hompyId})'>나의 미니홈피</a><br/><br/>
                    </div>	



				<!-- 내정보 수정 Modal 시작 -->
						<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
						  <div class="modal-dialog modal-dialog-centered modal-lg">
						    <div class="modal-content">
						      <div class="modal-header">
						        <h5 class="modal-title" id="staticBackdropLabel">내 정보 수정</h5>
						        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
						      </div>
						      <div class="modal-body">

						<div class="update-container">
							<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate.do" method="post" class="update-frm">
							<div class="mb-3 update-input-box">
  								<label for="memberId" class="form-label update-info-label">아이디</label>
								<input type="text" class="form-control update-info" placeholder="아이디 (4글자이상)" name="memberId_" 
									value='<sec:authentication property="principal.username"/>'  disabled readonly/>
								<input type="hidden" name="memberId" id="memberId" value='<sec:authentication property="principal.username"/>' required/>
							</div>
							<div class="mb-3 update-input-box">
								<label for="name" class="form-label update-info-label">이름</label>
								<input type="text" class="form-control update-info" placeholder="이름" name="name" id="name" value='<sec:authentication property="principal.name"/>' required/>
							</div>
							<div class="mb-3 update-input-box">
								<label for="birthday" class="form-label update-info-label">생일</label>
								<fmt:parseDate value="${principal.birthday}" pattern="yyyy-MM-dd" var="birthday"/>
								<input type="date" class="form-control update-info" placeholder="생일" name="birthday" id="birthday" 
									value='<fmt:formatDate value="${birthday}" pattern="yyyy-MM-dd"/>'/>
							</div>
							<div class="mb-3 update-input-box">
								<label for="email" class="form-label update-info-label">이메일</label>
								<input type="email" class="form-control update-info" placeholder="이메일" name="email" id="email" value="${principal.email}" required/>
							</div>
							<div class="mb-3 update-input-box">
								<label for="phone" class="form-label update-info-label">전화번호</label>
								<input type="tel" class="form-control update-info" placeholder="전화번호 (예:01012345678)" name="phone" id="phone" maxlength="11" value="${principal.phone}" required/>
							</div>
								<br />
						      </form:form>
						</div>
						      </div>
						      <div class="modal-footer">
						        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
						        <button type="button" class="btn btn-primary"  onclick="editMember();">수정하기</button>
						      </div>
						    </div>
						  </div>
						</div>
		        <!-- 내정보 수정 Modal 끝 -->
		        </sec:authorize>
		        
                  </div>
              </div>
        </header>
        <!-- Masthead 끝 -->

	<section id="content">