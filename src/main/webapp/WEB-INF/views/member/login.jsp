<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css?20240709'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/global.css?20240709'/>">
    <link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.min_4.5.0.css?20240709'/>">
    <script src="<c:url value='/js/jquery-3.5.1.min.js?20240709'/>" type="text/javascript"></script>
    <script src="<c:url value='/js/bootstrap.min_4.5.0.js?20240709'/>" type="text/javascript"></script>
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

        .login-container {
            text-align: center;
            margin-top: 50px;
        }

        .login-container input, .login-container button {
            display: block;
            margin: 10px auto;
            width: 300px;
            padding: 10px;
        }

        .login-container button {
            background-color: black;
            color: white;
            border: none;
            cursor: pointer;
        }
    </style>
   <script type="text/javascript">
        $(document).ready(function() {
            var urlParams = new URLSearchParams(window.location.search);
            console.log("에러값: ", urlParams.get('error'));
            console.log("로그인 Required값: ", urlParams.get('loginRequired'));

            if (urlParams.get('error') === 'true') {
                alert("아이디 및 비밀번호를 확인해주세요");
            }

            if (urlParams.get('loginRequired') === 'true') {
                alert("로그인 해주세요.");
            }
        });
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
        </div>
    </div>
</header>

<main>
    <div class="login-container">
        <form action="<c:url value='/login_proc'/>" method="post">
            <input type="text" name="username" placeholder="아이디" required>
            <input type="password" name="password" placeholder="비밀번호" required>
            <button type="submit">로그인</button>
        </form>
        <button onclick="location.href='<c:url value='/MemberInsert'/>'">회원가입</button>
    </div>
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
