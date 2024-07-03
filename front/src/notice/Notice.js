import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Notice = () => {
    const [notices, setNotices] = useState([]);
    const [searchQuery, setSearchQuery] = useState('');
    const [currentPage, setCurrentPage] = useState(0);
    const [totalPages, setTotalPages] = useState(0);

    useEffect(() => {
        fetchNotices();
    }, [currentPage]);

    const fetchNotices = async () => {
        try {
            const response = await axios.get(`NoticeSelect`);
            setNotices(response.data.content);
            setTotalPages(response.data.totalPages);
        } catch (error) {
            console.error('공지사항을 가져오는 중 오류 발생:', error);
        }
    };

    const handleSearchChange = (event) => {
        setSearchQuery(event.target.value);
    };

    const handleSearchSubmit = (event) => {
        event.preventDefault();
        setCurrentPage(0); // 새로운 검색 시 첫 페이지로 리셋
        fetchNotices();
    };

    const handlePageChange = (newPage) => {
        setCurrentPage(newPage);
    };

    return (
        <div className="container">
            <h1 className="custom-header">공지사항 목록</h1>
            <form onSubmit={handleSearchSubmit} className="form-inline my-2 my-lg-0">
                <div className="input-group">
                    <input
                        className="form-control mr-sm-2"
                        type="search"
                        placeholder="제목 검색"
                        aria-label="Search"
                        value={searchQuery}
                        onChange={handleSearchChange}
                    />
                    <div className="input-group-append">
                        <button className="btn btn-outline-primary my-2 my-sm-0" type="submit">
                            검색
                        </button>
                    </div>
                </div>
            </form>
            <table className="table table-hover">
                <thead className="thead-light">
                    <tr className="text-center">
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성 날짜</th>
                        <th>조회수</th>
                    </tr>
                </thead>
                <tbody>
                    {notices.map(notice => (
                        <tr className="text-center" key={notice.notice_code}>
                            <td>{notice.notice_code}</td>
                            <td>
                                <a href={`./NoticeSelectDetail?notice_code=${notice.notice_code}`}>
                                    {notice.notice_title}
                                </a>
                            </td>
                            <td>{new Date(notice.notice_date).toLocaleDateString()}</td>
                            <td>{notice.notice_view}</td>
                        </tr>
                    ))}
                </tbody>
            </table>
            {notices.length > 0 && (
                <nav aria-label="페이지 네비게이션 예제">
                    <ul className="pagination justify-content-center">
                        <li className={`page-item ${currentPage === 0 ? 'disabled' : ''}`}>
                            <button className="page-link" onClick={() => handlePageChange(0)}>&laquo;</button>
                        </li>
                        {[...Array(totalPages).keys()].map(page => (
                            <li key={page} className={`page-item ${currentPage === page ? 'active' : ''}`}>
                                <button className="page-link" onClick={() => handlePageChange(page)}>{page + 1}</button>
                            </li>
                        ))}
                        <li className={`page-item ${currentPage === totalPages - 1 ? 'disabled' : ''}`}>
                            <button className="page-link" onClick={() => handlePageChange(totalPages - 1)}>&raquo;</button>
                        </li>
                    </ul>
                </nav>
            )}
        </div>
    );
};

export default Notice;

