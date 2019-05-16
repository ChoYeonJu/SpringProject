package com.cafe.board.mapper;

import java.util.List;

import com.cafe.board.model.BbsDto;
import com.cafe.board.model.BoardParameterDto;

public interface BbsDao {

	void writeArticle(BbsDto bbsDto);
	List<BbsDto> listArticle(BoardParameterDto boardParameterDto);
	int totalArticleCount(BoardParameterDto boardParameterDto);
	int newArticleCount(int bcode); 
	BbsDto viewArticle(int seq);
	void modifyFile(BbsDto bbsDto);
	void modifyArticle(BbsDto bbsDto);
	void deleteBbsArticle(int seq);
	void deleteBoardArticle(int seq);
	
}
