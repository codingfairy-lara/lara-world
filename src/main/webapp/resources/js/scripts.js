/* 
* ! ** Bootstrap **
* Start Bootstrap - Creative v7.0.7 (https://startbootstrap.com/theme/creative)
* Copyright 2013-2023 Start Bootstrap
* Licensed under MIT (https://github.com/StartBootstrap/startbootstrap-creative/blob/master/LICENSE)
*/

window.addEventListener('DOMContentLoaded', event => {

    // Navbar shrink function
    var navbarShrink = function () {
        const navbarCollapsible = document.body.querySelector('#mainNav');
        if (!navbarCollapsible) {
            return;
        }
        if (window.scrollY === 0) {
            navbarCollapsible.classList.remove('navbar-shrink')
        } else {
            navbarCollapsible.classList.add('navbar-shrink')
        }

    };

    // Shrink the navbar 
    navbarShrink();

    // Shrink the navbar when page is scrolled
    document.addEventListener('scroll', navbarShrink);

    // Activate Bootstrap scrollspy on the main nav element
    const mainNav = document.body.querySelector('#mainNav');
    if (mainNav) {
        new bootstrap.ScrollSpy(document.body, {
            target: '#mainNav',
            rootMargin: '0px 0px -40%',
        });
    };

    // Collapse responsive navbar when toggler is visible
    const navbarToggler = document.body.querySelector('.navbar-toggler');
    const responsiveNavItems = [].slice.call(
        document.querySelectorAll('#navbarResponsive .nav-link')
    );
    responsiveNavItems.map(function (responsiveNavItem) {
        responsiveNavItem.addEventListener('click', () => {
            if (window.getComputedStyle(navbarToggler).display !== 'none') {
                navbarToggler.click();
            }
        });
    });

    // Activate SimpleLightbox plugin for portfolio items
    //new SimpleLightbox({
   //     elements: '#portfolio a.portfolio-box'
   // });

});

/**
 * ! ** minihompy popup **
 */
 
