package kr.spring.silli.member.service;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import kr.spring.silli.member.vo.UserVO;

@Service
public interface UserService {
	public int checkuserIdExist(String user_id);	
	
	public  Map<Object,Object>  join(UserVO uservo,String user_id);
	
	public Map<String,Object> memLogin(UserVO uservo,HttpSession session);
	
}
