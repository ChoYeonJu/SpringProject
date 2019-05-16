package com.cafe.admin.service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cafe.admin.mapper.BoardAdminDao;
import com.cafe.admin.model.BoardListDto;
import com.cafe.admin.model.BoardTypeDto;
import com.cafe.admin.model.CategoryDto;
import com.cafe.board.model.AlbumDto;
import com.cafe.board.model.BoardDto;

@Service
public class BoardAdminServiceImpl implements BoardAdminService {

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<BoardTypeDto> boardTypeList() {
		return sqlSession.getMapper(BoardAdminDao.class).boardTypeList();
	}

	@Override
	public List<BoardListDto> listBoard() {
		return sqlSession.getMapper(BoardAdminDao.class).listBoard();
	}
	
	@Override
	public void makeBoard(BoardListDto boardListDto) {
		sqlSession.getMapper(BoardAdminDao.class).makeBoard(boardListDto);
	}

	@Override
	public void changeBoard(BoardListDto boardListDto) {
		sqlSession.getMapper(BoardAdminDao.class).changeBoard(boardListDto);
	}

	@Override
	public void deleteBoard(int bcode) {
		sqlSession.getMapper(BoardAdminDao.class).deleteBoard(bcode);
	}

	@Override
	public List<CategoryDto> listCategory() {
		return sqlSession.getMapper(BoardAdminDao.class).listCategory();
	}

	@Override
	public void makeCategory(String cname) {
		sqlSession.getMapper(BoardAdminDao.class).makeCategory(cname);
	}

	@Override
	public void changeCategory(CategoryDto categoryDto) {
		sqlSession.getMapper(BoardAdminDao.class).changeCategory(categoryDto);
	}

	@Override
	public void deleteCategory(int ccode) {
		sqlSession.getMapper(BoardAdminDao.class).deleteCategory(ccode);
	}

}
