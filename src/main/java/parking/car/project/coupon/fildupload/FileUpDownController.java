package parking.car.project.coupon.fildupload;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class FileUpDownController {
    private static final Logger logger = LogManager.getLogger(FileUpDownController.class);
    private final FileUpDownService fileUpDownService;

    //Spring 4.3 이후로는 파라미터 생성자가 하나만 있는 경우에 @RequestMapping 사용하면 @Autowired 생략가능
    @GetMapping("/upload")
    public String form() {
    	logger.info("컨트롤러 확인");
        return "./fileupdown/uploadform";
    }

    @PostMapping("/upload")
    public String upload(Model model, FileUpDownDTO fileUpDownDTO,
    		MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {
        	return fileUpDownService.uploadFile(model, fileUpDownDTO, multipartHttpServletRequest);
    }

    @GetMapping("/down")
    public String down(@RequestParam(value = "fileName", required = true) String fileName, HttpServletResponse response) throws Exception {
        return fileUpDownService.downloadFile(fileName, response);
    }
}