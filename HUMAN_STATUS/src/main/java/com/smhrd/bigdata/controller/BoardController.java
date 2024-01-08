package com.smhrd.bigdata.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.smhrd.bigdata.entity.Board;
import com.smhrd.bigdata.entity.Comment;
import com.smhrd.bigdata.entity.Member;
import com.smhrd.bigdata.entity.PagingVO;
import com.smhrd.bigdata.mapper.BoardMapper;
import com.smhrd.bigdata.service.BoardService;

@Controller
public class BoardController {

   @Autowired
   BoardMapper mapper;

   @Autowired
   private BoardService boardService;

   // 게시판 페이지 1
   // 게시글 목록이 보임
   @GetMapping("/board")
   public String boardList(PagingVO vo, Model model, @RequestParam(value = "nowPage", required = false) String nowPage,
         @RequestParam(value = "cntPerPage", required = false) String cntPerPage) {
      try {
         int total = boardService.countBoard();
         if (nowPage == null && cntPerPage == null) {
            nowPage = "1";
            cntPerPage = "10";
         } else if (nowPage == null) {
            nowPage = "1";
         } else if (cntPerPage == null) {
            cntPerPage = "10";
         }

         vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
         List<Board> boardList = boardService.selectBoard(vo);

         // boardList를 로그로 출력
         boardList.forEach(board -> System.out.println(board));

         model.addAttribute("paging", vo);
         model.addAttribute("list", boardList);
         return "board";
      } catch (Exception e) {
         // 예외 처리 로직 추가
         e.printStackTrace();
         return "error";
      }
   }

   // 게시글 작성 페이지 2
   // 게시판 페이지에서 작성 버튼을 누르면 게시글 작성 페이지에서 게시글을 작성할 수 있음
   @GetMapping("/boardform")
   public String boardform() {
      return "boardform";
   }

   @PostMapping("/boardform")
   public String postBoardForm(@ModelAttribute Board board, RedirectAttributes redirectAttributes,
         HttpSession session) {
      try {
         // 로그인된 회원 정보 가져오기
         Member member = (Member) session.getAttribute("loginMember");
         if (member != null) {
            String memberId = member.getId();
            board.setId(memberId); // 작성자 ID 설정
         }
         boardService.write(board);
         redirectAttributes.addFlashAttribute("message", "게시글이 성공적으로 등록되었습니다.");
      } catch (Exception e) {
         // 에러가 발생했을 경우
         redirectAttributes.addFlashAttribute("error", "게시글 등록 중 오류가 발생했습니다.");
         e.printStackTrace(); // 에러 로그 출력
      }
      return "redirect:/board";
   }

   // 게시글 작성
   // 게시글 작성 페이지에서 작성 버튼을 누르면 게시판 페이지로 이동
   // 게시글 작성
   @PostMapping("/writeBoard")
   public String write(@ModelAttribute Board board, HttpSession session) {
      Member member = (Member) session.getAttribute("loginMember");
      if (member != null) {
         String memberId = member.getId();
         board.setId(memberId); // 작성자 ID 설정
         System.out.println("User ID set to Board: " + board.getId());
         mapper.write(board);
         System.out.println("Board after write: " + board);
         return "redirect:/board";
      } else {
         // 로그인되지 않은 사용자에게 처리할 부분
         return "redirect:/login"; // 로그인 페이지로 리다이렉트 또는 다른 처리
      }
   }

   @PostMapping("/submitBoard")
   public String submitBoard(@ModelAttribute Board board, RedirectAttributes redirectAttributes) {
      boardService.save(board);
      redirectAttributes.addFlashAttribute("message", "게시글이 성공적으로 저장되었습니다.");
      return "redirect:/boardList";
   }

