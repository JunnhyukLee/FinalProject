<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 상세 내용</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
    <script>
        function deleteNotice(notice_code) {
            if (confirm("정말로 이 공지사항을 삭제하시겠습니까?")) {
                $.ajax({
                    type: "POST",
                    url: "${pageContext.request.contextPath}/NoticeDelete", // 삭제를 처리하는 URL
                    data: { notice_code: notice_code }, // 삭제할 공지사항 코드 전달
                    success: function(response) {
                        alert("게시글이 삭제되었습니다.");
                        window.location.href = "${pageContext.request.contextPath}/NoticeSelect";
                    },
                    error: function(xhr, status, error) {
                        alert("게시글 삭제에 실패했습니다.");
                    }
                });
            }
        }
    </script>
</head>
<body>
<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <h1>공지사항 상세 내용</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light"></section>
<section id="notice-detail">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">${noticeDTO.notice_title}</h5>
                        <p class="card-text">${noticeDTO.notice_content}</p>
                        <div class="text-center">
                        <c:if test="${member_rating == 'admin'}">
                            <a href="${pageContext.request.contextPath}/NoticeUpdate?notice_code=${noticeDTO.notice_code}" class="btn btn-warning">수정</a>
                            <button onclick="deleteNotice(${noticeDTO.notice_code})" class="btn btn-danger">삭제</button>
                        </c:if>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-12">
                                <a href="${pageContext.request.contextPath}/NoticeSelect" class="btn btn-primary btn-block">공지사항 목록으로 돌아가기</a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>



