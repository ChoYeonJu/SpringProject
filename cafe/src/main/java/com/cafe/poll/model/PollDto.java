package com.cafe.poll.model;

import java.util.List;

public class PollDto {

	private int pseq;
	private int paseq;
	private String answer;
	private int pollCount;
	private List<PollAnswerDto> pollAnswerList;

	public int getPseq() {
		return pseq;
	}

	public void setPseq(int pseq) {
		this.pseq = pseq;
	}

	public int getPaseq() {
		return paseq;
	}

	public void setPaseq(int paseq) {
		this.paseq = paseq;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public int getPollCount() {
		return pollCount;
	}

	
	public void setPollCount(int pollCount) {
		this.pollCount = pollCount;
	}

	public List<PollAnswerDto> getPollAnswerList() {
		return pollAnswerList;
	}

	public void setPollAnswerList(List<PollAnswerDto> pollAnswerList) {
		this.pollAnswerList = pollAnswerList;
	}
}
