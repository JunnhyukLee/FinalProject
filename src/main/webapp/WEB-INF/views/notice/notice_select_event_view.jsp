<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>이벤트 목록</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
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
button, .btn-custom {
    background-color: #28a745; /* 초록색으로 변경 */
    color: white; /* 글자색 흰색으로 설정 */
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 버튼 내부 여백 설정 */
    cursor: pointer; /* 커서 모양 변경 */
    margin-bottom: 10px; /* 버튼 아래 여백 설정 */
}

button:hover, .btn-custom:hover {
    background-color: #218838; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

.nav-item .nav-link {
    font-size: 1rem;
    padding: 0.5rem 1rem;
}

.button-container {
    text-align: left; /* 가운데 정렬 */
    margin-top: 20px; /* 위 여백 설정 */
}

.custom-header {
	font-size: 1.5rem; /* 글자 크기를 줄입니다 */
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

	<c:if test="${not empty message}">
		<script type="text/javascript">
			alert("${message}");
		</script>
	</c:if>
	<header id="main-header" class="py-2 btn-dark text-white">
		<div class="container">
			<div class="row align-items-center">
				<div class="col-md-6">
					<h1 class="custom-header">이벤트 및 공지사항 관리</h1>
				</div>
				<div class="col-md-6 text-right">
				<button onclick="location.href ='./Menu'" class="btn-custom">메뉴</button>
					<c:if test="${member_rating == 'ADMIN'}">
						<a href="./NoticeInsert" class="btn-custom">글 작성</a>
					</c:if>
					<ul class="nav nav-tabs d-inline-flex">
						<li class="nav-item"><a class="nav-link active"
							href="#">이벤트</a></li>
						<li class="nav-item"><a class="nav-link"
							href="./NoticeSelect">공지 사항</a></li>
					</ul>
				</div>
			</div>
		</div>
	</header>
	<section class="py-4 mb-4 bg-light"></section>
	<section id="notices">
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<form action="./NoticeSelectEvent" method="get"
						class="form-inline my-2 my-lg-0">
						<div class="input-group">
							<input class="form-control mr-sm-2" type="search"
								placeholder="제목 검색" aria-label="Search" name="searchQuery"
								value="${param.searchQuery}">
							<div class="input-group-append">
								<button class="btn btn-outline-primary my-2 my-sm-0"
									type="submit">검색</button>
							</div>
						</div>
					</form>
					<div class="card">
						<div class="card-header">
							<h5>이벤트 목록</h5>
						</div>
						<div class="card-body">
							<table class="table table-hover">
								<thead class="thead-light">
									<tr class="text-center">
										<th>번호</th>
										<th>제목</th>
										<th>작성 날짜</th>
										<th>조회수</th>
										<!-- 조회수 열 추가 -->
									</tr>
								</thead>
								<tbody>
									<c:forEach var="notice" items="${noticePage.content}">
										<tr class="text-center">
											<td>${notice.notice_code}</td>
											<td><a
												href="./NoticeSelectEventDetail?notice_code=${notice.notice_code}">${notice.notice_title}</a></td>
											<td><fmt:formatDate value="${notice.notice_date}"
													pattern="yyyy-MM-dd HH:mm" /></td>
											<td>${notice.notice_view}</td>
											<!-- 조회수 표시 -->
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<c:choose>
								<c:when
									test="${empty noticePage.content and not empty param.searchQuery}">
									<div class="alert alert-warning" role="alert">검색 결과가
										없습니다.</div>
								</c:when>
								<c:when test="${empty noticePage.content}">
									<div class="alert alert-warning" role="alert">등록된 이벤트가
										없습니다.</div>
								</c:when>
							</c:choose>
							<c:if test="${not empty noticePage.content}">
								<nav aria-label="Page navigation example">
									<ul class="pagination justify-content-center">
										<li class="page-item ${noticePage.first ? 'disabled' : ''}">
											<a class="page-link"
											href="?page=0&size=${noticePage.size}&searchQuery=${param.searchQuery}"
											aria-label="Previous"> <span aria-hidden="true">&laquo;</span>
										</a>
										</li>
										<c:forEach
											begin="${noticePage.number - 2 < 0 ? 0 : noticePage.number - 2}"
											end="${noticePage.number + 2 < noticePage.totalPages ? noticePage.number + 2 : noticePage.totalPages - 1}"
											var="i">
											<c:if test="${i >= 0 && i < noticePage.totalPages}">
												<li
													class="page-item ${noticePage.number == i ? 'active' : ''}">
													<a class="page-link"
													href="?page=${i}&size=${noticePage.size}&searchQuery=${param.searchQuery}">${i + 1}</a>
												</li>
											</c:if>
										</c:forEach>
										<li class="page-item ${noticePage.last ? 'disabled' : ''}">
											<a class="page-link"
											href="?page=${noticePage.totalPages - 1}&size=${noticePage.size}&searchQuery=${param.searchQuery}"
											aria-label="Next"> <span aria-hidden="true">&raquo;</span>
										</a>
										</li>
									</ul>
								</nav>
							</c:if>
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

</body>
</html>
