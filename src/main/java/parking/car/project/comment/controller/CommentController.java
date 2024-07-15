package parking.car.project.comment.controller;

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
import parking.car.project.comment.dto.CommentDTO;
import parking.car.project.comment.entity.Comment;
import parking.car.project.comment.service.CommentService;
import parking.car.project.member.service.CustomMemberDetails;

@Controller
@RequiredArgsConstructor
public class CommentController {

	private static final Logger logger = LogManager.getLogger(CommentController.class);

	@Inject
	private final CommentService commentService;

	@GetMapping("/CommentSelectMember")
	public String getCommentsByMember(HttpServletRequest request, Model model) {

		CustomMemberDetails customMemberDetails = (CustomMemberDetails) request.getSession()
				.getAttribute("customMemberDetails");

		if (customMemberDetails != null) {
			Integer member_code = customMemberDetails.getMemberCode();
			logger.info("Fetching comments for member_code: {}", member_code);
			List<Comment> comments = commentService.findCommentsByMemberCode(member_code);
			model.addAttribute("list", comments);
			model.addAttribute("member_code", member_code);
			return "comment/comment_member_view";
		} else {
			return "redirect:/login?loginRequired=true";
		}
	}

	@GetMapping("/CommentSelectParking")
	public String getAllComments(Model model) {
		logger.info("Fetching comments for all parking lots");
		List<Comment> comments = commentService.findAllComments();
		logger.info("Comments found: {}", comments);
		model.addAttribute("list", comments);
		return "comment/comment_parking_view";
	}

	@GetMapping("/CommentSelectDetail")
	public String detail(Model model, @RequestParam("comment_code") Integer comment_code) {
		Optional<Comment> comment = commentService.findCommentById(comment_code);
		comment.ifPresent(value -> model.addAttribute("commentDTO", value));
		return "comment/comment_select_detail_view";
	}

	@GetMapping("/CommentInsert")
	public String insertForm() {
		return "comment/comment_insert";
	}

	@PostMapping("/CommentInsert")
	public String insert(HttpServletRequest request, CommentDTO commentDTO,
			@RequestParam("parking_code") String pk_code) {

		CustomMemberDetails customMemberDetails = (CustomMemberDetails) request.getSession()
				.getAttribute("customMemberDetails");

		if (customMemberDetails != null) {
			Integer member_code = customMemberDetails.getMemberCode();
			Integer parking_code = Integer.parseInt(pk_code); // 주차장 코드는 그대로 사용

			Comment comment = new Comment();
			comment.setComment_content(commentDTO.getComment_content());
			comment.setComment_date(new Date());
			comment.setParking_code(parking_code);
			comment.setMember_code(member_code);
			commentService.saveComment(comment);
			return "comment/comment_insert_view";
		} else {
			// 세션에 customMemberDetails가 없는 경우 처리
			return "redirect:/login"; // 예를 들어 로그인 페이지로 리다이렉트
		}

	}

	@GetMapping("/CommentUpdate")
	public String updateForm(Model model, @RequestParam("comment_code") Integer comment_code) {
		Optional<Comment> comment = commentService.findCommentById(comment_code);
		comment.ifPresent(value -> model.addAttribute("commentDTO", value));
		return "comment/comment_update";
	}

	@PostMapping("/CommentUpdate")
	public String update(HttpServletRequest request, CommentDTO commentDTO) {

		CustomMemberDetails customMemberDetails = (CustomMemberDetails) request.getSession()
				.getAttribute("customMemberDetails");

		if (customMemberDetails != null) {
			Integer member_code = customMemberDetails.getMemberCode();
			Comment comment = new Comment();
			comment.setComment_code(commentDTO.getComment_code());
			comment.setComment_content(commentDTO.getComment_content());
			comment.setComment_date(new Date());
			comment.setParking_code(commentDTO.getParking_code());
			comment.setMember_code(member_code);
			commentService.saveComment(comment);
			return "comment/comment_update_view";
		} else {
			// 세션에 customMemberDetails가 없는 경우 처리
			return "redirect:/login"; // 예를 들어 로그인 페이지로 리다이렉트
		}

	} // 리뷰 댓글 수정 컨트롤러

	@GetMapping("/CommentDelete")
	public String deleteForm() {
		return "comment/comment_delete";
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