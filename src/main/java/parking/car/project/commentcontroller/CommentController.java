package parking.car.project.commentcontroller;


import java.util.Date;
import java.util.List;
import java.util.Optional;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jakarta.inject.Inject;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import parking.car.project.commentdto.CommentDTO;
import parking.car.project.commententity.Comment;
import parking.car.project.commentservice.CommentService;

@Controller
@RequiredArgsConstructor
public class CommentController {

    private static final Logger logger = LogManager.getLogger(CommentController.class);

    @Inject
    private final CommentService commentService;

	
	  /*@GetMapping("/CommentSelect") public String list(Model model) { int
	  parking_code = 3; // Example value, replace with actual logic 
	  List<Comment>
	  comments = commentService.findAllComments(parking_code);
	  model.addAttribute("list", comments); logger.info("list", model); return
	  "./comment/comment_select_view"; }*/
	 
    
    @GetMapping("/CommentSelectMember")
   // public String getCommentsByMember(@RequestParam("member_code") int member_code, Model model) 
    public String memberlist(Model model){
    	int member_code=3;
    	logger.info("Fetching comments for member_code: {}", member_code);
        List<Comment> comments = commentService.findCommentsByMemberCode(member_code);
        model.addAttribute("list", comments);
        model.addAttribute("member_code", member_code); 
        return "./comment/comment_member_view";
    }
    
    @GetMapping("/CommentSelectParking")
   // public String getCommentsByParking(@RequestParam("parking_code") int parking_code, Model model) 
    public String parkinglist(Model model){
    	int parking_code=3;
        logger.info("Fetching comments for parking_code: {}", parking_code);
        List<Comment> comments = commentService.findCommentsByParkingCode(parking_code);
        logger.info("Comments found: {}", comments);
        model.addAttribute("list", comments);
        model.addAttribute("parking_code", parking_code); // JSP에서 사용하기 위해 추가
        return "./comment/comment_parking_view";
    }
    
    @GetMapping("/CommentSelectDetail")
    public String detail(Model model, @RequestParam("comment_code") Integer comment_code) {
        Optional<Comment> comment = commentService.findCommentById(comment_code);
        comment.ifPresent(value -> model.addAttribute("commentDTO", value));
        return "./comment/comment_select_detail_view";
    }
    
//    @GetMapping("/CommentInsert")
//    public String insertForm(Model model, @RequestParam("parking_code") Integer parking_code) {
//    	model.addAttribute("parking_code", parking_code);
//        return "./comment/comment_insert";
//    }

    @PostMapping("/CommentInsert")
//    public String insert(HttpServletRequest request, CommentDTO commentDTO, @RequestParam("parking_code") Integer parking_code) {
//        Integer member_code = (Integer) request.getSession().getAttribute("member_code");
    public String insert(HttpServletRequest request, CommentDTO commentDTO) {
        Integer member_code = 3; 
        Integer parking_code = 3;  
        Comment comment = new Comment();
        comment.setComment_content(commentDTO.getComment_content());
        comment.setComment_date(new Date());
        comment.setParking_code(parking_code);
        comment.setMember_code(member_code);
        commentService.saveComment(comment);
        return "./comment/comment_insert_view";
    }
    
    @GetMapping("/CommentInsert")
    public String insertForm() {
        return "./comment/comment_insert";
    }
//
//    @PostMapping("/CommentInsert")
//    public String insert(Model model, CommentDTO commentDTO) {
//        Comment comment = new Comment();
//        comment.setComment_content(commentDTO.getComment_content());
//        comment.setComment_date(new Date());
//        comment.setParking_code(commentDTO.getParking_code());
//        comment.setMember_code(commentDTO.getMember_code());
//        commentService.saveComment(comment);
//
//        return "./comment/comment_insert_view";
//    }

    @GetMapping("/CommentUpdate")
    public String updateForm(Model model, @RequestParam("comment_code") Integer comment_code) {
        Optional<Comment> comment = commentService.findCommentById(comment_code);
        comment.ifPresent(value -> model.addAttribute("commentDTO", value));
        return "./comment/comment_update";
    }

    @PostMapping("/CommentUpdate")
    public String update(HttpServletRequest request, CommentDTO commentDTO) {
    	//Integer member_code = (Integer) request.getSession().getAttribute("member_code");
        int member_code=3;
    	Comment comment = new Comment();
        comment.setComment_code(commentDTO.getComment_code());
        comment.setComment_content(commentDTO.getComment_content());
        comment.setComment_date(new Date());
        comment.setParking_code(commentDTO.getParking_code());
        comment.setMember_code(member_code);
        commentService.saveComment(comment);
        return "./comment/comment_update_view";
    }

    @GetMapping("/CommentDelete")
    public String deleteForm() {
        return "./comment/comment_delete";
    }

    @PostMapping("/CommentDelete")
    @ResponseBody
    public ResponseEntity<String> delete(@RequestParam("comment_code") Integer comment_code) {
        logger.info("Deleting comment with code: {}", comment_code);
        try {
            commentService.deleteComment(comment_code);
            return new ResponseEntity<>("삭제 성공", HttpStatus.OK);
        } catch (Exception e) {
            logger.error("Error deleting comment", e);
            return new ResponseEntity<>("삭제 실패", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}