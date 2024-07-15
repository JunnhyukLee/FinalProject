<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 수정</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
<script type="text/javascript">
	function confirmSignUp(event) {
		event.preventDefault(); // 폼 제출 기본 동작을 막음

		if (!validateForm()) {
			return false;
		}
		if (confirm("수정하시겠습니까?")) {
			document.getElementById("sign_dept").submit();
			alert("수정이 완료되었습니다");
		}
	}
	
	function validateForm() {

		if (!$("input[name='member_password']").val()) {
			alert("비밀번호를 입력하세요.");
			$("input[name='member_password']").focus();
			return false;
		}
		var regexp_member_password = /^[a-zA-Z0-9!@#$%^&*()_+\-=\[\]{};':"\\|,.<>\/?]{6,20}$/;
		var member_password_check = $("input[name='member_password']").val();
		if (!regexp_member_password.test(member_password_check)) {
		    alert("비밀번호는 공백을 제외한 6~20자만 입력할 수 있습니다.");
		    $("input[name='member_password']").focus();
		    return false;
		}


		if (!$("input[name='member_name']").val()) {
			alert("이름을 입력하세요.");
			$("input[name='member_name']").focus();
			return false;
		}
		var regexp_name = /^[가-힣]{2,4}$/;
		var name_check = $("input[name='member_name']").val();
		if (!regexp_name.test(name_check)) {
			alert("이름은 공백을 제외한 한글 2~4자만 입력할 수 있습니다.");
			$("input[name='member_name']").focus();
			return false;
		}

		if (!$("input[name='member_email']").val()) {
			alert("이메일을 입력하세요.");
			$("input[name='member_email']").focus();
			return false;
		}
		var regexp_member_email = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/i;
		var member_email_check = $("input[name='member_email']").val();
		if (!regexp_member_email.test(member_email_check)) {
			alert("올바른 이메일 형식이 아닙니다.");
			$("input[name='member_email']").focus();
			return false;
		}

		if (!$("input[name='member_callnumber']").val()) {
			alert("전화번호를 입력하세요.");
			$("input[name='member_callnumber']").focus();
			return false;
		}
		var regexp_member_callnumber = /^\d{3}-\d{3,4}-\d{4}$/i;
		var member_callnumber_check = $("input[name='member_callnumber']")
				.val();
		if (!regexp_member_callnumber.test(member_callnumber_check)) {
			alert("올바른 전화번호 형식이 아닙니다. 예)000-0000-0000");
			$("input[name='member_callnumber']").focus();
			return false;
		}

		if (!$("input[name='member_birthday']").val()) {
			alert("생년월일을 입력하세요.");
			$("input[name='member_birthday']").focus();
			return false;
		}
		var regexp_member_birthday = /^\d{4}-\d{2}-\d{2}$/;
		var member_birthday_check = $("input[name='member_birthday']").val();
		if (!regexp_member_birthday.test(member_birthday_check)) {
			alert("올바른 생년월일 형식이 아닙니다. 예)1999-02-05");
			$("input[name='member_birthday']").focus();
			return false;
		}

		if (!$("#member_gender").val()) {
            alert("성별을 선택해 주세요.");
            $("#member_gender").focus();
            return false;
        }

		if (!$("input[name='member_car_num1']").val()) {
			alert("차량번호를 입력하세요.");
			$("input[name='member_car_num1']").focus();
			return false;
		}
		var regexp_member_car_num1 = /^[0-9]{2,3}[ㄱ-ㅎ가-힣][0-9]{4}$/;
		var member_car_num1_check = $("input[name='member_car_num1']").val();
		if (!regexp_member_car_num1.test(member_car_num1_check)) {
			alert("올바른 차량번호 형식이 아닙니다.");
			$("input[name='member_car_num1']").focus();
			return false;
		}

		return true;
	}
	
	$(function() {
		$("#dbidCheck").click(function() {
			var id = $('#member_id').val();
			$.ajax({
				url : './IdCheck.jh',
				type : 'get',
				data : {
					'member_id' : id
				},
				success : function(result) {
					console.log("아이디 값 - " + result);
					if ($.trim(result) == 1) {
						alert("이미 등록된 아이디입니다.");
						$("#member_id").focus();
					} else {
						alert("등록되지 않은 아이디입니다.");
						$('#idCheck').val("1");
						$("#member_name").focus();
					}
				}
			});
		});
		$("input[id='member_id']").on("change", function() {
			$("#idCheck").val(0);
		});
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

form {
	text-align: center;
	margin-top: 10px;
}

.button-container {
	text-align: left;
	margin-top: 10px;
	margin-left: 10px;
}

.button-container button {
	margin-right: 10px;
	background-color: black; /* 배경색 검정색으로 설정 */
	color: white; /* 글자색 흰색으로 설정 */
	border: none; /* 테두리 제거 */
	padding: 5px 10px; /* 버튼 내부 여백 설정 */
	cursor: pointer; /* 커서 모양 변경 */
}

.button-container button:hover {
	background-color: #333; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

.card-header {
	background-color: #343a40;
	color: white;
}

.form-control-sm {
	width: 100%;
}

.ml-sm-3 {
	margin-left: 1rem;
}
</style>
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
				</div>
			</div>
		</div>
	</header>

	<main>
		<div class="container">
			<div class="row">
				<div class="col-md-12">
					<div class="card mt-4">
						<div class="card-header">
							<h5>회원 수정</h5>
						</div>
						<div class="card-body">
							<form action="./MemberUpdate" method="post" id="sign_dept">
								<fieldset>
									<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
									<div class="form-group row">
										<label for="member_code" class="ml-sm-3 col-form-label">회원 코드</label>
										<div class="ml-sm-3">
											<input type="text" name="member_code" id="member_code" class="form-control form-control-sm bg-white" value="${param.member_code}" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="member_id" class="ml-sm-3 col-form-label">회원 아이디</label>
										<div class="ml-sm-3">
											<input type="text" name="member_id" id="member_id" class="form-control form-control-sm bg-white" value="${memberDTO.member_id}" readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="member_name" class="ml-sm-3 col-form-label">회원 이름</label>
										<div class="ml-sm-3">
											<input type="text" name="member_name" id="member_name" class="form-control form-control-sm" value="${memberDTO.member_name}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_password" class="ml-sm-3 col-form-label">회원 비밀번호</label>
										<div class="ml-sm-3">
											<input type="text" name="member_password" id="member_password" class="form-control form-control-sm" value="${memberDTO.member_password}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_email" class="ml-sm-3 col-form-label">회원 이메일</label>
										<div class="ml-sm-3">
											<input type="text" name="member_email" id="member_email" class="form-control form-control-sm" value="${memberDTO.member_email}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_callnumber" class="ml-sm-3 col-form-label">회원 전화번호</label>
										<div class="ml-sm-3">
											<input type="text" name="member_callnumber" id="member_callnumber" class="form-control form-control-sm" value="${memberDTO.member_callnumber}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_birthday" class="ml-sm-3 col-form-label">회원 생년월일</label>
										<div class="ml-sm-3">
											<input type="text" name="member_birthday" id="member_birthday" class="form-control form-control-sm" value="${memberDTO.member_birthday}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_gender" class="ml-sm-3 col-form-label">회원 성별</label>
										<div class="ml-sm-3">
											<input type="text" name="member_gender" id="member_gender" class="form-control form-control-sm" value="${memberDTO.member_gender}"readonly>
										</div>
									</div>
									<div class="form-group row">
										<label for="member_car_num1" class="ml-sm-3 col-form-label">회원 차량번호1</label>
										<div class="ml-sm-3">
											<input type="text" name="member_car_num1" id="member_car_num1" class="form-control form-control-sm" value="${memberDTO.member_car_num1}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_car_num2" class="ml-sm-3 col-form-label">회원 차량번호2</label>
										<div class="ml-sm-3">
											<input type="text" name="member_car_num2" id="member_car_num2" class="form-control form-control-sm" value="${memberDTO.member_car_num2}">
										</div>
									</div>
									<div class="form-group row">
										<label for="member_car_num3" class="ml-sm-3 col-form-label">회원 차량번호3</label>
										<div class="ml-sm-3">
											<input type="text" name="member_car_num3" id="member_car_num3" class="form-control form-control-sm" value="${memberDTO.member_car_num3}">
										</div>
									</div>
									<input type="hidden" name="member_rating" id="member_rating"value="${memberDTO.member_rating}">
									<div class="form-group">
										<button type="submit" class="btn btn-secondary" onclick="confirmSignUp(event)">수정</button>
										<button type="reset" class="btn btn-secondary" onclick="location.href='/'">취소</button>
									</div>
								</fieldset>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</main>
	<footer id="main-footer" class="py-2 bg-secondary text-white text-center">
		<div class="container">
			<span>© 2024 P.K.-Management</span>
		</div>
	</footer>
</body>
</html>
