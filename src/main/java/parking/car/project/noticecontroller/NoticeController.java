package parking.car.project.noticecontroller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import parking.car.project.noticedto.NoticeDTO;
import parking.car.project.noticeentity.Notice;
import parking.car.project.noticeservice.NoticeService;
import lombok.RequiredArgsConstructor;

import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class NoticeController {

    private static final Logger logger = LogManager.getLogger(NoticeController.class);

    @Inject
    private final NoticeService noticeService;

    @GetMapping("/NoticeSelect")
    public String list(Model model, HttpServletRequest request,
                      @RequestParam(value = "page", defaultValue = "0") int page,
                      @RequestParam(value = "size", defaultValue = "10") int size,
                      @RequestParam(value = "searchQuery", required = false) String searchQuery) {
    	String member_rating = "admin";
    	//String memberRating = (String) request.getSession().getAttribute("member_rating");
        model.addAttribute("member_rating", member_rating);
    	Pageable pageable = PageRequest.of(page, size);
        Page<Notice> noticePage;

        if (searchQuery == null || searchQuery.isEmpty()) {
           noticePage = noticeService.findNoticesByType("공지사항", pageable);
        } else {
            noticePage = noticeService.searchNoticesByTitle("공지사항", searchQuery, pageable);
        }

        model.addAttribute("noticePage", noticePage);
        model.addAttribute("currentPage", page);
        model.addAttribute("searchQuery", searchQuery);
        logger.info("list", model);
        return "./notice/notice_select_view";
    }
    
    @GetMapping("/NoticeSelectEvent")
    public String listEvents(Model model, HttpServletRequest request,
                             @RequestParam(value = "page", defaultValue = "0") int page,
                             @RequestParam(value = "size", defaultValue = "10") int size,
                             @RequestParam(value = "searchQuery", required = false) String searchQuery) {
    	String member_rating = "admin";
    	//String memberRating = (String) request.getSession().getAttribute("member_rating");
        model.addAttribute("member_rating", member_rating);
    	Pageable pageable = PageRequest.of(page, size);
        Page<Notice> noticePage;

        if (searchQuery == null || searchQuery.isEmpty()) {
            noticePage = noticeService.findNoticesByType("이벤트", pageable);
        } else {
            noticePage = noticeService.searchNoticesByTitle("이벤트", searchQuery, pageable);
        }

        model.addAttribute("noticePage", noticePage);
        model.addAttribute("currentPage", page);
        model.addAttribute("searchQuery", searchQuery);
        logger.info("list", model);
        return "./notice/notice_select_event_view";
    }

    @GetMapping("/NoticeSelectDetail")
    public String detail(Model model, HttpServletRequest request, @RequestParam("notice_code") Integer notice_code) {
    	noticeService.incrementNoticeView(notice_code);
        Optional<Notice> notice = noticeService.findNoticeById(notice_code);
        notice.ifPresent(value -> model.addAttribute("noticeDTO", value));
        String member_rating = "admin";
    	//String memberRating = (String) request.getSession().getAttribute("member_rating");
        model.addAttribute("member_rating", member_rating);
        return "./notice/notice_select_detail_view";
    }

    @GetMapping("/NoticeSelectEventDetail")
    public String detailEvent(Model model, HttpServletRequest request, @RequestParam("notice_code") Integer notice_code) {
    	noticeService.incrementNoticeView(notice_code);
        Optional<Notice> notice = noticeService.findNoticeById(notice_code);
        notice.ifPresent(value -> model.addAttribute("noticeDTO", value));
        String member_rating = "admin";
    	//String memberRating = (String) request.getSession().getAttribute("member_rating");
        model.addAttribute("member_rating", member_rating);
        return "./notice/notice_select_event_detail_view";
    }

    @GetMapping("/NoticeInsert")
    public String insertForm() {
        return "./notice/notice_insert";
    }

    @PostMapping("/NoticeInsert")
    public String insert(Model model, NoticeDTO noticeDTO, RedirectAttributes redirectAttributes) {
        Notice notice = new Notice();
        notice.setNotice_code(noticeDTO.getNotice_code());
        notice.setNotice_title(noticeDTO.getNotice_title());
        notice.setNotice_content(noticeDTO.getNotice_content());
        notice.setNotice_date(noticeService.convertStringToDate(noticeDTO.getNotice_date()));
        notice.setNotice_type(noticeDTO.getNotice_type());
        noticeService.saveNotice(notice);

        redirectAttributes.addFlashAttribute("message", "입력하신 글을 등록하였습니다.");

        if ("공지사항".equals(notice.getNotice_type())) {
            return "redirect:/NoticeSelect";
        } else {
            return "redirect:/NoticeSelectEvent";
        }
    }

    @GetMapping("/NoticeUpdate")
    public String updateForm(Model model, @RequestParam("notice_code") Integer notice_code) {
        Optional<Notice> notice = noticeService.findNoticeById(notice_code);
        notice.ifPresent(value -> model.addAttribute("noticeDTO", value));
        return "./notice/notice_update";
    }

    @PostMapping("/NoticeUpdate")
    public String update(NoticeDTO noticeDTO) {
        Notice notice = new Notice();
        notice.setNotice_code(noticeDTO.getNotice_code());
        notice.setNotice_title(noticeDTO.getNotice_title());
        notice.setNotice_content(noticeDTO.getNotice_content());
        notice.setNotice_date(noticeService.convertStringToDate(noticeDTO.getNotice_date()));
        notice.setNotice_type(noticeDTO.getNotice_type());
        Optional<Notice> existingNoticeOpt = noticeService.findNoticeById(noticeDTO.getNotice_code());
        if (existingNoticeOpt.isPresent()) {
            notice.setNotice_view(existingNoticeOpt.get().getNotice_view());
        }
        noticeService.saveNotice(notice);
        return "./notice/notice_update_view";
    }

    @GetMapping("/NoticeUpdateEvent")
    public String updateEventForm(Model model, @RequestParam("notice_code") Integer notice_code) {
        Optional<Notice> notice = noticeService.findNoticeById(notice_code);
        notice.ifPresent(value -> model.addAttribute("noticeDTO", value));
        return "./notice/notice_update_event";
    }

    @PostMapping("/NoticeUpdateEvent")
    public String updateEvent(NoticeDTO noticeDTO) {
        Notice notice = new Notice();
        notice.setNotice_code(noticeDTO.getNotice_code());
        notice.setNotice_title(noticeDTO.getNotice_title());
        notice.setNotice_content(noticeDTO.getNotice_content());
        notice.setNotice_date(noticeService.convertStringToDate(noticeDTO.getNotice_date()));
        notice.setNotice_type(noticeDTO.getNotice_type());
        Optional<Notice> existingNoticeOpt = noticeService.findNoticeById(noticeDTO.getNotice_code());
        if (existingNoticeOpt.isPresent()) {
            notice.setNotice_view(existingNoticeOpt.get().getNotice_view());
        }
        noticeService.saveNotice(notice);
        return "./notice/notice_update_event_view";
    }

    @GetMapping("/NoticeDelete")
    public String deleteForm() {
        return "./notice/notice_delete";
    }

    @PostMapping("/NoticeDelete")
    @ResponseBody
    public ResponseEntity<String> delete(@RequestParam("notice_code") Integer notice_code) {
        logger.info("Deleting notice with code: {}", notice_code);
        try {
            noticeService.deleteNotice(notice_code);
            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error deleting notice", e);
            return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }


    @GetMapping("/NoticeDeleteEvent")
    public String deleteEventForm() {
        return "./notice/notice_delete";
    }

    @PostMapping("/NoticeDeleteEvent")
    public String deleteEvent(@RequestParam("notice_code") Integer notice_code) {
        noticeService.deleteNotice(notice_code);
        return "./notice/notice_delete_view";
    }
}
