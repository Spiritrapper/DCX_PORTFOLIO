package com.smhrd.bigdata.mapper;

import java.util.List;

import com.smhrd.bigdata.entity.Board;
import com.smhrd.bigdata.entity.Comment;
import com.smhrd.bigdata.entity.PagingVO;

public interface BoardMapper {
	
	public int write(Board board);

	public Board content(int idx);

	public List<Board> boardList();
	
	public int incrementViews(int idx);
	
	public int recommend(int idx, String memberId);
	
	public int recommendCheck(int idx, String memberId);
	
	public int recommendCancel(int idx, String memberId);
	
	public int recommendCount(long idx);
	
	public int updateRecommendCount(int idx);
	
	public int delete(int idx);
	
	public List<Board> search(int start, int end, String search, String dis_part);
	
	public List<Board> search_comments(int start, int end, String search, String dis_part);
	
	public List<Board> search_recommends(int start, int end, String search, String dis_part);
	
	public List<Board> search_views(int start, int end, String search, String dis_part);
	
	public int addComment(int idx, String comment, String memberId);
	
	public List<Comment> showComment(int idx);
	
	public int deleteComment(int idx);
	
	public int commentCount(int idx);
	
	public int updateCommentCount(int idx);

	// 게시물 총 갯수
	public int countBoard();

	public int countBoard2(String search, String dis_part);

	// 페이징 처리 게시글 조회
	public List<Board> selectBoard(PagingVO vo);
	
	public int updateExp(String memberId);
	
	public String selectBoardId(int idx);
	
	public int updateLevel(String id);
}