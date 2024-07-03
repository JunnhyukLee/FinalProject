<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>이벤트 상세 내용</title>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
  <script>
    function deleteNotice(notice_code) {
        if (confirm("정말로 이 이벤트를 삭제하시겠습니까?")) {
            // AJAX 요청을 통해 서버에 삭제 요청을 보냄
            $.ajax({
                type: "POST",
                url: "./NoticeDelete", // 삭제를 처리하는 URL
                data: { notice_code: notice_code }, // 삭제할 공지사항 코드 전달
                success: function(response) {
                    // 삭제 성공 시 알림창 또는 다른 작업 수행
                    alert("게시글이 삭제되었습니다.");
                    // 삭제 후 필요한 동작 수행 (예: 페이지 리로드 등)
                    window.location.href = "./NoticeSelectEvent";
                },
                error: function(xhr, status, error) {
                    // 삭제 실패 시 처리
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
                <h1>이벤트 상세 내용</h1>
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
                            <a href="./NoticeUpdateEvent?notice_code=${noticeDTO.notice_code}" class="btn btn-warning">수정</a>
                            <button onclick="deleteNotice(${noticeDTO.notice_code})" class="btn btn-danger">삭제</button>
                        </c:if>
                        </div>
                        <div class="row mt-4">
                            <div class="col-md-12">
                                <a href="./NoticeSelectEvent" class="btn btn-primary btn-block">이벤트 목록으로 돌아가기</a>
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

