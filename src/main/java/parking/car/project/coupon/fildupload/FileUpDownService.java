package parking.car.project.coupon.fildupload;

import java.io.File;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.Map;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import jakarta.servlet.http.HttpServletResponse;


@Component
public class FileUpDownService {
    private static final Logger logger = LogManager.getLogger(FileUpDownService.class);

    public String uploadFile(Model model, FileUpDownDTO fileUpDownDTO, MultipartHttpServletRequest multipartHttpServletRequest) throws Exception {
        String name = fileUpDownDTO.getName();
        String subject = fileUpDownDTO.getSubject();
        String realFileName = fileUpDownDTO.getFile().getOriginalFilename();

        Map<String, MultipartFile> map = multipartHttpServletRequest.getFileMap();
        Iterator<Map.Entry<String, MultipartFile>> iterator = map.entrySet().iterator();
        MultipartFile multipartFile = fileUpDownDTO.getFile();

        if (multipartFile.isEmpty()) {
            return "redirect:/upload";
        }

        String fileName = multipartFile.getOriginalFilename();
        String savePath = multipartHttpServletRequest.getSession().getServletContext().getRealPath("./resources/upload");
        String filePath = savePath + "\\";
        String saveFileName = "";
        String saveFilePath = "";

        while (iterator.hasNext()) {
            Map.Entry<String, MultipartFile> entry = iterator.next();
            multipartFile = entry.getValue();
            String extensionExclude = fileName.substring(0, fileName.lastIndexOf("."));
            String extension = fileName.substring(fileName.lastIndexOf(".") + 1);
            saveFilePath = filePath + File.separator + fileName;
            File saveFile = new File(saveFilePath);

            if (saveFile.isFile()) {
                boolean fileExist = true;
                int index = 0;

                while (fileExist) {
                    index++;
                    saveFileName = extensionExclude + index + "." + extension;
                    String dictFile = filePath + File.separator + saveFileName;
                    fileExist = new File(dictFile).isFile();

                    if (!fileExist) {
                        saveFilePath = dictFile;
                    }
                }

                multipartFile.transferTo(new File(saveFilePath));
                model.addAttribute("name", name);
                model.addAttribute("subject", subject);
                model.addAttribute("realFileName", realFileName);
                model.addAttribute("fileName", saveFileName);
                return "./fileupdown/uploadview";
            } else {
                multipartFile.transferTo(saveFile);
                model.addAttribute("name", name);
                model.addAttribute("subject", subject);
                model.addAttribute("realFileName", realFileName);
                model.addAttribute("fileName", fileName);
                return "./fileupdown/uploadview";
            }
        }

        return saveFilePath;
    }

    public String downloadFile(String fileName, HttpServletResponse response) throws Exception {
        fileName = URLEncoder.encode(fileName, "UTF-8").replaceAll("\\+", "%20");
        logger.info("데이터 확인 - " + fileName);
        response.setContentType("application/octet-stream");
        return "redirect:/resources/upload/" + fileName;
    }
}