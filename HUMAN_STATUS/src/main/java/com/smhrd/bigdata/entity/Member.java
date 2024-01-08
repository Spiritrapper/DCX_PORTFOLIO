package com.smhrd.bigdata.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class Member {
	
	private String id;
	private String pw;
	private String email;
	private String birthdate;
	private String job;
	
	
	
}