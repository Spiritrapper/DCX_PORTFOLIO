package com.smhrd.bigdata.service;

import com.smhrd.bigdata.entity.Board;
import com.smhrd.bigdata.entity.Comment;
import com.smhrd.bigdata.entity.PagingVO;
import com.smhrd.bigdata.mapper.BoardMapper;
import com.smhrd.bigdata.repository.BoardRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardService {

    @Autowired
    private BoardMapper boardMapper;
    @Autowired
    private BoardRepository boardRepository;

    public int countBoard() {
        return boardMapper.countBoard();
    }

    public void save(Board board) {
        boardRepository.save(board);
    }

    public List<Board> selectBoard(PagingVO vo) {
        return boardMapper.selectBoard(vo);
    }

    public void write(Board b) {
        boardMapper.write(b);
    }

    public Board content(int idx) {
        return boardMapper.content(idx);
    }

    public void incrementViews(int idx) {
        boardMapper.incrementViews(idx);
    }

    public List<Comment> showComment(int idx) {
        return boardMapper.showComment(idx);
    }

    public void delete(int idx, String memberId) {
        boardMapper.delete(idx);

    }

    public List<Board> search(String search, String dis_part, String sort, int start, int end) {
        List<Board> list;

        if (sort.equals("board_comments")) {
            list = boardMapper.search_comments(start, end, search, dis_part);
        } else if (sort.equals("board_views")) {
            list = boardMapper.search_views(start, end, search, dis_part);
        } else {
            list = boardMapper.search(start, end, search, dis_part);
        }

        return list;
    }

    public void addComment(int board_idx, String comment, String memberId) {
        Long commentId = null;
        String commentContent = comment;
        String userId = memberId;

        boardMapper.addComment(commentId, board_idx, commentContent, userId);
        boardMapper.updateCommentCount(board_idx);
        String id = boardMapper.selectBoardId(board_idx);
    }

    public void deleteComment(int idx, String memberId, int board_idx) {
        boardMapper.deleteComment(idx);
        boardMapper.updateCommentCount(board_idx);
        String id = boardMapper.selectBoardId(idx);

    }
}
