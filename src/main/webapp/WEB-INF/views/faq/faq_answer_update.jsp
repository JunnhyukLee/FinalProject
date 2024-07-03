<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>댓글 수정</title>
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
                <h1>댓글 수정</h1>
            </div>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light"></section>
<section id="faq">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>댓글</h5>
                    </div>
                    <div class="card-body">
                        <form action="./FaqAnswerUpdate" method="post" id="faq_form">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="faq_answer" class="ml-sm-3 col-form-label">댓글 내용</label>
                                    <div class="ml-sm-3">
                                        <textarea name="faq_answer" id="faq_answer" class="form-control form-control-sm" rows="5">${faqDTO.faq_answer}</textarea>
                                    </div>
                                </div>
                                <input type="hidden" name="faq_answer_code" value="${faqDTO.faq_answer_code}">
                                <!-- 추가된 부분: 게시글 고유 식별자(hidden input) -->
                                <input type="hidden" name="faq_code" value="${faqDTO.faq_code}">
                                <div class="form-group">
                                    <button type="button" class="btn btn-secondary" onclick="submitForm()">작성</button>
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
<a href="./FaqSelect" class="btn btn-primary btn-block"> 게시판홈으로 돌아가기</a>

<script>
    function submitForm() {
        var answer = document.getElementById('faq_answer').value.trim();

        if (answer === '') {
            alert('댓글 내용을 입력해주세요.');
            return;
        }

        if (answer.length > 2000) {
            alert('댓글 내용이 2000자를 초과하였습니다.');
            return;
        }

        document.getElementById('faq_form').submit();
    }
</script>

</body>
</html>



