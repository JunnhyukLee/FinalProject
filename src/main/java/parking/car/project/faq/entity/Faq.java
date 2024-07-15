package parking.car.project.faq.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
public class Faq {
    @Id
    private int faq_code;
    private int faq_answer_code;
    private String faq_title;
    private String faq_question;
    private String faq_answer;
    private Date faq_question_date;
    private Date faq_answer_date;
    private String member_name;
    private int faq_view=0;
    private int member_code;
}