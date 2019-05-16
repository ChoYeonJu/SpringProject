package com.cafe.board.mapper;

import java.util.List;

import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardParameterDto;

public interface AlbumDao {

	void writeArticle(AlbumDto albumDto);
	List<AlbumDto> listArticle(BoardParameterDto boardParameterDto);
	int totalArticleCount(BoardParameterDto boardParameterDto);
	int newArticleCount(int bcode); 
	AlbumDto viewArticle(int seq);
	void modifyPicture(AlbumDto albumDto);
	void modifyArticle(AlbumDto albumDto);
	void deleteAlbumArticle(int seq);
	void deleteBoardArticle(int seq);
	
}
