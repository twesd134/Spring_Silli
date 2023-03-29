package kr.spring.silli.quiz.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import kr.spring.silli.quiz.mapper.QuizMapper;
import kr.spring.silli.quiz.vo.QuestionVO;
import kr.spring.silli.quiz.vo.faileVO;

@Service
public class QuizServiceImpl implements QuizService {
	@Resource
	private QuizMapper QuizMapper;
	
	public Map<String,Object> chk(QuestionVO questionvo,HttpSession session) {
		
		String user_id = (String)session.getAttribute("user_id");
		questionvo.setUser_id(user_id);
		Map<String,Object> map = new HashMap<String, Object>();
		List<QuestionVO> re_chk= QuizMapper.requiz(questionvo);
		//문제갯수
		List<QuestionVO> chk=QuizMapper.chk(questionvo);
		
		if(re_chk.size()==0)
		{	
			QuizMapper.ans_del(questionvo);
			re_chk=QuizMapper.requiz(questionvo);
			
		}
		else{
			
			re_chk=QuizMapper.requiz(questionvo);
			
		}
		
		map.put("chk",chk);
		map.put("re_chk", re_chk);
		session.setAttribute("re_chk",re_chk);
		return map;
	}

	
	@Override
	public void ans_ins(QuestionVO questionvo, HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		questionvo.setUser_id(user_id);
		QuizMapper.ans_ins(questionvo);
	}
	
	@Override
	public Map<String, Object> faile_chk(QuestionVO questionvo,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		questionvo.setUser_id(user_id);
		Map<String,Object> map = new HashMap<String, Object>();
		List<QuestionVO> fail_chk=QuizMapper.faile_chk(questionvo);
		map.put("fail_chk", fail_chk);
		return map;
		
	}

	@Override
	public void faile_del(QuestionVO questionvo,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		questionvo.setUser_id(user_id);
		System.out.println("faile==="+questionvo);
		QuizMapper.faile_del(questionvo);
	}
	
	
	@Override
	public void faile_insert(QuestionVO questionvo,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		questionvo.setUser_id(user_id);
		
		QuizMapper.faile_insert(questionvo);
		
	}
	
	@Override
	public void quiz_del(QuestionVO questionvo,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		questionvo.setUser_id(user_id);
		QuizMapper.quiz_del(questionvo);
	}
}
