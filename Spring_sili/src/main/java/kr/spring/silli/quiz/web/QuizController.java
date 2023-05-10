package kr.spring.silli.quiz.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import kr.spring.silli.quiz.service.QuizService;
import kr.spring.silli.quiz.vo.QuestionVO;
import kr.spring.silli.quiz.vo.faileVO;

@Controller
public class QuizController {
	
	@Resource
	private QuizService QuizService;
	
	@GetMapping("/quiz_list.do")
	public String quiz_list3(Model model,QuestionVO questionvo,HttpSession seesion)
	{
		String returnJSP = "quiz/quiz_list";
		model.addAttribute("chk", QuizService.chk(questionvo,seesion));
		return returnJSP;
	}
	
	@PostMapping("/quiz_list.do")
	@ResponseBody
	public Map<String, Object> quiz_list2(QuestionVO questionvo,HttpSession seesion) throws Exception {
		return QuizService.chk(questionvo,seesion);
	}
	
	@PostMapping("/faile_insert.do")
	@ResponseBody
	public void faile_insert(QuestionVO questionvo,HttpSession seesion) {
		QuizService.faile_insert(questionvo,seesion);
	}
	
	@GetMapping("/quiz_delete.do")
	@ResponseBody
	public void quiz_delete(QuestionVO questionvo,HttpSession session)
	{
		QuizService.quiz_del(questionvo,session);
	}
	
	@GetMapping("/faile_delete.do")
	@ResponseBody
	public void faile_delete(QuestionVO questionvo,HttpSession session) {
		QuizService.faile_del(questionvo,session);
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
	public String quiz_failed(Model model,QuestionVO questionvo,HttpSession seesion){
		String returnJSP="quiz/faile_quiz";
		model.addAttribute("chk",QuizService.faile_chk(questionvo,seesion));
		return returnJSP;
	}
	
	@PostMapping("/quiz_faile.do")
	@ResponseBody
	public Map<String, Object> quiz_faile(QuestionVO questionvo,HttpSession seesion){
		
		return QuizService.faile_chk(questionvo,seesion);
	}
	
	
	@PostMapping("/ans_insert.do")
	@ResponseBody
	public void ans_insert(QuestionVO questionvo,HttpSession seesion) {
		QuizService.ans_ins(questionvo,seesion);
	}
	
	@GetMapping("/quiz_write.do")
	public String quiz_write(QuestionVO questionvo,HttpSession session) {
		String returnJSP="quiz/quiz_write";
		
		return returnJSP;
	}
	
	@PostMapping("/quiz_write.do")
	@ResponseBody
	public void quiz_writee(@RequestParam(value="question[]") List<String> question
			,@RequestParam(value="answer[]") List<String>  answer
			,@RequestParam(value="user_id[]") List<String> user_id) {
//		System.out.println("컨트롤러"+question);
//		System.out.println("컨트롤러"+answer);
//		System.out.println("컨트롤러"+user_id);
//		List<QuestionVO> as=new ArrayList<QuestionVO>();
//		QuestionVO list=new QuestionVO();
//		list.setQuestion(question);
//		list.setAnswer(answer);
//		list.setUser_id(user_id);
		QuizService.quiz_write(question,answer,user_id);
	}
	
	@GetMapping("/quiz_del.do")
	public String quiz_del(Model model,QuestionVO questionvo,HttpSession session) {
		String returnJSP="quiz/quiz_del";
		return returnJSP;
	}
	
	@PostMapping
	@ResponseBody
	public void quiz_dele(QuestionVO questionvo,HttpSession session) {
		QuizService.quiz_del(questionvo, session);
	}
	
}
