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


<title>일촌 신청 정보</title>

<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<link href="${pageContext.request.contextPath}/resources/css/minihompy/layout.css" rel="stylesheet" />
<link href="${pageContext.request.contextPath}/resources/css/minihompy/font.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
	
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>



<c:if test="${not empty msg}">
	<c:choose>
		<c:when test="${msg eq '일촌 신청이 완료되었습니다.'}">
			<script> 
				alert('${msg}');
				opener.parent.location.reload();
				window.close();
			</script>
		</c:when>
		<c:otherwise> 
			<script>
				alert('${msg}');
			</script>	
		</c:otherwise>
	</c:choose>
</c:if>

<body>
<header style="text-align: center; font-size: 32px; margin: 0 auto; padding-top: 7%;">일촌 신청</header>
	<div class="container">
	<div class="card ilchon-card" >
		<div class="ilchon-request-sender-box border-bottom">
			<span>보내는이 : <span class="profile-name" onclick="visitMh(${ilchon.hompyId1})">${ilchon.name1}</span></span>
			<div class="ilchon-request-sender">
				<div class="ilchon-request-sender-img">
					<c:choose>
						<c:when test="${fn:contains(principal.gender, 'M')}">
			               	<img src="${pageContext.request.contextPath}/resources/images/male.png" alt="아바타"/>
			               </c:when>
			               <c:when test="${fn:contains(principal.gender, 'F')}">
			               	<img src="${pageContext.request.contextPath}/resources/images/female.png" alt="아바타"/>
			               </c:when>
					</c:choose>
				</div>
				
				<div class="ilchon-request-info">
					<span><span class="profile-name" onclick="visitMh(${ilchon.hompyId2})">${ilchon.name2}</span>님에게<br/> 일촌을 신청합니다.</span>
				</div>
			</div>
			
		</div>
		
		<form name="ilchonFrm" action="${pageContext.request.contextPath}/ilchon/enroll.do" method="post"> 
			<input type="hidden" name="memberId1" value="${ilchon.memberId1}" class="form-control" >
			<input type="hidden" name="memberId2" value="${ilchon.memberId2}" class="form-control" >
			<input type="hidden" name="hompyId1" value="${ilchon.hompyId1}" class="form-control" >
			<input type="hidden" name="hompyId2" value="${ilchon.hompyId2}" class="form-control" >
			<input type="hidden" name="name1" value="${ilchon.name1}" class="form-control" >
			<input type="hidden" name="name2" value="${ilchon.name2}" class="form-control" >
		<div class="ilchon-name-box">
			<span class="profile-name" onclick="visitMh(${ilchon.hompyId1})">${ilchon.name1}</span>님을
			<span class="profile-name" onclick="visitMh(${ilchon.hompyId2})">${ilchon.name2}</span>님의 
				<input type="text" class="form-control input-ilchon-name" name="ilchonName1" placeholder="일촌" >로<br/>
			<span class="profile-name" onclick="visitMh(${ilchon.hompyId2})">${ilchon.name2}</span>님을
			<span class="profile-name" onclick="visitMh(${ilchon.hompyId1})">${ilchon.name1}</span>님의
				<input type="text" class="form-control input-ilchon-name" name="ilchonName2" placeholder="일촌" >로<br/>
			<textarea class="form-control input-ilchon-name" name="msg" rows="2" placeholder="우리 일촌할까요?"></textarea>
			<p class="card-text setting-card-text">상대방이 동의하면 일촌이 맺어집니다.</p>
		</div>
			<div style="margin: 0 auto;	text-align: center;">
	 			<sec:csrfInput /> 
				<input type="submit" class="button_submit ilcon-button" value="보내기" >
				<input type="submit" class="button_submit ilcon-button" value="취소" onclick="javascript:window.close();" style="background-color: #a7acb1;" >
			</div>
		</form>
	
	</div>
	
	
    
	</div>
</body>

<style>
	* {margin: 0; padding: 0; box-sizing: border-box;}
	body {background: #f6f6f6; color: #444; font-family: 'Roboto', sans-serif; font-size: 16px; line-height: 1; width: 100%; height: 100%;}
	.container {
	    max-width: 100%;
	    padding: 2rem;
	}

</style>

</html>