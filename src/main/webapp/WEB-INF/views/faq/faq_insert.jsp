<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시글</title>
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
                <h1>게시글</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light">
</section>
<section id="faq">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>게시글</h5>
                    </div>
                    <div class="card-body">
                        <form action="./FaqInsert" method="post" id="faq_form">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="faq_title" class="ml-sm-3 col-form-label">제목</label>
                                    <div class="ml-sm-3">
                                        <input type="text" name="faq_title" id="faq_title" class="form-control form-control-sm">
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="faq_question" class="ml-sm-3 col-form-label">내용</label>
                                    <div class="ml-sm-3">
                                        <textarea name="faq_question" id="faq_question" class="form-control form-control-sm" rows="5"></textarea>
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
<a href="./FaqSelect" class="btn btn-primary btn-block"> 게시판 홈으로 돌아가기</a>

<script>
    function submitForm() {
        var title = document.getElementById('faq_title').value.trim();
        var question = document.getElementById('faq_question').value.trim();

        if (title === '') {
            alert('제목을 입력해주세요.');
            return;
        }

        if (question === '') {
            alert('내용을 입력해주세요.');
            return;
        }

        if (question.length > 2000) {
            alert('내용이 허용된 글자수를 초과하였습니다.');
            return;
        }

        document.getElementById('faq_form').submit();
    }
</script>

</body>
</html>


