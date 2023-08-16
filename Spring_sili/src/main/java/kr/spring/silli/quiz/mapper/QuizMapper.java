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
	public List<QuestionVO> re_faile(QuestionVO questionvo);
	public int quiz_del(ArrayList<String> quiz_idx);
	public void ans_del(QuestionVO questionvo);
	public void ans_ins(QuestionVO questionvo);
	public void quiz_write(List<QuestionVO> list);
	public List<QuestionVO> cate(QuestionVO questionvo);
	public default void quiz_do(List<QuestionVO> list)
	{
		System.out.println("결과==="+list);
//		System.out.println("mapper=="+question+"answer"+answer+"user_id=="+user_id);
	}
	public void quiz_ignore_insert(List<QuestionVO> list);
	
	public void quiz_update(List<QuestionVO> list);
	
	// 기존 문제 수정
    void updateQuestion(@Param("quiz_idx") int quizIdx, @Param("question") String question);

    void updateAnswer(@Param("quiz_idx") int quizIdx, @Param("answer") String answer);

    void updateUserId(@Param("quiz_idx") int quizIdx, @Param("user_id") String userId);
    
    // 새로운 문제 추가
    void insertQuestion(@Param("question") String question, @Param("answer") String answer, @Param("user_id") String userId);
	public void category_del(String category);
	public List<QuestionVO> cate_detail(QuestionVO questionvo);
	
	
	
}
