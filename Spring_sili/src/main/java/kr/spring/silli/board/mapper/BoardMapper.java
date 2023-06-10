package kr.spring.silli.board.mapper;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import kr.spring.silli.board.vo.CompanyVO;


public interface BoardMapper {
	public void write(CompanyVO companyvo);
	public List<CompanyVO> board_list(CompanyVO companyvo);
	public CompanyVO get_list(CompanyVO companyvo);
	public void update(CompanyVO companyvo);
	public void delete(int board_idx);
	public int totalCount(CompanyVO companyvo);
	public int pagecount(CompanyVO companyvo);
	public int delete_select_com(ArrayList<String> board_idx);
	public int delete_select_pro(ArrayList<String> board_idx);
	public int idx(CompanyVO companyvo);
	public void boardrank(CompanyVO companyvo);
	public List<CompanyVO> ranklist(CompanyVO companyvo);
	public void re_write(CompanyVO companyvo);
	public List<CompanyVO> re_list(CompanyVO companyvo);
	public int re_count(CompanyVO companyvo);
	
}
