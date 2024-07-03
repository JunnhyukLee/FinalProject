<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>댓글 삭제</title>
    <!-- 부트스트랩 및 추가 스타일시트, 자바스크립트 파일 링크 -->
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
    <script>
        function deleteFaqAnswer(faq_code) {
            if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                // AJAX 요청을 통해 서버에 삭제 요청을 보냄
                $.ajax({
                    type: "POST",
                    url: "./FaqAnswerDelete",
                    data: { faq_code: faq_code },
                    success: function(response) {
                        // 삭제 성공 시 알림창 또는 다른 작업 수행
                        alert("댓글이 삭제되었습니다.");
                        // 삭제 후 필요한 동작 수행 (예: 페이지 리로드 등)
                        window.location.href = "./FaqSelectDetail?faq_code=" + faq_code;
                    },
                    error: function(xhr, status, error) {
                        // 삭제 실패 시 처리
                        alert("댓글 삭제에 실패했습니다.");
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
            <div class="col-md-6">
                <h1>댓글 삭제</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light"></section>
<section id="faq-delete">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>댓글 삭제</h5>
                    </div>
                    <div class="card-body">
                        <div class="form-group row">
                            <label for="faq_code" class="ml-sm-3 col-form-label">삭제할 댓글의 게시글 번호</label>
                            <div class="ml-sm-3">
                                <input type="text" name="faq_code" id="faq_code" class="form-control form-control-sm bg-white">
                            </div>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-secondary" onclick="deleteFaqAnswer(document.getElementById('faq_code').value)">삭제</button>
                            <a href="./FaqSelect" class="btn btn-secondary">취소</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<a href="./FaqSelect" class="btn btn-primary btn-block"> 게시판홈으로 돌아가기</a>
</body>
</html>

