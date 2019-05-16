<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/top.jsp"%>
<%@ include file="/WEB-INF/views/common/template/left.jsp"%>

<!-- Center ======================================================================================= -->
        <script>
        $(document).ready(function() {
        	//새글, 전체글, 현재, 전체페이지 팦업
        	$('[data-toggle="popover"]').popover();
        	
        	//글쓰기 페이지 이동
        	$('#newBtn').click(function() {
        		//alert("새글쓰기로 이동");
        		$(document).find('[name="bcode"]').val('${para.bcode}');
        		$(document).find('[name="pageNo"]').val('1');
        		$(document).find('[name="key"]').val('');
        		$(document).find('[name="word"]').val('');
        		var paraForm = $('#paraForm');
        		paraForm.attr('action', '${root}/album/write.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//글보기 페이지 이동
        	$('.album_list>div').click(function() {
     			//alert($(this).find('#article_seq').val() + "번 글보기!!!!");
        		$(document).find('[name="bcode"]').val('${para.bcode}');
        		$(document).find('[name="pageNo"]').val('${para.pageNo}');
        		$(document).find('[name="key"]').val('${para.key}');
        		$(document).find('[name="word"]').val('${para.word}');
        		$(document).find('[name="seq"]').val($(this).find('#article_seq').val());
        		var paraForm = $('#paraForm');
        		paraForm.attr('action', '${root}/album/view.cafe').attr('method', 'get');
        		paraForm.submit();
     		});
     		
        	//pagenavigation 페이지 이동
        	//최신목록으로 이동
        	$('.firstpage').click(function() {
        		//alert('최신목록으로 이동하자!!!!');
        		var paraForm = $('#paraForm');
        		paraForm.find('[name="bcode"]').val('${para.bcode}');
        		paraForm.find('[name="pageNo"]').val('1');
        		paraForm.attr('action', '${root}/album/list.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//페이지 번호로 이동
        	$('.page').click(function() {
        		//alert($(this).attr('data-page') + '로 이동하자!!!!');
        		var paraForm = $('#paraForm');
        		paraForm.find('[name="bcode"]').val('${para.bcode}');
        		paraForm.find('[name="pageNo"]').val($(this).attr('data-page'));
        		paraForm.find('[name="key"]').val('${para.key}');
        		paraForm.find('[name="word"]').val('${para.word}');
        		paraForm.attr('action', '${root}/album/list.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//검색
        	$('#boardsearch').click(function() {
        		//alert($(this).attr('data-page') + '로 이동하자!!!!');
        		var sForm = $('#sForm');
        		sForm.find('[name="bcode"]').val('${para.bcode}');
        		sForm.find('[name="pageNo"]').val('1');
        		sForm.attr('action', '${root}/album/list.cafe').attr('method', 'get');
        		sForm.submit();
        	});
        	
        });
        </script>
        <form id="paraForm">
        	<input type="hidden" id="bcode" name="bcode"/>
        	<input type="hidden" id="pageNo" name="pageNo"/>
        	<input type="hidden" id="key" name="key"/>
        	<input type="hidden" id="word" name="word"/>
        	<input type="hidden" id="seq" name="seq"/>
        </form>
        <div class="col-sm-9">
        	<div class="page-header">
                <h4 id="container"><%=application.getAttribute("board" + request.getParameter("bcode")) %></h4>
            </div>
            <div class="pull-left">
           		<button type="button" id="newBtn" class="btn btn-sm btn-default" data-backdrop="static">새글쓰기</button>
           	</div>
           	<div class="pull-right">
           		<label>
	           		<a href="#" data-toggle="popover" data-trigger="focus" data-placement="top" title="오늘쓴글수" data-content="${navi.newCount}개">${navi.newCount}</a> 
	           		/ <a href="#" data-toggle="popover" data-trigger="focus" data-placement="left" title="전체글수" data-content="${navi.totalCount}개">${navi.totalCount}</a>
           		</label>
           	</div>
			<div style="height: 40px;"></div>
	            <div class="table-responsive">
	                <div class="album_list col-md-12">
	                <c:forEach varStatus="idx" var="article" items="${articleList}">
						<div class="col-md-3">
							<div class="thumbnail">
								<c:if test="${article.savePicture != null}">
								<img src="${root}/upload/album/${article.saveFolder}/thumb/${article.savePicture}" class="img-rounded" alt="Lights" style="width:100%">
								</c:if>
								<c:if test="${article.savePicture == null}">
								<img src="${root}/img/board/noimage.png" class="img-rounded" alt="Lights" style="width:100%">
								</c:if>
								<div class="caption">
									<p>${article.subject}
									<c:if test="${article.memocount != 0}">
		                        	<span class="badge" style="background: magenta;">${article.memocount}</span>
		                        	</c:if>
									</p>
								</div>
							</div>
							<input type="hidden" id="article_seq" value="${article.seq}">
						</div>
						<c:if test="${idx.index % 4 == 3}">
						</div>
						<div class="album_list col-md-12">
						</c:if>
					</c:forEach>
				</div>
				<table class="table">
                    <tr>
                    	<td>
                    	<div class="pull-right">
			           		<label>
			           		<a href="#" data-toggle="popover" data-trigger="focus" data-placement="bottom" title="현재페이지" data-content="${navi.currentPage} page">${navi.currentPage}</a> 
			           		/ <a href="#" data-toggle="popover" data-trigger="focus" data-placement="left" title="전체페이지" data-content="${navi.totalPageCount} pages">${navi.totalPageCount}</a>
			           		</label>
			           	</div>
                    	${navi.navigator}
                    	</td>
                    </tr>
                </table>
            </div>
            <div class="col-sm-12 pull-right">
            <form id="sForm" class="navbar-form navbar-right">
            	<input type="hidden" id="sbcode" name="bcode"/>
        		<input type="hidden" id="spageNo" name="pageNo"/>
			    <table>
			    <tr>
			    	<td>
					<div class="form-group">
						<select class="form-control" id="skey" name="key">
					    	<option value="1">제목 + 내용</option>
					    	<option value="2">제목만</option>
					    	<option value="3">글작성자</option>
					    	<option value="4">댓글내용</option>
					  	</select>
						<input type="text" id="sword" name="word" class="form-control" placeholder="검색어">
					</div>
					<button id="boardsearch" class="btn btn-default">
						<i class="glyphicon glyphicon-search"></i>
					</button>
					</td>
				</tr>
				</table>
			</form>
            </div>
        </div>

<%@ include file="/WEB-INF/views/common/template/bottom.jsp"%>