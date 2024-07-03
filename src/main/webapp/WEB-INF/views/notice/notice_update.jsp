<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>공지사항 또는 이벤트 정보 수정</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/global.css">
    <script src="${pageContext.request.contextPath}/js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
    <script src="${pageContext.request.contextPath}/js/jquery.validate.min.js" type="text/javascript"></script>
    <script>
        function cancelEdit() {
            window.location.href = "${pageContext.request.contextPath}/NoticeSelectDetail?notice_code=${noticeDTO.notice_code}";
        }
    </script>
</head>
<body>
<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>공지사항 또는 이벤트 수정</h1>
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
                        <h5>공지사항 또는 이벤트 수정</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/NoticeUpdate" method="post" id="notice_form">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="notice_title" class="ml-sm-3 col-form-label">제목</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="notice_title" id="notice_title" class="form-control form-control-sm" value="${noticeDTO.notice_title}">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="notice_content" class="ml-sm-3 col-form-label">내용</label>
                                    <div class="ml-sm-3">
                                        <textarea name="notice_content" id="notice_content" class="form-control form-control-sm" rows="5">${noticeDTO.notice_content}</textarea>
                                    </div>
                                </div>
                                <input type="hidden" name="notice_code" value="${noticeDTO.notice_code}">
                                <input type="hidden" name="notice_type" value="${noticeDTO.notice_type}" />
                                <div class="form-group">
                                    <button type="submit" class="btn btn-secondary">수정</button>
                                    <button type="button" class="btn btn-secondary" onclick="cancelEdit()">취소</button>
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



