package com.cafe.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe.board.mapper.BoardDao;
import com.cafe.board.model.BoardDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.util.PageNavigation;
import com.cafe.util.SizeConstance;

@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void writeArticle(BoardDto boardDto) {
		sqlSession.getMapper(BoardDao.class).writeArticle(boardDto);
	}

	@Override
	public List<BoardDto> listArticle(BoardParameterDto boardParameterDto) {
		int end = boardParameterDto.getPageNo() * SizeConstance.DEFAULT_LIST_SIZE;
		boardParameterDto.setEnd(end);
		boardParameterDto.setStart(end - SizeConstance.DEFAULT_LIST_SIZE + 1);
		return sqlSession.getMapper(BoardDao.class).listArticle(boardParameterDto);
	}
	
	@Override
	public PageNavigation makePageNavigation(BoardParameterDto boardParameterDto) {
		BoardDao boardDao = sqlSession.getMapper(BoardDao.class);
		int naviSize = SizeConstance.NAVIGATION_SIZE;
		int listSize = SizeConstance.DEFAULT_LIST_SIZE;
		int pageNo = boardParameterDto.getPageNo();
		PageNavigation navigation = new PageNavigation();
		int newArticleCount = boardDao.newArticleCount(boardParameterDto.getBcode());
		navigation.setNewCount(newArticleCount);
		int totalArticleCount = boardDao.totalArticleCount(boardParameterDto);
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
	public BoardDto viewArticle(int seq, String word) {
		BoardDto boardDto = sqlSession.getMapper(BoardDao.class).viewArticle(seq);
		if(word != null && !word.isEmpty())
			boardDto.setContent(boardDto.getContent().replaceAll(word, "<b style='color:red;'>" + word + "</b>"));
		return boardDto;
	}

	@Override
	public void modifyArticle(BoardDto boardDto) {
		sqlSession.getMapper(BoardDao.class).modifyArticle(boardDto);
	}

	@Override
	public void deleteArticle(int seq) {
		sqlSession.getMapper(BoardDao.class).deleteArticle(seq);
	}

}
