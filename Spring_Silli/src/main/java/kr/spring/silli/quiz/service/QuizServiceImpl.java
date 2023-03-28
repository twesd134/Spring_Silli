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
		List<QuestionVO> chk=QuizMapper.chk(questionvo);
		System.out.println("chk.length=="+chk.size());
		//문제갯수
		
		int cnt=chk.size();
		
		
		if(chk.size()==0)
		{
			int ninsert = QuizMapper.requiz(questionvo);
			chk=QuizMapper.chk(questionvo);
			
		}
		else{
			
			chk=QuizMapper.chk(questionvo);
		
		}
		map.put("chk", chk);
		session.setAttribute("cnt",cnt);
		return map;
	}


	@Override
	public Map<String, Object> faile_chk(faileVO failevo,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		failevo.setUser_id(user_id);
		Map<String,Object> map = new HashMap<String, Object>();
		List<faileVO> chk=QuizMapper.faile_chk(failevo);
		map.put("chk", chk);
		return map;
		
	}

	@Override
	public void faile_del(faileVO faile,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		faile.setUser_id(user_id);
		System.out.println("faile==="+faile);
		QuizMapper.faile_del(faile);
	}
	
	
	@Override
	public void faile_insert(faileVO faile,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		faile.setUser_id(user_id);
		
		QuizMapper.faile_insert(faile);
		
	}
	
	@Override
	public void quiz_del(QuestionVO questionvo,HttpSession session) {
		String user_id = (String)session.getAttribute("user_id");
		questionvo.setUser_id(user_id);
		QuizMapper.quiz_del(questionvo);
	}
}
