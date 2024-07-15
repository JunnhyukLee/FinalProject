<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원 정보 입력</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/bootstrap.min.css'/>">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/style.css'/>">
<script type="text/javascript" src="<c:url value='/js/jquery-3.5.1.min.js'/>"></script>
<script type="text/javascript">
    function confirmSignUp(event) {
        event.preventDefault(); // 폼 제출 기본 동작을 막음

        // 유효성 검사
        if (!validateForm()) {
            return false;
        }

        if (confirm("회원가입 하시겠습니까?")) {
            document.getElementById("sign_member").submit(); // 폼 제출

            // 회원가입 완료 팝업을 띄우기 위해 약간의 딜레이를 줍니다.
            setTimeout(function() {
                alert("회원가입이 완료되었습니다.");
            }, 100);
        }
    }
    
    function validateForm() {
        if (!$("input[name='member_id']").val()) {
            alert("아이디를 입력하세요.");
            $("input[name='member_id']").focus();
            return false;
        }
        var regexp_member_id = /^[a-zA-Z0-9]{8,20}$/;
        var member_id_check = $("input[name='member_id']").val();
        if (!regexp_member_id.test(member_id_check)) {
            alert("아이디에 공백을 제외한 8~20자만 입력할 수 있습니다.");
            $("input[name='member_id']").focus();
            return false;
        }

        if (!$("#idCheck").val() || $("#idCheck").val() == "0") {
            alert("아이디 중복 체크를 해주세요.");
            $("input[name='member_id']").focus();
            return false;
        }

        if (!$("input[name='member_password']").val()) {
            alert("비밀번호를 입력하세요.");
            $("input[name='member_password']").focus();
            return false;
        }
        var regexp_member_password = /^[a-zA-Z0-9]{6,20}$/;
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
        var member_callnumber_check = $("input[name='member_callnumber']").val();
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

    $(document).ready(function() {
        $("#sign_member").on("submit", confirmSignUp);

        $("#dbidCheck").click(function() {
            var id = $('#member_id').val();
            $.ajax({
                url: './IdCheck.jh',
                type: 'get',
                data: {
                    'member_id': id
                },
                success: function(result) {
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
        background-color: #f8f9fa;
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
        text-align: center;
    }

    .container {
        margin-top: 30px;
    }

    .card-header {
        background-color: #343a40;
        color: white;
    }

    .btn-secondary {
        margin-right: 10px;
    }

    .form-group label {
        font-weight: bold;
    }

    .form-control {
        border-radius: 0.25rem;
    }

    .btn-block {
        margin-top: 10px;
    }
</style>
</head>
<body>
    <header id="main-header" class="py-2 bg-secondary text-white">
        <div class="container">
            <div class="row">
                <div class="col-md-6">
                    <h1>회원 정보 입력</h1>
                </div>
            </div>
        </div>
    </header>
    <main class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>회원 입력</h5>
                    </div>
                    <div class="card-body">
                        <form id="sign_member" method="post">
                            <fieldset>
                                <div class="form-group row">
                                    <label for="member_id" class="col-sm-2 col-form-label">회원 아이디</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="member_id" id="member_id" class="form-control form-control-sm">
                                        <button type="button" id="dbidCheck" class="btn btn-info btn-sm mt-1">중복 확인</button>
                                        <input type="hidden" id="idCheck" value="0">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_name" class="col-sm-2 col-form-label">회원 이름</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="member_name" id="member_name" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_password" class="col-sm-2 col-form-label">회원 비밀번호</label>
                                    <div class="col-sm-10">
                                        <input type="password" name="member_password" id="member_password" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_email" class="col-sm-2 col-form-label">회원 이메일</label>
                                    <div class="col-sm-10">
                                        <input type="email" name="member_email" id="member_email" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_callnumber" class="col-sm-2 col-form-label">회원 전화번호</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="member_callnumber" id="member_callnumber" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_birthday" class="col-sm-2 col-form-label">회원 생년월일</label>
                                    <div class="col-sm-10">
                                        <input type="date" name="member_birthday" id="member_birthday" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_gender" class="col-sm-2 col-form-label">회원 성별</label>
                                    <div class="col-sm-10">
                                        <select name="member_gender" id="member_gender" class="form-control form-control-sm">
                                            <option value="" disabled selected>선택</option>
                                            <option value="남자">남자</option>
                                            <option value="여자">여자</option>
                                        </select>
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_car_num1" class="col-sm-2 col-form-label">회원 차번호1</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="member_car_num1" id="member_car_num1" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_car_num2" class="col-sm-2 col-form-label">회원 차번호2</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="member_car_num2" id="member_car_num2" class="form-control form-control-sm">
                                    </div>
                                </div>

                                <div class="form-group row">
                                    <label for="member_car_num3" class="col-sm-2 col-form-label">회원 차번호3</label>
                                    <div class="col-sm-10">
                                        <input type="text" name="member_car_num3" id="member_car_num3" class="form-control form-control-sm">
                                    </div>
                                </div>
                                
                                <input type="hidden" name="member_rating" id="member_rating" value="MEMBER">
                                

                                <div class="form-group">
                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
                                    <button type="submit" class="btn btn-secondary">회원 가입</button>
                                    <button type="reset" class="btn btn-secondary">취소</button>
                                </div>
                            </fieldset>
                        </form>
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
