<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>게시글 삭제</title>
    <!-- 부트스트랩 및 추가 스타일시트, 자바스크립트 파일 링크 -->
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
</head>
<body>
<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>게시글 삭제</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light"></section>
<section id="notice-delete">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>게시글 삭제</h5>
                    </div>
                    <div class="card-body">
                        <form action="./NoticeDelete" method="post" id="notice_delete_form">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="notice_code" class="ml-sm-3 col-form-label">게시글 번호</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="notice_code" id="notice_code" class="form-control form-control-sm bg-white" value="${param.notice_code}">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-secondary">삭제</button>
                                    <a href="./NoticeSelect" class="btn btn-secondary">취소</a>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>

