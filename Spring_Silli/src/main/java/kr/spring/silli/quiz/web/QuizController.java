package kr.spring.silli.quiz.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.spring.silli.quiz.service.QuizService;
import kr.spring.silli.quiz.vo.QuestionVO;
import kr.spring.silli.quiz.vo.faileVO;

@Controller
public class QuizController {
	
	@Resource
	private QuizService QuizService;
	
	
	@PostMapping("/faile_insert.do")
	@ResponseBody
	public void faile_insert(faileVO faile,HttpSession seesion) {
		QuizService.faile_insert(faile,seesion);
	}
	
	@GetMapping("/quiz_delete.do")
	@ResponseBody
	public void quiz_delete(QuestionVO questionvo,HttpSession session)
	{
		QuizService.quiz_del(questionvo,session);
	}
	
	@GetMapping("/faile_delete.do")
	@ResponseBody
	public void faile_delete(faileVO faile,HttpSession session) {
		QuizService.faile_del(faile,session);
	}
	
	@GetMapping("/quiz_main.do")
	public String quiz_list(Model model, QuestionVO questionvo,HttpSession seesion) {
		String returnJSP = "quiz/quiz_main";
		model.addAttribute("chk", QuizService.chk(questionvo,seesion));
		return returnJSP;
	}
	
	@PostMapping("/quiz_main.do")
	@ResponseBody
	public Map<String, Object> quiz_list(QuestionVO questionvo,HttpSession seesion) throws Exception {
		
		return QuizService.chk(questionvo,seesion);
		
	}
	
	@GetMapping("/quiz_faile.do")
	public String quiz_failed(Model model,faileVO faile,HttpSession seesion){
		String returnJSP="quiz/faile_quiz";
		model.addAttribute("chk",QuizService.faile_chk(faile,seesion));
		return returnJSP;
	}
	
	@PostMapping("/quiz_faile.do")
	@ResponseBody
	public Map<String, Object> quiz_faile(faileVO faile,HttpSession seesion){
		
		return QuizService.faile_chk(faile,seesion);
	}
	

}
