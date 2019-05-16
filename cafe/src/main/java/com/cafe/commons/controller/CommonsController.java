package com.cafe.commons.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import com.cafe.admin.model.BoardListDto;
import com.cafe.admin.service.BoardAdminService;
import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardDto;
import com.cafe.board.service.BoardCommonService;
import com.cafe.util.PageNavigation;

@Controller
@RequestMapping("/commons")
public class CommonsController {
	
	@Autowired
	private BoardAdminService boardAdminService;
	
	@Autowired
	private BoardCommonService boardCommonService;
	
	@RequestMapping(value="/index.cafe", method=RequestMethod.GET)
	public ModelAndView index(HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();
		
		ServletContext context = request.getServletContext();
		
//		게시판목록
		@SuppressWarnings("unchecked")
		List<BoardListDto> menu = (List<BoardListDto>) context.getAttribute("boardmenu");
		
		if(menu == null) {
			menu = boardAdminService.listBoard();
			context.setAttribute("boardmenu", menu);
			
			for(BoardListDto boardListDto : menu) {
				context.setAttribute("board" + boardListDto.getBcode(), boardListDto.getBname());
			}
		}
		
//		인기앨범
		List<AlbumDto> palist = boardCommonService.popularAlbum();
		
//		최신앨범
		List<AlbumDto> nalist = boardCommonService.newAlbum();
		
//		인기글
		List<BoardDto> pblist = boardCommonService.popularArticle();
		
//		최신글
		List<BoardDto> nblist = boardCommonService.newArticle();
		
		mav.addObject("palist", palist);
		mav.addObject("nalist", nalist);
		mav.addObject("pblist", pblist);
		mav.addObject("nblist", nblist);
		mav.setViewName("main");
		return mav;
	}
	
	@RequestMapping(value="/searcharticle.cafe", method=RequestMethod.GET)
	public String searchaAticle(@RequestParam Map<String, String> map, Model model) {
		List<BoardDto> list = boardCommonService.searchArticle(map);
		PageNavigation navigation = boardCommonService.makePageNavigation(map);
		model.addAttribute("articleList", list);
		model.addAttribute("navi", navigation);
		model.addAttribute("searchword", map.get("searchword"));
		return "board/list";
	}

	@RequestMapping(value="/file_uploader_html5.cafe", method=RequestMethod.POST)
	@ResponseBody
	public String smartEditorUpload(HttpServletRequest request) {
		StringBuffer buffer = null;
		try {
			// 파일명 - 싱글파일업로드와 다르게 멀티파일업로드는 HEADER로 넘어옴 
			String name = request.getHeader("file-name");
			// 확장자
			String ext = name.substring(name.lastIndexOf(".")+1);
			// 파일 기본경로
			String defaultPath = request.getServletContext().getRealPath("/SE2");
			// 파일 기본경로 _ 상세경로
			String path = defaultPath + File.separator + "upload" + File.separator;

			File file = new File(path);
			if(!file.exists()) {
				file.mkdirs();
			}

			String realname = UUID.randomUUID().toString() + "." + ext;
			InputStream is = request.getInputStream();
			OutputStream os = new FileOutputStream(path + realname);
			int numRead;

			// 파일쓰기
			byte b[] = new byte[Integer.parseInt(request.getHeader("file-size"))];
			while((numRead = is.read(b,0,b.length)) != -1) {
				os.write(b, 0, numRead);
			}

			if(is != null) {
				is.close();
			}

			os.flush();
			os.close();

//			파일 삭제
//		 	File f1 = new File(path, realname);
//		 	if (!f1.isDirectory()) {
//		 		if(!f1.delete()) {
//		 			System.out.println("File 삭제 오류!");
//		 		}
//		 	}

			buffer = new StringBuffer();
			buffer.append("&bNewLine=true")
			  .append("&sFileName=")
			  .append(name)
			  .append("&sFileURL=")
			  .append(request.getContextPath()+"/SE2/upload/")
			  .append(realname);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return buffer.toString();
	}
	
}
