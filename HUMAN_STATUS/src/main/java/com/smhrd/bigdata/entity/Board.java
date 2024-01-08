package com.smhrd.bigdata.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime; // 추가

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Data
@Table(name = "t_board")
public class Board {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private long board_idx;
	private String board_title;
	private String board_content;
	private LocalDateTime created_at; // 수정
	private int board_views;
	private String id;
	private int board_comments;

	// 추가: 게시글 작성 시 사용할 생성자
	public Board(String board_title, String board_content, String id) {
		this.board_title = board_title;
		this.board_content = board_content;
		this.id = id;
		this.created_at = LocalDateTime.now();
		// 생성자에 필요한 필드들을 초기화합니다.
	}
	// 생성자에 필요한 필드들을 초기화합니다.
}

// 추가: getter 및 setter 메서드들
