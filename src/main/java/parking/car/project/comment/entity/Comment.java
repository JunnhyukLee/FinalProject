package parking.car.project.comment.entity;

import java.util.Date;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "COMMENTS")
public class Comment {
    @Id
    private int comment_code;
    private String comment_content;
    private Date comment_date;
    private int parking_code;
    private int member_code;
}