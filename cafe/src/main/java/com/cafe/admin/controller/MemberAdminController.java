package com.cafe.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.admin.service.MemberAdminService;
import com.cafe.commons.model.ListParameterDto;
import com.cafe.member.model.MemberDetailDto;
import com.cafe.util.PageNavigation;

@Controller
@RequestMapping(value="/memberadmin")
public class MemberAdminController {
	
	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private MemberAdminService memberAdminService;

	@RequestMapping("/list.cafe")
	public String listMember(ListParameterDto listParameterDto, Model model) {
		List<MemberDetailDto> list = memberAdminService.listMember(listParameterDto);
		PageNavigation navigation = memberAdminService.makePageNavigation(listParameterDto);
		model.addAttribute("userlist", list);
		model.addAttribute("navi", navigation);
		model.addAttribute("listparam", listParameterDto);
		return "admin/user/list";
	}
	
	@RequestMapping(value="/blind.cafe", method=RequestMethod.GET, headers = { "Content-type=application/json" })
	@ResponseBody
	public Map<String, String> registerMember(@RequestParam("userid") String userid, @RequestParam("role") int role) {
		memberAdminService.blindMember(userid, role);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "ok");
		return map;
	}
	
}






