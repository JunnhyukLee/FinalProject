<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 또는 이벤트 정보 입력</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min_4.5.0.css?20240709">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css?20240709">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery.validate.min.js?20240709" type="text/javascript"></script>
<script>
    function submitForm() {
        var title = document.getElementById('notice_title').value.trim();
        var content = document.getElementById('notice_content').value.trim();

        if (title === '') {
            alert('제목을 입력해주세요.');
            return;
        }

        if (content === '') {
            alert('내용을 입력해주세요.');
            return;
        }

        if (content.length > 2000) {
            alert('내용이 허용된 글자수를 초과하였습니다.');
            return;
        }

        document.getElementById('notice_form').submit();
    }

    function cancelInsert() {
        window.location.href = "${pageContext.request.contextPath}/NoticeSelect";
    }
</script>
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
                    <h1>공지사항 또는 이벤트 정보 입력</h1>
                </div>
            </div>
        </div>
    </header>
    <section class="py-4 mb-4 bg-light"></section>
    <section id="notice">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="card">
                        <div class="card-header">
                            <h5>공지사항 또는 이벤트 입력</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/NoticeInsert" method="post" id="notice_form">
                                <sec:csrfInput />
                                <fieldset>
                                    <div class="form-group row">
                                        <label class="ml-sm-3 col-form-label">유형 선택:</label>
                                        <div class="ml-sm-3">
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="notice_type" id="notice_radio" value="공지사항" checked>
                                                <label class="form-check-label" for="notice_radio">공지사항</label>
                                            </div>
                                            <div class="form-check form-check-inline">
                                                <input class="form-check-input" type="radio" name="notice_type" id="event_radio" value="이벤트"> 
                                                <label class="form-check-label" for="event_radio">이벤트</label>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="notice_title" class="ml-sm-3 col-form-label">제목</label>
                                        <div class="ml-sm-3">
                                            <input type="text" name="notice_title" id="notice_title" class="form-control form-control-sm">
                                        </div>
                                    </div>
                                    <div class="form-group row">
                                        <label for="notice_content" class="ml-sm-3 col-form-label">내용</label>
                                        <div class="ml-sm-3">
                                            <textarea name="notice_content" id="notice_content" class="form-control form-control-sm" rows="5"></textarea>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <button type="button" class="btn btn-secondary" onclick="submitForm()">등록</button>
                                        <button type="button" class="btn btn-secondary" onclick="cancelInsert()">취소</button>
                                    </div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <a href="${pageContext.request.contextPath}/NoticeSelect" class="btn btn-primary btn-block"> 공지사항 목록으로 돌아가기</a>

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

</body>
</html>