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
	<c:choose>
		<c:when test="${msg eq '프로필을 성공적으로 저장했습니다.'}">
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
<title>프로필 업로드</title>

<header style="text-align: center; font-size: 32px; margin: 0 auto; padding-top: 5%;">새 프로필 작성</header>
<main class="main_full" style="width: 95%;">
	<div class="container">
 		<form name="profileFrm" action="${pageContext.request.contextPath}/profile/enroll.do" method="post" enctype="multipart/form-data"> 
		<input type="hidden" name="hompyId" value="${myHompyId}" class="form-control" >
		<div class="panel">
			<div class="button_outer">
				<div class="btn_upload">
					<input type="file" id="upload_file" name="upload_file" class="custom-file-input" required>
					이미지 업로드
				</div>
				<div class="processing_bar"></div>
				<div class="success_box"></div>
			</div>
		</div>
		<div class="error_msg"></div>
		<div class="uploaded_file_view" id="uploaded_view">
			<span class="file_remove">X</span>
		</div>
		<div style="margin: 0 auto;	text-align: center;">
			<input type="text"class="form-control" name="content" style="display: inline-block; width: 60%; height: 10%;" required>
			<br><sec:csrfInput /> 
			<input type="submit" class="btn btn-primary btn-xl" value="작성 완료" style="margin: 30px auto; font-family: 'Roboto', sans-serif; font-size: 16px; line-height: 1;" >
		</div>
 		</form> 
	</div>
</main>

<script>

var btnUpload = $("#upload_file"),
		btnOuter = $(".button_outer");
	btnUpload.on("change", function(e){
		var ext = btnUpload.val().split('.').pop().toLowerCase();
		if($.inArray(ext, ['gif','png','jpg','jpeg']) == -1) {
			$(".error_msg").text("이미지 파일이 아닙니다.");
		} else {
			$(".error_msg").text("");
			btnOuter.addClass("file_uploading");
			setTimeout(function(){
				btnOuter.addClass("file_uploaded");
			},3000);
			var uploadedFile = URL.createObjectURL(e.target.files[0]);
			setTimeout(function(){
				$("#uploaded_view").append('<img src="'+uploadedFile+'" />').addClass("show");
			},3500);
		}
	});
	$(".file_remove").on("click", function(e){
		$("#uploaded_view").removeClass("show");
		$("#uploaded_view").find("img").remove();
		btnOuter.removeClass("file_uploading");
		btnOuter.removeClass("file_uploaded");
	});
</script>

<style>
	* {margin: 0; padding: 0; box-sizing: border-box;}
	*, *::before, *::after {
    	box-sizing: content-box;
	}
	body {background: #f6f6f6; color: #444; font-family: 'Roboto', sans-serif; font-size: 16px; line-height: 1; width: 98%; height: 100%;}
	.container {max-width: 1100px; padding: 0 20px; margin:0 auto;}
	.panel {margin: 72px auto 35px; max-width: 500px; text-align: center;}
	.button_outer {background: #f36841; border-radius:30px; text-align: center; height: 50px; width: 200px; display: inline-block; transition: .2s; position: relative; overflow: hidden;}
	.btn_upload {padding: 17px 30px 12px; color: #fff; text-align: center; position: relative; display: inline-block; overflow: hidden; z-index: 3; white-space: nowrap;}
	.btn_upload input {position: absolute; width: 100%; left: 0; top: 0; width: 100%; height: 105%; cursor: pointer; opacity: 0;}
	.file_uploading {width: 100%; height: 10px; margin-top: 20px; background: #ccc;}
	.file_uploading .btn_upload {display: none;}
	.processing_bar {position: absolute; left: 0; top: 0; width: 0; height: 100%; border-radius: 30px; background:#f36841; transition: 3s;}
	.file_uploading .processing_bar {width: 100%;}
	.success_box {display: none; width: 50px; height: 50px; position: relative;}
	.success_box:before {content: ''; display: block; width: 9px; height: 18px; border-bottom: 6px solid #fff; border-right: 6px solid #fff; -webkit-transform:rotate(45deg); -moz-transform:rotate(45deg); -ms-transform:rotate(45deg); transform:rotate(45deg); position: absolute; left: 17px; top: 10px;}
	.file_uploaded .success_box {display: inline-block;}
	.file_uploaded {margin-top: 0; width: 50px; background:#f36841; height: 50px;}
	.uploaded_file_view {max-width: 300px; margin: 38px auto; text-align: center; position: relative; transition: .2s; opacity: 0; border: 2px solid #ddd; padding: 15px;}
	.file_remove{width: 30px; height: 30px; border-radius: 50%; display: block; position: absolute; background: #aaa; line-height: 30px; color: #fff; font-size: 12px; cursor: pointer; right: -15px; top: -15px;}
	.file_remove:hover {background: #222; transition: .2s;}
	.uploaded_file_view img {max-width: 100%;}
	.uploaded_file_view.show {opacity: 1;}
	.error_msg {text-align: center; color: #f00}

</style>