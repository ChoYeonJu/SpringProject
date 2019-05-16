package com.cafe.board.mapper;

import java.util.List;

import com.cafe.board.model.BoardParameterDto;
import com.cafe.board.model.ReboardDto;

public interface ReboardDao {

	void writeArticle(ReboardDto reboardDto);
	void replyArticle(ReboardDto reboardDto);
	void updateStep(ReboardDto reboardDto);
	void updateReply(int pseq);
	List<ReboardDto> listArticle(BoardParameterDto boardParameterDto);
	int totalArticleCount(BoardParameterDto boardParameterDto);
	int newArticleCount(int bcode); 
	ReboardDto viewArticle(int seq);
	void modifyArticle(ReboardDto reboardDto);
	void deleteReboardArticle(int seq);
	void deleteBoardArticle(int seq);
	
}
