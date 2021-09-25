package com.ddit401.Bus_login.Console;

import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;


public class MemberDao {
	private static MemberDao instance = new MemberDao();
	public static MemberDao getInstance() {
		return instance;
	}
	private MemberDao() {}
	
	private JdbcTemplate template = DBApplication.getTemplate();
	
	public MemberVO login(MemberVO vo) {
		return template.queryForObject("SELECT * FROM MEMBER WHERE ID=? AND PW=?"
				, new BeanPropertyRowMapper<>(MemberVO.class)
				,vo.getId()
				,vo.getPwd());
	}
	public int inputNoticeMenu(MemberVO vo) {
		return vo.getInputNoticeMenu();
	}
}
