package com.cafe.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.cafe.board.model.BoardParameterDto;
import com.cafe.board.model.ReboardDto;
import com.cafe.board.service.BoardCommonService;
import com.cafe.board.service.ReboardService;
import com.cafe.member.model.MemberDto;
import com.cafe.util.PageNavigation;

@Controller
@RequestMapping(value="/reboard")
public class ReboardController {
	
	@Autowired
	private BoardCommonService boardCommonService;
	
	@Autowired
	private ReboardService reboardService;

	@RequestMapping(value="/list.cafe", method=RequestMethod.GET)
	public String listArticle(BoardParameterDto boardParameterDto, Model model) {
		List<ReboardDto> list = reboardService.listArticle(boardParameterDto);
		PageNavigation navigation = reboardService.makePageNavigation(boardParameterDto);
		model.addAttribute("articleList", list);
		model.addAttribute("navi", navigation);
		model.addAttribute("para", boardParameterDto);
		return "board/reboard/list";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.GET)
	public String writeArticle(BoardParameterDto boardParameterDto, Model model) {
		model.addAttribute("para", boardParameterDto);
		return "board/reboard/write";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.POST)
	public String writeArticle(ReboardDto reboardDto, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			int seq = boardCommonService.getNextSeq();
			reboardDto.setSeq(seq);
			reboardDto.setUsername(memberDto.getUsername());
			reboardDto.setUserid(memberDto.getUserid());
			reboardDto.setEmail(memberDto.getEmailid() + "@" + memberDto.getEmaildomain());
			reboardDto.setGcode(seq);
			
			reboardService.writeArticle(reboardDto);
			return "redirect:/reboard/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/reply.cafe", method=RequestMethod.GET)
	public String replyArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		ReboardDto reboardDto = reboardService.viewArticle(seq, boardParameterDto.getWord());
		model.addAttribute("article", reboardDto);
		model.addAttribute("para", boardParameterDto);
		return "board/reboard/reply";
	}
	
	@RequestMapping(value="/reply.cafe", method=RequestMethod.POST)
	public String replyArticle(ReboardDto reboardDto, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			int seq = boardCommonService.getNextSeq();
			reboardDto.setSeq(seq);
			reboardDto.setUsername(memberDto.getUsername());
			reboardDto.setUserid(memberDto.getUserid());
			reboardDto.setEmail(memberDto.getEmailid() + "@" + memberDto.getEmaildomain());
			
			reboardService.replyArticle(reboardDto);
			return "redirect:/reboard/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/view.cafe", method=RequestMethod.GET)
	public String viewArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		ReboardDto reboardDto = reboardService.viewArticle(seq, boardParameterDto.getWord());
		boardCommonService.updateHit(seq);
		model.addAttribute("article", reboardDto);
		model.addAttribute("para", boardParameterDto);
		return "board/reboard/view";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.GET)
	public String modifyArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		ReboardDto reboardDto = reboardService.viewArticle(seq, boardParameterDto.getWord());
		model.addAttribute("article", reboardDto);
		model.addAttribute("para", boardParameterDto);
		return "board/reboard/modify";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.POST)
	public String modifyArticle(ReboardDto reboardDto, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			reboardService.modifyArticle(reboardDto);
			return "redirect:/reboard/view.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=&seq=" + reboardDto.getSeq();
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/delete.cafe", method=RequestMethod.GET)
	public String deleteArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			reboardService.deleteArticle(seq);
			model.addAttribute("para", boardParameterDto);
			return "redirect:/reboard/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
}
