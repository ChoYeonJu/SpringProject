package com.cafe.admin.controller;

import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.cafe.admin.service.PollAdminService;
import com.cafe.commons.model.ListParameterDto;
import com.cafe.poll.model.PollDto;

@Controller
@RequestMapping(value="/polladmin")
public class PollAdminController {

	private Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private PollAdminService pollAdminService;
	
	@RequestMapping("/list.cafe")
	public String listMember(ListParameterDto listParameterDto, Model model) {
		List<PollDto> list = pollAdminService.listPoll(listParameterDto);
		model.addAttribute("polllist", list);
		return "admin/poll/list";
	}
}
