package com.cafe.board.mapper;

import java.util.List;
import java.util.Map;

import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardDto;

public interface BoardCommonDao {

	List<AlbumDto> popularAlbum();
	List<AlbumDto> newAlbum();
	List<BoardDto> popularArticle();
	List<BoardDto> newArticle();
	List<BoardDto> searchArticle(Map<String, String> map);
	int totalArticleCount(String word);
	
	int getNextSeq();
	void updateHit(int seq);
	
	String didSweetOrHate(Map<String, String> map);
	void sweetOrHate(Map<String, String> map);
	void shCancel(Map<String, String> map);
	Map<String, Integer> shCount(Map<String, String> map);
	
	
//	int boardSweetUserCount(Map<String, String> map);
//	int boardHateUserCount(Map<String, String> map);
//	void sweetOrHate(Map<String, String> map);
//	void sweetCancel(Map<String, String> map);
//	void hateCancel(Map<String, String> map);
//	int getSweetCount(int seq);
//	int getHateCount(int seq);
	
}
