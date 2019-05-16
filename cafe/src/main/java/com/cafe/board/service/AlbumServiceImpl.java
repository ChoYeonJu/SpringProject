package com.cafe.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe.board.mapper.AlbumDao;
import com.cafe.board.mapper.ReboardDao;
import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.util.PageNavigation;
import com.cafe.util.SizeConstance;

@Service
public class AlbumServiceImpl implements AlbumService {
	
	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void writeArticle(AlbumDto albumDto) {
		sqlSession.getMapper(AlbumDao.class).writeArticle(albumDto);
	}

	@Override
	public List<AlbumDto> listArticle(BoardParameterDto boardParameterDto) {
		int end = boardParameterDto.getPageNo() * SizeConstance.ALBUM_LIST_SIZE;
		boardParameterDto.setEnd(end);
		boardParameterDto.setStart(end - SizeConstance.ALBUM_LIST_SIZE + 1);
		return sqlSession.getMapper(AlbumDao .class).listArticle(boardParameterDto);
	}

	@Override
	public PageNavigation makePageNavigation(BoardParameterDto boardParameterDto) {
		int naviSize = SizeConstance.NAVIGATION_SIZE;
		int listSize = SizeConstance.ALBUM_LIST_SIZE;
		int pageNo = boardParameterDto.getPageNo();
		PageNavigation navigation = new PageNavigation();
		int newArticleCount = sqlSession.getMapper(ReboardDao.class).newArticleCount(boardParameterDto.getBcode());
		navigation.setNewCount(newArticleCount);
		int totalArticleCount = sqlSession.getMapper(ReboardDao.class).totalArticleCount(boardParameterDto);
		navigation.setTotalCount(totalArticleCount);
		int totalPageCount = (totalArticleCount - 1) / listSize + 1;
		navigation.setTotalPageCount(totalPageCount);
		navigation.setCurrentPage(pageNo);
		navigation.setStartRange(pageNo < naviSize);
		navigation.setEndRange((totalPageCount - 1) / naviSize * naviSize < pageNo);
		navigation.makeNavigator();
		return navigation;
	}

	@Override
	public AlbumDto viewArticle(int seq, String word) {
		AlbumDto albumDto = sqlSession.getMapper(AlbumDao.class).viewArticle(seq);
		if(word != null && !word.isEmpty())
			albumDto.setContent(albumDto.getContent().replaceAll(word, "<b style='color:red;'>" + word + "</b>"));
		return albumDto;
	}

	@Override
	@Transactional
	public void modifyArticle(AlbumDto albumDto) {
		AlbumDao albumDao = sqlSession.getMapper(AlbumDao.class);
		albumDao.modifyArticle(albumDto);
		albumDao.modifyPicture(albumDto);
	}

	@Override
	@Transactional
	public void deleteArticle(int seq) {
		AlbumDao albumDao = sqlSession.getMapper(AlbumDao.class);
		albumDao.deleteAlbumArticle(seq);
		albumDao.deleteBoardArticle(seq);
	}

}
