package com.cafe.board.service;

import java.util.*;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe.board.mapper.BoardCommonDao;
import com.cafe.board.model.*;
import com.cafe.util.PageNavigation;
import com.cafe.util.SizeConstance;

@Service
public class BoardCommonServiceImpl implements BoardCommonService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<AlbumDto> popularAlbum() {
		return sqlSession.getMapper(BoardCommonDao.class).popularAlbum();
	}

	@Override
	public List<AlbumDto> newAlbum() {
		return sqlSession.getMapper(BoardCommonDao.class).newAlbum();
	}

	@Override
	public List<BoardDto> popularArticle() {
		return sqlSession.getMapper(BoardCommonDao.class).popularArticle();
	}

	@Override
	public List<BoardDto> newArticle() {
		return sqlSession.getMapper(BoardCommonDao.class).newArticle();
	}
	
	@Override
	public List<BoardDto> searchArticle(Map<String, String> map) {
		int pageNo = Integer.parseInt(map.get("pageNo"));
		int end = pageNo * SizeConstance.DEFAULT_LIST_SIZE;
		int start = end - SizeConstance.DEFAULT_LIST_SIZE;
		map.put("start", start + "");
		map.put("end", end + "");
		return sqlSession.getMapper(BoardCommonDao.class).searchArticle(map);
	}
	
	@Override
	public PageNavigation makePageNavigation(Map<String, String> map) {
		int naviSize = SizeConstance.NAVIGATION_SIZE;
		int listSize = SizeConstance.DEFAULT_LIST_SIZE;
		int pageNo = Integer.parseInt(map.get("pageNo"));
		PageNavigation navigation = new PageNavigation();
		int totalArticleCount = sqlSession.getMapper(BoardCommonDao.class).totalArticleCount(map.get("searchword"));
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
	public int getNextSeq() {
		return sqlSession.getMapper(BoardCommonDao.class).getNextSeq();
	}

	@Override
	public void updateHit(int seq) {
		sqlSession.getMapper(BoardCommonDao.class).updateHit(seq);
	}

	@Override
	public Map<String, String> sweetOrHate(int seq, int mseq, String userid, String flag) {
		BoardCommonDao boardCommonDao = sqlSession.getMapper(BoardCommonDao.class);
		Map<String, String> map = new HashMap<String, String>();
		map.put("seq", seq + "");
		map.put("mseq", mseq + "");
		map.put("userid", userid);
		map.put("flag", flag);
		
		int result = 0;
		String doSW = boardCommonDao.didSweetOrHate(map);//Y, N (투표O) or null (투표X)
		if(doSW == null) {//투표한적이없다면.
			boardCommonDao.sweetOrHate(map);
		} else {//투표한적이 있다면.
			if(doSW.equals(flag)) {//같은곳에 투표했다면.
				boardCommonDao.shCancel(map);
			} else {
				result = 1;
			}
		}
		
		Map<String, Integer> countMap = boardCommonDao.shCount(map);
		
		Map<String, String> resultMap = new HashMap<String, String>();
		resultMap.put("result", result + "");
		resultMap.put("sweet", countMap.get("sweet") + "");
		resultMap.put("hate", countMap.get("hate") + "");
		return resultMap;
		
		
////		투표한적이 있는지검사
//		int sweetCount = boardCommonDao.boardSweetUserCount(map);
//		int hateCount = boardCommonDao.boardHateUserCount(map);
//		Map<String, String> resultMap = new HashMap<String, String>();
//		int result = 0;
////		result : 0 >> 정상 투표
////		result : 1 >> 투표는 한번만.
//		if(("Y".equals(flag) && hateCount != 0) || ("N".equals(flag) && sweetCount != 0)) {
//			result = 1;
//		} else {
//			if(sweetCount == 0 && hateCount == 0)
//				boardCommonDao.sweetOrHate(map);
//			else {
//				if("Y".equals(flag))
//					boardCommonDao.sweetCancel(map);
//				else 
//					boardCommonDao.hateCancel(map);
//			}
//		}
//		int sweet = boardCommonDao.getSweetCount(seq);
//		int hate = boardCommonDao.getHateCount(seq);
//		resultMap.put("result", result + "");
//		resultMap.put("sweet", sweet + "");
//		resultMap.put("hate", hate + "");
//		return resultMap;
	}
	
}
