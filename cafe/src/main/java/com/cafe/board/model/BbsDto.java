package com.cafe.board.model;

public class BbsDto extends BoardDto {

	private int bseq;
	private String saveFolder;
	private String originalFile;
	private String saveFile;
	private long fileSize;
	private String viewSize;

	public int getBseq() {
		return bseq;
	}

	public void setBseq(int bseq) {
		this.bseq = bseq;
	}

	public String getSaveFolder() {
		return saveFolder;
	}

	public void setSaveFolder(String saveFolder) {
		this.saveFolder = saveFolder;
	}

	public String getOriginalFile() {
		return originalFile;
	}

	public void setOriginalFile(String originalFile) {
		this.originalFile = originalFile;
	}

	public String getSaveFile() {
		return saveFile;
	}

	public void setSaveFile(String saveFile) {
		this.saveFile = saveFile;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public String getViewSize() {
		return viewSize;
	}

	public void setViewSize(String viewSize) {
		this.viewSize = viewSize;
	}

}
