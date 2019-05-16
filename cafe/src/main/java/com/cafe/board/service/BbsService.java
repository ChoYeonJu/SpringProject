package com.cafe.board.service;

import java.util.List;

import com.cafe.board.model.BbsDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.util.PageNavigation;

public interface BbsService {

	void writeArticle(BbsDto bbsDto);
	List<BbsDto> listArticle(BoardParameterDto boardParameterDto);
	PageNavigation makePageNavigation(BoardParameterDto boardParameterDto);
	BbsDto viewArticle(int seq, String word);
	void modifyArticle(BbsDto bbsDto);
	void deleteArticle(int seq);
	
}
