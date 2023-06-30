<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<sec:authentication property="principal" var="principal" />

<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param value="Lara World" name="title"/>
</jsp:include>


	<sec:authorize access="isAnonymous()">
        <!-- signUp 시작 -->
        <section class="page-section bg-primary" id="signUp">
            <div class="container px-4 px-lg-5">
                <div class="row gx-4 gx-lg-5 justify-content-center">
                    <div class="col-lg-8 text-center">
                        <h2 class="text-white mt-0">We've got what you need!</h2>
                        <hr class="divider divider-light" />
                        <p class="text-white-75 mb-4">라라 월드에 오신 것을 환영합니다! 세계를 가로지르는 즐거운 여행을 시작해 볼까요?<br/>Welcome to Lara World! Let’s begin the pleasant journey across the world.</p>
                        <a class="btn btn-light btn-xl" href="${pageContext.request.contextPath}/member/memberEnroll.do">Sign Up | 회원가입</a>
                        <a class="btn btn-light btn-xl" href="${pageContext.request.contextPath}/member/memberLogin.do">Sign In | 로그인</a>
                    </div>
                </div>
            </div>
        </section>
        <!-- signUp 끝 -->
	</sec:authorize>


	 <sec:authorize access="isAuthenticated()">
        <!-- Menu 시작 -->
        <div id="portfolio">
            <div class="container-fluid p-0">
                <div class="row g-0">
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="#" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/assets/img/portfolio/thumbnails/1.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">My Page</div>
                                <div class="project-name">내정보 수정</div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-sm-6">
                        <a class="portfolio-box" href="${pageContext.request.contextPath}/ilchon/list.do">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/assets/img/portfolio/thumbnails/2.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">My Ilchon</div>
                                <div class="project-name">일촌 관리</div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-sm-6" style="cursor: pointer;">
                        <a class="portfolio-box" onclick="visitRandomMh2(${principal.hompyId})">
                            <img class="img-fluid" src="${pageContext.request.contextPath}/resources/assets/img/portfolio/thumbnails/3.jpg" alt="..." />
                            <div class="portfolio-box-caption">
                                <div class="project-category text-white-50">Surf Lara World</div>
                                <div class="project-name">파도타기</div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
        <!-- Menu 끝 -->
         </sec:authorize>

        
        <!-- Services 시작 -->
        <section class="page-section" id="service">
            <div class="container px-4 px-lg-5">
                <h2 class="text-center mt-0">At Lara World</h2>
                <hr class="divider" />
                <div class="row gx-4 gx-lg-5">
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-gem fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Express Yourself</h3>
                            <p class="text-muted mb-0" style="overflow: visible;">나만의 개성을 살린 미니홈피를<br/>자유롭게 꾸미고 표현해보세요!</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-heart fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Special Relationship</h3>
                            <p class="text-muted mb-0" style="overflow: visible;">소중한 인연들과 일촌을 맺고🤍<br/>일상과 관심사를 공유하며 소통해보세요!</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-laptop fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Record Memories</h3>
                            <p class="text-muted mb-0" style="overflow: visible;">여러분의 행복한 순간과 즐거운 일상을<br/>기록하고 간직하세요!</p>
                        </div>
                    </div>
                    <div class="col-lg-3 col-md-6 text-center">
                        <div class="mt-5">
                            <div class="mb-2"><i class="bi-globe fs-1 text-primary"></i></div>
                            <h3 class="h4 mb-2">Social Networking</h3>
                            <p class="text-muted mb-0" style="overflow: visible;">파도타기로 미니홈피를 방문하고<br/>라라월드의 다양한 사람들을 만나보세요!</p>
                        </div>
                    </div>

                </div>
            </div>
        </section>
        <!-- Services 끝 -->

        <!-- contact 시작 -->
        <section class="page-section  bg-dark text-white" id="contact">
            <div class="container px-4 px-lg-5 text-center">
                <h1 class="mb-4"  style="color : #f4623a;">Contact</h1>
                <h2 class="mb-4">Hera Jang | 장해라</h2>
                <table class="contact-table">
	                <tbody>
	                <tr>
	                    <td><a href="mailto:blossom.vo.ov@gmail.com"><img src="${pageContext.request.contextPath}/resources/images/mail_icon.png" alt="" class="icons" style="width: 68px;"></a></td>
	                    <td class="contact-table">&nbsp;&nbsp;blossom.vo.ov@gmail.com</td>
	                </tr>
	                <tr>
	                    <td><a href="tel:+82-10-9555-9254"><img src="${pageContext.request.contextPath}/resources/images/cell-phone.png" alt="" class="icons" style="width: 68px;"></a></td>
	                    <td class="contact-table">&nbsp;&nbsp;+82 10-9555-9254</td>
	                </tr>
	                <tr>
	                    <td><a href="https://github.com/CodingFairy-Lara"><img src="${pageContext.request.contextPath}/resources/images/github_icon.png" alt="" class="icons"></a></td>
	                    <td class="contact-table">&nbsp;&nbsp;github.com/CodingFairy-Lara</td>
	                </tr>
	                <tr>
	                    <td><a href="https://www.kakaocorp.com/page/service/service/KakaoTalk"><img src="${pageContext.request.contextPath}/resources/images/kakao_icon.png" alt="" class="icons"></a></td>
	                    <td class="contact-table">&nbsp;&nbsp;blossom0v0</td>
	                    </tr>
	                </tbody>
                </table>
            </div>
        </section>
        <!-- Contact 끝 -->
        

<jsp:include page="/WEB-INF/views/common/footer.jsp"></jsp:include>
