package com.cafe.board.mapper;

import java.util.List;

import com.cafe.board.model.BoardDto;
import com.cafe.board.model.BoardParameterDto;

public interface BoardDao {

	void writeArticle(BoardDto boardDto);
	List<BoardDto> listArticle(BoardParameterDto boardParameterDto);
	int totalArticleCount(BoardParameterDto boardParameterDto);
	int newArticleCount(int bcode); 
	BoardDto viewArticle(int seq);
	void modifyArticle(BoardDto boardDto);
	void deleteArticle(int seq);
	
}
