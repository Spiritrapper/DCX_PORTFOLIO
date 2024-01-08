package com.smhrd.bigdata.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.smhrd.bigdata.entity.UserEvent;
import com.smhrd.bigdata.mapper.UserEventMapper;

@RestController
public class UserEventController {
	
	@Autowired
	UserEventMapper mapper;
	
    @GetMapping("/bigdata/vcon")
    public ResponseEntity<List<UserEvent>> getAllUserEvents() {
    	List<UserEvent> events = mapper.getAllUserEvents();
        return ResponseEntity.ok(events);
        
    }
    
	@GetMapping("/bigdata/vcon1")
	public ResponseEntity<Integer> getAllNumber() {
		int numsber = mapper.getAllNumber();
	    return ResponseEntity.ok(numsber);
	}
	
    @GetMapping("/bigdata/vcon2")
    public ResponseEntity<List<UserEvent>> getAllUserEvents1() {
    	List<UserEvent> events1 = mapper.getAllUserEvents1();
        return ResponseEntity.ok(events1);
        
    }

//    @GetMapping("/events/stream")
//    public Flux<ServerSentEvent<UserEvent>> streamEvents() {
//        return mapper.getEventStream();
//    }
}
