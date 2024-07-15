package parking.car.project.notice.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import parking.car.project.notice.entity.Notice;

public interface NoticeRepository extends JpaRepository<Notice, Integer> {

    @Query("SELECT n FROM Notice n WHERE n.notice_type = :noticeType ORDER BY n.notice_code ASC")
    Page<Notice> findByNoticeType(@Param("noticeType") String noticeType, Pageable pageable);

    @Query("SELECT n FROM Notice n WHERE n.notice_type = :noticeType AND n.notice_title LIKE %:title%")
    Page<Notice> searchByTitle(@Param("noticeType") String noticeType, @Param("title") String title, Pageable pageable);

    @Query("SELECT MAX(n.notice_code) FROM Notice n")
    Integer findMaxNoticeCode();
    
    @Modifying
    @Transactional
    @Query("UPDATE Notice n SET n.notice_view = n.notice_view + 1 WHERE n.notice_code = :notice_code")
    void incrementNoticeView(@Param("notice_code") int notice_code);
}
