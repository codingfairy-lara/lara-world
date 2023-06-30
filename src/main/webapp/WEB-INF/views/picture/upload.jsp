<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!-- spring-webmvc가 제공하는 jstl - csrf 토큰 발행 -->
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>

<sec:authentication property="principal" var="principal" />
<fmt:parseNumber var="myHompyId" integerOnly="true" 
                       type="number" value="${principal.hompyId}" />


<script src="${pageContext.request.contextPath}/resources/js/scripts.js"></script>
<!-- Core theme CSS (includes Bootstrap)-->
<link href="${pageContext.request.contextPath}/resources/css/styles.css" rel="stylesheet" />
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.8/css/fileinput.min.css"  rel="stylesheet" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.7/dist/umd/popper.min.js" integrity="sha384-zYPOMqeu1DAVkHiLqWBUTcbYfZ8osu1Nd6Z89ify25QV9guujx43ITvfi12/QExE" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.min.js" integrity="sha384-Y4oOpwW3duJdCWv5ly8SCFYWqFDsfob/3GkgExXKV4idmbt98QcxXYs9UoXAB7BZ" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>


<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.8/js/fileinput.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.8/js/plugins/sortable.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-fileinput/5.0.8/themes/fas/theme.min.js"></script>
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.5.0/js/locales/kr.js"></script>

<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.3/css/all.css" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/gh/kartik-v/bootstrap-fileinput@5.5.0/themes/fa5/theme.min.js"></script>

<c:if test="${not empty msg}">
	<c:choose>
		<c:when test="${msg eq '사진첩 게시물을 성공적으로 작성했습니다.'}">
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
<title>사진 업로드</title>

<header style="text-align: center; font-size: 32px; margin: 0 auto; padding-top: 5%;">새 사진첩 작성</header>
<main class="main_full" style="width: 100%;">
	<div class="container text-center mb-5 mt-5" style="margin-bottom : 1.5rem !important;">
	<div class="row">
		<div class="col-md-12">
			업로드 이미지
		</div>
	</div>
</div>

<section class="bg-diffrent">
	<form name="pictureFrm" action="${pageContext.request.contextPath}/picture/enroll.do" method="post" enctype="multipart/form-data"> 
    
   		<div class="container">
		<input type="hidden" name="hompyId" value="${myHompyId}" class="form-control" >
	        <div class="row">
	            <div class="col-md-12">
	                <div class="verify-sub-box">
		                 <div class="file-loading">
		                     <input id="multiplefileupload" name="upFiles" type="file" accept=".jpg,.gif,.png,.jpeg" multiple required>
	                  	 </div>
	                </div>
	            </div>
	        </div>
	    </div>
	    
	    <div style="margin: 3rem auto;	text-align: center;">
	    
   		<div class="mb-3">
		  <label for="title" class="form-label" >제목 </label><br/>
	      <input type="text" class="form-control" name="title" style="display: inline-block; width: 50%; height: 5%;" required />
		</div>
   		<div class="mb-3">
		  <label for="content" class="form-label" >내용 </label><br/>
	      <input type="text" class="form-control" name="content" style="display: inline-block; width: 50%; height: 10%;" required />
		</div>
			<br>
			<sec:csrfInput /> 
			<input type="hidden" name="_csrf" value="aa99cee1-9401-421d-a638-214bda70d142" /> 
			<input type="submit" class="btn btn-primary btn-xl" value="작성 완료" style="margin: 30px auto; font-family: 'Roboto', sans-serif; font-size: 16px; line-height: 1;" />
		</div>
    
	</form> 
    
</section>
</main>

<script>


$(document).ready(function()
	
	// input file 파일 첨부시 fileCheck 함수 실행
	{
		$("#multiplefileupload").on("change", fileCheck);
	});


	//----------multiplefile-upload---------
	$("#multiplefileupload").fileinput({
		language: 'kr',
	    'theme': 'fa',
	    'uploadUrl': `${pageContext.request.contextPath}/picture/enroll.do`,
	    maxFileCount: 5,
	    showRemove: false,
	    showUpload: false,
	    showZoom: false,
	    showCaption: false,
	    maxFileSize: 10000, /* 파일하나당 최대크기 10mb */
	    browseClass: "btn btn-danger",
	    browseLabel: "",
	    browseIcon: "<i class='fa fa-plus'></i>",
	    overwriteInitial: false,
	    initialPreviewAsData: true,
	    msgDuplicateFile: '[파일명 : "{name}" / 크기 : {size} KB] 이미 선택된 파일입니다. 중복된 파일은 목록에 추가되지 않았습니다.',
	    msgSizeTooLarge: '[파일명 : "{name}" / <b>크기 : {size} KB</b>] 파일 크기가 너무 큽니다. 허용 파일 사이즈는 <b>{maxSize} KB</b> 입니다.',
	    fileActionSettings :{
	    	showUpload: false,
	    	showZoom: false,
	      removeIcon: "<i class='fa fa-times'></i>",
	    }
	    
	});
	

</script>

