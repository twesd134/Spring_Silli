package kr.spring.silli.quiz.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

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
	
	
	@Override
	public void quiz_write(@RequestParam(value="question[]") List<String> question
			,@RequestParam(value="answer[]") List<String>  answer
			,@RequestParam(value="user_id[]") List<String> user_id)
	{
		
		List<QuestionVO> list=new ArrayList<QuestionVO>();
		
		for(int i=0;i<question.size();i++)
		{
			QuestionVO vo=new QuestionVO();
			vo.setQuestion(question.get(i));
			vo.setAnswer(answer.get(i));
			vo.setUser_id(user_id.get(i));
			list.add(vo);
		} 
		System.out.println("list=="+list);
		QuizMapper.quiz_write(list);
	}
	
	@Override
	public void quiz_update(@RequestParam(value="question[]") List<String> question
			,@RequestParam(value="answer[]") List<String>  answer
			,@RequestParam(value="quiz_idx[]") List<Integer> quiz_idx) {
		List<QuestionVO> list=new ArrayList<QuestionVO>();
		
		for(int i=0;i<question.size();i++)
		{
			QuestionVO vo=new QuestionVO();
			vo.setQuestion(question.get(i));
			vo.setAnswer(answer.get(i));
			vo.setQuiz_idx(quiz_idx.get(i));
			list.add(vo);
		} 
		
		System.out.println("list=="+list);
		QuizMapper.quiz_update(list);
	}
}
