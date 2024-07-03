package parking.car.project.faqcontroller;

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
import parking.car.project.faqdto.FaqDTO;
import parking.car.project.faqentity.Faq;
import parking.car.project.faqservice.FaqService;

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
        return "./faq/faq_select_view";
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
        
        return "./faq/faq_select_view";
    }


    @GetMapping("/FaqSelectDetail")
    public String detail(Model model, HttpServletRequest request, @RequestParam("faq_code") Integer faq_code) {
    	String member_rating = "user";
    	int member_code=3;
    	//String member_rating = (String) request.getSession().getAttribute("member_rating");
        //Integer member_code = (Integer) request.getSession().getAttribute("member_code");
        model.addAttribute("member_rating", member_rating);
        model.addAttribute("member_code", member_code);
    	faqService.incrementFaqView(faq_code); 
        Optional<Faq> faq = faqService.findFaqById(faq_code);
        faq.ifPresent(value -> model.addAttribute("faqDTO", value));
        return "./faq/faq_select_detail_view";
    }

    @GetMapping("/FaqInsert")
    public String insertForm() {
        return "./faq/faq_insert";
    }

    @PostMapping("/FaqInsert")
    public String insert(HttpServletRequest request, FaqDTO faqDTO) {
    	int member_code=3;
    	String member_name="이주훈";
    	//Integer member_code = (Integer) request.getSession().getAttribute("member_code");
    	//String member_name = (String) request.getSession().getAttribute("member_name");
        Faq faq = new Faq();
        faq.setFaq_title(faqDTO.getFaq_title());
        faq.setFaq_question(faqDTO.getFaq_question());
        faq.setFaq_question_date(new Date());
        faq.setMember_name(member_name); 
        faq.setMember_code(member_code);
        faqService.saveFaq(faq);
        return "./faq/faq_insert_view";
    }

    @GetMapping("/FaqUpdate")
    public String updateForm(Model model, @RequestParam("faq_code") Integer faq_code) {
        Optional<Faq> faq = faqService.findFaqById(faq_code);
        faq.ifPresent(value -> model.addAttribute("faqDTO", value));
        return "./faq/faq_update";
    }

    @PostMapping("/FaqUpdate")
    public String update(HttpServletRequest request, FaqDTO faqDTO) {
    	Integer member_code=3;
    	String member_name="이주훈";
    	//Integer member_code = (Integer) request.getSession().getAttribute("member_code");
    	//String member_name = (String) request.getSession().getAttribute("member_name");
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
        return "./faq/faq_update_view";
    }

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
        return "./faq/faq_answer_update";
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
        return "./faq/faq_answer_update_view";
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
        return "./faq/faq_answer_delete_view";
        //return "redirect:/FaqSelectDetail?faq_code=" + faq_code;
    }
} 


