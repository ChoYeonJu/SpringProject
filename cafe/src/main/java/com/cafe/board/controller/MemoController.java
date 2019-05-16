package com.cafe.board.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.board.model.MemoDto;
import com.cafe.board.service.MemoService;
import com.cafe.member.model.MemberDto;

@Controller
@RequestMapping(value="/memo")
public class MemoController {

	@Autowired
	private MemoService memoService;
	
	@RequestMapping(value="/list.cafe", method=RequestMethod.GET, headers = { "Content-type=application/json" })
	@ResponseBody
	public String writeMemo(@RequestParam("seq") int seq, @RequestParam(value="sort", defaultValue=", 'sort' : latest") String sort) {
		List<MemoDto> list = memoService.listMemo(seq, sort);
		String json = this.makeJson(list);
		return json;
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.POST, headers = { "Content-type=application/json" })
	@ResponseBody
	public String writeMemo(@RequestBody MemoDto memoDto, HttpServletRequest request, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			memoDto.setUserid(memberDto.getUserid());
			memoDto.setIpaddress(request.getRemoteAddr());
			memoService.writeMemo(memoDto);
			List<MemoDto> list = memoService.listMemo(memoDto.getSeq(), "latest");
			String json = this.makeJson(list);
			return json;
		}
		return "";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.POST, headers = { "Content-type=application/json" })
	@ResponseBody
	public String modifyMemo(@RequestBody MemoDto memoDto, HttpServletRequest request, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			memoService.modifyMemo(memoDto);
			List<MemoDto> list = memoService.listMemo(memoDto.getSeq(), "latest");
			String json = this.makeJson(list);
			return json;
		}
		return "";
	}
	
	@RequestMapping(value="/delete.cafe", method=RequestMethod.GET, headers = { "Content-type=application/json" })
	@ResponseBody
	public String deleteMemo(@RequestParam("seq") int seq, @RequestParam("mseq") int mseq) {
		memoService.deleteMemo(mseq);
		List<MemoDto> list = memoService.listMemo(seq, "latest");
		String json = this.makeJson(list);
		return json;
	}

	private String makeJson(List<MemoDto> list) {
		JSONArray array = new JSONArray(list);
		JSONObject json = new JSONObject();
		json.put("memolist", array);
		return json.toString();
	}
	
}
