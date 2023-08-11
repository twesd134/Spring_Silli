package kr.spring.silli.quiz.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
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
	
	@PostMapping("/category_del.do")
	@ResponseBody
	public void category_del(@RequestParam(value="category") String category)
	{
		System.out.println("ㅋㅌㄹ=="+category);
		QuizService.category_del(category);
	}
	
	@GetMapping("/quiz_list.do")
	public String quiz_list3(Model model,QuestionVO questionvo,HttpSession seesion)
	{
		String returnJSP = "quiz/quiz_list";
		model.addAttribute("chk", QuizService.chk(questionvo,seesion));
		return returnJSP;
	}
	
	@GetMapping("/quiz_cate.do")
	public String quiz_cate(Model model,QuestionVO questionvo,HttpSession seesion)
	{
		String returnJSP = "quiz/quiz_cate";
		model.addAttribute("cate",questionvo.getCategory());
		model.addAttribute("chk", QuizService.cate(questionvo,seesion));
		return returnJSP;
	}
	
	@GetMapping("/cate_detail.do")
	public String cate_detail(Model model,QuestionVO questionvo,HttpSession seesion)
	{
		String resultJSP="quiz/cate_detail";
		model.addAttribute("cate_detail",QuizService.cate_detail(questionvo, seesion));
		return resultJSP;
	}
	@PostMapping("/quiz_list.do")
	@ResponseBody
	public Map<String, Object> quiz_list2(QuestionVO questionvo,HttpSession seesion) throws Exception {
		return QuizService.chk(questionvo,seesion);
	}
	
	@PostMapping("/quiz_update.do")
	@ResponseBody
	public void quiz_update(@RequestParam(value="question[]") List<String> question
			,@RequestParam(value="answer[]") List<String>  answer
			,@RequestParam(value="user_id[]") List<String> user_id
			,@RequestParam(value="category[]") List<String> category) {
		
		QuizService.quiz_update(question,answer,user_id,category);
	}
	
	@PostMapping("/faile_insert.do")
	@ResponseBody
	public void faile_insert(QuestionVO questionvo,HttpSession seesion) {
		QuizService.faile_insert(questionvo,seesion);
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
	
	@GetMapping("/faile_cate.do")
	public String quiz_faile_list(Model model,QuestionVO questionvo,HttpSession seesion){
		String returnJSP="quiz/faile_cate";
		model.addAttribute("faile",QuizService.faile_cate(questionvo,seesion));
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
	public void quiz_writee(@RequestParam("category") String category,
			@RequestParam(value="question[]") List<String> question
			,@RequestParam(value="answer[]") List<String>  answer
			,@RequestParam(value="user_id[]") List<String> user_id) {
			
		QuizService.quiz_write(category,question,answer,user_id);
	}	
	
	@PostMapping("/quiz_del.do")
	@ResponseBody
	public void quiz_dele(@RequestParam(value = "quiz_idx[]") ArrayList<String> quiz_idx) {
		QuizService.quiz_del(quiz_idx);
	}
	
	@GetMapping("/quiz_one_check.do")
	public String quiz_one_check(Model model,QuestionVO questionvo,HttpSession seesion) {
		String returnJSP="quiz/quiz_one_check";
		model.addAttribute("chk", QuizService.chk(questionvo,seesion));
		return returnJSP;
	}
	
	@PostMapping("/quiz_one_check.do")
	@ResponseBody
	public Map<String, Object> quiz_one_check2(QuestionVO questionvo,HttpSession seesion) throws Exception {
		return QuizService.chk(questionvo,seesion);
	}
	
}
