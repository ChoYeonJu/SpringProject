package com.cafe.board.service;

import java.util.List;

import com.cafe.board.model.BoardParameterDto;
import com.cafe.board.model.ReboardDto;
import com.cafe.util.PageNavigation;

public interface ReboardService {

	void writeArticle(ReboardDto reboardDto);
	void replyArticle(ReboardDto reboardDto);
	List<ReboardDto> listArticle(BoardParameterDto boardParameterDto);
	PageNavigation makePageNavigation(BoardParameterDto boardParameterDto);
	ReboardDto viewArticle(int seq, String word);
	void modifyArticle(ReboardDto reboardDto);
	void deleteArticle(int seq);
	
}
