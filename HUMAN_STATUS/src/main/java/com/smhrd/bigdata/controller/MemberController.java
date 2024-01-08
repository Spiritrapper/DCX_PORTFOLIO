package com.smhrd.bigdata.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.smhrd.bigdata.entity.Member;
import com.smhrd.bigdata.mapper.MemberMapper;

@Controller
public class MemberController {
	
	@Autowired
	MemberMapper mapper;
	
	@PostMapping("/member/login")
	public String login(Member member, HttpSession session) {

		Member result = mapper.login(member); // 입력한 회원 정보로 로그인을 시도하여 그 결과를 result에 할당
		
		if(result == null) { // t_uesr에 입력한 회원 정보가 없어 로그인에 실패
			System.out.println("로그인 실패");
			return "redirect:/login"; // 로그인 페이지로 다시 이동
		} else {
			session.setAttribute("loginMember", result); // 세션에 로그인한 계정의 정보를 저장, 해당 정보는 session.invalidate()나 브라우저를 종료하기 전까지 유효함
			Member loginMember = (Member)session.getAttribute("loginMember"); // boardcontent.jsp에서 로그인한 사용자 정보를 사용해야 함
			String memberId = loginMember.getId(); // 로그인한 사용자의 Id를 memberId에 할당
							
			session.setAttribute("memberId",memberId); // memberId를 Model 객체에 저장하여 board.jsp로 넘김으로 사용 가능
			System.out.println("로그인 성공");
			
			return "redirect:/";
		}
		
	}
	
	@PostMapping("/member/join")
	public String join(@ModelAttribute Member member) {

		try {
			mapper.join(member); // 입력한 회원 정보를 t_user 테이블에 삽입
			
			System.out.println("회원가입 성공");
			return "redirect:/login";
		} catch(DataIntegrityViolationException e) { // MySQL WorkBench에서는 PrimaryKey가 중복되어 t_user 테이블에 데이터를 삽입할 수 없으면 에러가 떠서 예외처리를 하였음
			System.out.println("회원가입 실패");
			return "redirect:/login"; // 회원가입에 실패하면 다시 회원가입 페이지로 이동
		}
		
	}
	
	@GetMapping("/member/logout")
	public String logout(HttpSession session) {

		session.invalidate(); // 세션에 저장된 정보를 날림(세션에 로그인한 계정 정보를 날림으로 로그아웃)
		
		return "redirect:/";
		
	}

}