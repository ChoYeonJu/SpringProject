package com.cafe.board.service;

import java.util.List;
import java.util.Map;

import com.cafe.board.model.*;
import com.cafe.util.PageNavigation;

public interface BoardCommonService {

	List<AlbumDto> popularAlbum();
	List<AlbumDto> newAlbum();
	List<BoardDto> popularArticle();
	List<BoardDto> newArticle();
	
	List<BoardDto> searchArticle(Map<String, String> map);
	PageNavigation makePageNavigation(Map<String, String> map);
	
	int getNextSeq();
	void updateHit(int seq);
	Map<String, String> sweetOrHate(int seq, int mseq, String userid, String flag);
	
}
