<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
request.setCharacterEncoding("UTF-8");

application.log(request.getParameter("coupon_use"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쿠폰 정보 수정</title>
</head>
<body>
	사용여부 :
	<%
if (request.getParameter("coupon_use").equals("사용가능")) {
%>
	사용가능
	<%
} else {
%>
	이미사용된쿠폰
	<%
}
%>

	<script type="text/javascript">
		alert("입력하신 ${couponDTO.coupon_code}번의 쿠폰 코드 번호를 수정하였습니다.");
		location.href = "./CouponSelect";
	</script>

</body>
</html>