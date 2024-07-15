
package parking.car.project.notice.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import parking.car.project.notice.entity.Notice;
import parking.car.project.notice.repository.NoticeRepository;
import jakarta.inject.Inject;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Optional;

@Service
public class NoticeService {

    @Inject
    private NoticeRepository noticeRepository;

    @Transactional
    public Notice saveNotice(Notice notice) {
        if (notice.getNotice_code() == 0) {
            notice.setNotice_code(generateUniqueNoticeCode());
        }
        if (notice.getNotice_date() == null) {
            notice.setNotice_date(getCurrentDateWithoutSeconds());
        }
        if (notice.getNotice_type() == null) {
            // 기본 타입을 설정하거나 예외를 던질 수 있습니다.
            notice.setNotice_type("공지사항"); // 기본 타입 설정 예제
        }
        return noticeRepository.save(notice);
    }

    @Transactional(readOnly = true)
    public List<Notice> findAllNotices() {
        return noticeRepository.findAll();
    }

    @Transactional(readOnly = true)
    public Page<Notice> findNoticesByType(String noticeType, Pageable pageable) {
        return noticeRepository.findByNoticeType(noticeType, pageable);
    }

    @Transactional(readOnly = true)
    public Page<Notice> searchNoticesByTitle(String noticeType, String title, Pageable pageable) {
        return noticeRepository.searchByTitle(noticeType, title, pageable);
    }

    @Transactional(readOnly = true)
    public Optional<Notice> findNoticeById(int notice_code) {
        return noticeRepository.findById(notice_code);
    }

    @Transactional
    public void deleteNotice(int notice_code) {
        noticeRepository.deleteById(notice_code);
    }
    
    @Transactional
    public void incrementNoticeView(int notice_code) {
        noticeRepository.incrementNoticeView(notice_code);
    }
    
    @Transactional
    public Notice updateNotice(int notice_code, Notice noticeDetails) {
        Notice notice = noticeRepository.findById(notice_code)
                .orElseThrow(() -> new RuntimeException("Notice not found"));
        notice.setNotice_title(noticeDetails.getNotice_title());
        notice.setNotice_content(noticeDetails.getNotice_content());
        notice.setNotice_date(noticeDetails.getNotice_date());
        notice.setNotice_type(noticeDetails.getNotice_type());
        notice.setNotice_view(noticeDetails.getNotice_view());
        return noticeRepository.save(notice);
    }

    private int generateUniqueNoticeCode() {
        Integer maxCode = noticeRepository.findMaxNoticeCode();
        return (maxCode != null ? maxCode : 0) + 1;
    }

    public Date convertStringToDate(String dateString) {
        if (dateString == null || dateString.isEmpty()) {
            return getCurrentDateWithoutSeconds();
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
        try {
            return sdf.parse(dateString);
        } catch (ParseException e) {
            throw new RuntimeException("Invalid date format", e);
        }
    }

    public Date getCurrentDateWithoutSeconds() {
        Calendar calendar = Calendar.getInstance();
        calendar.set(Calendar.SECOND, 0);
        calendar.set(Calendar.MILLISECOND, 0);
        return calendar.getTime();
    }
}



