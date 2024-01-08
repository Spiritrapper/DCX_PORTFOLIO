package com.smhrd.bigdata.mapper;

import java.util.List;

import com.smhrd.bigdata.entity.Disease;

public interface DiseaseMapper {
	

	public List<Disease> search_disease(String dis_part, String dis_symptom);

}