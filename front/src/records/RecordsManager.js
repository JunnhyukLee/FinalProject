import React, { useState, useEffect } from 'react';
import axios from 'axios';
import { Button, Table, Form, Modal } from 'react-bootstrap';
import 'bootstrap/dist/css/bootstrap.min.css';

const RecordsManager = () => {
	const [view, setView] = useState('parkingList');
	const [records, setRecords] = useState([]);
	const [recordDetail, setRecordDetail] = useState(null);
	const [showModal, setShowModal] = useState(false);
	const [modalType, setModalType] = useState('');
	const [formData, setFormData] = useState({
		records_code: '',
		member_car_num: '',
		parking_code: '',
		parking_name: '',
		records_start: '',
		records_end: ''
	});
	const [selectedParking, setSelectedParking] = useState({ parking_code: '', parking_name: '' });
	const [imageFile, setImageFile] = useState(null);
	const member_code = window.memberCode; // JSP에서 설정한 memberCode 변수를 사용합니다.
	
	// CSRF 토큰을 가져오는 함수
	const getCsrfToken = () => {
		const csrfElement = document.querySelector('input[name="_csrf"]');
		return csrfElement ? csrfElement.value : '';
	};

	useEffect(() => {
		if (view === 'parkingList') {
			loadParkings(member_code);
		}
	}, [view]);

	const loadParkings = async (member_code) => {
		try {
			const response = await axios.get(`./recordsSelectParkingCode/${member_code}`, {
				withCredentials: true, // 쿠키 기반 인증 정보를 포함
				headers: {
					//'X-CSRF-TOKEN': getCsrfToken() // CSRF 토큰 추가
				}
			});
			console.log('Parking Data:', response.data); // 데이터 확인용 콘솔 로그
			setRecords(response.data);
		} catch (error) {
			console.error('Error loading parking data:', error); // 에러 확인용 콘솔 로그
			alert('주차 기록을 가져올 수 없습니다.');
		}
	};

	const loadRecords = async (parking_code) => {
		try {
			const response = await axios.get(`./recordsSelectParking/${parking_code}`, {
				withCredentials: true, // 쿠키 기반 인증 정보를 포함
				headers: {
					'X-CSRF-TOKEN': getCsrfToken() // CSRF 토큰 추가
				}
			});
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
			const response = await axios.get(`./recordsSelectDetailParking/${records_code}`, {
				withCredentials: true, // 쿠키 기반 인증 정보를 포함
				headers: {
					'X-CSRF-TOKEN': getCsrfToken() // CSRF 토큰 추가
				}
			});
			setRecordDetail(response.data);
			setView('recordDetail')
		} catch (error) {
			console.error('Error loading record detail:', error); // 에러 확인용 콘솔 로그
			alert('주차 기록 상세 정보를 가져올 수 없습니다.');
		}
	};

	const handleShowModal = (type, record = {}) => {
		const currentDate = new Date();
		const formattedDate = `${currentDate.getFullYear()}-${String(currentDate.getMonth() + 1).padStart(2, '0')}-${String(currentDate.getDate()).padStart(2, '0')} ${String(currentDate.getHours()).padStart(2, '0')}:${String(currentDate.getMinutes()).padStart(2, '0')}:${String(currentDate.getSeconds()).padStart(2, '0')}`;
		
		console.log("날짜" + formattedDate)

		setModalType(type);

		if (type === 'insert') {
			setFormData({
				records_code: '',
				member_car_num: '',
				parking_code: selectedParking.parking_code || '',
				parking_name: selectedParking.parking_name || '',
				records_start: formattedDate,
				records_end: ''
			});
		} else if (type === 'update') {
			setFormData({
				records_code: record.records_code || '',
				member_car_num: record.member_car_num || '',
				parking_code: record.parking_code || record.parking?.parking_code || '',
				parking_name: record.parking_name || record.parking?.parking_name || '',
				records_start: record.records_start || '',
				records_end: formattedDate
			});
		}

		setShowModal(true);
	};

	const handleCloseModal = () => {
		setShowModal(false);
		setFormData({
			records_code: '',
			member_car_num: '',
			parking_code: '',
			parking_name: '',
			records_start: '',
			records_end: ''
		});
		setImageFile(null);
	};

	const handleChange = (e) => {
		setFormData({ ...formData, [e.target.name]: e.target.value });
	};

	const handleImageUpload = (e) => {
		setImageFile(e.target.files[0]);
	};

	const handleSubmit = async (e) => {
		e.preventDefault();
		try {
			if (modalType === 'insert') {
				await axios.post('./recordsInsert', formData, {
					withCredentials: true, // 쿠키 기반 인증 정보를 포함
					headers: {
						'Content-Type': 'application/json',
						'X-CSRF-TOKEN': getCsrfToken() // CSRF 토큰 추가
					}
				});
				alert('주차 기록이 등록되었습니다.');
			} else if (modalType === 'update') {
				const response = await axios.put('./recordsUpdate', formData, {
					withCredentials: true, // 쿠키 기반 인증 정보를 포함
					headers: {
						'Content-Type': 'application/json',
						'X-CSRF-TOKEN': getCsrfToken() // CSRF 토큰 추가
					}
				});
				
				alert('주차 기록이 수정되었습니다.');
				
				const calculateRedirect = response.data.calculateRedirect;
				if (calculateRedirect) {
					window.location.href = calculateRedirect;
					//return;
				}
			}
			handleCloseModal();

			// 데이터 다시 불러오기
			if (view === 'parkingRecords') {
				await loadRecords(formData.parking_code);
				setView('parkingRecords');  // 데이터를 다시 불러온 후 view를 업데이트
			} else if (modalType === 'update') {
				await loadRecordDetail(formData.records_code);
				await loadRecords(formData.parking_code);
				setView('recordDetail');  // 데이터를 다시 불러온 후 view를 업데이트
			} else {
				loadParkings(member_code);
			}

		} catch (error) {
			console.error('Error during submission:', error.response ? error.response.data : error.message);
			alert('작업을 완료할 수 없습니다.');
		}
	};

	const carNumCheck = async () => {
		if (!imageFile) {
			alert('이미지를 업로드하세요.');
			return;
		}
		try {
			const formData = new FormData();
			formData.append('image', imageFile);

			const response = await axios.post('http://localhost:3001/carNumCheck', formData, {
				headers: {
					'Content-Type': 'multipart/form-data',
				},
			});

			if (response.data.licensePlate) {
				setFormData((prevFormData) => ({
					...prevFormData,
					member_car_num: response.data.licensePlate,
				}));
			} else {
				alert('차량 번호를 인식하지 못했습니다.');
			}
		} catch (error) {
			console.error('번호판 인식 중 오류 발생:', error);
			alert('번호판 인식 중 오류가 발생했습니다.');
			if (error.response) {
				console.error('에러 응답 데이터:', error.response.data);
			}
		}
	};

	return (
		<div className="container p-3 my-3 border">

			{view === 'parkingList' && (
				<div>
					<h1>주차 기록 관리</h1>
					<Button variant="outline-secondary" onClick={() => window.location.href = './Menu'}>
						메뉴
					</Button>
					<h3>주차장 코드 번호 조회</h3>
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
							{records.length ? (
								records.map((parking) => (
									<tr key={parking.parking_code}>
										<td>{parking.member?.member_code}</td>
										<td>{parking.parking_code}</td>
										<td>{parking.parking_name}</td>
										<td>
											<Button
												variant="outline-info"
												onClick={() => {
													setSelectedParking({ parking_code: parking.parking_code, parking_name: parking.parking_name });
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
					<Button variant="outline-secondary" onClick={() => setView('parkingList')}>
						주차장 목록
					</Button>

					<Button
						variant="outline-secondary"
						onClick={() => {
							const defaultParking = records.length > 0 ? records[0].parking : { parking_code: '', parking_name: '' };
							handleShowModal('insert', {
								parking_code: defaultParking.parking_code,
								parking_name: defaultParking.parking_name
							});
						}}>
						주차 기록 등록
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
					<Button variant="outline-secondary" onClick={() => handleShowModal('update', recordDetail)}>
						주차 기록 수정
					</Button>
				</div>
			)}

			<Modal show={showModal} onHide={handleCloseModal}>
				<Modal.Header closeButton>
					<Modal.Title>{modalType === 'insert' ? '주차 기록 등록' : '주차 기록 수정'}</Modal.Title>
				</Modal.Header>
				<Modal.Body>
					<Form onSubmit={handleSubmit}>
						<Form.Group>
							<Form.Label>주차장 코드</Form.Label>
							<Form.Control
								type="text"
								name="parking_code"
								value={formData.parking_code}
								readOnly
							/>
						</Form.Group>
						<Form.Group>
							<Form.Label>주차장 이름</Form.Label>
							<Form.Control
								type="text"
								name="parking_name"
								value={formData.parking_name}
								readOnly
							/>
						</Form.Group>
						<Form.Group>
							<Form.Label>차량 번호</Form.Label>
							<Form.Control
								type="text"
								name="member_car_num"
								value={formData.member_car_num}
								onChange={handleChange}
								required
								readOnly
							/>
						</Form.Group>
						
						{modalType === 'insert' && (
							<>
								<Form.Group>
									<Form.Label>차량 번호판 업로드</Form.Label>
									<Form.Control
										type="file"
										onChange={handleImageUpload}
									/>
								</Form.Group>
								<Button variant="primary" onClick={carNumCheck}>
									차량 번호판 확인
								</Button>
							</>
						)}
						
						<Form.Group>
							<Form.Label>입차 시간</Form.Label>
							<Form.Control
								type="text"
								name="records_start"
								value={formData.records_start}
								onChange={handleChange}
								readOnly
							/>
						</Form.Group>

						{modalType === 'update' && (
							<>
								<Form.Group>
									<Form.Label>출차 시간</Form.Label>
									<Form.Control
										type="text"
										name="records_end"
										value={formData.records_end}
										onChange={handleChange}
										readOnly
									/>
								</Form.Group>
							</>
						)}
						
						<Button variant="primary" type="submit">
							{modalType === 'insert' ? '등록' : '수정'}
						</Button>
					</Form>
				</Modal.Body>
			</Modal>

		</div>
	);
};

export default RecordsManager;