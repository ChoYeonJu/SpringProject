package com.cafe.board.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.cafe.board.mapper.ReboardDao;
import com.cafe.board.model.BoardParameterDto;
import com.cafe.board.model.ReboardDto;
import com.cafe.util.PageNavigation;
import com.cafe.util.SizeConstance;

@Service
public class ReboardServiceImpl implements ReboardService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public void writeArticle(ReboardDto reboardDto) {
		sqlSession.getMapper(ReboardDao .class).writeArticle(reboardDto);
	}

	@Override
	@Transactional
	public void replyArticle(ReboardDto reboardDto) {
		ReboardDao reboardDao = sqlSession.getMapper(ReboardDao .class);
		reboardDao.updateStep(reboardDto);
		reboardDao.replyArticle(reboardDto);
		reboardDao.updateReply(reboardDto.getPseq());
	}

	@Override
	public List<ReboardDto> listArticle(BoardParameterDto boardParameterDto) {
		int end = boardParameterDto.getPageNo() * SizeConstance.DEFAULT_LIST_SIZE;
		boardParameterDto.setEnd(end);
		boardParameterDto.setStart(end - SizeConstance.DEFAULT_LIST_SIZE + 1);
		return sqlSession.getMapper(ReboardDao .class).listArticle(boardParameterDto);
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
	public ReboardDto viewArticle(int seq, String word) {
		ReboardDto reboardDto = sqlSession.getMapper(ReboardDao.class).viewArticle(seq);
		if(word != null && !word.isEmpty())
			reboardDto.setContent(reboardDto.getContent().replaceAll(word, "<b style='color:red;'>" + word + "</b>"));
		return reboardDto;
	}

	@Override
	public void modifyArticle(ReboardDto reboardDto) {
		sqlSession.getMapper(ReboardDao.class).modifyArticle(reboardDto);
	}

	@Override
	@Transactional
	public void deleteArticle(int seq) {
		ReboardDao reboardDao = sqlSession.getMapper(ReboardDao .class);
		reboardDao.deleteReboardArticle(seq);
		reboardDao.deleteBoardArticle(seq);
	}

}
