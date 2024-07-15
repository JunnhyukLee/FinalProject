package parking.car.project.faq.controller;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import parking.car.project.faq.dto.FaqDTO;
import parking.car.project.faq.entity.Faq;
import parking.car.project.faq.service.FaqService;
import parking.car.project.member.service.CustomMemberDetails;

import java.util.Date;
import java.util.Optional;

@Controller
@RequiredArgsConstructor
public class FaqController {

    private static final Logger logger = LogManager.getLogger(FaqController.class);

    @Inject
    private final FaqService faqService;

    @GetMapping("/FaqSelect")
    public String list(Model model,
                       @RequestParam(value = "page", defaultValue = "0") int page,
                       @RequestParam(value = "size", defaultValue = "10") int size) {
        Pageable pageable = PageRequest.of(page, size);
        Page<Faq> faqPage = faqService.findAllFaqs(pageable);
        model.addAttribute("faqPage", faqPage);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", faqPage.getTotalPages());
        logger.info("list", model);
        return "faq/faq_select_view";
    }
    
    @GetMapping("/FaqSearch")
    public String search(@RequestParam(value = "searchFilter") String searchFilter,
                         @RequestParam(value = "searchQuery") String searchQuery,
                         @RequestParam(value = "page", defaultValue = "0") int page,
                         @RequestParam(value = "size", defaultValue = "10") int size,
                         Model model) {
        logger.info("Search filter: {}, Search query: {}", searchFilter, searchQuery);

        String faqTitleQuery = "faq_title".equals(searchFilter) ? searchQuery : "";
        String memberNameQuery = "member_name".equals(searchFilter) ? searchQuery : "";
        
        Pageable pageable = PageRequest.of(page, size);
        Page<Faq> searchResults = faqService.searchFaqsByTitleOrMemberName(faqTitleQuery, memberNameQuery, pageable);
        model.addAttribute("faqPage", searchResults);
        model.addAttribute("searchFilter", searchFilter);
        model.addAttribute("searchQuery", searchQuery);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", searchResults.getTotalPages());
        
        logger.info("Search results: {}", searchResults);
        
        return "faq/faq_select_view";
    }
    
    @GetMapping("/FaqSelectDetail")
    public String detail(Model model, HttpServletRequest request, @RequestParam("faq_code") Integer faq_code) {
       
       CustomMemberDetails customMemberDetails = (CustomMemberDetails) request.getSession().getAttribute("customMemberDetails");
       
        if (customMemberDetails != null) {
            String member_rating = customMemberDetails.getMemberRating(); // customMemberDetails에서 memberRating 가져오기
            Integer member_code = customMemberDetails.getMemberCode(); // customMemberDetails에서 memberCode 가져오기
            model.addAttribute("member_rating", member_rating);
            model.addAttribute("member_code", member_code);
        } else {
            // 세션에 customMemberDetails가 없는 경우 처리
            return "redirect:/login"; // 예를 들어 로그인 페이지로 리다이렉트
        }

        faqService.incrementFaqView(faq_code); 
        Optional<Faq> faq = faqService.findFaqById(faq_code);
        faq.ifPresent(value -> model.addAttribute("faqDTO", value));
        return "faq/faq_select_detail_view";
       
    } //게시판 상세 조회 컨트롤러 

    @GetMapping("/FaqInsert")
    public String insertForm() {
        return "faq/faq_insert";
    }
    
    @PostMapping("/FaqInsert")
    public String insert(HttpServletRequest request, FaqDTO faqDTO) {
       
       CustomMemberDetails customMemberDetails = (CustomMemberDetails) request.getSession().getAttribute("customMemberDetails");
       
        if (customMemberDetails != null) {
            Integer member_code = customMemberDetails.getMemberCode(); // customMemberDetails에서 memberCode 가져오기
            String member_name = customMemberDetails.getMemberName(); // customMemberDetails에서 memberName 가져오기
            Faq faq = new Faq();
            faq.setFaq_title(faqDTO.getFaq_title());
            faq.setFaq_question(faqDTO.getFaq_question());
            faq.setFaq_question_date(new Date());
            faq.setMember_name(member_name); 
            faq.setMember_code(member_code);
            faqService.saveFaq(faq);
            return "faq/faq_insert_view";
        } else {
            // 세션에 customMemberDetails가 없는 경우 처리
            return "redirect:/login"; // 예를 들어 로그인 페이지로 리다이렉트
        }
       
    } //게시글 작성 컨트롤러 코드

