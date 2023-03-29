package kr.spring.silli.quiz.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.silli.quiz.vo.QuestionVO;
import kr.spring.silli.quiz.vo.faileVO;


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
	
}
