package com.smhrd.bigdata.mapper;

import java.util.List;

import com.smhrd.bigdata.entity.History;

public interface HistoryMapper {
	

	public List<History> search_history(String id);
	
	public List<History> search_history2(String st);

}