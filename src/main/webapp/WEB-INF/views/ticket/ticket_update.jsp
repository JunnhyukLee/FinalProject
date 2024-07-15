<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>정기권 정보 수정</title>
	<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
	<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
	<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
	<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
	<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
    <script src="./js/jquery.validate.min.js" type="text/javascript"></script>
    <script src="./js/dept_validity.js" type="text/javascript"></script>
<style>
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

main {
	flex: 1;
}

footer {
	background-color: #6c757d;
	color: white;
	padding: 10px 0;
}

/* 버튼 스타일 */
button {
    background-color: #6c757d; /* 헤더의 배경색과 같은색으로 설정 */
    color: white; /* 글자색 흰색으로 설정 */
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 버튼 내부 여백 설정 */
    cursor: pointer; /* 커서 모양 변경 */
    margin-bottom: 10px; /* 버튼 아래 여백 설정 */
    margin-left: 30px;
}

button:hover {
    background-color: #5a6268; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

/* 버튼 컨테이너 */
.button-container {
    text-align: left; /* 가운데 정렬 */
    margin-top: 20px; /* 위 여백 설정 */
}
</style>
<script type="text/javascript">
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
            location.href = '<c:url value="/logout" />';
        }
    }
</script>
</head>
<body>

   <header id="main-header" class="py-2 bg-secondary text-white">
      <div class="container">
         <div class="row align-items-start justify-content-between">
            <div class="col-md-4 text-left">
               <h1>
                  <i class="fas fa-lock-open"></i>P.K.-Management
               </h1>
            </div>
            <div class="col-md-7 d-flex align-items-center">
               <div>
                  <c:if test="${not empty sessionScope.customMemberDetails}">
                     <div>환영합니다, ${sessionScope.customMemberDetails.username}님</div>
                  </c:if>
               </div>
               &nbsp;&nbsp;&nbsp;&nbsp;
               <div>
                  <c:choose>
                     <c:when test="${empty sessionScope.customMemberDetails}">
                        <button onclick="location.href='<c:url value='/login' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그인
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberInsert' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 회원가입
                        </button>
                     </c:when>
                     <c:otherwise>
                        <button onclick="confirmLogout()"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그아웃
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberSelectDetail'/>'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 내정보 보기
                        </button>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'ADMIN'}">
                           <button onclick="location.href='<c:url value='/AdminView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 어드민 메뉴 보기
                           </button>
                        </c:if>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'MANAGER'}">
                           <button onclick="location.href='<c:url value='/ManagerView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 매니저 메뉴 보기
                           </button>
                        </c:if>
                     </c:otherwise>
                  </c:choose>
               </div>
            </div>
         </div>
      </div>
   </header>

<main>

<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>정기권 정보 수정</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light"></section>
<section id="department">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>정기권 수정</h5>
                    </div>
                    <div class="card-body">
                        <form action="./TicketUpdate" method="post" id="sign_ticket" onsubmit="return validateForm()">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="deptno" class="ml-sm-3 col-form-label">정기권 코드</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_code" id="ticket_code" class="form-control form-control-sm bg-white"
                                               value="${TicketUpdate.ticket_code}" readonly>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="deptno" class="ml-sm-3 col-form-label">정기권 종류</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_type" id="ticket_type" class="form-control form-control-sm bg-white"
                                               value="${TicketUpdate.ticket_type}" readonly>
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="dname" class="ml-sm-3 col-form-label">정기권 이름</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_name" id="ticket_name" class="form-control form-control-sm"
                                               value="${TicketUpdate.ticket_name}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="loc" class="ml-sm-3 col-form-label">적용기간(일)</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_days" id="ticket_days" class="form-control form-control-sm"
                                               value="${TicketUpdate.ticket_days}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="loc" class="ml-sm-3 col-form-label">적용기간(시간)</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_time" id="ticket_time" class="form-control form-control-sm"
                                               value="${TicketUpdate.ticket_time}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="loc" class="ml-sm-3 col-form-label">가격</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="ticket_price" id="ticket_price" class="form-control form-control-sm"
                                               value="${TicketUpdate.ticket_price}">
                                    </div>
                                </div>
                                <div class="form-group">
                                	<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-secondary">등록</button>
                                    <button type="reset" class="btn btn-secondary">취소</button>
                                </div>
                            </fieldset>
                        </form>
                        <div class="row">
                            <div class="col-md-4">
                                <a href="./TicketSearch" class="btn btn-primary btn-block">정기권 목록</a>
                            </div>
                            <div class="col-md-4">
                                <a href="./TicketInsert" class="btn btn-success btn-block">정기권 입력</a>
                            </div>
                            <div class="col-md-4">
                                <a href="./TicketDelete?ticket_code=${TicketUpdate.ticket_code}" class="btn btn-danger btn-block">정기권 삭제</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</main>

<footer id="main-footer" class="py-2 bg-secondary text-black">
    <div class="container">
        <div class="row align-items-start justify-content-between">
            <div class="col-md-8">
                <div>
                    <button onclick="location.href = './TermSelect'"
                            style="padding: 5px 10px; font-size: 15px; background-color: transparent; border: none; color: white;">
                        <i class="fa fa-user"></i> 이용약관
                    </button>
                </div>
            </div>
            <div class="col-md-4 text-right">
                <h1 style="font-size: 15px">
                    <i class="fas fa-lock"></i>e1i4 제작
                </h1>
            </div>
        </div>
    </div>
</footer>

<script>
    function validateForm() {
        var typeRegex = /^[가-힣]{1,4}$/;
        var nameRegex = /^[0-9가-힣]{0,8}$/;
        var daysRegex = /^[0-9]{0,4}$/; // 수정된 부분: 빈칸도 허용
        var timeRegex = /^[0-9]{0,3}$/; // 수정된 부분: 빈칸도 허용
        var priceRegex = /^[0-9]{1,20}$/;

        var ticketType = document.getElementById("ticket_type").value;
        var ticketName = document.getElementById("ticket_name").value;
        var ticketDays = document.getElementById("ticket_days").value;
        var ticketTime = document.getElementById("ticket_time").value;
        var ticketPrice = document.getElementById("ticket_price").value;

        if (ticketCode === "" || ticketType === "" || ticketName === "" || ticketPrice === "") {
            alert("빈칸을 채워주세요.");
            return false;
        }
        if (!typeRegex.test(ticketType)) {
            alert("정기권 종류: 한글 4글자까지 입력해주세요.");
            return false;
        }
        if (!nameRegex.test(ticketName)) {
            alert("정기권 이름: 숫자 포함 한글 8글자까지 입력해주세요.");
            return false;
        }
       
        if (!daysRegex.test(ticketDays)) {
            alert("유효기간(일):숫자 4자리까지 입력해주세요.");
            return false;
        }
        
        if (!timeRegex.test(ticketTime)) {
            alert("유효기간(시간):숫자 3자리까지 입력해주세요.");
            return false;
        }
        if (!priceRegex.test(ticketPrice)) {
            alert("가격: 숫자 20자리까지 입력해주세요.");
            return false;
        }
        return true;
    }
</script>
</body>
</html>