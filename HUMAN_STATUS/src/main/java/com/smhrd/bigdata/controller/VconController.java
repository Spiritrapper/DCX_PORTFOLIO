package com.smhrd.bigdata.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataIntegrityViolationException;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;


import com.smhrd.bigdata.entity.Vcon;
import com.smhrd.bigdata.mapper.VconMapper;

@Controller
public class VconController {

   @Autowired
   VconMapper mapper;

   @GetMapping("/vcon")
   public String vcon(String id, String st, HttpSession session) {

      List<Vcon> list3 = mapper.search_vcon(id);
      session.setAttribute("list3", list3);
      System.out.println(list3.size());
      
	  List<Vcon> list4 = mapper.search_vcon2(st);
	  session.setAttribute("list4", list4);
	  System.out.println(list4.size());     
	  
	  return "vcon";
   }
   
// 여기부터 새로 추가
   @PostMapping("/vcon/input")
   public String input(@ModelAttribute Vcon vcon) {

      try {
         mapper.input(vcon); // 입력한 이름 정보를를 Tester2_2 테이블에 삽입
         
         System.out.println("이름기입 성공");
         return "redirect:/vcon";
      } catch(DataIntegrityViolationException e) { // MySQL WorkBench에서는 PrimaryKey가 중복되어 테이블에 데이터를 삽입할 수 없으면 에러가 떠서 예외처리를 하였음
         System.out.println("이름기입 실패");
         return "redirect:/vcon"; // 
      }
      
   }
}

