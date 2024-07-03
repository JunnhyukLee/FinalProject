<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>질문 게시판</title>
    <link rel="shortcut icon" href="./img/favicon.ico" type="image/x-icon">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
    <script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
    <script>
        function deleteFaq(faq_code) {
            if (confirm("정말로 이 게시물을 삭제하시겠습니까?")) {
                $.ajax({
                    type: "POST",
                    url: "./FaqDelete",
                    data: { faq_code: faq_code },
                    success: function(response) {
                        alert("게시글이 삭제되었습니다.");
                        window.location.href = "./FaqSelect";
                    },
                    error: function(xhr, status, error) {
                        alert("게시글 삭제에 실패했습니다.");
                    }
                });
            }
        }

        function deleteFaqAnswer(faq_code) {
            if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                $.ajax({
                    type: "POST",
                    url: "./FaqAnswerDelete",
                    data: { faq_code: faq_code },
                    success: function(response) {
                        alert("댓글이 삭제되었습니다.");
                        window.location.href = "./FaqSelectDetail?faq_code=" + faq_code;
                    },
                    error: function(xhr, status, error) {
                        alert("댓글 삭제에 실패했습니다.");
                    }
                });
            }
        }
    </script>
</head>
<body>
<nav class="navbar navbar-expand-md bg-dark navbar-dark text-white">
    <div class="container">
        <div class="col-md-6">
            <h1>
                <i class="fas fa-user-tag"></i>
                게시판
            </h1>
        </div>
        <div id="toggle" class="navbar-collapse collapse">
            <ul class="navbar-nav">
            </ul>
            <ul class="navbar-nav ml-auto py-3 mb-3 pl-3 pr-3">
                <li>
                    <a href="FaqSelect" class="navbar-brand text-white">
                        <i class="fa fa-home"></i>홈
                    </a>
                </li>
            </ul>
        </div>
    </div>
</nav> 
<header id="main-header" class="py-2 bg-secondary"> </header>
<section class="py-3 mb-3 bg-light">
    <div class="container">
        <div class="row col-md-12"></div>
    </div>
</section>
<section id="board">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h3 class="text-muted">
                            <i class="fas fa-sticky-note mr-sm-1"></i>글 내용
                        </h3>
                        <div class="form-group row">
                           <c:if test="${faqDTO.member_code == member_code || member_rating == 'admin'}">
                                <div class="col-10 offset-2 pl-0 py-1">
                                    <a href="./FaqUpdate?faq_code=${faqDTO.faq_code}" class="btn btn-outline-secondary mr-1">
                                        <i class="fas fa-edit"></i> 수정
                                    </a>
                                    <!-- 삭제 버튼에 onclick 이벤트 추가 -->
                                    <button onclick="deleteFaq(${faqDTO.faq_code})" class="btn btn-outline-danger">
                                        <i class="fas fa-trash"></i> 삭제
                                    </button>
                                </div>
                            </c:if>
                        </div>
                    </div>
                    <div class="card-body">
                        <div class="row pl-1 pr-1">
                            <div class="col col-md-10">
                                <input type="hidden" name="faq_code" value="${faqDTO.faq_code}">
                                <div class="form-group row">
                                    <label for="subject" class="col-2 col-form-label pr-0"><i class="fas fa-pen-alt mr-sm-1"></i>제목</label>
                                    <div class="col-10 pl-0 py-1">
                                        ${faqDTO.faq_title}
                                    </div>
                                </div>
                                <div class="form-group row">
                                    <label for="question" class="col-2 col-form-label pr-0"><i class="fas fa-edit mr-sm-1"></i>내용</label>
                                    <div class="col-10 pl-0 py-1">
                                        ${faqDTO.faq_question}
                                    </div>
                                </div>
                                <c:if test="${empty faqDTO.faq_answer and member_rating == 'admin'}">
                                    <div class="form-group row">
                                        <div class="col-12 text-right">
                                            <a href="./FaqAnswerUpdate?faq_code=${faqDTO.faq_code}" class="btn btn-primary">댓글 작성</a>
                                        </div>
                                    </div>
                                </c:if>
                                <c:if test="${not empty faqDTO.faq_answer}">
                                    <div class="form-group row">
                                        <label for="answer" class="col-2 col-form-label pr-0"><i class="fas fa-comments mr-sm-1"></i>답변</label>
                                        <div class="col-10 pl-0 py-1">
                                            ${faqDTO.faq_answer}
                                            <span class="text-muted ml-2">
                                                작성일: <fmt:formatDate value="${faqDTO.faq_answer_date}" pattern="yyyy-MM-dd HH:mm"/>
                                                <c:if test="${member_rating == 'admin'}">
                                                    <a href="./FaqAnswerUpdate?faq_code=${faqDTO.faq_code}" class="btn btn-outline-secondary btn-sm ml-2">수정</a>
                                                    <button onclick="deleteFaqAnswer(${faqDTO.faq_code})" class="btn btn-outline-danger btn-sm ml-2">삭제</button>
                                                </c:if>
                                            </span>
                                        </div>
                                    </div>
                                </c:if>
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
