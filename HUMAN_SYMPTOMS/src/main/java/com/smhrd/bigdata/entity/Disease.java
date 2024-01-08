package com.smhrd.bigdata.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@AllArgsConstructor
@Data
@NoArgsConstructor
public class Disease {
	

    private int dis_idx;

    // 질병 부위 

    private String dis_part;

    // 질병 명 

    private String dis_name;

    // 질병 증상 

    private String dis_symptom;

    // 치료 식단 

    private String dis_diet;
    
    private String dis_diet_img;
    
    private String dis_part_img;
    
    private String dis_detail1;
    
    private String dis_detail_content1;
    
    private String dis_detail2;
    
    private String dis_detail_content2;
    
    private String dis_detail3;
    
    private String dis_detail_content3;
    
    private String dis_exercise_link;

}