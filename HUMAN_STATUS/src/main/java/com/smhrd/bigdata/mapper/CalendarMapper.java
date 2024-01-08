package com.smhrd.bigdata.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.smhrd.bigdata.entity.Calendar;
import com.smhrd.bigdata.entity.Member;

@Mapper
public interface CalendarMapper {
	
    List<Calendar> findAll();
    void saveEvent(Calendar event); // 이벤트 저장
    void updateEvent(Calendar event); // 이벤트 업데이트
    Calendar findById(Member currentMember); // 이벤트 ID로 Calendar 찾기
    void deleteEvent(String id); // 이벤트 삭제 
    // 사용자 ID로 이벤트 조회
 
    // 사용자 ID를 기반으로 이벤트를 조회하는 메소드
    List<Calendar> findEventsByUserId(String id);
   
}
