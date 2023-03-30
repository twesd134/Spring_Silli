package kr.spring.silli.board.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.spring.silli.board.service.boardservice;
import kr.spring.silli.board.vo.CompanyVO;


@Controller
public class ComController {
	
	@Resource
	private boardservice boardservice;
	
	
	@RequestMapping("/download.do")
	public String download(@RequestParam("upload") String all, HttpServletResponse response) throws Exception {
		// 파일 정보를 가지고 온다 ( 여기서 FileInfo는 스프링에 있는 자료형이 아니고 제가 만든 DTO 입니다 )
		String fileName = all;
		// 파일 이름 가지고 오고
		String Path = "C:\\eGovment_Devloper\\eGovFrameDev-3.7.0-64bit\\workspace\\Spring_sili\\src\\main\\webapp\\resources\\image\\";
		String tempfileName = Path + all;
		System.out.println("tempfileName == " + tempfileName);
		System.out.println("is == " + (new File(tempfileName)).exists());
		// 파일 저장되어 있는 경로뒤에 붙여줘서
		// saveFileName을 만든다.
		String contentType = "UTF-8";
		// contentType 가져오고
		File file = new File(tempfileName);
		long fileLength = file.length();
		// 데이터베이스에 없는 정보는 파일로 만들어서 가져온다. 이 경우엔 Content-Length 가져온 것
		try {
			// 특수문자에 대한 보안 추가
			String[] strArray = { "..", "/", "\\" };
			System.out.println("strArray" + strArray);
			for (int i = 0; i <= strArray.length; i++) {
				System.out.println("strArray==" + strArray[i]);
				if (fileName.contains(strArray[i])) {
					return "board/com/error";
				}
			}
		} catch (Exception e)

		{
			System.out.println("eeeee==" + e);
		}

		response.setHeader("Content-Disposition","attachment; filename=\"" + URLEncoder.encode(fileName, "UTF-8") + "\";");
		response.setHeader("Content-Transfer-Encoding", "binary");
		response.setContentType("application/octet-stream; charset=UTF-8");
		response.setHeader("Content-Length", "" + fileLength);
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		// 그 정보들을 가지고 reponse의 Header에 세팅한 후
		try (FileInputStream fis = new FileInputStream(tempfileName); OutputStream out = response.getOutputStream();) {
			// saveFileName을 파라미터로 넣어 inputStream 객체를 만들고
			// response에서 파일을 내보낼 OutputStream을 가져와서
			int readCount = 0;
			byte[] buffer = new byte[4096];
			// 파일 읽을 만큼 크기의 buffer를 생성한 후
			while ((readCount = fis.read(buffer)) != -1) {
				out.write(buffer, 0, readCount);
				out.flush();
				// outputStream에 씌워준다
			}
		} catch (Exception ex) {
			throw new RuntimeException("file Load Error");
		}
		return "aaaa";
	}

	@GetMapping("/company_list.do")
	public String company(Model model, CompanyVO companyvo) throws Exception {
		String gubun = "company";
		companyvo.setGubun(gubun);
		String returnJSP = "board/com/company";
		model.addAttribute("com_list", boardservice.board_list(companyvo));
		return returnJSP;
	}

	@PostMapping("/company_list.do")
	@ResponseBody
	public Map<String, Object> company(CompanyVO companyvo) throws Exception {
		String gubun = "company";
		companyvo.setGubun(gubun);
		return boardservice.board_list(companyvo);
	}
	
