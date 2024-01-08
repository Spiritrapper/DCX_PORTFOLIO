package com.smhrd.bigdata.mapper;

import java.util.List;

import com.smhrd.bigdata.entity.UserEvent;

public interface UserEventMapper {

	List<UserEvent> getAllUserEvents();
	
	int getAllNumber(); 
	int getAllNumber1();
	
	List<UserEvent> getAllUserEvents1();

}
