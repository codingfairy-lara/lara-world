<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%-- spring-webmvc가 제공하는 jstl - csrf 토큰 발행 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<sec:authentication property="principal" var="principal" />
<fmt:parseNumber var="myHompyId" integerOnly="true" 
                       type="number" value="${principal.hompyId}" />

<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
<!-- bootstrap js: jquery load 이후에 작성할것.-->
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
<!-- Bootstrap core JS-->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
<!-- Core theme JS-->

<c:if test="${not empty msg}">
	<script>
		alert('${msg}');
	</script>	
</c:if>


<main class="main_full">
	<div class="container" style="padding: 5;">
	
	<c:if test="${empty profileHistory}">
	<div style="text-align: center; margin: 50% 0 auto;">
		프로필 히스토리가 없습니다.
	</div>
	</c:if>	
	<c:forEach items="${profileHistory}" var="profile" varStatus="vs">
	 	<div class="card" style="width: 22rem; margin: 25 auto;">
	 	<c:if test="${profile.hompyId == myHompyId}">
<%-- 	 	<form id="profileDeleteFrm" name="profileDeleteFrm">
 			<input type="hidden" name="no" value="${profile.no}" class="form-control" > --%>
<%--   			<input type="submit" class="file_remove" style="font-size: 1.5rem; text-align: center; border: 0;"" value="X" data-no="${profile.no}"> --%>
 	 		<button type="submit" class="file_remove" data-no="${profile.no}">X</button> 
<%-- 	 	</form> --%>
	 	</c:if>
           <img 
             class="profile-image-img" 
             src="${pageContext.request.contextPath}/profile/images/${profile.attachment.renamedFilename}"
             alt="프로필 이미지" />
		  <div class="card-body" style=" padding-bottom: 7;" >
		    <p class="card-text">${profile.content}</p>
		    <p class="card-text" style="font-size: 12px; text-align: right;"> 작성일 : 
		    			<fmt:parseDate value="${profile.createdAt}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="createdAt"/>
						<fmt:formatDate value="${createdAt}" pattern="yyyy-MM-dd HH:mm"/>
			</p>
		  </div>
		</div>
	</c:forEach>
	
	</div>
</main>
	<script>
	$(document).on("click", "button.file_remove", function(){
		let no = $(this).attr("data-no");
		if(confirm("선택한 프로필을 삭제 하시겠습니까?")){
			delAddressItem(no);
		}
	})
	
	function delAddressItem(no){
		
		const csrfHeader = "${_csrf.headerName}";
		const csrfToken = "${_csrf.token}";
		const headers = {};
		headers[csrfHeader] = csrfToken;
 		
		$.ajax({
			url : `${pageContext.request.contextPath}/profile/delete.do`,
			data : {no : no},
			type : "POST",
			headers,
 			async: false, 
			error : function(request, status, error){
				console.log("Code:"+request.status+" / Message:"+request.responseText+" / Error: "+error);
			},
			success: function(data){
					window.alert("프로필 삭제가 완료되었습니다.");
					document.location.reload(true);
					opener.parent.location.reload();

			}
		})
		
	}
    </script>  

<style>
	* {margin: 0; padding: 0;}
	body {background: #f6f6f6; color: #444; font-family: 'Roboto', sans-serif; font-size: 16px; line-height: 1;}
	.file_remove{
	    width: 30px;
	    height: 30px;
	    border-radius: 50%;
	    display: block;
	    position: absolute;
	    background: #aaa;
	    line-height: 30px;
	    color: #fff;
	    font-size: 18px;
	    cursor: pointer;
	    right: -15px;
	    top: -15px;
	    border: 0;
    }
	.file_remove:hover {background: #222; transition: .2s;}
</style>