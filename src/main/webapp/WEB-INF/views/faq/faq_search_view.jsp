<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글 검색 결과</title>
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

.custom-header {
	font-size: 1.5rem; /* 글자 크기를 줄입니다 */
}

.input-group .form-control {
	flex: 1.5; /* 검색 입력 창을 늘립니다 */
}

.input-group .form-control:first-child {
	flex: 1; /* 검색 타입 선택 폼을 늘립니다 */
}

.form-inline {
	display: flex;
	justify-content: center;
}

.search-container {
	flex-grow: 1;
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
					<h1 class="custom-header">게시판</h1>
				</div>
				<div class="col-md-6 text-center search-container">
					<!-- 검색 창 -->
					<form action="./FaqSearchResults" method="get"
						class="form-inline my-2 my-lg-0">
						<select class="form-control mr-sm-2" name="searchFilter">
							<option value="faq_title"
								${param.searchFilter == 'faq_title' ? 'selected' : ''}>제목</option>
							<option value="member_name"
								${param.searchFilter == 'member_name' ? 'selected' : ''}>작성자</option>
						</select> <input class="form-control mr-sm-2" type="search"
							placeholder="검색어 입력" aria-label="Search" name="searchQuery"
							value="${param.searchQuery}">
						<button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
					</form>
				</div>
				<div class="col-md-3 text-right">
					<!-- 글 작성 버튼 -->
					<a href="./FaqInsert" class="btn btn-primary">글쓰기</a> <a
						href="./FaqSelect" class="btn btn-primary">홈으로 이동</a>
				</div>
			</div>
		</div>
	</header>
	<section class="py-4 mb-4 bg-light"></section>
	<section id="boards">
		<div class="container">
			<!-- 검색된 게시글 목록 표시 -->
			<table class="table table-hover">
				<thead class="thead-light">
					<tr class="text-center">
						<th>번호</th>
						<th>제목</th>
						<th>작성자</th>
						<th>작성일</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="faq" items="${searchResults}">
						<tr class="text-center">
							<td>${faq.faq_code}</td>
							<td><a href="./FaqSelectDetail?faq_code=${faq.faq_code}">${faq.faq_title}</a></td>
							<td>${faq.member_name}</td>
							<td><fmt:formatDate value="${faq.faq_question_date}"
									pattern="yyyy-MM-dd HH:mm" /></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<!-- 검색된 게시글이 없을 때 메시지 표시 -->
			<c:if test="${empty searchResults}">
				<div class="alert alert-warning" role="alert">입력하신 내용으로 검색한 글이
					없습니다.</div>
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

