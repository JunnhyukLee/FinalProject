<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 댓글 목록</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
<script>
    $(document).ready(function() {
        var csrfToken = '${_csrf.token}';

        function deleteComment(comment_code) {
            if (confirm("정말로 이 댓글을 삭제하시겠습니까?")) {
                $.ajax({
                    type: "POST",
                    url: "./CommentDelete",
                    data: { 
                        comment_code: comment_code,
                        _csrf: csrfToken 
                    },
                    success: function(response) {
                        alert("댓글이 삭제되었습니다.");
                        window.location.href = "./CommentSelectMember?member_code=" + ${member_code};
                    },
                    error: function(xhr, status, error) {
                        alert("댓글 삭제에 실패했습니다.");
                    }
                });
            }
        }

        function goToAddComment() {
            window.location.href = "./CommentInsert";
        }

        window.deleteComment = deleteComment;
        window.goToAddComment = goToAddComment;
    });
</script>
<style>
body {
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	margin: 0;
}

main {
	flex: 1;
}

footer {
	background-color: #6c757d;
	color: white;
	padding: 10px 0;
}

.btn-custom {
    width: 80px; /* 버튼의 너비를 동일하게 설정 */
    height: 40px; /* 버튼의 높이를 동일하게 설정 */
    font-size: 16px; /* 버튼의 글자 크기를 동일하게 설정 */
    margin-right: 10px; /* 버튼 간의 간격 설정 */
}

/* 버튼 컨테이너 */
.button-container {
    text-align: center; /* 가운데 정렬 */
    margin-top: 20px; /* 위 여백 설정 */
}
</style>
<script type="text/javascript">
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
            location.href = '<c:url value="/logout" />';
        }
    }
</script>
</head>
<body>

   <header id="main-header" class="py-2 bg-secondary text-white">
      <div class="container">
         <div class="row align-items-start justify-content-between">
            <div class="col-md-4 text-left">
               <h1>
                  <i class="fas fa-lock-open"></i>P.K.-Management
               </h1>
            </div>
            <div class="col-md-7 d-flex align-items-center">
               <div>
                  <c:if test="${not empty sessionScope.customMemberDetails}">
                     <div>환영합니다, ${sessionScope.customMemberDetails.username}님</div>
                  </c:if>
               </div>
               &nbsp;&nbsp;&nbsp;&nbsp;
               <div>
                  <c:choose>
                     <c:when test="${empty sessionScope.customMemberDetails}">
                        <button onclick="location.href='<c:url value='/login' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그인
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberInsert' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 회원가입
                        </button>
                     </c:when>
                     <c:otherwise>
                        <button onclick="confirmLogout()"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그아웃
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberSelectDetail'/>'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 내정보 보기
                        </button>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'ADMIN'}">
                           <button onclick="location.href='<c:url value='/AdminView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 어드민 메뉴 보기
                           </button>
                        </c:if>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'MANAGER'}">
                           <button onclick="location.href='<c:url value='/ManagerView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 매니저 메뉴 보기
                           </button>
                        </c:if>
                     </c:otherwise>
                  </c:choose>
               </div>
            </div>
         </div>
      </div>
   </header>

<main>

    <header id="main-header" class="py-2 btn-dark text-white">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h1>회원 댓글 목록</h1>
                </div>
                <div class="col-md-6 text-right">
                    <button onclick="location.href ='./Menu'" class="btn btn-primary btn-custom">메뉴</button>
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
                                    <c:forEach var="comment" items="${list}">
                                        <tr class="text-center">
                                            <td>${comment.comment_code}</td>
                                            <td>${comment.comment_content}</td>
                                            <td><fmt:formatDate value="${comment.comment_date}" pattern="yyyy-MM-dd HH:mm" /></td>
                                            <td>
                                                <a href="./CommentUpdate?comment_code=${comment.comment_code}" class="btn btn-warning btn-custom">수정</a>
                                                <button onclick="deleteComment(${comment.comment_code})" class="btn btn-danger btn-custom">삭제</button>
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

</main>

<footer id="main-footer" class="py-2 bg-secondary text-black">
    <div class="container">
        <div class="row align-items-start justify-content-between">
            <div class="col-md-8">
                <div>
                    <button onclick="location.href = './TermSelect'"
                            style="padding: 5px 10px; font-size: 15px; background-color: transparent; border: none; color: white;">
                        <i class="fa fa-user"></i> 이용약관
                    </button>
                </div>
            </div>
            <div class="col-md-4 text-right">
                <h1 style="font-size: 15px">
                    <i class="fas fa-lock"></i>e1i4 제작
                </h1>
            </div>
        </div>
    </div>
</footer>

</body>
</html>
