<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 수정</title>
</head>
<body>
	<script type="text/javascript">
		alert("게시글의 내용을 수정하였습니다");
		var faq_code = "${param.faq_code}";
		location.href = "./FaqSelectDetail?faq_code=" + faq_code;
	</script>

</body>
</html>