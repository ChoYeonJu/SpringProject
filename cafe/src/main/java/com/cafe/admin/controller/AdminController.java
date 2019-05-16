package com.cafe.admin.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.cafe.member.model.MemberDto;

@Controller
@RequestMapping(value="/admin")
public class AdminController {

	@RequestMapping(value="/index.cafe", method=RequestMethod.GET)
	public String index(HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null && memberDto.getRole() == 0) {
			return "admin/index";
		}
		return "redirect:/commons/index.cafe";
	}
}
