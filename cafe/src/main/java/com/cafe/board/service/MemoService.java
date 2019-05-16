package com.cafe.board.service;

import java.util.List;

import com.cafe.board.model.MemoDto;

public interface MemoService {

	void writeMemo(MemoDto memoDto);
	List<MemoDto> listMemo(int seq, String sort);
	void modifyMemo(MemoDto memoDto);
	void deleteMemo(int mseq);
	
}
