<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 삭제 결과</title>
</head>
<body>
<script type="text/javascript">
    // 댓글 삭제 성공 시 경고 메시지 표시
    alert("댓글이 성공적으로 삭제되었습니다.");

    // 삭제된 댓글의 게시글 코드로 상세 조회 페이지로 이동
    var faq_code = "${faq_code}";
    location.href = "./FaqSelectDetail?faq_code=" + faq_code;
</script>
</body>
</html>