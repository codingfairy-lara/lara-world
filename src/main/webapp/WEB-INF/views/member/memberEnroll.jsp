<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%-- spring-webmvc가 제공하는 jstl - csrf 토큰 발행 --%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>


<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원등록" name="title"/>
</jsp:include>

<script>
$(".masthead").hide();

</script>

<section class="vh-100 bg-image"
  style="background-image: url('https://mdbcdn.b-cdn.net/img/Photos/new-templates/search-box/img4.webp');">
  <div class="mask d-flex align-items-center h-100 gradient-custom-3">
    <div class="container h-100">
      <div class="row d-flex justify-content-center align-items-center h-100">
        <div class="col-12 col-md-9 col-lg-7 col-xl-6">
          <div class="card text-center" style="border-radius: 15px;">
            <div class="card-body p-5">
              <h2 class="text-uppercase text-center mb-5">Create an account</h2>

<div id="enroll-container" class="mx-auto text-center">
	<form:form name="memberEnrollFrm" action="" method="POST">
		<table class="mx-auto w-100">
		<tbody style="height: 450px;">
			<tr>
				<th>아이디</th>
				<td>
					<div id="memberId-container">
			            <input type="text" class="form-control" placeholder="아이디(4글자 이상)" name="memberId" id="memberId" required>
			            <span class="guide ok" style="display: none;">이 아이디는 사용가능합니다.</span>
			            <span class="guide error" style="display: none;">이 아이디는 사용할 수 없습니다.</span>
			            <span class="guide empty" style="display: none;">4글자 이상 입력하세요.</span>
			            <input type="hidden" id="idValid" value="0"/>
			        </div>

				</td>
			</tr>
			<tr>
				<th>패스워드</th>
				<td>
					<input type="password" class="form-control" name="password" id="password" required>
				</td>
			</tr>
			<tr>
				<th>패스워드확인</th>
				<td>	
					<input type="password" class="form-control" id="passwordCheck" required>
				</td>
			</tr>  
			<tr>
				<th>이름</th>
				<td>	
					<input type="text" class="form-control" name="name" id="name" required>
				</td>
			</tr>
			<tr>
				<th>성별</th>
				<td>	
			    <div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="gender" id="gender0" value="M" checked>
				  <label class="form-check-label" for="gender0">남</label>
				</div>
				<div class="form-check form-check-inline">
				  <input class="form-check-input" type="radio" name="gender" id="gender1" value="F">
				  <label class="form-check-label" for="gender1">여</label>
				</div>
				</td>
			</tr>
			<tr>
				<th>생년월일</th>
				<td>	
					<input type="date" class="form-control" name="birthday" id="birthday"/>
				</td>
			</tr> 
			<tr>
				<th>이메일</th>
				<td>	
					<input type="email" class="form-control" placeholder="abc@xyz.com" name="email" id="email">
				</td>
			</tr>
			<tr>
				<th>휴대폰</th>
				<td>	
					<input type="tel" class="form-control" placeholder="(-없이)01012345678" name="phone" id="phone" maxlength="11" required>
				</td>
			</tr>
		</tbody>
		</table>
		<div style="margin-top: 25px;">
			<input class="btn btn-light btn-xl" type="reset"  onclick="location.href='${pageContext.request.contextPath}/#signUp';" value="취소">
			<input class="btn btn-primary btn-xl" type="submit" value="가입" >
		</div>
	</form:form>
</div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>


<script>
const guides = document.querySelectorAll(".guide");
const ok = document.querySelector(".ok");
const error = document.querySelector(".error");
const empty = document.querySelector(".empty");
const idValid = document.querySelector("#idValid")

/**
 * 아이디 4글자이상인 경우 server로 전송해 사용가능여부를 표시한다.
 */
document.querySelector("#memberId").addEventListener("keyup", (e) => {
	console.log(e.target.value);
	const memberId = e.target;
	if(memberId.value.length < 4){
		// 초기화처리
		ok.style.display = "none";
		error.style.display = "none";
		empty.style.display = "inline";
		idValid.value = 0;
		return;
	}
	

	
	$.ajax({
		url : "${pageContext.request.contextPath}/member/checkIdDuplicate3.do",
		data : {memberId : memberId.value},
		method : "GET",
		dataType : "json",
		success(data){
			console.log(data);
			const {memberId, available} = data;
			
			if(available){
				ok.style.display = "inline";
				empty.style.display = "none";
				error.style.display = "none";
				idValid.value = 1;
			}
			else {
				ok.style.display = "none";
				empty.style.display = "none";
				error.style.display = "inline";
				idValid.value = 0;
			}
		},
		error : console.log
	});
	
	
	
});

document.memberEnrollFrm.addEventListener('submit', (e) => {
	if(idValid.value === "0"){
		e.preventDefault();
	}
});
</script>
<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
