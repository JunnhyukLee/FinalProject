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
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
    <style>
        .custom-header {
            font-size: 1.5rem; /* 글자 크기를 줄입니다 */
        }
        .btn-custom {
            font-size: 0.9rem; /* 버튼 글자 크기를 설정 */
        }
    </style>
</head>
<body>
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
            <c:if test="${member_rating == 'admin'}">
                <a href="./NoticeInsert" class="btn btn-success btn-custom">글 작성</a>
                </c:if>
                <a href="./TermSelect" class="btn btn-success btn-custom">이용약관</a>
                <ul class="nav nav-tabs d-inline-flex">
                    <li class="nav-item">
                        <a class="nav-link active btn-custom" href="#">이벤트</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn-custom" href="./NoticeSelect">공지 사항</a>
                    </li>
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
                <form action="./NoticeSelectEvent" method="get" class="form-inline my-2 my-lg-0">
                    <div class="input-group">
                        <input class="form-control mr-sm-2" type="search" placeholder="제목 검색" aria-label="Search" name="searchQuery" value="${param.searchQuery}">
                        <div class="input-group-append">
                            <button class="btn btn-outline-primary my-2 my-sm-0" type="submit">검색</button>
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
                                <th>조회수</th> <!-- 조회수 열 추가 -->
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="notice" items="${noticePage.content}">
                                <tr class="text-center">
                                    <td>${notice.notice_code}</td>
                                    <td><a href="./NoticeSelectEventDetail?notice_code=${notice.notice_code}">${notice.notice_title}</a></td>
                                    <td><fmt:formatDate value="${notice.notice_date}" pattern="yyyy-MM-dd HH:mm" /></td>
                                    <td>${notice.notice_view}</td> <!-- 조회수 표시 -->
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                        <c:choose>
                            <c:when test="${empty noticePage.content and not empty param.searchQuery}">
                                <div class="alert alert-warning" role="alert">
                                    검색 결과가 없습니다.
                                </div>
                            </c:when>
                            <c:when test="${empty noticePage.content}">
                                <div class="alert alert-warning" role="alert">
                                    등록된 이벤트가 없습니다.
                                </div>
                            </c:when>
                        </c:choose>
                        <c:if test="${not empty noticePage.content}">
                            <nav aria-label="Page navigation example">
                                <ul class="pagination justify-content-center">
                                    <li class="page-item ${noticePage.first ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=0&size=${noticePage.size}&searchQuery=${param.searchQuery}" aria-label="Previous">
                                            <span aria-hidden="true">&laquo;</span>
                                        </a>
                                    </li>
                                    <c:forEach begin="${noticePage.number - 2 < 0 ? 0 : noticePage.number - 2}" end="${noticePage.number + 2 < noticePage.totalPages ? noticePage.number + 2 : noticePage.totalPages - 1}" var="i">
                                        <c:if test="${i >= 0 && i < noticePage.totalPages}">
                                            <li class="page-item ${noticePage.number == i ? 'active' : ''}">
                                                <a class="page-link" href="?page=${i}&size=${noticePage.size}&searchQuery=${param.searchQuery}">${i + 1}</a>
                                            </li>
                                        </c:if>
                                    </c:forEach>
                                    <li class="page-item ${noticePage.last ? 'disabled' : ''}">
                                        <a class="page-link" href="?page=${noticePage.totalPages - 1}&size=${noticePage.size}&searchQuery=${param.searchQuery}" aria-label="Next">
                                            <span aria-hidden="true">&raquo;</span>
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
</body>
</html>
