package com.cafe.board.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.board.model.BoardDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.board.service.BoardCommonService;
import com.cafe.board.service.BoardService;
import com.cafe.member.model.MemberDto;
import com.cafe.util.PageNavigation;

@Controller
@RequestMapping(value="/board")
public class BoardController {
	
	@Autowired
	private BoardCommonService boardCommonService;
	
	@Autowired
	private BoardService boardService;

	@RequestMapping(value="/list.cafe", method=RequestMethod.GET)
	public String listArticle(BoardParameterDto boardParameterDto, Model model) {
		List<BoardDto> list = boardService.listArticle(boardParameterDto);
		PageNavigation navigation = boardService.makePageNavigation(boardParameterDto);
		model.addAttribute("articleList", list);
		model.addAttribute("navi", navigation);
		model.addAttribute("para", boardParameterDto);
		return "board/basic/list";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.GET)
	public String writeArticle(BoardParameterDto boardParameterDto, Model model) {
		model.addAttribute("para", boardParameterDto);
		return "board/basic/write";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.POST)
	public String writeArticle(BoardDto boardDto, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			int seq = boardCommonService.getNextSeq();
			boardDto.setSeq(seq);
			boardDto.setUsername(memberDto.getUsername());
			boardDto.setUserid(memberDto.getUserid());
			boardDto.setEmail(memberDto.getEmailid() + "@" + memberDto.getEmaildomain());
			
			boardService.writeArticle(boardDto);
			return "redirect:/board/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/view.cafe", method=RequestMethod.GET)
	public String viewArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		BoardDto boardDto = boardService.viewArticle(seq, boardParameterDto.getWord());
		boardCommonService.updateHit(seq);
		model.addAttribute("article", boardDto);
		model.addAttribute("para", boardParameterDto);
		return "board/basic/view";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.GET)
	public String modifyArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		BoardDto boardDto = boardService.viewArticle(seq, boardParameterDto.getWord());
		model.addAttribute("article", boardDto);
		model.addAttribute("para", boardParameterDto);
		return "board/basic/modify";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.POST)
	public String modifyArticle(BoardDto boardDto, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			boardService.modifyArticle(boardDto);
			return "redirect:/board/view.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=&seq=" + boardDto.getSeq();
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/delete.cafe", method=RequestMethod.GET)
	public String deleteArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			boardService.deleteArticle(seq);
			model.addAttribute("para", boardParameterDto);
			return "redirect:/board/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/sweethate.cafe", method=RequestMethod.GET)
	@ResponseBody
	public Map<String, String> sweetOrHate(@RequestParam("seq") int seq, @RequestParam("mseq") int mseq, @RequestParam("flag") String flag, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		Map<String, String> map = new HashMap<String, String>();
		if(memberDto != null) {
			map = boardCommonService.sweetOrHate(seq, mseq, memberDto.getUserid(), flag);
		} else {
//			result : 100 >> 로그인후 투표
			map.put("result", "100");
		}
		return map;
	}
}
