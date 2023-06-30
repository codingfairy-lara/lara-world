<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<sec:authentication property="principal" var="principal" />

<script>
window.addEventListener('load', () => {
	$(staticBackdrop)
		.modal()
		.on('hide.bs.modal', (e) => {
			// x버튼, 취소버튼, 모달외 영역을 클릭한 경우
			location.href = "${pageContext.request.contextPath}/";
		});
});
</script>

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="회원정보" name="title"/>
</jsp:include>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered modal-lg">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="staticBackdropLabel">내 정보 수정</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">

<div id="update-container">
	<form:form name="memberUpdateFrm" action="${pageContext.request.contextPath}/member/memberUpdate.do" method="post">
	<input type="text" class="form-control" placeholder="아이디 (4글자이상)" name="memberId" id="memberId" 
		value='<sec:authentication property="principal.username"/>' readonly required/>
	<input type="text" class="form-control" placeholder="이름" name="name" id="name" value='<sec:authentication property="principal.name"/>' required/>
	<fmt:parseDate value="${principal.birthday}" pattern="yyyy-MM-dd" var="birthday"/>
	<input type="date" class="form-control" placeholder="생일" name="birthday" id="birthday" 
		value='<fmt:formatDate value="${birthday}" pattern="yyyy-MM-dd"/>'/>
	<input type="email" class="form-control" placeholder="이메일" name="email" id="email" value="${principal.email}" required/>
	<input type="tel" class="form-control" placeholder="전화번호 (예:01012345678)" name="phone" id="phone" maxlength="11" value="${principal.phone}" required/>
	<br />

     </form:form>
</div>

      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary" onclick="editMember();">수정하기</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
