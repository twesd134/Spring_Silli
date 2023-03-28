package kr.spring.silli.board.service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kr.spring.silli.board.mapper.BoardMapper;
import kr.spring.silli.board.vo.CompanyVO;
import kr.spring.silli.board.vo.PageMaker;
@Service
public class boardserviceImpl implements boardservice{

	@Resource
	private BoardMapper boardmapper;

	
	
	String savePath ="C:\\eGovment_Devloper\\eGovFrameDev-3.7.0-64bit\\workspace\\Spring_sili\\src\\main\\webapp\\resources\\image\\";
	
	@Override
	public Map<String,Object> write(CompanyVO companyvo,HttpServletRequest request,HttpSession session) {
		
		String uploadPath = session.getServletContext().getRealPath("/")+"WEB-INF/files/";
		System.out.println("uploadPath: "+uploadPath);
		Map<String,Object> map = new HashMap<String, Object>();
		int fileMaxSize=10*1024*1024;
		 // 파일 전송
		
		  try {
			  
		  	  	boolean isAction = true;
		  	  	MultipartHttpServletRequest mtf = (MultipartHttpServletRequest)request;
				Map<String, Object> mFile = new HashMap<String, Object>();
				for(int ii = 1; ii <= 5; ii++) {
					MultipartFile fileM = mtf.getFile("multi_" + ii);
					String fileName = "";
					int idx=fileM.getOriginalFilename().lastIndexOf(".");
					//파일형식 짜르기 jpg,png 추출
					String fieMs=fileM.getOriginalFilename().substring(idx+1);
					String[] strArray = {"png","jpg","gif","bmp","pdf","docx","xlsx","xls","pptx","ppt","txt"};
					List<String> strList = new ArrayList<>(Arrays.asList(strArray));
					if(fileM.getSize() >0 && fileM.getSize() <= fileMaxSize ) {
						if(strList.contains(fieMs))
						{
							fileName = fileM.getOriginalFilename();
							fileM.transferTo(new File(uploadPath + fileName));
						}
						else {
							isAction = false;
							break;
						}
					}
					else if(fileM.getSize() > fileMaxSize){
							
							map.put("chk","ERROR");
							map.put("message",ii+"번째 파일 용량은 10m 미만이여야 됩니다");
							map.put("ii",ii);
							
					}
					mFile.put("fileName" + ii, fileName);
				}
				
				if(isAction) {
					
					companyvo.setUpload_1(mFile.get("fileName1").toString());
					companyvo.setUpload_2(mFile.get("fileName2").toString());
					companyvo.setUpload_3(mFile.get("fileName3").toString());
					companyvo.setUpload_4(mFile.get("fileName4").toString());
					companyvo.setUpload_5(mFile.get("fileName5").toString());
					
					boardmapper.write(companyvo);
					
					map.put("code", "OK");
					map.put("boardIdx", companyvo.getBoard_idx());
					
				}
				else {
					//return "ERROR_FILE";
					map.put("code", "ERROR_FILE");
					map.put("message", "허용하지 않는 첨부파일 형식입니다.");
				}
		    }
		  
		  catch(Exception e) {
		            //return "ERROR";
		            map.put("code", "ERROR");
					map.put("message", "오류입니다.");
		  }
		  
		  return map;
	}
	
