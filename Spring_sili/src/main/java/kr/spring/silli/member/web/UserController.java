package kr.spring.silli.member.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.spring.silli.member.service.UserService;
import kr.spring.silli.member.vo.UserVO;

@Controller
public class UserController {
	
	@Resource
	private UserService userservice;
	
	
	@GetMapping("/loginForm.do")
	public String loginForm() throws Exception {

		return "user/login";
	}
	
	
	@GetMapping("logout.do")
	@ResponseBody
	public String memLogout(HttpSession session) {
		session.invalidate();
		return "";
	}
	
	@RequestMapping("/login.do")
	@ResponseBody
	public Map<String, Object> login(UserVO m,HttpSession session) {
		
		return userservice.memLogin(m,session);
	}
	
	@GetMapping("checkUserIdExist")
	@ResponseBody
	public int checkUserIdExist(@RequestParam("user_id") String user_id){
		int chk=userservice.checkuserIdExist(user_id);
		return chk;
	}
	
	
	@GetMapping("joinForm.do")
	public String joinForm() {
		
		return "user/join";
	}
	
	@RequestMapping("join.do")
	@ResponseBody
	public Map<Object, Object> join(String user_id,UserVO uservo) {
		return userservice.join(uservo,user_id);
	}
}
