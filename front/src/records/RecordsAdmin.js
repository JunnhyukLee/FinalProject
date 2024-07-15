import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Button, Table } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';

const RecordsAdmin = () => {
	const [view, setView] = useState('parkingAllList');
	const [parkings, setParkings] = useState([]);
	const [records, setRecords] = useState([]);
	const [recordDetail, setRecordDetail] = useState(null);

	useEffect(() => {
			loadAllParkings();
	}, []);

	const loadAllParkings = async () => {
		try {
			const response = await axios.get(`./recordsSelectAllParking`);
			console.log('Parking Data:', response.data); // 데이터 확인용 콘솔 로그
			setParkings(response.data);
		} catch (error) {
			console.error('Error loading parking data:', error); // 에러 확인용 콘솔 로그
			alert('주차장 목록을 가져올 수 없습니다.');
		}
	};

	const loadRecords = async (parking_code) => {
		try {
			const response = await axios.get(`./recordsSelectParking/${parking_code}`);
			if (response.data && response.data.list) {
				setRecords(response.data.list);
				setView('parkingRecords'); // 뷰를 주차 기록 조회로 전환
			} else {
				alert('주차 기록을 가져올 수 없습니다.');
			}
		} catch (error) {
			console.error('Error loading records:', error); // 에러 확인용 콘솔 로그
			alert('주차 기록을 가져올 수 없습니다.');
		}
	};

	const loadRecordDetail = async (records_code) => {
		try {
			const response = await axios.get(`./recordsSelectDetailParking/${records_code}`);
			setRecordDetail(response.data);
			setView('recordDetail')
		} catch (error) {
			console.error('Error loading record detail:', error); // 에러 확인용 콘솔 로그
			alert('주차 기록 상세 정보를 가져올 수 없습니다.');
		}
	};

	return (
		<div className="container p-3 my-3 border">

			{view === 'parkingAllList' && (
				<div>
					<h1>주차 기록 관리</h1>
					<Button variant="outline-secondary" onClick={() => window.location.href = './Menu'}>
						메뉴
					</Button>
					<h3>주차장 목록 조회</h3>
					<Table className="custom-table">
						<thead>
							<tr>
								<th>회원 코드 번호</th>
								<th>주차장 코드 번호</th>
								<th>주차장 이름</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							{parkings.length ? (
								parkings.map((parking) => (
									<tr key={parking.parking_code}>
										<td>{parking.member?.member_code}</td>
										<td>{parking.parking_code}</td>
										<td>{parking.parking_name}</td>
										<td>
											<Button
												variant="outline-info"
												onClick={() => {
													loadRecords(parking.parking_code);
												}}>
												주차 기록 보기
											</Button>
										</td>
									</tr>
								))
							) : (
								<tr>
									<td colSpan="4">등록된 주차장이 없습니다.</td>
								</tr>
							)}
						</tbody>
					</Table>
				</div>
			)}

			{view === 'parkingRecords' && (
				<div>
					<h1>주차 기록 관리</h1>
					<Button variant="outline-secondary" onClick={() => setView('parkingAllList')}>
						주차장 목록
					</Button>
					
					<h3>주차 기록 조회</h3>
					<Table className="custom-table">
						<thead>
							<tr>
								<th>주차장 코드 번호</th>
								<th>주차 기록 코드 번호</th>
								<th>차량 번호</th>
								<th>입차 시간</th>
								<th>출차 시간</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							{records.length ? (
								records.map((record) => (
									<tr key={record.records_code}>
										<td>{record.parking?.parking_code}</td>
										<td>{record.records_code}</td>
										<td>{record.member_car_num}</td>
										<td>{record.records_start}</td>
										<td>{record.records_end}</td>
										<td>
											<Button variant="outline-info" onClick={() => loadRecordDetail(record.records_code)}>
												상세 정보
											</Button>
										</td>
									</tr>
								))
							) : (
								<tr>
									<td colSpan="6">해당 주차장에 주차 이용 내역이 없습니다.</td>
								</tr>
							)}
						</tbody>
					</Table>
				</div>
			)}

			{view === 'recordDetail' && recordDetail && (
				<div>
					<h1>주차 기록 관리</h1>
					<h3>상세 주차 기록 조회</h3>
					<div>주차 기록 코드: {recordDetail.records_code}</div>
					<div>차량 번호: {recordDetail.member_car_num}</div>
					<div>주차장 이름: {recordDetail.parking_name}</div>
					<div>입차 시간: {recordDetail.records_start}</div>
					<div>출차 시간: {recordDetail.records_end}</div>
					<Button variant="outline-secondary" onClick={() => setView('parkingRecords')}>
						주차 기록 목록
					</Button>
				</div>
			)}

		</div>
	);
};

export default RecordsAdmin;