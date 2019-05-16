package com.cafe.util;

public class PageNavigation {

	private boolean startRange;
	private boolean endRange;
	private int totalCount;
	private int newCount;
	private int totalPageCount;
	private int currentPage;
	private String navigator;

	public boolean isStartRange() {
		return startRange;
	}

	public void setStartRange(boolean startRange) {
		this.startRange = startRange;
	}

	public boolean isEndRange() {
		return endRange;
	}

	public void setEndRange(boolean endRange) {
		this.endRange = endRange;
	}

	public int getTotalCount() {
		return totalCount;
	}

	public void setTotalCount(int totalCount) {
		this.totalCount = totalCount;
	}

	public int getNewCount() {
		return newCount;
	}

	public void setNewCount(int newCount) {
		this.newCount = newCount;
	}

	public int getTotalPageCount() {
		return totalPageCount;
	}

	public void setTotalPageCount(int totalPageCount) {
		this.totalPageCount = totalPageCount;
	}

	public int getCurrentPage() {
		return currentPage;
	}

	public void setCurrentPage(int currentPage) {
		this.currentPage = currentPage;
	}

	public String getNavigator() {
		return navigator;
	}

	public void makeNavigator() {
		int naviSize = SizeConstance.NAVIGATION_SIZE;
		int startPage = (currentPage - 1) / naviSize * naviSize + 1;
		int endPage = startPage + naviSize - 1;
		if(totalPageCount < endPage)
			endPage = totalPageCount;
		
		StringBuffer buffer = new StringBuffer();
		buffer.append("            			<div class=\"col-sm-10\" style=\"text-align: center;\"> \n");
		buffer.append("			            	<ul class=\"pagination\"> \n");
		buffer.append("			            		<li class=\"firstpage\"> \n");
		buffer.append("			            			<a href=\"#\" aria-label=\"Previous\"> \n");
		buffer.append("			            				<span aria-hidden=\"true\">최신</span> \n");
		buffer.append("			            			</a> \n");
		buffer.append("								</li> \n");
		buffer.append("			            		<li class=\"page\" data-page=\"" + (this.startRange ? 1 : (startPage - 1)) + "\"> \n");
		buffer.append("			            			<a href=\"#\" aria-label=\"Previous\"> \n");
		buffer.append("			            				<span aria-hidden=\"true\">이전</span> \n");
		buffer.append("			            			</a> \n");
		buffer.append("								</li> \n");
		for(int i=startPage;i<=endPage;i++) {
			buffer.append("								<li class=\"" + (currentPage == i ? "page active" : "page") + "\" data-page=\"" + i + "\"><a href=\"#\">" + i + "</a></li> \n");
		}
		buffer.append("								<li class=\"page\" data-page=\"" + (this.endRange ? endPage : (endPage + 1)) + "\"> \n");
		buffer.append("			            			<a href=\"#\" aria-label=\"Next\"> \n");
		buffer.append("			            				<span aria-hidden=\"true\">다음</span> \n");
		buffer.append("			            			</a> \n");
		buffer.append("								</li> \n");
		buffer.append("								<li class=\"page\" data-page=\"" + totalPageCount + "\"> \n");
		buffer.append("			            			<a href=\"#\" aria-label=\"Next\"> \n");
		buffer.append("			            				<span aria-hidden=\"true\">마지막</span> \n");
		buffer.append("			            			</a> \n");
		buffer.append("								</li> \n");
		buffer.append("							</ul> \n");
		buffer.append("            			</div> \n");
		this.navigator = buffer.toString();
	}

}
