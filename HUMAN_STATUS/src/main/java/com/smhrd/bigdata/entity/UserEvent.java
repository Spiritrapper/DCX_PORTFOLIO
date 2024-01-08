package com.smhrd.bigdata.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.time.LocalDate;


@Data
@NoArgsConstructor
@AllArgsConstructor
public class UserEvent {

	private int student ;
	private int yawning_count;
	private int stretching_count;
	private LocalDate  DATE;

	// 잠카운트 계산을 위한 테이블 컬럼명
    private int id;
    private String timestamp;
    private int st1;
    private int st2;
    private int st3;
    private int st4;
    private String timestamp2;
    
    private int total;
}
