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
		alert("입력하신 글의 내용을 수정하였습니다");
		location.href = "./NoticeSelectEventDetail?notice_code=${param.notice_code}";
	</script>

</body>
</html>