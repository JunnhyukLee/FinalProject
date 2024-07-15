package parking.car.project.faq.dto;

import lombok.Data;

@Data
public class FaqDTO {
    private int faq_code;
    private int faq_answer_code;
    private String faq_title;
    private String faq_question;
    private String faq_answer;
    private String faq_question_date;
    private String faq_answer_date;
    private String member_name;
    private int faq_view=0;
    private int member_code;
}