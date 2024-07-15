package parking.car.project.term.controller;

import java.util.List;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import jakarta.inject.Inject;
import lombok.RequiredArgsConstructor;
import parking.car.project.term.dto.TermDTO;
import parking.car.project.term.service.TermService;

@Controller
@RequiredArgsConstructor
public class TermController {

    private static final Logger logger = LogManager.getLogger(TermController.class);

    @Inject
    private final TermService termService;

    @GetMapping("/TermSelect")
    public String list(Model model) {
        List<TermDTO> terms = termService.termSelectAll();
        model.addAttribute("list", terms);
        logger.info("list", model);
        return "term/term_select_view";
    }
}