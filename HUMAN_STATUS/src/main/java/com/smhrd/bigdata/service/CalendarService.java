package com.smhrd.bigdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestBody;

import com.smhrd.bigdata.entity.Calendar;
import com.smhrd.bigdata.entity.Member;
import com.smhrd.bigdata.mapper.CalendarMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@Service
public class CalendarService {
    private final CalendarMapper calendarMapper;
    private final Logger logger = LoggerFactory.getLogger(CalendarService.class);

    @Autowired
    public CalendarService(CalendarMapper calendarMapper) {
        this.calendarMapper = calendarMapper;
    }

    public List<Calendar> findAll() {
        try {
            return calendarMapper.findAll();
        } catch (Exception e) {
            logger.error("Error during findAll", e);
            throw e;
        }
    }

    // 여러 이벤트를 저장하는 메서드
    @Transactional
    public void saveEvents(List<Calendar> events) {
        try {
            for (Calendar event : events) {
                calendarMapper.saveEvent(event);
            }
        } catch (Exception e) {
            logger.error("Error during saveEvents", e);
            throw e;
        }
    }

    @Transactional
    public void updateEvent(Calendar event) {
        try {
            calendarMapper.updateEvent(event);
        } catch (Exception e) {
            logger.error("Error during updateEvent", e);
            throw e;
        }
    }
    
    @Transactional
    public  List<Calendar>  findEventsByUserId(String id) {
    	return   calendarMapper.findEventsByUserId(id);
    }

    @Transactional
    public void deleteEvent(String id) {
        try {
            calendarMapper.deleteEvent(id);
        } catch (Exception e) {
            logger.error("Error during deleteEvent", e);
            throw e;
        }
    }
}