<style>
	@import url('https://fonts.googleapis.com/css?family=Roboto:100,300,400,500,700,900&display=swap');
	
	button:focus,
	input:focus{
	  outline: none;
	  box-shadow: none;
	}
	a,
	a:hover{
	  text-decoration: none;
	}
	
	body{
	  font-family: 'Roboto', sans-serif;
	}
	
	/*----------multiple-file-upload-----------*/
	.input-group.file-caption-main{
	    display: none;
	}
	.close.fileinput-remove{
	    display: none;
	}
	.file-drop-zone{
	    margin: 0px;
	    border: 1px solid #fff;
	    background-color: #fff;
	    padding: 0px;
	    display: contents;
	}
	.file-drop-zone.clickable:hover{
	    border-color: #fff;
	}
	.file-drop-zone .file-preview-thumbnails{
	    display: inline;
	}
	.file-drop-zone-title{
	    padding: 15px;
	    height: 120px;
	    width: 120px;
	    font-size: 12px;
	}
	.file-input-ajax-new{
	    display: inline-block;
	}
	.file-input.theme-fa{
		display: flex;
		flex-wrap: wrap;
		align-items: center;
		justify-content: center;
	    width: 100%;
	}
	.file-preview{
	    padding: 0px;
	    border: none;
		display: flex;
    	justify-content: center;
	}
	.file-drop-zone-title{
	    display: none;
	}
	.file-footer-caption{
	    display: none !important;
	}
	.kv-file-upload{
	    display: none;
	}
	.file-upload-indicator{
	    display: none;
	}
	.file-drag-handle.drag-handle-init.text-info{
	    display: none;
	}
	.krajee-default.file-preview-frame .kv-file-content{
	    width: 90px;
	    height: 90px;
	    display: flex;
	    text-align: center;
	    align-items: center;
	}
	.krajee-default.file-preview-frame{
	    background-color: #fff;
	    margin: 3px;
	    border-radius: 15px;
	    overflow: hidden;
	}
	.krajee-default.file-preview-frame:not(.file-preview-error):hover{
	    box-shadow: none;
	    border-color: #f4623a;
		transition: 0.5s;
	}
	.krajee-default.file-preview-frame:not(.file-preview-error):hover .file-preview-image{
	    transform: scale(1.1);
	}
	.krajee-default.file-preview-frame{
	    box-shadow: none;
	    border-color: #fff;
	    max-width: 150px;
	    margin: 5px;
	    padding: 0px;
	    transition: 0.5s;
	}
	.file-thumbnail-footer,
	.file-actions{
	    width: 20px;
	    height: 20px !important;
	    position: absolute !important;
	    top: 3px;
	    right: 3px;
	}
	.kv-file-remove:focus,
	.kv-file-remove:active{
	    outline: none !important;
	    box-shadow: none !important;
	}
	.kv-file-remove{
		border-radius: 50%;
		z-index: 1;
		right: 0;
		position: absolute;
		top: 0;
		text-align: center;
		color: #fff;
		background-color: #f4623a;
		border: 1px solid #f4623a;
		padding: 3px 5px;
		font-size: 10px;
		transition: 0.5s;
	}
	.kv-file-remove:hover{
	    border-color: #fdeff0;
	    background-color: #fdeff0;
	    color: #f4623a;
	}
	.kv-preview-data.file-preview-video{
	    width: 100% !important;
	    height: 100% !important;
	}
	.btn-outline-secondary.focus, .btn-outline-secondary:focus{
	    box-shadow: none;
	}
	.btn-toggleheader,
	.btn-fullscreen,
	.btn-borderless{
	    display: none;
	}
	.btn-kv.btn-close{
	    color: #fff;
	    border: none;
	    background-color: #ed3237;
	    font-size: 11px;
	    width: 18px;
	    height: 18px;
	    text-align: center;
	    padding: 0px;
	}
	.btn-outline-secondary:not(:disabled):not(.disabled).active:focus, 
	.btn-outline-secondary:not(:disabled):not(.disabled):active:focus, 
	.show>.btn-outline-secondary.dropdown-toggle:focus{
	    background-color: rgba(255,255,255,0.8);
	    color: #000;
	    box-shadow: none;
	    color: #ed3237;
	}
	.kv-file-content .file-preview-image{
	    width: 90px !important;
	    height: 90px !important;
	    max-width: 90px !important;
	    max-height: 90px !important;
	    transition: 0.5s;
	}
	.btn-danger.btn-file{
	    padding: 0px;
	    height: 95px;
	    width: 95px;
	    display: inline-block;
	    margin: 5px;
	    border-color: #fdeff0;
	    background-color: #fdeff0;
	    color: #f4623a;
	    border-radius: 15px;
	    padding-top: 30px;
	    transition: 0.5s;
	}
	.btn-danger.btn-file:active,
	.btn-danger.btn-file:hover{
	    background-color: #fde3e5;
	    color: #f4623a;
	    border-color: #fdeff0;
	    box-shadow: none;
	}
	.btn-danger.btn-file i{
	    font-size: 30px;  
	}
	
	
	@media (max-width: 350px){
	    .krajee-default.file-preview-frame:not([data-template=audio]) .kv-file-content{
	        width: 90px;
	    }
	}

</style>