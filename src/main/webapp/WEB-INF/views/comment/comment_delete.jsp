<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>리뷰 댓글 삭제</title>
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
                <h1>댓글 삭제</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light">
</section>
<section id="comment-delete">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>댓글 삭제</h5>
                    </div>
                    <div class="card-body">
                        <form action="./CommentDelete" method="post" id="comment_delete_form">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="comment_code" class="ml-sm-3 col-form-label">댓글 번호</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="comment_code" id="comment_code" class="form-control form-control-sm bg-white">
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="submit" class="btn btn-secondary">삭제</button>
                                    <a href="./CommentSelect" class="btn btn-secondary">취소</a>
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