const popupMh = (hompyId) => {
    const w = 1200, h = 750;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('minihompy/home.do?hompyId='+hompyId, 'minihompy', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

const visitMh = (hompyId) => {
    const w = 1200, h = 750;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/1.7;
    const top = (height-h)/1.6;
    const popup = open('minihompy/visit.do?hompyId='+hompyId, 'visit minihompy', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

/**
 * ! ** random minihompy popup **
 */

const visitRandomMh = (hompyId) => {
    const w = 1200, h = 750;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/1.7;
    const top = (height-h)/1.6;
    const popup = open('minihompy/visitrd.do?hompyId='+hompyId,  'visit minihompy', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

const visitRandomMh2 = (hompyId) => {
    const w = 1200, h = 750;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/1.7;
    const top = (height-h)/1.6;
    const popup = open('minihompy/minihompy/visitrd.do?hompyId='+hompyId,  'visit minihompy', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};


/**
 * ! ** upload profile **
 */

const popupUpload = (myHompyId) => {
    const w = 900, h = 800;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('profile/upload.do', 'profile upload', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

/**
 * ! ** profile history **
 */

const popupHistory = (hompyId) => {
    const w = 600, h = 800;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('profile/history.do?hompyId='+hompyId, 'profile history', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

/**
 * ! ** cookie **
 */

function getCookie(cname) {
    var value = document.cookie.match('(^|;) ?' + cname + '=([^;]*)(;|$)');
    return value? value[2] : null;
}

/**
 * ! ** upload diary **
 */

const popupDiaryFrm = (myHompyId) => {
    const w = 900, h = 800;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('diary/upload.do', 'diary upload', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

const showDiaryList = () => {
	$('#diaryRender').hide();
	$('#diaryList').show();
	checkEmptyDiary();
};



const delCookie = (cname) => {
	getCookie(cname);
	  // 쿠키 삭제는? 이미 한참 지나간 시간을 입력해버림으로써 쿠키를 삭제시킨다.
	  console.log(cname);
	  document.cookie = cname + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT; path=/';
	  // alert('쿠키를 삭제했습니다.');
	};


/**
 *! ** diary calendar **
 
    달력 렌더링 할 때 필요한 정보 목록 

    현재 월(초기값 : 현재 시간)
    금월 마지막일 날짜와 요일
    전월 마지막일 날짜와 요일
*/

function calendarInit(hompyId) {

    // 날짜 정보 가져오기
    var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
    var utc = date.getTime() + (date.getTimezoneOffset() * 60 * 1000); // uct 표준시 도출
    var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
    var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)
  
    var thisMonth = new Date(today.getFullYear(), today.getMonth(), today.getDate());
    // 달력에서 표기하는 날짜 객체
  
    
    var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
    var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
    var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일

    // kst 기준 현재시간
    // console.log(thisMonth);

    // 캘린더 렌더링
    renderCalender(thisMonth);

    function renderCalender(thisMonth) {

        // 렌더링을 위한 데이터 정리
        currentYear = thisMonth.getFullYear();
        currentMonth = thisMonth.getMonth();
        currentDate = thisMonth.getDate();
        var week = new Array('SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT');

    	var today_num = thisMonth.getDay();
    	currentDay = today_num;
        
        currentDay = week[today_num];

        // 이전 달의 마지막 날 날짜와 요일 구하기
        var startDay = new Date(currentYear, currentMonth, 0);
        var prevDate = startDay.getDate();
        var prevDay = startDay.getDay();

        // 이번 달의 마지막날 날짜와 요일 구하기
        var endDay = new Date(currentYear, currentMonth + 1, 0);
        var nextDate = endDay.getDate();
        var nextDay = endDay.getDay();

        // console.log(prevDate, prevDay, nextDate, nextDay);

        // 현재 월 표기
        $('.year-month').text(currentYear + '.' + (currentMonth + 1));
        $('.cur-day').text(currentDay);

        // 렌더링 html 요소 생성
        calendar = document.querySelector('.dates')
        calendar.innerHTML = '';
        
        // 지난달
        for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day prev disable">' + i + '</div>'
        }
        
        // 이번달
        for (var i = 1; i <= nextDate; i++) {
			calendar.innerHTML = calendar.innerHTML + '<div class="day current" data-date='+i+' onclick="getDiary('+i+', '+hompyId+');">' + i + '</div>'
        }
        
        // 다음달
        for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
            calendar.innerHTML = calendar.innerHTML + '<div class="day next disable">' + i + '</div>'
        }

        // 오늘 날짜 표기
        if (today.getMonth() == currentMonth) {
            todayDate = today.getDate();
            var currentMonthDate = document.querySelectorAll('.dates .current');
            currentMonthDate[todayDate -1].classList.add('today');
        }
    }

    // 이전달로 이동
    $('.go-prev').on('click', function() {
        thisMonth = new Date(currentYear, currentMonth - 1, 1);
        renderCalender(thisMonth);
    });

    // 다음달로 이동
    $('.go-next').on('click', function() {
        thisMonth = new Date(currentYear, currentMonth + 1, 1);
        renderCalender(thisMonth); 
    });
}

function getYearMonth() {
	let year_month = '';
	year_month = document.getElementById('year-month').innerHTML;
	return year_month;
}

/**
 * ! ** upload picture **
 */

const popupPictureFrm = (myHompyId) => {
    const w = 900, h = 800;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('picture/upload.do', 'picture upload', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

//파일 현재 필드 숫자 totalCount랑 비교값
var fileCount = 0;
// 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
var totalCount = 5;
// 파일 고유넘버
var fileNum = 0;
// 첨부파일 배열
var content_files = new Array();

function fileCheck(e) {
    var files = e.target.files;
    
    // 파일 배열 담기
    var filesArr = Array.prototype.slice.call(files);
    console.log(filesArr);
    
    // 파일 개수 확인 및 제한
    if (fileCount + filesArr.length > totalCount) {
        alert("이미지는 최대 "+totalCount+"개까지 업로드 가능합니다.");
    	// document.location.reload(true);
    	return;
    } else {
    	 fileCount = fileCount + filesArr.length;
    }

  }
 
 function renderPicture(container, pictureNo, attachCount) {
        // 렌더링 html 요소 생성
        let photo = document.querySelector(container);
        let html = ``
						    
        if (attachCount > 0) {
	        for (let i = 0; i <= attachCount; i++) {
	    		html += `<div class="carousel-indicators">
							    <button type="button" data-bs-target="#picture-` + pictureNo + `"
							    data-bs-slide-to="` + i + `"
							    class="active" aria-current="true" aria-label="Slide ` + i+1 + `"
							    ></button>`
							    
				if (attachCount > 1) {
			        for (let j = 1; j <= attachCount; j++) {
			            html += `<button type="button" data-bs-target="#picture-` + pictureNo + `" 
			            data-bs-slide-to="` + j + `"
			            aria-label="Slide ` + j+1 + `"
			            ></button>`;
		           	}
		        }
		        
        	}
			    html += `</div>`;
        
	    		html += `<div class="carousel-inner">
        					<c:forEach items="${picture.attachments}" var="attach" varStatus="vs">
							    <div class="carousel-item active">
							      <img src="${pageContext.request.contextPath}/profile/images/${attachment.renamedFilename}" class="d-block w-100" alt="이미지1">
							    </div>
							</c:forEach>
						</div>`;
        		
					if (attachCount > 1) {
						html += `<button class="carousel-control-prev" type="button" data-bs-target="#picture-` + pictureNo + `" data-bs-slide="prev">
							    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Previous</span>
							  </button>
							  <button class="carousel-control-next" type="button" data-bs-target="#picture-` + pictureNo + `" data-bs-slide="next">
							    <span class="carousel-control-next-icon" aria-hidden="true"></span>
							    <span class="visually-hidden">Next</span>
							  </button>`;
        			}
        		
        }

		photo.innerHtml = html;
} 

/**
 * ! ** ilchon request **
 */

$(document).on("click", "a.ilchon-request", function(){
	let memberId1 = $(this).attr("data-member-id-1");
	let memberId2 = $(this).attr("data-member-id-2");
	let hompyId1 = $(this).attr("data-hompy-id-1");
	let hompyId2 = $(this).attr("data-hompy-id-2");
	let name1 = $(this).attr("data-member-name-1");
	let name2 = $(this).attr("data-member-name-2");

	popupIlchonFrm(memberId1, memberId2, hompyId1, hompyId2, name1, name2);

})


const popupIlchonFrm = (memberId1, memberId2, hompyId1, hompyId2, name1, name2) => {
    const w = 380, h = 560;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('ilchon/requestfrm.do?memberId1=' +memberId1+ '&memberId2=' +memberId2+ '&hompyId1=' +hompyId1+ '&hompyId2=' +hompyId2+ '&name1=' +name1+ '&name2=' +name2,
     'Ilchon Form', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

const popupIlchonRequest = (requestNo) => {
    const w = 400, h = 560;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('request.do?requestNo=' +requestNo,
     'Ilchon Request', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

const popupIlchonEditFrm = (requestNo) => {
    const w = 400, h = 560;
    const {width, height, availWidth, availHeight, availTop} = screen;
    const left = (width-w)/2;
    const top = (height-h)/2;
    const popup = open('editfrm.do?requestNo=' +requestNo,
     'Ilchon Request', `width=${w}px, height=${h}px, left=${left}px, top=${top}px`);
};

function editMember() {
   document.memberUpdateFrm.submit();
   }
