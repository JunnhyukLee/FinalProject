import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Button, Table } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';

const RecordsUser = () => {
	const [records, setRecords] = useState([]);
	const [recordDetail, setRecordDetail] = useState(null);
	const [view, setView] = useState('userList');
	const member_code = window.memberCode; // JSP에서 설정한 memberCode 변수를 사용합니다.

	useEffect(() => {
		loadRecords();
	}, []);

	const loadRecords = async () => {
		try {
			const responseList = await axios.get(`./recordsSelectUser/${member_code}`);
			console.log('Response List:', responseList); // 응답 로그 추가
			setRecords(responseList.data);
		} catch (error) {
			console.error('Error fetching records:', error); // 에러 로그 추가
			alert('주차 기록을 가져올 수 없습니다.');
		}
	};

	const loadRecordDetail = async (records_code) => {
		try {
			const responseDetail = await axios.get(`./recordsSelectDetailUser/${records_code}`);
			console.log('Response Detail:', responseDetail); // 응답 로그 추가
			setRecordDetail(responseDetail.data);
			setView('userDetail');
		} catch (error) {
			console.error('Error fetching record detail:', error); // 에러 로그 추가
			alert('주차 기록 상세 정보를 가져올 수 없습니다.');
		}
	};

	const handleViewDetail = (records_code) => {
		loadRecordDetail(records_code);
	};

	const handleBackToList = () => {
		setRecordDetail(null);
		setView('userList');
	};

	return (
		<div className="container p-3 my-3 border">
			<h1>주차 기록 관리</h1>
			{view === 'userList' && (
				<>
					<Button variant="outline-secondary" onClick={() => (window.location.href = './Menu')}>
						메뉴
					</Button>
					<h3>주차 기록 조회</h3>
					<Table className="custom-table">
						<thead>
							<tr>
								<th>코드 번호</th>
								<th>차량 번호</th>
								<th>입차 시간</th>
								<th>출차 시간</th>
								<th>상세 정보</th>
							</tr>
						</thead>
						<tbody>
							{records.length ? (
								records.map((record) => (
									<tr key={record.records_code}>
										<td>{record.records_code}</td>
										<td>{record.member_car_num}</td>
										<td>{record.records_start}</td>
										<td>{record.records_end}</td>
										<td>
											<Button
												variant="outline-info"
												onClick={() => handleViewDetail(record.records_code)}
											>
												상세 정보
											</Button>
										</td>
									</tr>
								))
							) : (
								<tr>
									<td colSpan="5">회원님 정보로 주차 이용 내역이 없습니다.</td>
								</tr>
							)}
						</tbody>
					</Table>
				</>
			)}
			{view === 'userDetail' && recordDetail && (
				<div className="container p-3 my-3 border">
					<h3>상세 주차 기록 조회</h3>
					<div>주차 기록 코드: {recordDetail.records_code}</div>
					<div>차량 번호: {recordDetail.member_car_num}</div>
					<div>주차장 이름: {recordDetail.parking_name}</div>
					<div>입차 시간: {recordDetail.records_start}</div>
					<div>출차 시간: {recordDetail.records_end}</div>
					<Button variant="outline-secondary" onClick={handleBackToList}>
						주차 기록 목록(사용자)
					</Button>
					<Button variant="outline-secondary" onClick={() => window.location.href = `./CommentInsert?parking_code=${recordDetail.parking.parking_code}`}>
						리뷰 작성
					</Button>
				</div>
			)}
		</div>
	);
};

export default RecordsUser;
