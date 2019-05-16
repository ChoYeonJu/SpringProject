package com.cafe.board.service;

import java.util.List;

import com.cafe.board.model.BoardDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.util.PageNavigation;

public interface BoardService {

	void writeArticle(BoardDto boardDto);
	List<BoardDto> listArticle(BoardParameterDto boardParameterDto);
	PageNavigation makePageNavigation(BoardParameterDto boardParameterDto);
	BoardDto viewArticle(int seq, String word);
	void modifyArticle(BoardDto boardDto);
	void deleteArticle(int seq);
	
}
