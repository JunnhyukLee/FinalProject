package parking.car.project.faq.service;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import parking.car.project.faq.entity.Faq;
import parking.car.project.faq.repository.FaqRepository;
import jakarta.inject.Inject;
import java.util.Optional;

@Service
public class FaqService {

    @Inject
    private FaqRepository faqRepository;

    @Transactional
    public Faq saveFaq(Faq faq) {
        if (faq.getFaq_code() == 0) {
            int maxFaqCode = faqRepository.findMaxFaqCode();
            faq.setFaq_code(maxFaqCode + 1);
            faq.setFaq_answer_code(maxFaqCode + 1);
        } else {
            // Updating an existing FAQ, ensure faq_answer_code is not set to 0
            Optional<Faq> existingFaq = faqRepository.findById(faq.getFaq_code());
            if (existingFaq.isPresent()) {
                faq.setFaq_answer_code(existingFaq.get().getFaq_answer_code());
                if (faq.getMember_name() == null) {
                    faq.setMember_name(existingFaq.get().getMember_name());
                }
                if (faq.getMember_code() == 0) {
                    faq.setMember_code(existingFaq.get().getMember_code());
                }
            }
        }
        return faqRepository.save(faq);
    }

    @Transactional(readOnly = true)
    public Page<Faq> findAllFaqs(Pageable pageable) {
        return faqRepository.findFaqAll(pageable);
    }

    @Transactional(readOnly = true)
    public Optional<Faq> findFaqById(int faq_code) {
        return faqRepository.findById(faq_code);
    }
    
    @Transactional
    public void incrementFaqView(int faq_code) {
        faqRepository.incrementFaqView(faq_code);
    }

    @Transactional
    public void deleteFaq(int faq_code) {
        faqRepository.deleteById(faq_code);
    }

    @Transactional
    public Faq updateFaq(int faq_code, Faq faqDetails) {
        Faq faq = faqRepository.findById(faq_code)
                .orElseThrow(() -> new RuntimeException("FAQ not found"));
        faq.setFaq_title(faqDetails.getFaq_title());
        faq.setFaq_question(faqDetails.getFaq_question());
        faq.setFaq_answer(faqDetails.getFaq_answer());
        faq.setFaq_question_date(faqDetails.getFaq_question_date());
        faq.setFaq_answer_date(faqDetails.getFaq_answer_date());
        return faqRepository.save(faq);
    }

    @Transactional(readOnly = true)
    public Page<Faq> searchFaqsByTitleOrMemberName(String faq_title, String member_name, Pageable pageable) {
        return faqRepository.searchByTitleOrMemberName(faq_title, member_name, pageable);
    }

}