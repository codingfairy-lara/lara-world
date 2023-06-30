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


<title>다이어리 업로드</title>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://unpkg.com/gijgo@1.9.14/js/gijgo.min.js" type="text/javascript"></script>
<link href="https://unpkg.com/gijgo@1.9.14/css/gijgo.min.css" rel="stylesheet" type="text/css" />

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>



<c:if test="${not empty msg}">
	<c:choose>
		<c:when test="${msg eq '다이어리 작성이 완료되었습니다.'}">
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
<header style="text-align: center; font-size: 32px; margin: 0 auto; padding-top: 7%;">새 다이어리 작성</header>
<main class="main_full">
	<div class="container">
	<form name="diaryFrm" action="${pageContext.request.contextPath}/diary/enroll.do" method="post"> 
		<input type="hidden" name="hompyId" value="${myHompyId}" class="form-control" >
		<div class="mb-3">
		  <label for="diaryDate" class="form-label" >날짜</label>
	      <input id="datepicker" name="diaryDate" width="70%"/>
		</div>
		<div class="mb-3">
		  <label for="content" class="form-label">다이어리 내용</label>
		  <textarea class="form-control" id="content" name="content" rows="6" placeholder="내용을 입력해 주세요." required></textarea>
		</div>
		
		<div style="margin: 0 auto;	text-align: center;">
 			<sec:csrfInput /> 
			<input type="submit" class="button_submit" value="작성 완료" style="margin: 20px auto; font-family: 'Roboto', sans-serif; font-size: 16px; line-height: 1;" >
		</div>
	</form>
	
	
    <script>

        $('#datepicker').datepicker({
/*         	dateFormat: 'yy-mm-dd', */
        	format: 'yyyy-mm-dd', // 데이트피커 버전에 따라 포멧 설정 형식이 다름.
            uiLibrary: 'bootstrap5'
        });
        
/*         document.getElementById('datepicker').value = new Date().toISOString().substring(0, 10); */  // 한국시간으로 변경하기!
       	 var date = new Date();
         date.setHours(date.getHours() + 9);
         date_format = date.toISOString().replace('T', ' ').substring(0, 10);
         document.getElementById('datepicker').placeholder = date_format;

    </script>
    
	</div>
</main>
</body>

<style>
	* {margin: 0; padding: 0; box-sizing: border-box;}
	body {background: #f6f6f6; color: #444; font-family: 'Roboto', sans-serif; font-size: 16px; line-height: 1; width: 95%; height: 100%;}
	.container {max-width: 60%; padding: 0 20px; /* margin:0 auto; */ margin: 70px auto 35px;}
	.button_submit {
		background: #f36841;
	    border-radius: 30px;
	    border: none;
	    text-align: center;
	    color: #fff;
	    font-weight: 400;
	    height: 50px;
	    width: 200px;
	    display: inline-block;
	    transition: .2s;
	    position: relative;
	    overflow: hidden;
	}
	textarea {
	    border: none;
	    resize: none;
  	}
</style>

</html>