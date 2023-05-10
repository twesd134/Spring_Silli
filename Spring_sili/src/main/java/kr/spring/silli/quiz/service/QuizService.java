package kr.spring.silli.quiz.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import kr.spring.silli.quiz.vo.QuestionVO;
import kr.spring.silli.quiz.vo.faileVO;

@Service
public interface QuizService {
	
	public Map<String,Object> chk(QuestionVO questionvo,HttpSession session);
	public void faile_insert(QuestionVO questionvo,HttpSession sessio);
	public Map<String, Object> faile_chk(QuestionVO questionvo,HttpSession session);
	public void faile_del(QuestionVO questionvo,HttpSession session);
	public void quiz_del(QuestionVO questionvo,HttpSession session);
	public void ans_ins(QuestionVO questionvo,HttpSession session);
	public void quiz_write(@RequestParam(value="question[]") List<String> question
			,@RequestParam(value="answer[]") List<String>  answer
			,@RequestParam(value="user_id[]") List<String> user_id);	
}
