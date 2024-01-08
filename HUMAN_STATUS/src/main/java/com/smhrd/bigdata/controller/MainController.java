package com.smhrd.bigdata.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class MainController {
		
	@GetMapping("/login")
	public String login() {
		
		return "login";
		
	}
	
	@GetMapping("/")
	public String body(HttpSession session) {
		
		return "main";
		
	}
	
	   @GetMapping("/event")
	   public String event(HttpSession session) {
	      
	      return "event";
	   
	}
	
	// history 페이지로 들어가는 부분
	/*
	 * @GetMapping("/history") public String history(HttpSession session) {
	 * 
	 * return "history"; }
	 */
	/*
	 * // vcon 페이지로 들어가는 부분
	 * 
	 * @GetMapping("/vcon") public String vcon(HttpSession session) {
	 * 
	 * return "vcon"; }
	 */
}