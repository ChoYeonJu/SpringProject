package com.cafe.board.controller;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.cafe.board.model.BbsDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.board.service.BbsService;
import com.cafe.board.service.BoardCommonService;
import com.cafe.member.model.MemberDto;
import com.cafe.util.FileRepository;
import com.cafe.util.FileUtil;
import com.cafe.util.PageNavigation;

@Controller
@RequestMapping(value="/bbs")
public class BbsController {

	@Autowired
	ServletContext servletContext;
	
	@Autowired
	private BoardCommonService boardCommonService;
	
	@Autowired
	private BbsService bbsService;

	@RequestMapping(value="/list.cafe", method=RequestMethod.GET)
	public String listArticle(BoardParameterDto boardParameterDto, Model model) {
		List<BbsDto> list = bbsService.listArticle(boardParameterDto);
		PageNavigation navigation = bbsService.makePageNavigation(boardParameterDto);
		model.addAttribute("articleList", list);
		model.addAttribute("navi", navigation);
		model.addAttribute("para", boardParameterDto);
		return "board/bbs/list";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.GET)
	public String writeArticle(BoardParameterDto boardParameterDto, Model model) {
		model.addAttribute("para", boardParameterDto);
		return "board/bbs/write";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.POST)
	public String writeArticle(BbsDto bbsDto, @RequestParam("upfile") MultipartFile multipartFile, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			String originFilename = multipartFile.getOriginalFilename();

			int seq = boardCommonService.getNextSeq();
			bbsDto.setSeq(seq);
			bbsDto.setUsername(memberDto.getUsername());
			bbsDto.setUserid(memberDto.getUserid());
			bbsDto.setEmail(memberDto.getEmailid() + "@" + memberDto.getEmaildomain());
			
			if (multipartFile != null && !multipartFile.isEmpty()) {
				String realPath = servletContext.getRealPath("/upload/bbs");
				Map<String, String> map = FileRepository.saveFile(multipartFile, realPath);
				String saveFolder = map.get("saveFolder");
				String saveFilename = map.get("saveFileName");
				bbsDto.setSaveFolder(saveFolder);
				bbsDto.setSaveFile(saveFilename);
				bbsDto.setOriginalFile(originFilename);
				long fileSize = Long.parseLong(map.get("saveFileSize"));
				bbsDto.setFileSize(fileSize);
			}
			
			bbsService.writeArticle(bbsDto);
			return "redirect:/bbs/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/view.cafe", method=RequestMethod.GET)
	public String viewArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		BbsDto bbsDto = bbsService.viewArticle(seq, boardParameterDto.getWord());
		boardCommonService.updateHit(seq);
		model.addAttribute("article", bbsDto);
		model.addAttribute("para", boardParameterDto);
		return "board/bbs/view";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.GET)
	public String modifyArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		BbsDto bbsDto = bbsService.viewArticle(seq, boardParameterDto.getWord());
		model.addAttribute("article", bbsDto);
		model.addAttribute("para", boardParameterDto);
		return "board/bbs/modify";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.POST)
	public String modifyArticle(BbsDto bbsDto, @RequestParam("upfile") MultipartFile multipartFile, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			String realPath = servletContext.getRealPath("/upload/bbs");
			System.out.println(">>>>>>>>>>>>>>>>>>>>> 바꿀파일이름 : " + multipartFile.getOriginalFilename() + "\t원본 파일이름 : " + bbsDto.getOriginalFile());
			///////////////////////////////////// 수정전 파일이 수정파일과 다를경우 이전 파일진 삭제 후 파일 올리기 ////////////////////////////////////////////
			String uploadFile = multipartFile.getOriginalFilename();//현재파일이름
			String originalFile = bbsDto.getOriginalFile();//이전파일이름
			if(!originalFile.equals(uploadFile)) {

				FileUtil.deleteFile(realPath + File.separator + bbsDto.getSaveFolder(), bbsDto.getSaveFile());

			}
			
			if (multipartFile != null && !multipartFile.isEmpty()) {
				Map<String, String> map = FileRepository.saveFile(multipartFile, realPath);
				String saveFolder = map.get("saveFolder");
				String saveFilename = map.get("saveFileName");
				bbsDto.setSaveFolder(saveFolder);
				bbsDto.setSaveFile(saveFilename);
				bbsDto.setOriginalFile(uploadFile);
				long fileSize = Long.parseLong(map.get("saveFileSize"));
				bbsDto.setFileSize(fileSize);
			} else {
				bbsDto.setSaveFolder("");
				bbsDto.setSaveFile("");
				bbsDto.setOriginalFile("");
				bbsDto.setFileSize(0);
			}
			
			bbsService.modifyArticle(bbsDto);
			return "redirect:/bbs/view.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=&seq=" + bbsDto.getSeq();
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/delete.cafe", method=RequestMethod.GET)
	public String deleteArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			BbsDto bbsDto = bbsService.viewArticle(seq, null);
			if(bbsDto.getSaveFile() != null && !bbsDto.getSaveFile().isEmpty()) {
				String realPath = servletContext.getRealPath("/upload/bbs");
				FileUtil.deleteFile(realPath + File.separator + bbsDto.getSaveFolder(), bbsDto.getSaveFile());
			}
			bbsService.deleteArticle(seq);
			model.addAttribute("para", boardParameterDto);
			return "redirect:/bbs/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/download.cafe", method=RequestMethod.GET)
	public ModelAndView downloadFile(@RequestParam("sfolder") String sfolder, @RequestParam("ofile") String ofile, 
				@RequestParam("sfile") String sfile, HttpSession session) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			Map<String, Object> fileInfo = new HashMap<String, Object>();
		    fileInfo.put("sfolder", sfolder);
		    fileInfo.put("ofile", ofile);
		    fileInfo.put("sfile", sfile);
		 
		    return new ModelAndView("fileDownloadView", "downloadFile", fileInfo);
		} else {
			return new ModelAndView("redirect:/commons/index.cafe");
		}
	}
	
}
