<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>리뷰 댓글 목록</title>
    <link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css">
    <link rel="stylesheet" type="text/css" href="./css/global.css">
    <script src="./js/jquery-3.5.1.min.js" type="text/javascript"></script>
    <script src="./js/bootstrap.min_4.5.0.js" type="text/javascript"></script>
    <script>
    function deleteComment(comment_code) {
        if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
            // AJAX 요청을 통해 서버에 삭제 요청을 보냄
            $.ajax({
                type: "POST",
                url: "./CommentDelete", // 삭제를 처리하는 URL
                data: { comment_code: comment_code }, // 삭제할 댓글 코드 전달
                success: function(response) {
                    // 삭제 성공 시 알림창 또는 다른 작업 수행
                    alert("댓글이 삭제되었습니다.");
                    // 삭제 후 필요한 동작 수행 (예: 페이지 리로드 등)
                    window.location.href = "./CommentSelect";
                },
                error: function(xhr, status, error) {
                    // 삭제 실패 시 처리
                    alert("댓글 삭제에 실패했습니다.");
                }
            });
        }
    }
    function goToAddComment() {
        window.location.href = "./CommentInsert";
    }
    </script>
</head>
<body>
<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>댓글 목록</h1>
            </div>
            <div class="col-md-6 text-right">
                <button onclick="goToAddComment()" class="btn btn-primary">댓글 작성</button>
            </div>
        </div>
    </div>
</header>
<section id="comments">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>댓글 목록</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-hover">
                            <thead class="thead-light">
                            <tr class="text-center">
                                <th>댓글 코드</th>
                                <th>댓글 내용</th>
                                <th>작성 날짜</th>
                                <th>액션</th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="list" items="${list}">
                                <tr class="text-center">
                                    <td>${list.comment_code}</td>
                                    <td>${list.comment_content}</td>
                                    <td>
                                        <fmt:formatDate value="${list.comment_date}" pattern="yyyy-MM-dd HH:mm" />
                                    </td>
                                    <td>
                                        <a href="./CommentUpdate?comment_code=${list.comment_code}" class="btn btn-warning">수정</a>
                                        <button onclick="deleteComment(${list.comment_code})" class="btn btn-danger">삭제</button>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty list}">
                                <tr>
                                    <td colspan="4">등록된 댓글이 없습니다.</td>
                                </tr>
                            </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
</html>



