package com.smhrd.bigdata.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.smhrd.bigdata.entity.Board;
import com.smhrd.bigdata.entity.Comment;
import com.smhrd.bigdata.entity.Member;
import com.smhrd.bigdata.entity.PagingVO;
import com.smhrd.bigdata.mapper.BoardMapper;
import com.smhrd.bigdata.mapper.MemberMapper;

@Controller
public class BoardController {
	
	@Autowired
	BoardMapper mapper;
	
	// 게시판 페이지
	// 게시글 목록이 보임
	@GetMapping("board")
	public String boardList(PagingVO vo, Model model
			, @RequestParam(value="nowPage", required=false) String nowPage
			, @RequestParam(value="cntPerPage", required=false) String cntPerPage) {
		
		int total = mapper.countBoard();
		if (nowPage == null && cntPerPage == null) {
			nowPage = "1";
			cntPerPage = "10";
		} else if (nowPage == null) {
			nowPage = "1";
		} else if (cntPerPage == null) { 
			cntPerPage = "10";
		}
		System.out.println(total);
		vo = new PagingVO(total, Integer.parseInt(nowPage), Integer.parseInt(cntPerPage));
		model.addAttribute("paging", vo);
		model.addAttribute("list", mapper.selectBoard(vo));
		return "board";
	}
	
	// 게시글 작성 페이지
	// 게시판 페이지에서 작성 버튼을 누르면 게시글 작성 페이지에서 게시글을 작성할 수 있음
	@GetMapping("/boardform")
	public String boardform() {
		
		return "boardform";
		
	}
	
	// 게시글 작성
	// 게시글 작성 페이지에서 작성 버튼을 누르면 게시판 페이지로 이동
	@PostMapping("/board/write")
	public String write(Board b, HttpSession session) {
		
		mapper.write(b); // 게시글 작성 페이지에서 작성한 데이터들을 t_board 테이블에 삽입
		
		Member member = (Member)session.getAttribute("loginMember");
		String memberId = member.getId();
		mapper.updateLevel(memberId); // t_board 테이블에 해당 게시글 작성자의 레벨을 갱신
		
		return "redirect:/board"; // 작성 후 다시 게시판 페이지로 이동
		
	}
	
	// 게시글 상세 페이지
	// 게시판 페이지에서 글 제목을 누르면 게시글 상세 페이지로 이동
	@GetMapping("/board/content/{board_idx}")
	public String content(@PathVariable("board_idx") int idx, Model model, HttpSession session) throws IOException {
		
		Board board = mapper.content(idx); // 해당 게시글 번호로 게시글 정보를 가져옴
		
		model.addAttribute("board",board); // 게시글 상세 페이지에 나타내기 위해 Model 객체에 저장
		
		mapper.incrementViews(idx); // 게시글 상세 페이지를 누르면 해당 게시글의 조회수가 1 올라감
		
		Member member = (Member)session.getAttribute("loginMember"); // boardcontent.jsp에서 로그인한 사용자 정보를 사용해야 함
		String memberId = member.getId(); // 로그인한 사용자의 Id를 memberId에 할당
		
		int check = mapper.recommendCheck(idx, memberId); // 로그인한 사용자가 해당 게시글을 추천했는지 여부를 check에 할당(추천했으면 1, 안했으면 0 반환)
		
		model.addAttribute("check",check); // 1 또는 0을 boardcontent에 넘겨서 추천 여부에 따라 추천↑ 또는 추천↓ 버튼으로 바뀜
		
		int count = mapper.recommendCount(idx); // 게시글의 추천수도 count에 할당
		
		model.addAttribute("count",count); // 일단 count도 보냄
		
		List<Comment> commentList = mapper.showComment(idx); // 해당 게시글의 댓글을 가져와서 commentList에 할당
		
		model.addAttribute(commentList); // 해당 게시글의 댓글들을 boardcontent.jsp에 나타내기 위해 Model 객체에 저장
		
		return "boardcontent";
	}
	
	//게시글 추천
	@GetMapping("/board/content/{board_idx}/recommend")
	public String recommend(@PathVariable("board_idx") int idx, Model model, HttpSession session) throws IOException {
		
		Member member = (Member)session.getAttribute("loginMember");
		String memberId = member.getId();
		mapper.recommend(idx, memberId); // t_recommend 테이블에 게시글 번호와 세션에 저장된 Id를 삽입 
		mapper.updateRecommendCount(idx); // t_board 테이블에 해당 게시글의 추천수를 갱신
		mapper.updateExp(memberId); // t_user 테이블에 해당 사용자의 경험치를 갱신
		String id = mapper.selectBoardId(idx);
		System.out.println(id);
		mapper.updateLevel(id); // t_board 테이블에 해당 게시글 작성자의 레벨을 갱신
		
		return "redirect:/board/content/{board_idx}";
	}
	
	// 게시글 추천 취소
	@GetMapping("/board/content/{board_idx}/recommendCancel")
	public String recommendCancel(@PathVariable("board_idx") int idx, Model model, HttpSession session) throws IOException {
		
		Member member = (Member)session.getAttribute("loginMember");
		String memberId = member.getId();
		mapper.recommendCancel(idx, memberId); // t_recommend 테이블에 게시글 번호와 세션에 저장된 Id에 해당하는 행 삭제
		mapper.updateRecommendCount(idx); // t_board 테이블에 해당 게시글의 추천수를 갱신
		mapper.updateExp(memberId); // t_user 테이블에 해당 사용자의 경험치를 갱신
		String id = mapper.selectBoardId(idx);
		System.out.println(id);
		mapper.updateLevel(id); // t_board 테이블에 해당 게시글 작성자의 레벨을 갱신
		
		return "redirect:/board/content/{board_idx}";
	}
	