   // 게시글 상세 페이지 22
   // 게시판 페이지에서 글 제목을 누르면 게시글 상세 페이지로 이동
   @GetMapping("/board/{board_idx}")
   public String content(@PathVariable("board_idx") int idx, Model model, HttpSession session) throws IOException {
      // 게시글 정보를 가져와 모델에 추가
      Board board = mapper.content(idx);
      if (board != null) {
         model.addAttribute("board", board);
         mapper.incrementViews(idx);

         Member member = (Member) session.getAttribute("loginMember");
         if (member != null) {
            String memberId = member.getId();
            // 게시글의 댓글 정보를 가져와 모델에 추가
            List<Comment> commentList = mapper.showComment(idx);

            // 로그를 통해 commentList 내용 확인
            System.out.println("Comment List: " + commentList);

            model.addAttribute("commentList", commentList);
         }

         return "boardcontent"; // 게시글 내용을 보여주는 뷰로 이동
      } else {
         // 존재하지 않는 게시글에 대한 처리
         return "redirect:/error"; // 예: 404 페이지로 리다이렉트 또는 에러 페이지로 이동
      }
   }

   // 게시글 삭제
   @GetMapping("/board/content/{board_idx}/delete")
   public String delete(@PathVariable("board_idx") int idx, Model model, HttpSession session) throws IOException {
      mapper.delete(idx);
      Member member = (Member) session.getAttribute("loginMember");
      String memberId = member.getId();
      return "redirect:/board";
   }

   // 게시글 조회
   @GetMapping("/search")
   public String search(@RequestParam("search") String search, @RequestParam("sort") String sort,
         @RequestParam(value = "nowPage", required = false) String nowPage,
         @RequestParam(value = "cntPerPage", required = false) String cntPerPage, Model model, HttpSession session)
         throws IOException {

      int total = mapper.countBoard2(search);
      if (nowPage == null && cntPerPage == null) {
         nowPage = "1";
         cntPerPage = "10";
      } else if (nowPage == null) {
         nowPage = "1";
      } else if (cntPerPage == null) {
         cntPerPage = "10";
      }
      System.out.println(total);
      PagingVO vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
      int start = vo.getStartPage();
      int end = vo.getEndPage();
      String dis_part = "1";
      List<Board> list = mapper.search(start, end, search, dis_part);
      model.addAttribute("paging", vo);
      model.addAttribute("list", list);
      model.addAttribute("search", search);
      model.addAttribute("sort", sort);
      Member member = (Member) session.getAttribute("loginMember");
      String memberId = member.getId();
      model.addAttribute("memberId", memberId);
      return "board";
   }

   // 댓글 작성
   @PostMapping("/board/{board_idx}/addComment")
   public String addComment(@PathVariable("board_idx") Integer boardIdx,
         @RequestParam(name = "cmt_content", required = true) String commentContent,
         HttpSession session) {
      try {
         Member member = (Member) session.getAttribute("loginMember");
         if (member != null) {
            String memberId = member.getId();
            boardService.addComment(boardIdx, commentContent, memberId);
            // 실제 게시판 인덱스 값을 사용하여 리다이렉트
            return "redirect:/board/" + boardIdx;
         } else {
            return "redirect:/login";
         }
      } catch (Exception e) {
         // 예외를 더 세밀하게 처리하거나(예: 로깅), 사용자에게 보여줄 에러 페이지로 리다이렉트
         e.printStackTrace();
         return "error";
      }
   }

   // 댓글 삭제
   @GetMapping("/board/{board_idx}/{cmt_idx}/deleteComment")
   public String deleteComment(@PathVariable("cmt_idx") int idx, @PathVariable("board_idx") int board_idx, Model model,
         HttpSession session) throws IOException {
      Member member = (Member) session.getAttribute("loginMember");
      String memberId = member.getId();
      mapper.deleteComment(idx);
      mapper.updateCommentCount(board_idx);

      List<Comment> commentList = mapper.showComment(idx);
      model.addAttribute(commentList);
      return "redirect:/board/content/{board_idx}";
   }
}
