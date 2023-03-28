package kr.spring.silli.member.mapper;

import kr.spring.silli.member.vo.UserVO;

public interface UserMapper {
	public int checkuserIdExist(String user_id);
	public int write(UserVO uservo);
	public UserVO memLogin(UserVO m);
}
