<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>내 요금</title>
<link rel="stylesheet" type="text/css" href="./css/style.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/global.css?20240709">
<link rel="stylesheet" type="text/css" href="./css/bootstrap.min_4.5.0.css?20240709">
<script src="./js/jquery-3.5.1.min.js?20240709" type="text/javascript"></script>
<script src="./js/bootstrap.min_4.5.0.js?20240709" type="text/javascript"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<meta name="_csrf" content="${_csrf.token}"/>
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

/* 버튼 스타일 */
button {
    background-color: #6c757d; /* 헤더의 배경색과 같은색으로 설정 */
    color: white; /* 글자색 흰색으로 설정 */
    border: none; /* 테두리 제거 */
    padding: 10px 20px; /* 버튼 내부 여백 설정 */
    cursor: pointer; /* 커서 모양 변경 */
    margin-bottom: 10px; /* 버튼 아래 여백 설정 */
    margin-left: 30px;
}

button:hover {
    background-color: #5a6268; /* 호버 상태일 때 배경색 약간 어둡게 변경 */
}

/* 버튼 컨테이너 */
.button-container {
    text-align: left; /* 가운데 정렬 */
    margin-top: 20px; /* 위 여백 설정 */
}
</style>
<script type="text/javascript">
    function confirmLogout() {
        if (confirm("로그아웃 하시겠습니까?")) {
            location.href = '<c:url value="/logout" />';
        }
    }
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
            <div class="col-md-7 d-flex align-items-center">
               <div>
                  <c:if test="${not empty sessionScope.customMemberDetails}">
                     <div>환영합니다, ${sessionScope.customMemberDetails.username}님</div>
                  </c:if>
               </div>
               &nbsp;&nbsp;&nbsp;&nbsp;
               <div>
                  <c:choose>
                     <c:when test="${empty sessionScope.customMemberDetails}">
                        <button onclick="location.href='<c:url value='/login' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그인
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberInsert' />'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 회원가입
                        </button>
                     </c:when>
                     <c:otherwise>
                        <button onclick="confirmLogout()"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 로그아웃
                        </button>
                        <button
                           onclick="location.href='<c:url value='/MemberSelectDetail'/>'"
                           style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                           <i class="fa fa-user"></i> 내정보 보기
                        </button>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'ADMIN'}">
                           <button onclick="location.href='<c:url value='/AdminView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 어드민 메뉴 보기
                           </button>
                        </c:if>
                        <c:if test="${sessionScope.customMemberDetails.memberRating == 'MANAGER'}">
                           <button onclick="location.href='<c:url value='/ManagerView'/>'"
                              style="padding: 5px 5px; font-size: 15px; background-color: transparent; border: none; color: white;">
                              <i class="fa fa-user"></i> 매니저 메뉴 보기
                           </button>
                        </c:if>
                     </c:otherwise>
                  </c:choose>
               </div>
            </div>
         </div>
      </div>
   </header>

<main>

<header id="main-header" class="py-2 btn-dark text-white">
    <div class="container">
        <div class="row">
            <div class="col-md-6">
                <h1>요금 정산</h1>
            </div>
                <button onclick="location.href ='./Menu'">메뉴</button>
        </div>
    </div>
