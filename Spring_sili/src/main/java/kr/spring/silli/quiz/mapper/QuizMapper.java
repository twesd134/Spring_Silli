package kr.spring.silli.quiz.mapper;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import kr.spring.silli.quiz.vo.QuestionVO;


@Mapper
public interface QuizMapper {
	
	 
	
	public List<QuestionVO> chk(QuestionVO questionvo);
	public int faile_insert(QuestionVO questionvo);
	public List<QuestionVO> faile_chk(QuestionVO questionvo);
	public void faile_del(QuestionVO questionvo);
	public List<QuestionVO> requiz(QuestionVO questionvo);
	public void quiz_del(QuestionVO questionvo);
	public void ans_del(QuestionVO questionvo);
	public void ans_ins(QuestionVO questionvo);
	public void quiz_write(List<QuestionVO> list);
	public default void quiz_do(List<QuestionVO> list)
	{
		System.out.println("결과==="+list);
//		System.out.println("mapper=="+question+"answer"+answer+"user_id=="+user_id);
	}
}