	public int totalCount(CompanyVO companyvo){
		return boardmapper.totalCount(companyvo);
	}
	
	
	public CompanyVO get_list(CompanyVO companyvo)
	{
		return boardmapper.get_list(companyvo);
	}
	
	
	@Override
	public Map<String,Object> update(CompanyVO companyvo,HttpServletRequest request,HttpSession session) {
		
		String uploadPath = session.getServletContext().getRealPath("/")+"WEB-INF/files/";
		System.out.println("uploadPath: "+uploadPath);
		Map<String,Object> map = new HashMap<String, Object>();
		  // 파일 전송
		int fileMaxSize=10*1024*1024;
		  try {
				MultipartHttpServletRequest mtf = (MultipartHttpServletRequest)request;
				
				Map<String, Object> mFile = new HashMap<String, Object>();
				boolean isAction = true;
				for(int ii = 1; ii <= 5; ii++) {
					MultipartFile fileM = mtf.getFile("multi_" + ii);
					System.out.println(fileM.getSize() + " // " + fileM.getOriginalFilename());
					String fileName = "";
					int idx=fileM.getOriginalFilename().indexOf(".");
					String fieMs=fileM.getOriginalFilename().substring(idx+1);
					String[] strArray = {"png","jpg","gif","bmp","pdf","docx","xlsx","xls","pptx","ppt"};
					List<String> strList = new ArrayList<>(Arrays.asList(strArray));
					System.out.println("fileM.getSize=="+fileM.getSize());
					System.out.println("fileMaxSize=="+fileMaxSize);
					if(fileM.getSize() > 0 && fileM.getSize() <= fileMaxSize) {
						if(strList.contains(fieMs))
						{
							fileName = fileM.getOriginalFilename();
							fileM.transferTo(new File(uploadPath + fileName));
						}
						else {
						isAction = false;
						break;
					}
				  }	else if(fileM.getSize() > fileMaxSize){
						
						map.put("chk","ERROR");
						map.put("message",ii+"번째 파일 용량은 10m 미만이여야 됩니다");
						map.put("ii",ii);
						
				}
					mFile.put("fileName" + ii, fileName);
				}
			
		       CompanyVO selCompanyVO = boardmapper.get_list(companyvo);
		       
		       
		       if(isAction)
		       {
		       //첨부파일 유지 하기 위한 로직
		       if(mFile.get("fileName1").toString().equals("")) {
		    	   mFile.put("fileName1", (selCompanyVO.getUpload_1() != null ? selCompanyVO.getUpload_1() : ""));
		       }
		       if(mFile.get("fileName2").toString().equals("")) {
		    	   mFile.put("fileName2", (selCompanyVO.getUpload_2() != null ? selCompanyVO.getUpload_2() : ""));
		       }
		       if(mFile.get("fileName3").toString().equals("")) {
		    	   mFile.put("fileName3", (selCompanyVO.getUpload_3() != null ? selCompanyVO.getUpload_3() : ""));
		       }
		       if(mFile.get("fileName4").toString().equals("")) {
		    	   mFile.put("fileName4", (selCompanyVO.getUpload_4() != null ? selCompanyVO.getUpload_4() : ""));
		       }
		       if(mFile.get("fileName5").toString().equals("")) {
		    	   mFile.put("fileName5", (selCompanyVO.getUpload_5() != null ? selCompanyVO.getUpload_5() : ""));
		       }
		       
		       companyvo.setUpload_1(mFile.get("fileName1").toString());
		       companyvo.setUpload_2(mFile.get("fileName2").toString());
		       companyvo.setUpload_3(mFile.get("fileName3").toString());
		       companyvo.setUpload_4(mFile.get("fileName4").toString());
		       companyvo.setUpload_5(mFile.get("fileName5").toString());
		       
		       map.put("code", "OK");
			   map.put("boardIdx", companyvo.getBoard_idx());
		    // TODO Auto-generated method stub
				boardmapper.update(companyvo);
		       }
		       else {
		    	   map.put("code", "ERROR_FILE");
				   map.put("message", "허용하지 않는 첨부파일 형식입니다.");
		       }
		   }
		  
		  catch(Exception e) {
			  
	            //return "ERROR";
	            map.put("code", "ERROR");
				map.put("message", "오류입니다.");
				System.out.println("게시판 등록 오류 발생 :: " + e.toString());
		      }
		  
		  return map;
	}
	
	
	@Override
	public void delete(int board_idx) {
		boardmapper.delete(board_idx);
	}
	@Override
	public int delete_select_com(ArrayList<String> board_idx) {
		// TODO Auto-generated method stub
		return boardmapper.delete_select_com(board_idx);
	}
	@Override
	public int idx(CompanyVO companyvo) {
		// TODO Auto-generated method stub
		return boardmapper.idx(companyvo);
	}
	
	public Map<String,Object> board_list(CompanyVO companyvo) throws Exception {
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		
		int totalCount = boardmapper.totalCount(companyvo);
		List<CompanyVO> com_list = boardmapper.board_list(companyvo);
		List<CompanyVO> pro_list = boardmapper.board_list(companyvo);
		List<CompanyVO> ranklist=boardmapper.ranklist(companyvo);
		if(companyvo.getKeyword()=="" || companyvo.getKeyword()==null )
		{
			System.out.println("공백입니다");
		}
		else{
			boardmapper.boardrank(companyvo);
		}
		
		PageMaker pageMaker=new PageMaker();
		pageMaker.setCri(companyvo);
		if(totalCount==0)
		{	
			pageMaker.setCri(companyvo);
			pageMaker.setTotalCount(totalCount);
			pageMaker.setTotBlock(totalCount);
			
		}else if(totalCount>0){
			pageMaker.setCri(companyvo);
			pageMaker.setTotalCount(totalCount);
			pageMaker.setTotBlock(totalCount);
		}
		
		map.put("ranklist", ranklist);
		map.put("pageMaker",pageMaker);	
		map.put("totalCount",totalCount);
		map.put("com_list",com_list);
		map.put("pro_list",pro_list);
		
		return  map;
		
	}
	
	
	
	
}
