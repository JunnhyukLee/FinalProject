<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 목록</title>

<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
<script src="./js/popper.min.js" type="text/javascript"></script>
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
button, .btn {
    background-color: #6c757d; /* 헤더의 배경색과 같은색으로 설정 */
    color: white; /* 글자색 흰색으로 설정 */
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 버튼 내부 여백 설정 */
    cursor: pointer; /* 커서 모양 변경 */
    margin-bottom: 10px; /* 버튼 아래 여백 설정 */
    white-space: nowrap; /* 텍스트 줄바꿈 방지 */
}

button:hover, .btn:hover {
    background-color: #5a6268; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

/* 특정 버튼 색상 설정 */
.btn-primary {
    background-color: #007bff;
    border-color: #007bff;
}

.btn-primary:hover {
    background-color: #0056b3;
    border-color: #0056b3;
}

.btn-secondary {
    background-color: #6c757d;
    border-color: #6c757d;
}

.btn-secondary:hover {
    background-color: #5a6268;
    border-color: #5a6268;
}

/* 버튼 컨테이너 */
.button-container {
    text-align: left; /* 가운데 정렬 */
    margin-top: 20px; /* 위 여백 설정 */
}

.custom-header {
    font-size: 1.5rem; /* 글자 크기를 줄입니다 */
}

.input-group .form-control {
    flex: 2; /* 검색 입력 창을 늘립니다 */
}

.input-group .form-control:first-child {
    flex: 1; /* 검색 타입 선택 폼을 늘립니다 */
}

.align-right {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    gap: 10px;
}

.align-right .btn {
    flex: 1;
    max-width: 150px; /* 버튼의 최대 너비를 설정 */
    text-align: center;
    padding: 10px 15px; /* 버튼 내부 여백 조정 */
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
            <div class="row align-items-center">
                <div class="col-md-3">
                    <h1 class="custom-header">주차관리 질문 게시판</h1>
                </div>
                <div class="col-md-5">
                    <!-- 검색 창 -->
                    <form action="./FaqSearch" method="get" class="form-inline my-2 my-lg-0">
                        <div class="input-group">
                            <select class="form-control mr-sm-2" name="searchFilter">
                                <option value="faq_title" ${param.searchFilter == 'faq_title' ? 'selected' : ''}>제목</option>
                                <option value="member_name" ${param.searchFilter == 'member_name' ? 'selected' : ''}>작성자</option>
                            </select>
                            <input class="form-control mr-sm-2" type="search" placeholder="검색어 입력" aria-label="Search" name="searchQuery" value="${param.searchQuery}">
                            <div class="input-group-append">
                                <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
                            </div>
                        </div>
                    </form>
                </div>
                <div class="col-md-4 align-right">
                    <button class="btn btn-primary" onclick="location.href ='./Menu'">메뉴</button>
                    <!-- 글 작성 버튼 -->
                    <a href="./FaqInsert" class="btn btn-primary">글쓰기</a>
                    <!-- 자주 묻는 질문 모달 버튼 -->
                    <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#termsModal">자주 묻는 질문</button>
                </div>
            </div>
        </div>
    </header>
    <section class="py-4 mb-4 bg-light"></section>
    <section id="boards">
        <div class="container">
            <!-- 게시판 목록 표시 -->
            <table class="table table-hover">
                <thead class="thead-light">
                    <tr class="text-center">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="faq" items="${faqPage.content}">
                        <tr class="text-center">
                            <td>${faq.faq_code}</td>
                            <td><a href="./FaqSelectDetail?faq_code=${faq.faq_code}">${faq.faq_title}</a></td>
                            <td>${faq.member_name}</td>
                            <td><fmt:formatDate value="${faq.faq_question_date}" pattern="yyyy-MM-dd HH:mm" /></td>
                            <td>${faq.faq_view}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <!-- 게시글이 없을 때 메시지 표시 -->
            <c:if test="${empty faqPage.content and empty param.searchQuery}">
                <div class="alert alert-warning" role="alert">게시글이 없습니다.</div>
            </c:if>
            <!-- 검색 결과가 없을 때 메시지 표시 -->
            <c:if test="${empty faqPage.content and not empty param.searchQuery}">
                <div class="alert alert-warning" role="alert">검색 결과가 없습니다.</div>
            </c:if>

            <!-- 페이지 네비게이션 -->
            <c:if test="${not empty faqPage.content}">
                <nav aria-label="Page navigation example">
                    <ul class="pagination justify-content-center">
                        <li class="page-item ${faqPage.first ? 'disabled' : ''}"><a class="page-link" href="?page=0&size=${faqPage.size}&searchQuery=${param.searchQuery}" aria-label="Previous"> <span aria-hidden="true">&laquo;</span></a></li>
                        <c:forEach var="i" begin="${faqPage.number - 2 < 0 ? 0 : faqPage.number - 2}" end="${faqPage.number + 2 < faqPage.totalPages ? faqPage.number + 2 : faqPage.totalPages - 1}">
                            <li class="page-item ${faqPage.number == i ? 'active' : ''}"><a class="page-link" href="?page=${i}&size=${faqPage.size}&searchQuery=${param.searchQuery}">${i + 1}</a></li>
                        </c:forEach>
                        <li class="page-item ${faqPage.last ? 'disabled' : ''}"><a class="page-link" href="?page=${faqPage.totalPages - 1}&size=${faqPage.size}&searchQuery=${param.searchQuery}" aria-label="Next"> <span aria-hidden="true">&raquo;</span></a></li>
                    </ul>
                </nav>
            </c:if>
        </div>
    </section>
    <footer class="footer mt-auto py-3 bg-light">
        <div class="container">
            <div class="row">
                <div class="col-md-12 text-center"></div>
            </div>
        </div>
    </footer>
    <!-- 이용약관 모달 -->
    <div class="modal fade" id="termsModal" tabindex="-1" role="dialog" aria-labelledby="termsModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="termsModalLabel">자주 묻는 질문</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <p>자주 묻는 질문 리스트</p>
                    <p>질문 1</p>
                    <p>질문 1의 답변</p>
                    <p>질문 2</p>
                    <p>질문 2의 답변</p>
                    <p>질문 3</p>
                    <p>질문 3의 답변</p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>

</main>

<footer id="main-footer" class="py-2 bg-secondary text-black">
    <div class="container">
        <div class="row align-items-start justify-content-between">
            <div class="col-md-8">
                <div>
                    <button onclick="location.href = './TermSelect'" style="padding: 5px 10px; font-size: 15px; background-color: transparent; border: none; color: white;">
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
