package kr.spring.silli.member.service;


import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import kr.spring.silli.member.mapper.UserMapper;
import kr.spring.silli.member.vo.UserVO;


@Service
public class UserServiceImpl implements UserService {
	
	@Resource
	private UserMapper usermapper;
	
	@Override
	public int checkuserIdExist(String user_id) {
		int chk=usermapper.checkuserIdExist(user_id);
		return chk;
	}	
	
	@Override
	public Map<Object, Object> join(UserVO uservo,String user_id) {
		
		Map<Object,Object> map = new HashMap<Object, Object>();

		int nResult = usermapper.write(uservo);
		if(nResult == 1) {
			map.put("success","등록성공");
			
		}
		else {
			map.put("chk", "ERROR");
			map.put("message","사용자가 존재합니다");
		}
		
		return map;
	}

	@Override
	public Map<String,Object> memLogin(UserVO m,HttpSession session) {
		Map<String,Object> map = new HashMap<String, Object>();
		UserVO mvo=usermapper.memLogin(m);
		if(mvo==null)
		{
			map.put("chk","overlap");
		}
		else {
			if(m.getUser_id()==null || m.getUser_id().equals("") || m.getUser_pw()==null || m.getUser_pw().equals(""))
			{
			
			 map.put("chk","ERROR");
			 map.put("message","공백입니다");
			 		 
			} else {
					map.put("ok", "로그인 성공");
					session.setAttribute("user_id",mvo.getUser_id());
			}
		}
		return map;
	}
	
}
