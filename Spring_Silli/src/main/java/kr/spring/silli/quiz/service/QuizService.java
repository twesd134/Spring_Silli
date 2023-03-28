package kr.spring.silli.quiz.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import kr.spring.silli.quiz.vo.QuestionVO;
import kr.spring.silli.quiz.vo.faileVO;

@Service
public interface QuizService {
	public Map<String,Object> chk(QuestionVO questionvo,HttpSession session);
	public void faile_insert(faileVO faile,HttpSession sessio);
	public Map<String, Object> faile_chk(faileVO faile,HttpSession session);
	public void faile_del(faileVO faile,HttpSession session);
	public void quiz_del(QuestionVO questionvo,HttpSession session);
}