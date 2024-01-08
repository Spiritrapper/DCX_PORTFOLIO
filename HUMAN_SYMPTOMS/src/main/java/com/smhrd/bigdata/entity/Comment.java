package com.smhrd.bigdata.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Comment {
	
	private int cmt_idx;
	private int board_idx;
	private String cmt_content;
	private String created_at;
	private String id;

}