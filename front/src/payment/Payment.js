import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Payment = () => {
    // 상태 변수 선언
    const [payments, setPayments] = useState([]); // 모든 결제 내역을 저장하는 배열
    const [selectedPayment, setSelectedPayment] = useState(null); // 선택된 결제 내역
    const [paymentData, setPaymentData] = useState({
        payment_code: '',
        payment_name: '',
        payment_total: ''
    });

    // 컴포넌트가 마운트될 때 결제 내역을 가져옴
    useEffect(() => {
        fetchPayments();
    }, []);

    // 전체 결제 내역을 서버에서 가져오는 함수
    const fetchPayments = async () => {
        try {
            const response = await axios.get('/payments');
            setPayments(response.data);
        } catch (error) {
            console.error('결제 내역을 가져오는 중 오류 발생:', error);
        }
    };

    // 특정 결제 내역을 서버에서 가져오는 함수
    const fetchPaymentDetails = async (payment_code) => {
        try {
            const response = await axios.get(`/payments/${payment_code}`);
            setSelectedPayment(response.data);
        } catch (error) {
            console.error('결제 상세 정보를 가져오는 중 오류 발생:', error);
        }
    };

    // 입력 필드의 값이 변경될 때 상태를 업데이트하는 함수
    const handleInputChange = (e) => {
        const { name, value } = e.target;
        setPaymentData({
            ...paymentData,
            [name]: value
        });
    };

    // 새로운 결제를 생성하는 함수
    const handleCreatePayment = async () => {
        try {
            await axios.post('/payments', paymentData);
            alert('결제가 성공적으로 생성되었습니다!');
            fetchPayments(); // 결제 내역을 다시 가져옴
        } catch (error) {
            console.error('결제 생성 중 오류 발생:', error);
        }
    };

    // 기존 결제 정보를 수정하는 함수
    const handleUpdatePayment = async () => {
        try {
            await axios.put(`/payments/${paymentData.payment_code}`, paymentData);
            alert('결제가 성공적으로 수정되었습니다!');
            fetchPayments(); // 결제 내역을 다시 가져옴
        } catch (error) {
            console.error('결제 수정 중 오류 발생:', error);
        }
    };

    // 특정 결제를 삭제하는 함수
    const handleDeletePayment = async (payment_code) => {
        try {
            await axios.delete(`/payments/${payment_code}`);
            alert('결제가 성공적으로 삭제되었습니다!');
            fetchPayments(); // 결제 내역을 다시 가져옴
        } catch (error) {
            console.error('결제 삭제 중 오류 발생:', error);
        }
    };

    return (
        <div>
            <h1>결제 관리</h1>
            <div>
                <h2>결제 생성 / 수정</h2>
                <input
                    type="text"
                    name="payment_code"
                    placeholder="결제 코드"
                    value={paymentData.payment_code}
                    onChange={handleInputChange}
                />
                <input
                    type="text"
                    name="payment_name"
                    placeholder="결제 이름"
                    value={paymentData.payment_name}
                    onChange={handleInputChange}
                />
                <input
                    type="number"
                    name="payment_total"
                    placeholder="결제 금액"
                    value={paymentData.payment_total}
                    onChange={handleInputChange}
                />
                <button onClick={handleCreatePayment}>결제 생성</button>
                <button onClick={handleUpdatePayment}>결제 수정</button>
            </div>
            <div>
                <h2>결제 목록</h2>
                <ul>
                    {payments.map((payment) => (
                        <li key={payment.payment_code}>
                            {payment.payment_name} - {payment.payment_total}원
                            <button onClick={() => fetchPaymentDetails(payment.payment_code)}>상세 보기</button>
                            <button onClick={() => handleDeletePayment(payment.payment_code)}>삭제</button>
                        </li>
                    ))}
                </ul>
            </div>
            {selectedPayment && (
                <div>
                    <h2>결제 상세 정보</h2>
                    <p>코드: {selectedPayment.payment_code}</p>
                    <p>이름: {selectedPayment.payment_name}</p>
                    <p>금액: {selectedPayment.payment_total}원</p>
                </div>
            )}
        </div>
    );
};

export default Payment;
