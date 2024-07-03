<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>리뷰 작성</title>
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
<link rel="stylesheet" type="text/css" href="./css/global.css">
<script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
<script src="./js/jquery.validate.min.js" type="text/javascript"></script>
</head>
<body>
<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>리뷰 작성</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light">
</section>
<section id="comment-write">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>댓글 작성</h5>
                    </div>
                    <div class="card-body">
                        <form action="./CommentInsert" method="post" id="comment_form">
                        <!-- <input type="hidden" name="parking_code" value="${parking_code}" /> -->
                            <fieldset>
                                <div class="form-group row">
                                    <label for="comment_content" class="ml-sm-3 col-form-label">내용</label>
                                    <div class="ml-sm-3">
                                        <textarea name="comment_content" id="comment_content" class="form-control form-control-sm" rows="5"></textarea>
                                    </div>
                                </div>
                                <div class="form-group">
                                    <button type="button" class="btn btn-secondary" onclick="submitForm()">등록</button>
                                    <button type="reset" class="btn btn-secondary">취소</button>
                                </div>
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<a href="./CommentSelect" class="btn btn-primary btn-block"> 댓글 목록으로 돌아가기</a>

<script>
    function submitForm() {
        var content = document.getElementById('comment_content').value.trim();

        if (content === '') {
            alert('내용을 입력해주세요.');
            return;
        }

        // 추가적인 유효성 검사 등이 필요하다면 여기에 추가할 수 있습니다.

        document.getElementById('comment_form').submit();
    }
</script>

</body>
</html>
