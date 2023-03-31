package kr.spring.silli.board.vo;

import lombok.Data;

@Data
public class CompanyVO {

	private int board_idx;
	private String title;
	private String content;
	private String writer;
	private String reg_date;
	private String upload_1;
	private String upload_2;
	private String upload_3;
	private String upload_4;
	private String upload_5;
	private String gubun;
	private int page; //현재 페이지 번호
	private int perPageNum; // 한페이지에 보여줄 게시글의 수
	private String searchType;
	private String keyword;
	private int keyCount;
	private int pageNum;
	private String start;
	private String now_date;
	private String gue_pw;
	
	


	public String getStart() {
		return start;
	}

	public void setStart(String start) {
		this.start = start;
	}
	
	public String getNow_date() {
		return now_date;
	}

	public void setNow_date(String now_date) {
		this.now_date = now_date;
	}

	public CompanyVO() {
		  this.page=1;
		  this.perPageNum=5; // 조정	 
	}
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	  // 현재 페이지의 게시글의 시작번호
	 public int getPageStart() {     // 1page  2page  3page
		  return (page-1)*perPageNum; // 0~     10~    20~   : limit ${pageStart},#{perPageNum}
	  }
	public int getPerPageNum() {
			return perPageNum;
	}
	public void setPerPageNum(int perPageNum) {
			this.perPageNum = perPageNum;
	}  
	public String getSearchType() {
		return searchType;
	}
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public int getKeyCount() {
		return keyCount;
	}
	public void setKeyCount(int keyCount) {
		this.keyCount = keyCount;
	}
	public int getPageNum() {
		return pageNum;
	}
	public void setPageNum(int pageNum) {
		this.pageNum = pageNum;
	}
	public String getUpload_1() {
		return upload_1;
	}
	public void setUpload_1(String upload_1) {
		this.upload_1 = upload_1;
	}
	public String getUpload_2() {
		return upload_2;
	}
	public void setUpload_2(String upload_2) {
		this.upload_2 = upload_2;
	}
	public String getUpload_3() {
		return upload_3;
	}
	public void setUpload_3(String upload_3) {
		this.upload_3 = upload_3;
	}
	public String getUpload_4() {
		return upload_4;
	}
	public void setUpload_4(String upload_4) {
		this.upload_4 = upload_4;
	}
	public String getUpload_5() {
		return upload_5;
	}
	public void setUpload_5(String upload_5) {
		this.upload_5 = upload_5;
	}
	
	public int getBoard_idx() {
		return board_idx;
	}
	public void setBoard_idx(int board_idx) {
		this.board_idx = board_idx;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	
	
	
}
