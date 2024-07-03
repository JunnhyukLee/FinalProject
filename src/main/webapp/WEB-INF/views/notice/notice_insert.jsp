<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>공지사항 또는 이벤트 정보 입력</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min_4.5.0.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css">
<script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<script src="${pageContext.request.contextPath}/js/jquery.validate.min.js" type="text/javascript"></script>
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
</head>
<body>
<header id="main-header" class="py-2 btn-dark text-white">
<div class="container">
<div class="row">
<div class="col-md-6">
<h1>공지사항 또는 이벤트 정보 입력</h1>
</div>
</div>
</div>
</header>
<section class="py-4 mb-4 bg-light">
</section>
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
</body>
</html>
