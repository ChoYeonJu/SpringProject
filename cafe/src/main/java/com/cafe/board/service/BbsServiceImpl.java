package com.cafe.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe.board.mapper.BbsDao;
import com.cafe.board.mapper.ReboardDao;
import com.cafe.board.model.BbsDto;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.util.FileUtil;
import com.cafe.util.PageNavigation;
import com.cafe.util.SizeConstance;

@Service
public class BbsServiceImpl implements BbsService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void writeArticle(BbsDto bbsDto) {
		sqlSession.getMapper(BbsDao .class).writeArticle(bbsDto);
	}

	@Override
	public List<BbsDto> listArticle(BoardParameterDto boardParameterDto) {
		int end = boardParameterDto.getPageNo() * SizeConstance.DEFAULT_LIST_SIZE;
		boardParameterDto.setEnd(end);
		boardParameterDto.setStart(end - SizeConstance.DEFAULT_LIST_SIZE + 1);
		return sqlSession.getMapper(BbsDao .class).listArticle(boardParameterDto);
	}

	@Override
	public PageNavigation makePageNavigation(BoardParameterDto boardParameterDto) {
		int naviSize = SizeConstance.NAVIGATION_SIZE;
		int listSize = SizeConstance.DEFAULT_LIST_SIZE;
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
	public BbsDto viewArticle(int seq, String word) {
		BbsDto bbsDto = sqlSession.getMapper(BbsDao.class).viewArticle(seq);
		bbsDto.setViewSize(FileUtil.calcSize(bbsDto.getFileSize()));
		if(word != null && !word.isEmpty())
			bbsDto.setContent(bbsDto.getContent().replaceAll(word, "<b style='color:red;'>" + word + "</b>"));
		return bbsDto;
	}

	@Override
	@Transactional
	public void modifyArticle(BbsDto bbsDto) {
		BbsDao bbsDao = sqlSession.getMapper(BbsDao.class);
		bbsDao.modifyArticle(bbsDto);
		bbsDao.modifyFile(bbsDto);
	}

	@Override
	@Transactional
	public void deleteArticle(int seq) {
		BbsDao bbsDao = sqlSession.getMapper(BbsDao.class);
		bbsDao.deleteBbsArticle(seq);
		bbsDao.deleteBoardArticle(seq);
	}

}
