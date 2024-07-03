package parking.car.project.commentdto;

import lombok.Data;

@Data
public class CommentDTO {
    private int comment_code;
    private String comment_content;
    private String comment_date;
    private int parking_code = 3;
    private int member_code = 3;
}