package com.smhrd.bigdata.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.smhrd.bigdata.entity.Board;
import com.smhrd.bigdata.entity.Comment;
import com.smhrd.bigdata.entity.PagingVO;

public interface BoardMapper {

   public int write(Board board);

   public Board content(int idx);

   public List<Board> boardList();

   public int incrementViews(int idx);

   public int delete(int idx);

   public List<Board> search(int start, int end, String search, String dis_part);

   public List<Board> search_comments(int start, int end, String search, String dis_part);

   public List<Board> search_views(int start, int end, String search, String dis_part);

   void addComment(@Param("commentId") Long commentId, @Param("boardIdx") int boardIdx,
         @Param("commentContent") String commentContent, @Param("userId") String userId);

   public List<Comment> showComment(int idx);

   public int deleteComment(int idx);

   public int commentCount(int idx);

   public int updateCommentCount(int idx);

   // 게시물 총 갯수
   public int countBoard();

   public int countBoard2(String search);

   public int countBoard2(String search, String dis_part);

   // 페이징 처리 게시글 조회
   public List<Board> selectBoard(PagingVO vo);

   public String selectBoardId(int idx);

}