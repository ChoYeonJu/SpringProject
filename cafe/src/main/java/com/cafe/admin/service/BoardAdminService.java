package com.cafe.admin.service;

import java.util.List;

import com.cafe.admin.model.BoardListDto;
import com.cafe.admin.model.BoardTypeDto;
import com.cafe.admin.model.CategoryDto;
import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardDto;

public interface BoardAdminService {

	List<BoardTypeDto> boardTypeList();
	List<BoardListDto> listBoard();
	
	void makeBoard(BoardListDto boardListDto);
	void changeBoard(BoardListDto boardListDto);
	void deleteBoard(int bcode);
	
	List<CategoryDto> listCategory();
	void makeCategory(String cname);
	void changeCategory(CategoryDto categoryDto);
	void deleteCategory(int ccode);
	
	
}
