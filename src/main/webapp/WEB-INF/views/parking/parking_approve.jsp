<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주차장 승인</title>
</head>
<body>
	
	<script type="text/javascript">
		alert("${parkingDTO.parking_code}번의 주차장을 승인하였습니다.");
		location.href = "${pageContext.request.contextPath}/ParkingSelectAdmin";
	</script>

</body>
</html>