	@RequestMapping("/delete_select_com.do")
	@ResponseBody
	public String delete_select_com(@RequestParam(value = "board_idx[]") ArrayList<String> board_idx) {
		try {
			boardservice.delete_select_com(board_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return "";
	}

	@GetMapping("/procedure_list.do")
	public String procedure(Model model, CompanyVO companyvo) throws Exception {
		String gubun = "procedure";
		companyvo.setGubun(gubun);
		String returnJSP = "board/pro/procedure";
		model.addAttribute("pro_list", boardservice.board_list(companyvo));
		return returnJSP;
	}

	@PostMapping("/procedure_list.do")
	@ResponseBody
	public Map<String, Object> procedure(CompanyVO companyvo) throws Exception {
		String gubun = "procedure";
		companyvo.setGubun(gubun);
		return boardservice.board_list(companyvo);
	}

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		String formattedDate = dateFormat.format(date);
		model.addAttribute("serverTime", formattedDate);
		return "home";
	}

	@GetMapping("/com_detail.do")
	public String detail(Model model, CompanyVO companyvo) {
		String gubun = "company";
		companyvo.setGubun(gubun);
		CompanyVO get_com = boardservice.get_list(companyvo);
		model.addAttribute("get_com", get_com);
		String returnJSP = "board/com/com_detail";
		return returnJSP;
	}

	@RequestMapping("/com_delete.do")
	@ResponseBody
	public String com_delete(@RequestParam("board_idx") int board_idx) {
		String resultJSP = "false";
		try {
			boardservice.delete(board_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return resultJSP;
	}

	@RequestMapping("/com_write.do")
	public String com_write(CompanyVO companyvo, Model model) {

		String returnJSP = "board/com/com_write";
		
		return returnJSP;
	}

	@RequestMapping("/com_writeSuccess.do")
	@ResponseBody
	public Map<String, Object> com_writesuccess(CompanyVO companyvo, MultipartHttpServletRequest mtf,
			HttpSession session) {

		String gubun = "company";
		companyvo.setGubun(gubun);

		return boardservice.write(companyvo, mtf, session);
		// return "board_idx="+companyvo.getBoard_idx();
	}

	@RequestMapping("/com_update.do")
	public String update(Model model, CompanyVO companyvo) {
		String returnJSP = "board/com/com_update";
		String gubun = "company";
		companyvo.setGubun(gubun);
		CompanyVO get_com = boardservice.get_list(companyvo);
		model.addAttribute("get_com", get_com);
		return returnJSP;
	}

	@PostMapping("/com_updatesucess.do")
	@ResponseBody
	public Map<String, Object> updatesucess(CompanyVO companyvo, HttpServletRequest request, BindingResult result,
			HttpSession session) {

		String gubun = "company";
		companyvo.setGubun(gubun);
		return boardservice.update(companyvo, request, session);

	}

	@GetMapping("/pro_detail.do")
	public String pro_detail(Model model, CompanyVO companyvo) {

		String gubun = "procedure";
		companyvo.setGubun(gubun);
		CompanyVO get_com = boardservice.get_list(companyvo);
		model.addAttribute("get_com", get_com);
		String returnJSP = "board/pro/pro_detail";
		return returnJSP;
	}

	@RequestMapping("/pro_delete.do")
	@ResponseBody
	public String pro_delete(@RequestParam("board_idx") int board_idx) {
		String resultJSP = "false";
		try {
			boardservice.delete(board_idx);
		} catch (Exception e) {
			System.out.println(e);
		}
		return resultJSP;
	}

	@RequestMapping("/pro_write.do")
	public String pro_write(CompanyVO companyvo, Model model) {

		String returnJSP = "board/pro/pro_write";
		return returnJSP;
	}

	@RequestMapping("/pro_writeSuccess.do")
	@ResponseBody
	public Map<String, Object> pro_writesuccess(CompanyVO companyvo, MultipartHttpServletRequest mtf,
			HttpSession session) {
		String gubun = "procedure";
		companyvo.setGubun(gubun);
		return boardservice.write(companyvo, mtf, session);
	}

	@RequestMapping("/pro_update.do")
	public String pro_update(Model model, CompanyVO companyvo) {
		String gubun = "procedure";
		companyvo.setGubun(gubun);
		CompanyVO get_com = boardservice.get_list(companyvo);
		model.addAttribute("get_com", get_com);
		String returnJSP = "board/pro/pro_update";
		return returnJSP;
	}

	@PostMapping("/pro_updatesucess.do")
	@ResponseBody
	public Map<String, Object> pro_updatesucess(CompanyVO companyvo, HttpServletRequest request, BindingResult result,
			HttpSession session) {
		String gubun = "procedure";
		companyvo.setGubun(gubun);
		return boardservice.update(companyvo, request, session);

	}
}
