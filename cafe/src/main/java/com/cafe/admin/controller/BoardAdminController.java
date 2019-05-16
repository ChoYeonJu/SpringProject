package com.cafe.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.cafe.admin.model.BoardListDto;
import com.cafe.admin.model.BoardTypeDto;
import com.cafe.admin.model.CategoryDto;
import com.cafe.admin.service.BoardAdminService;

@Controller
@RequestMapping(value="/boardadmin")
public class BoardAdminController {

	@Autowired
	private BoardAdminService boardAdminService;
	
	////////////////////////////////////////// Category ///////////////////////////////////////////////
	@RequestMapping(value="/makecategory.cafe", method=RequestMethod.GET)
	public String makeCategory(Model model) {
		List<CategoryDto> list = boardAdminService.listCategory();
		model.addAttribute("categorylist", list);
		return "admin/board/makecategory";
	}
	
	@RequestMapping(value="/makecategory.cafe", method=RequestMethod.POST)
	public String makeCategory(@RequestParam("cname") String cname) {
		boardAdminService.makeCategory(cname);
		return "redirect:/boardadmin/makecategory.cafe";
	}
	
	@RequestMapping(value="/changecategory.cafe", method=RequestMethod.GET, headers = { "Content-type=application/json" })
	@ResponseBody
	public Map<String, String> changeCategory(CategoryDto categoryDto) {
		boardAdminService.changeCategory(categoryDto);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "ok");
		return map;
	}
	
	@RequestMapping(value="/deletecategory.cafe", method=RequestMethod.POST)
	public String deleteCategory(@RequestParam("ccode") int ccode) {
		boardAdminService.deleteCategory(ccode);
		return "redirect:/boardadmin/makecategory.cafe";
	}
			
	////////////////////////////////////////// Board ///////////////////////////////////////////////
	@RequestMapping(value="/makeboard.cafe", method=RequestMethod.GET)
	public String makeBoard(Model model) {
		List<CategoryDto> clist = boardAdminService.listCategory();
		List<BoardTypeDto> btlist = boardAdminService.boardTypeList();
		List<BoardListDto> blist = boardAdminService.listBoard();
		JSONArray array = new JSONArray(blist);
		JSONObject json = new JSONObject();
		json.put("jsonboard", array);
		model.addAttribute("categorylist", clist);
		model.addAttribute("boardtypelist", btlist);
		model.addAttribute("boardlist", blist);
		model.addAttribute("jsonobject", json);
		return "admin/board/makeboard";
	}
	
	@RequestMapping(value="/makeboard.cafe", method=RequestMethod.POST)
	public String makeBoard(BoardListDto boardListDto) {
		boardAdminService.makeBoard(boardListDto);
		return "redirect:/boardadmin/makeboard.cafe";
	}
	
	@RequestMapping(value="/changeboard.cafe", method=RequestMethod.GET, headers = { "Content-type=application/json" })
	@ResponseBody
	public Map<String, String> changeBoard(BoardListDto boardListDto) {
		boardAdminService.changeBoard(boardListDto);
		Map<String, String> map = new HashMap<String, String>();
		map.put("result", "ok");
		return map;
	}
	
	@RequestMapping(value="/deleteboard.cafe", method=RequestMethod.POST)
	public String deleteBoard(@RequestParam("delbcode") int bcode) {
		boardAdminService.deleteBoard(bcode);
		return "redirect:/boardadmin/makeboard.cafe";
	}
}