</header>
<section class="py-4 mb-4 bg-light"></section>
<section id="department">
    <div class="container">
        <div class="row">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-header">
                        <h5>정산 목록</h5>
                    </div>
                    <div class="card-body">
                        <form id="selectForm">
                            <table class="table table-hover">
                                <thead class="thead-light">
                                    <tr class="text-center">
                                        <th>선택</th>
                                        <th>사용자 ID</th>
                                        <th>정산 날짜</th>
                                        <th>정산 금액</th>
                                        <th>정산 상태</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="list" items="${calculateList}">
                                        <tr class="text-center">
                                            <td><input type="radio" name="selectedRow"
                                                       value="${list.calculate_code}" data-amount="${list.calculate_amount}"></td>
                                            <td>${list.member_id}</td>
                                            <td>
                                                <fmt:formatDate value="${list.calculate_date}" pattern="yyyy.MM.dd HH:mm" />
                                            </td>
                                            <td>
                                                <fmt:formatNumber value="${list.calculate_amount}" type="number" maxFractionDigits="0"/>원
                                            </td>
                                            <td>${list.calculate_status}</td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                            <div class="text-right">
                                <button type="button" class="btn btn-primary" id="payButton">결제하기</button>
                            </div>
                        </form>
                        <!-- 결제 정보를 전송할 숨은 폼 -->
                        <form id="paymentForm" method="post" action="./PaymentInsert" style="display:none;">
                            <input type="hidden" id="hiddenCode" name="calculate_code" />
                            <input type="hidden" id="hiddenAmount" name="calculate_amount" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<script type="text/javascript">
    $(document).ready(function() {
        var csrfToken = $("meta[name='_csrf']").attr("content");

        $('#payButton').click(function() {
            var selectedCode = $('input[name="selectedRow"]:checked').val();
            var selectedAmount = parseInt($('input[name="selectedRow"]:checked').data('amount'), 10);

            console.log('선택된 코드:', selectedCode);
            console.log('선택된 금액:', selectedAmount);

            if (!selectedCode || !selectedAmount) {
                alert('정산 목록에서 항목을 선택하세요.');
                return;
            }

            // 결제할 정보를 hidden 필드에 설정
            $('#hiddenCode').val(selectedCode);
            $('#hiddenAmount').val(selectedAmount);

            // 아임포트 결제 요청
            var IMP = window.IMP;
            IMP.init('imp75221483'); 
            IMP.request_pay({
                pg: 'html5_inicis', 
                pay_method: 'card', 
                merchant_uid: 'merchant_' + new Date().getTime(), 
                name: '요금 정산', 
                amount: selectedAmount, 
                m_redirect_url: './PaymentInsert' 
            }, function(rsp) {
                if (rsp.success) {
                    console.log('결제 성공');
                    sendPaymentInfo(selectedCode, selectedAmount, '결제완료');
                    updateCalculateStatus(selectedCode);
                    var msg = '결제가 완료되었습니다.';
                    alert(msg);
                } else {
                    console.log('결제 실패:', rsp.error_msg);
                    var msg = '결제에 실패하였습니다. ' + rsp.error_msg;
                    alert(msg);

                    // 결제 실패 시 서버에 정보 전송
                    sendPaymentInfo(selectedCode, selectedAmount, '결제실패');
                }
            });
        });

        // 결제 정보를 서버로 전송하는 함수
        function sendPaymentInfo(calculate_code, calculate_amount, payment_status) {
            console.log('결제 정보 전송 시도 중');
            $.ajax({
                type: 'POST',
                url: './PaymentInsert',
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken); // CSRF 토큰 설정
                },
                contentType: 'application/json',
                data: JSON.stringify({
                    payment_code: generatePaymentCode(),
                    calculate_code: calculate_code,
                    payment_total: calculate_amount,
                    payment_name: '요금정산',
                    payment_status: payment_status
                }),
                success: function(response) {
                    console.log('서버로 결제 정보 전송 성공');
                    console.log(response); // 서버 응답 확인

                    // 결제 성공 후 calculate_status 업데이트 요청
                    updateCalculateStatus(calculate_code);
                },
                error: function(xhr, status, error) {
                    console.error('결제 정보 전송 실패: ' + error);
                }
            });
        }

        // 정산 상태 업데이트 함수
        function updateCalculateStatus(calculate_code) {
            console.log('정산 상태 업데이트 시도 중');
            $.ajax({
                type: 'POST',
                url: './UpdateCalStatus',
                data: {
                    calculate_code: calculate_code
                },
                beforeSend: function(xhr) {
                    xhr.setRequestHeader('X-CSRF-TOKEN', csrfToken); // CSRF 토큰 설정
                },
                success: function(response) {
                    console.log('정산 상태 업데이트 성공:', response);
                    // 추가 성공 처리
                },
                error: function(xhr, status, error) {
                    console.error('정산 상태 업데이트 실패:', error);
                    // 실패 메시지 표시
                }
            });
        }

        // 1부터 1000까지 순차적으로 payment_code 생성
        function generatePaymentCode() {
            var currentPaymentCode = localStorage.getItem('currentPaymentCode') || 0;
            currentPaymentCode = parseInt(currentPaymentCode) + 1;
            if (currentPaymentCode > 1000) {
                currentPaymentCode = 1; // 1000을 초과하면 다시 1로 초기화
            }
            localStorage.setItem('currentPaymentCode', currentPaymentCode);
            return currentPaymentCode;
        }
    });
</script>
</main>

<footer>
    <div class="container">
        <div class="text-center">
            &copy; 2023 Company Name. All rights reserved.
        </div>
    </div>
</footer>

</body>
</html>
