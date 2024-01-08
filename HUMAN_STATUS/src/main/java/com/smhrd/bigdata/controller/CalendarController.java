package com.smhrd.bigdata.controller;

import java.util.List;

import org.json.JSONObject;
import org.json.JSONArray;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.smhrd.bigdata.service.CalendarService;

import com.smhrd.bigdata.entity.Calendar; // 예시 Entity, 필요에 맞게 변경
import com.smhrd.bigdata.entity.Comment;
import com.smhrd.bigdata.entity.Member;
import com.smhrd.bigdata.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

import java.io.IOException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

@RestController

@RequestMapping("/history")
public class CalendarController {

	@Autowired
	private CalendarService calendarService;
	@Autowired
	private MemberMapper memberMapper;

	// 모든 캘린더 이벤트 조회
	@GetMapping("/calendar1")
	public ResponseEntity<List<Calendar>> getAllCalendarEvents(HttpSession session) {
		 
		 Member currentMember = (Member) session.getAttribute("loginMember");
	        if (currentMember == null) {
	            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(null);
	        }
	        List<Calendar> events = calendarService.findEventsByUserId(currentMember.getId());
	        session.setAttribute("events", events);
	
	        return ResponseEntity.ok(events);
	}
	// 캘린더 이벤트 추가 또는 업데이트
	
    @PostMapping("/saveEvent") 
    public ResponseEntity<String> addNewCalendarEvents(@RequestBody List<Calendar> events, HttpSession session) { 
    	
    	Member currentMember = (Member) session.getAttribute("loginMember"); 
    	System.out.println(events);
    	System.out.println(session);

    	if (currentMember == null) { 
    		
    		return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("사용자 로그인 필요"); 
    		}
 
    	for (Calendar event : events) { 
    		event.setId(currentMember.getId()); 
    	}
    		calendarService.saveEvents(events);
 
    	return ResponseEntity.ok("Events successfully added."); 
    	
    }
  
	/*
	 * @GetMapping("/bigdata/vcon1") public ResponseEntity<Integer> getAllNumber() {
	 * int numsber = mapper.getAllNumber(); return ResponseEntity.ok(numsber); }
	 */
	
	/*
	 * @PostMapping("/saveEvent") public ResponseEntity<String>
	 * addNewCalendarEvents(@RequestBody List<Calendar> events) { // Logic to handle
	 * the saving of events return ResponseEntity.ok("Events successfully added.");
	 * }
	 */
	@PutMapping("/updateEvent")
	public ResponseEntity<String> updateCalendarEvent(@PathVariable String id, @RequestBody Calendar event) {
		Calendar existingEvent = (Calendar) calendarService.findEventsByUserId(id);
		if (existingEvent == null) {
			return ResponseEntity.notFound().build();
		}
		calendarService.updateEvent(event);
		return ResponseEntity.ok("이벤트가 성공적으로 업데이트되었습니다.");
	}

	@DeleteMapping("/deleteEvent")
	public ResponseEntity<String> deleteCalendarEvent(@PathVariable String id) {
		Calendar existingEvent = (Calendar) calendarService.findEventsByUserId(id);
		if (existingEvent == null) {
			return ResponseEntity.notFound().build();
		}
		calendarService.deleteEvent(id);
		return ResponseEntity.ok("이벤트가 성공적으로 삭제되었습니다.");
	}

	/*
	 * @PostMapping("/newEvent") public ResponseEntity<String>
	 * addNewCalendarEvent(@RequestBody Calendar newEvent) { // 사용자 이름으로 사용자 정보 조회
	 * Member member = memberMapper.findByName(newEvent.getTitle()); if (member ==
	 * null) { // 새로운 사용자 생성 member = new Member();
	 * member.setId(newEvent.getTitle()); memberMapper.saveUser(member); }
	 * 
	 * // 캘린더 이벤트 저장 calendarService.saveEvent(newEvent); return
	 * ResponseEntity.ok("새 이벤트가 성공적으로 추가되었습니다."); }
	 */

}
