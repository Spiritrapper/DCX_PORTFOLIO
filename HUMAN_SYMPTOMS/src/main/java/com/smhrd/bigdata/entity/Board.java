package com.smhrd.bigdata.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name="t_board")
public class Board {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long board_idx;
	private String board_title;
	private String board_content;
	private String created_at;
	private int board_views;
	private String id;
	private String dis_part;
	private int board_recommends;
	private int board_comments;
	private int id_level;
	
}