package com.smhrd.bigdata.entity;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recommend {
	
	private int reco_idx;
	private int board_idx;
	private String id;
	private String created_at;

}