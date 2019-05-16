package com.cafe.board.service;

import java.util.List;

import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.util.PageNavigation;

public interface AlbumService {

	void writeArticle(AlbumDto albumDto);
	List<AlbumDto> listArticle(BoardParameterDto boardParameterDto);
	PageNavigation makePageNavigation(BoardParameterDto boardParameterDto);
	AlbumDto viewArticle(int seq, String word);
	void modifyArticle(AlbumDto albumDto);
	void deleteArticle(int seq);
}
