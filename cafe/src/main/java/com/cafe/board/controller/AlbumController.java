package com.cafe.board.controller;

import java.io.File;
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

import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.board.service.AlbumService;
import com.cafe.board.service.BoardCommonService;
import com.cafe.member.model.MemberDto;
import com.cafe.util.FileRepository;
import com.cafe.util.FileUtil;
import com.cafe.util.PageNavigation;

@Controller
@RequestMapping(value="/album")
public class AlbumController {
	
	@Autowired
	ServletContext servletContext;
	
	@Autowired
	private BoardCommonService boardCommonService;
	
	@Autowired
	private AlbumService albumService;
	
	@RequestMapping(value="/list.cafe", method=RequestMethod.GET)
	public String listArticle(BoardParameterDto boardParameterDto, Model model) {
		List<AlbumDto> list = albumService.listArticle(boardParameterDto);
		PageNavigation navigation = albumService.makePageNavigation(boardParameterDto);
		model.addAttribute("articleList", list);
		model.addAttribute("navi", navigation);
		model.addAttribute("para", boardParameterDto);
		return "board/album/list";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.GET)
	public String writeArticle(BoardParameterDto boardParameterDto, Model model) {
		model.addAttribute("para", boardParameterDto);
		return "board/album/write";
	}
	
	@RequestMapping(value="/write.cafe", method=RequestMethod.POST)
	public String writeArticle(AlbumDto albumDto, @RequestParam("picture") MultipartFile multipartFile, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			int seq = boardCommonService.getNextSeq();
			albumDto.setSeq(seq);
			albumDto.setUsername(memberDto.getUsername());
			albumDto.setUserid(memberDto.getUserid());
			albumDto.setEmail(memberDto.getEmailid() + "@" + memberDto.getEmaildomain());
			
			if (multipartFile != null && !multipartFile.isEmpty()) {
				String originFilename = multipartFile.getOriginalFilename();
				boolean isExist = FileUtil.isPermissionCheck(originFilename);
				if (!isExist) {
					model.addAttribute("msg", "이미지파일(gif,jpg,jpeg,png)만 가능합니다.");
					model.addAttribute("subject", albumDto.getSubject());
					model.addAttribute("content", albumDto.getContent());
					return "board/album/write";
				}
				
				String realPath = servletContext.getRealPath("/upload/album");
				Map<String, String> map = FileRepository.saveFile(multipartFile, realPath);
				String saveFolder = map.get("saveFolder");
				String saveFilename = map.get("saveFileName");
				albumDto.setSaveFolder(saveFolder);
				albumDto.setSavePicture(saveFilename);
				albumDto.setOriginalPicture(originFilename);
				
	//			Thumbnail Image
				String path = realPath + File.separator + saveFolder;
				int pictureMode = FileUtil.createThumbImage(path, saveFilename);
				albumDto.setPictureMode(pictureMode);
			}
			
			albumService.writeArticle(albumDto);
			return "redirect:/album/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/view.cafe", method=RequestMethod.GET)
	public String viewArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		AlbumDto albumDto = albumService.viewArticle(seq, boardParameterDto.getWord());
		boardCommonService.updateHit(seq);
		model.addAttribute("article", albumDto);
		model.addAttribute("para", boardParameterDto);
		return "board/album/view";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.GET)
	public String modifyArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, Model model) {
		AlbumDto albumDto = albumService.viewArticle(seq, boardParameterDto.getWord());
		model.addAttribute("article", albumDto);
		model.addAttribute("para", boardParameterDto);
		return "board/album/modify";
	}
	
	@RequestMapping(value="/modify.cafe", method=RequestMethod.POST)
	public String modifyArticle(AlbumDto albumDto, @RequestParam("picture") MultipartFile multipartFile, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			String realPath = servletContext.getRealPath("/upload/album");
//			System.out.println(">>>>>>>>>>>>>>>>>>>>> 바꿀사진이름 : " + multipartFile.getOriginalFilename() + "\t원본 사진이름 : " + albumDto.getOriginalPicture());
			///////////////////////////////////// 수정전 사진이 수정사진과 다를경우 이전 사진 삭제 후 사진 올리기 ////////////////////////////////////////////
			String uploadPicture = multipartFile.getOriginalFilename();
			String originalPicture = albumDto.getOriginalPicture();
			if(!uploadPicture.isEmpty() && !originalPicture.equals(uploadPicture)) {
				boolean isExist = FileUtil.isPermissionCheck(originalPicture);
				if (!isExist) {
					model.addAttribute("msg", "이미지파일(gif,jpg,jpeg,png)만 가능합니다.");
					model.addAttribute("subject", albumDto.getSubject());
					model.addAttribute("content", albumDto.getContent());
					return "board/album/write";
				}
				FileUtil.deleteFile(realPath + File.separator + albumDto.getSaveFolder(), albumDto.getSavePicture());
				FileUtil.deleteFile(realPath + File.separator + albumDto.getSaveFolder() + File.separator + "thumb", albumDto.getSavePicture());

				Map<String, String> map = FileRepository.saveFile(multipartFile, realPath);
				String saveFolder = map.get("saveFolder");
				String saveFilename = map.get("saveFileName");
				albumDto.setSaveFolder(saveFolder);
				albumDto.setSavePicture(saveFilename);
				albumDto.setOriginalPicture(uploadPicture);
				
//				Thumbnail Image
				String path = realPath + File.separator + saveFolder;
				int pictureMode = FileUtil.createThumbImage(path, saveFilename);
				albumDto.setPictureMode(pictureMode);
				
			}
			
			albumService.modifyArticle(albumDto);
			return "redirect:/album/view.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=&seq=" + albumDto.getSeq();
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
	@RequestMapping(value="/delete.cafe", method=RequestMethod.GET)
	public String deleteArticle(@RequestParam("seq") int seq, BoardParameterDto boardParameterDto, HttpSession session, Model model) {
		MemberDto memberDto = (MemberDto) session.getAttribute("userInfo");
		if(memberDto != null) {
			AlbumDto albumDto = albumService.viewArticle(seq, null);
			if(albumDto.getSavePicture() != null && !albumDto.getSavePicture().isEmpty()) {
				String realPath = servletContext.getRealPath("/upload/album");
				FileUtil.deleteFile(realPath + File.separator + albumDto.getSaveFolder(), albumDto.getSavePicture());
				FileUtil.deleteFile(realPath + File.separator + albumDto.getSaveFolder() + File.separator + "thumb", albumDto.getSavePicture());
			}
			albumService.deleteArticle(seq);
			model.addAttribute("para", boardParameterDto);
			return "redirect:/album/list.cafe?bcode=" + boardParameterDto.getBcode() + "&pageNo=1&key=&word=";
		} else {
			return "redirect:/commons/index.cafe";
		}
	}
	
}
