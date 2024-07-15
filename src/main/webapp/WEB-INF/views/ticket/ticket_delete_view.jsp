<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>정기권 삭제</title>
</head>
<body>
	<script type="text/javascript">
		alert("입력하신 ${ticketDTO.ticket_code}번의 정기권을 삭제하였습니다.");
		location.href = "./TicketSearch";
	</script>
</body>
</html>