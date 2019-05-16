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
        		paraForm.attr('action', '${root}/board/write.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//글보기 페이지 이동
        	$('.article_list>tr').click(function() {
     			//alert($(this).find('#article_seq').val() + "번 글보기!!!!");
        		$(document).find('[name="bcode"]').val('${para.bcode}');
        		$(document).find('[name="pageNo"]').val('${para.pageNo}');
        		$(document).find('[name="key"]').val('${para.key}');
        		$(document).find('[name="word"]').val('${para.word}');
        		$(document).find('[name="seq"]').val($(this).find('#article_seq').val());
        		var paraForm = $('#paraForm');
        		paraForm.attr('action', '${root}/board/view.cafe').attr('method', 'get');
        		paraForm.submit();
     		});
     		
        	//pagenavigation 페이지 이동
        	//최신목록으로 이동
        	$('.firstpage').click(function() {
        		//alert('최신목록으로 이동하자!!!!');
        		var paraForm = $('#paraForm');
        		paraForm.find('[name="bcode"]').val('${para.bcode}');
        		paraForm.find('[name="pageNo"]').val('1');
        		paraForm.attr('action', '${root}/board/list.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//페이지 번호로 이동
        	$('.page').click(function() {
        		//alert($(this).attr('data-page') + '로 이동하자!!!!');
        		var paraForm = $('#paraForm');
        		paraForm.find('[name="pageNo"]').val($(this).attr('data-page'));
        		paraForm.find('[name="searchword"]').val('${searchword}');
        		paraForm.attr('action', '${root}/commons/searcharticle.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//검색
        	$('#boardsearch').click(function() {
        		//alert($(this).attr('data-page') + '로 이동하자!!!!');
        		var sForm = $('#sForm');
        		sForm.find('[name="bcode"]').val('${para.bcode}');
        		sForm.find('[name="pageNo"]').val('1');
        		sForm.attr('action', '${root}/board/list.cafe').attr('method', 'get');
        		sForm.submit();
        	});
        	
        });
        </script>
        <form id="paraForm">
        	<input type="hidden" id="bcode" name="bcode"/>
        	<input type="hidden" id="pageNo" name="pageNo"/>
        	<input type="hidden" id="key" name="key"/>
        	<input type="hidden" id="word" name="word"/>
        	<input type="hidden" id="searchword" name="searchword"/>
        	<input type="hidden" id="seq" name="seq"/>
        </form>
        <div class="col-sm-9">
        	<div class="page-header">
                <h4 id="container">전체글목록</h4>
            </div>
			<div style="height: 30px;"></div>
            <div class="table-responsive">
                <!-- <table class="table table-bordered"> -->
                <table class="table table-hover">
                    <colgroup>
                        <col width="80">
                        <col width="*">
                        <col width="120">
                        <col width="80">
                        <col width="120">
                    </colgroup>
                    <thead>
                    <tr><th colspan="5"></th></tr>
                    <tr>
                        <th class="text-center">글번호</th>
                        <th class="text-center">제목</th>
                        <th class="text-center">작성자</th>
                        <th class="text-center">조회수</th>
                        <th class="text-center">작성일</th>
                    </tr>
                    </thead>
                    <tbody class="article_list">
                    <!-- 글목록 start -->
                    <c:forEach var="article" items="${articleList}">
                    <tr>
                        <td class="text-center">${article.seq}</td>
                        <td class="text-left">
                        	${article.subject}
                        	<c:if test="${article.memocount != 0}">
                        	<span class="badge" style="background: orange;">${article.memocount}</span>
                        	</c:if>
                        </td>
                        <td class="text-center">${article.username}</td>
                        <td class="text-center">${article.hit}</td>
                        <td class="text-center">${article.logtime}</td>
                        <input type="hidden" id="article_seq" value="${article.seq}">
                    </tr>
                    </c:forEach>
                    <!-- 글목록 end -->
                    </tbody>
				</table>
				<table class="table">
                    <tr>
                    	<td>
                    	${navi.navigator}
                    	</td>
                    </tr>
                </table>
            </div>
        </div>

<%@ include file="/WEB-INF/views/common/template/bottom.jsp"%>