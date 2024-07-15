package parking.car.project.comment.dto;

import lombok.Data;

@Data
public class CommentDTO {
    private int comment_code;
    private String comment_content;
    private String comment_date;
    private int parking_code;
    private int member_code;
}