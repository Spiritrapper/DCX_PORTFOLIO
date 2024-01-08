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
	private char gender;
	private String birthdate;
	private int exp;
	
}