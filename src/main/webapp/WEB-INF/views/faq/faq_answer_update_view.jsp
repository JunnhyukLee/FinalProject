<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 수정</title>
</head>
<body>
<script type="text/javascript">
    alert("댓글 내용이 작성되었습니다");
    var faq_code = "${param.faq_code}";
    location.href = "./FaqSelectDetail?faq_code="+ faq_code;
</script>
</body>
</html>
