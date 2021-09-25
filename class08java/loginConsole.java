package com.ddit401.Bus_login.Console;

import java.util.Scanner;

import org.springframework.dao.EmptyResultDataAccessException;

public class loginConsole {
	public static void main(String[] args) {
//-------------------------------------------------------------------------------------	
//import및 변수
		Scanner scn = new Scanner(System.in);
		MemberController ck = MemberController.getInstance();
		MemberController menu = MemberController.getInstance();
		MemberVO memberVo = new MemberVO();
//-------------------------------------------------------------------------------------			
//입력		
		System.out.print("─────────१✌˚◡˚✌५─────────१✌˚◡˚✌५─────────"+"\n");
	
		boolean logintry = true;
		
		while (logintry) {
			
			System.out.print("아이디를 입력하세요: ");
			String id = scn.next();
			
			System.out.print("비밀번호를 입력하세요: ");
			String pw = scn.next();
			
			memberVo.setId(id);
			memberVo.setPwd(pw);
//--------------------------------------------------------------------------------------
//출력
			try {
				//성공
				MemberVO result = ck.login(memberVo);
				if(result.getId()==null) {
					System.out.println("로그인 실패입니다.");
					System.out.println("아이디와 비밀번호를 확인하세요.");
				}else {
					System.out.println("로그인 성공 >.<");
					//while문 종료
					logintry = false;
					System.out.println("─────────१✌˚◡˚✌५─────────१✌˚◡˚✌५─────────");
				}
				
			} catch (EmptyResultDataAccessException e) {
				System.out.println("로그인 실패입니다.");
				System.out.println("아이디와 비밀번호를 확인하세요.");
			} 
		}//while end
		
		boolean userMenuResult = true;
		exit:       
		while (userMenuResult) {
			
			System.out.println("1.회원가입, 2.로그인취소");
			System.out.print("메뉴를 선택하세요: ");
			String userMenu = scn.next();
			System.out.print("\n");
			memberVo.setInputNoticeMenu(Integer.parseInt(userMenu));
			
			switch (menu.inputNoticeMenu(memberVo)) {
			case 1: //회원가입
				System.out.println("회원가입으로 이동합니다.");
				break;
			case 2: //로그인취소
				System.out.println("로그인을 취소하셨습니다.");
				userMenuResult = false;
				break exit;
			default: // 안내 
				System.out.println("<<사용방법>> 1~2번만 선택할 수 있습니다.");
				break;
			}
		}
	}
}	
