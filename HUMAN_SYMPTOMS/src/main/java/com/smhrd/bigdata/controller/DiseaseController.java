package com.smhrd.bigdata.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smhrd.bigdata.entity.Disease;
import com.smhrd.bigdata.mapper.DiseaseMapper;

@Controller
public class DiseaseController {
	
	@Autowired
	DiseaseMapper mapper;
	
	@GetMapping("/disease")
	public String disease(@RequestParam("dis_part") String dis_part, @RequestParam("dis_symptom") String dis_symptom, HttpSession session) {
	   
		List<Disease> list = mapper.search_disease(dis_part, dis_symptom);
		session.setAttribute("list", list);
		System.out.println(list.size());
		return "disease";
	}

}