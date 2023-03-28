package kr.spring.silli.quiz.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import kr.spring.silli.quiz.vo.QuestionVO;
import kr.spring.silli.quiz.vo.faileVO;


@Mapper
public interface QuizMapper {
	
	public List<QuestionVO> chk(QuestionVO questionvo);
	public int faile_insert(faileVO faile);
	public List<faileVO> faile_chk(faileVO faile);
	public void faile_del(faileVO faile);
	public int requiz(QuestionVO questionvo);
	public void quiz_del(QuestionVO questionvo);

}
