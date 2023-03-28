package kr.spring.silli.board.service;

import java.util.ArrayList;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import kr.spring.silli.board.vo.CompanyVO;

@Service
public interface boardservice {
	public Map<String,Object> write(CompanyVO companyvo,HttpServletRequest request,HttpSession session);
	public CompanyVO get_list (CompanyVO companyvo);
	public Map<String,Object> update(CompanyVO companyvo,HttpServletRequest request,HttpSession session);
	public void delete(int board_idx);
	public int totalCount(CompanyVO companyvo);
	public int delete_select_com(ArrayList<String> board_idx);
	public int idx(CompanyVO companyvo);
	public Map<String,Object> board_list(CompanyVO companyvo) throws Exception;
}
