package kr.spring.silli.board.vo;

import lombok.Data;

@Data
public class PageMaker {
  private CompanyVO cri;
  private int totalCount; // 총게시글의 수
  private int startPage; // 시작페이지번호
  private int endPage; // 끝페이지번호(조정이 되어야 한다)
  private boolean prev; // 이전버튼(true, false)
  private boolean next; // 다음버튼(true, false)
  private int displayPageNum=5; // 1 2 3 4 5 6 7 8 9 10
  private int totBlock;	// 전체 페이지 블록 갯수
  private int lastPage;

  public int getTotBlock() {
  	return totBlock;
  }
  public void setTotBlock(int totalCount) {
  	this.totBlock = totalCount;
  	makePaging();
  }
// 총게시글의 수를 구하는 메서드
  public void setTotalCount(int totalCount) {
	  this.totalCount=totalCount;
	  
	  makePaging();
  }
  private void makePaging() { 
	// 1.화면에 보여질 마지막 페이지 번호
	totBlock=(int)Math.ceil(totalCount/displayPageNum);
	endPage=(int)(Math.ceil(cri.getPage()/(double)displayPageNum)*displayPageNum);
	// 2.화면에 보여질 시작 페이지 번호
	lastPage=(int)(Math.ceil(Math.ceil(totalCount)/displayPageNum));
	startPage=(endPage-displayPageNum)+1;
	if(startPage<=0) startPage=1;
	// 3.전체 마지막 페이지 계산
	int tempEndPage=(int)(Math.ceil(totalCount/(double)cri.getPerPageNum()));
	// 4.화면에 보여질 마지막 페이지 유효성 체크
	if(tempEndPage<endPage) {
		endPage=tempEndPage;		
	}
	// 5.이전페이지 버튼(링크)존재 여부
	prev=(startPage==1) ? false : true;
	// 6.다음페이지 버튼(링크)존재 여부
	next=(endPage<tempEndPage)? true : false;
  	}
  
	public CompanyVO getCri() {
		return cri;
	}
	public void setCri(CompanyVO cri) {
		this.cri = cri;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public boolean isPrev() {
		return prev;
	}
	public void setPrev(boolean prev) {
		this.prev = prev;
	}
	public boolean isNext() {
		return next;
	}
	public void setNext(boolean next) {
		this.next = next;
	}
	public int getDisplayPageNum() {
		return displayPageNum;
	}
	public void setDisplayPageNum(int displayPageNum) {
		this.displayPageNum = displayPageNum;
	}
	public int getTotalCount() {
		return totalCount;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
  
}