	// 게시글 삭제
	@GetMapping("/board/content/{board_idx}/delete")
	public String delete(@PathVariable("board_idx") int idx, Model model, HttpSession session) throws IOException {
		
		mapper.delete(idx); // t_board 테이블에서 삭제하려는 게시글의 게시글 번호로 삭제
		Member member = (Member)session.getAttribute("loginMember");
		String memberId = member.getId();
		mapper.updateExp(memberId); // t_user 테이블에 해당 사용자의 경험치를 갱신
		mapper.updateLevel(memberId); // t_board 테이블에 해당 게시글 작성자의 레벨을 갱신
		return "redirect:/board";
	}
	
	// 게시글 조회
	@GetMapping("/search")
	public String search(@RequestParam("search") String search, @RequestParam("dis_part") String dis_part, @RequestParam("sort") String sort, @RequestParam(value="nowPage", required=false)String nowPage
			, @RequestParam(value="cntPerPage", required=false)String cntPerPage, Model model, HttpSession session) throws IOException {

		int total = mapper.countBoard2(search, dis_part);
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
		List<Board> list; // 조회 결과를 저장할 Board 객체를 담을 List 생성
		int start = vo.getStart();
		int end = vo.getEnd();
		
		if(sort.equals("board_comments")) { // 정렬 기준이 댓글수일 때,
			list = mapper.search_comments(start, end, search, dis_part);
		} else if(sort.equals("board_recommends")) { // 정렬 기준이 추천수일 때,
			list = mapper.search_recommends(start, end, search, dis_part);
		} else if(sort.equals("board_views")) { // 정렬 기준이 조회수일 때,
			list = mapper.search_views(start, end, search, dis_part);
		} else { // 정렬 기준을 선택하지 않았을 때,
			list = mapper.search(start, end, search, dis_part);
		}
		
		model.addAttribute("paging", vo);
		model.addAttribute("list",list); // 조회 결과를 포함한 list를 Model 객체에 저장
		model.addAttribute("search",search);
		model.addAttribute("dis_part",dis_part);
		model.addAttribute("sort",sort);
		
		Member member = (Member)session.getAttribute("loginMember");	// 없으면 검색 버튼 클릭 시 삭제 버튼이 사라짐
		String memberId = member.getId();								// 없으면 검색 버튼 클릭 시 삭제 버튼이 사라짐
		
		model.addAttribute("memberId",memberId);						// 없으면 검색 버튼 클릭 시 삭제 버튼이 사라짐
		
		return "board";
	}
	
	// 댓글 작성
	@PostMapping("/board/content/{board_idx}/addComment")
	public String addComment(@PathVariable("board_idx") int idx, @RequestParam("cmt_content") String comment, Model model, HttpSession session) throws IOException {
		
		Member member = (Member)session.getAttribute("loginMember");
		String memberId = member.getId();
		
		mapper.addComment(idx, comment, memberId); // 게시글 번호와 댓글 내용과 사용자 Id를 t_comment 테이블에 삽입
		mapper.updateCommentCount(idx); // t_board 테이블에 해당 게시글의 댓글수를 갱신
		mapper.updateExp(memberId); // t_user 테이블에 해당 사용자의 경험치를 갱신
		String id = mapper.selectBoardId(idx);
		System.out.println(id);
		mapper.updateLevel(id); // t_board 테이블에 해당 게시글 작성자의 레벨을 갱신
		
		List<Comment> commentList = mapper.showComment(idx); // 해당 게시글의 댓글을 가져와서 commentList에 할당
		
		model.addAttribute(commentList); // commentList를 게시글 상세 페이지에 나타나게 Model 객체에 저장
		
		return "redirect:/board/content/{board_idx}";
	}
	
	// 댓글 삭제
	@GetMapping("/board/content/{board_idx}/{cmt_idx}/deleteComment")
	public String deleteComment(@PathVariable("cmt_idx") int idx, @PathVariable("board_idx") int board_idx, Model model, HttpSession session) throws IOException {
		
		Member member = (Member)session.getAttribute("loginMember");
		String memberId = member.getId();
		
		mapper.deleteComment(idx); // t_comment 테이블에서 해당 댓글 삭제
		mapper.updateCommentCount(board_idx); // t_board 테이블에서 댓글을 삭제한 게시글의 댓글수를 갱신
		mapper.updateExp(memberId); // t_user 테이블에 해당 사용자의 경험치를 갱신
		String id = mapper.selectBoardId(idx);
		System.out.println(id);
		mapper.updateLevel(id); // t_board 테이블에 해당 게시글 작성자의 레벨을 갱신
		
		List<Comment> commentList = mapper.showComment(idx); // 해당 게시글의 댓글을 가져와서 commentList에 할당
		
		model.addAttribute(commentList); // commentList를 게시글 상세 페이지에 나타나게 Model 객체에 저장
		
		return "redirect:/board/content/{board_idx}";
	}
	
}