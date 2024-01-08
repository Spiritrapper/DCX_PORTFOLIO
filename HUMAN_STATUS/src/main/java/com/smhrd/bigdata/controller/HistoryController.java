package com.smhrd.bigdata.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smhrd.bigdata.entity.History;
import com.smhrd.bigdata.mapper.HistoryMapper;

@Controller
public class HistoryController {

	@Autowired
	HistoryMapper mapper;

	@GetMapping("/history")
	public String history(String id, String st, HttpSession session) {

		List<History> list1 = mapper.search_history(id);
		session.setAttribute("list1", list1);
		System.out.println(list1.size());

		List<History> list2 = mapper.search_history2(st);
		session.setAttribute("list2", list2);
		System.out.println(list2.size());

		return "history";
	}
}