    @GetMapping("/FaqUpdate")
    public String updateForm(Model model, @RequestParam("faq_code") Integer faq_code) {
        Optional<Faq> faq = faqService.findFaqById(faq_code);
        faq.ifPresent(value -> model.addAttribute("faqDTO", value));
        return "faq/faq_update";
    }
    
    @PostMapping("/FaqUpdate")
    public String update(HttpServletRequest request, FaqDTO faqDTO) {
       
        CustomMemberDetails customMemberDetails = (CustomMemberDetails) request.getSession().getAttribute("customMemberDetails");
        
           if (customMemberDetails != null) {
               Integer member_code = customMemberDetails.getMemberCode(); // customMemberDetails에서 memberCode 가져오기
               String member_name = customMemberDetails.getUsername(); // customMemberDetails에서 memberName 가져오기
               Optional<Faq> faqOptional = faqService.findFaqById(faqDTO.getFaq_code());
               if (faqOptional.isPresent()) {
                   Faq faq = faqOptional.get();
                   faq.setFaq_title(faqDTO.getFaq_title());
                   faq.setFaq_question(faqDTO.getFaq_question());
                   faq.setFaq_question_date(new Date());
                   if (member_name != null) {
                       faq.setMember_name(member_name);
                   }
                   if (member_code != null) {
                       faq.setMember_code(member_code);
                   }
                   faqService.saveFaq(faq);
               }
               return "faq/faq_update_view";
           } else {
               // 세션에 customMemberDetails가 없는 경우 처리
               return "redirect:/login"; // 예를 들어 로그인 페이지로 리다이렉트
           }
       
    } //게시글 수정 컨트롤러 코드

    @PostMapping("/FaqDelete")
    @ResponseBody
    public ResponseEntity<String> delete(@RequestParam("faq_code") Integer faq_code) {
        logger.info("Deleting FAQ with code: {}", faq_code);
        try {
            faqService.deleteFaq(faq_code);
            return ResponseEntity.ok("삭제 성공");
        } catch (Exception e) {
            logger.error("Error deleting FAQ", e);
            return ResponseEntity.status(500).body("삭제 실패");
        }
    }
    
    
    @GetMapping("/FaqAnswerUpdate")
    public String updateAnswerForm(Model model, @RequestParam("faq_code") Integer faq_code) {
        Optional<Faq> faqOptional = faqService.findFaqById(faq_code);
        faqOptional.ifPresent(faq -> model.addAttribute("faqDTO", faq));
        return "faq/faq_answer_update";
    }

    @PostMapping("/FaqAnswerUpdate")
    public String updateAnswer(FaqDTO faqDTO) {
        Optional<Faq> faqOptional = faqService.findFaqById(faqDTO.getFaq_code());
        if (faqOptional.isPresent()) {
            Faq faq = faqOptional.get();
            faq.setFaq_answer(faqDTO.getFaq_answer());
            faq.setFaq_answer_date(new Date());
            faqService.saveFaq(faq);
        }
        return "faq/faq_answer_update_view";
        //return "redirect:/FaqSelectDetail?faq_code=" + faqDTO.getFaq_code();
    }

    @PostMapping("/FaqAnswerDelete")
    public String deleteAnswer(@RequestParam("faq_code") int faq_code) {
        Optional<Faq> faqOptional = faqService.findFaqById(faq_code);
        if (faqOptional.isPresent()) {
            Faq faq = faqOptional.get();
            faq.setFaq_answer(null);
            faq.setFaq_answer_date(null);
            faqService.saveFaq(faq);
        }
        return "faq/faq_answer_delete_view";
        //return "redirect:/FaqSelectDetail?faq_code=" + faq_code;
    }
} 