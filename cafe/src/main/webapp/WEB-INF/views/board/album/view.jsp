<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/top.jsp"%>
<%@ include file="/WEB-INF/views/common/template/left.jsp"%>

<!-- Center ======================================================================================= -->
        <script>
        $(document).ready(function() {
        	//글쓰기
        	$('#newBtn').click(function() {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else {
	        		$(document).find('[name="bcode"]').val('${para.bcode}');
	        		$(document).find('[name="pageNo"]').val('1');
	        		$(document).find('[name="key"]').val('');
	        		$(document).find('[name="word"]').val('');
	        		var paraForm = $('#paraForm');
	        		paraForm.attr('action', '${root}/album/write.cafe').attr('method', 'get');
	        		paraForm.submit();
        		}
        	});
        	
        	//글수정
        	$('#modiBtn').click(function() {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else {
	        		$(document).find('[name="bcode"]').val('${para.bcode}');
	        		$(document).find('[name="pageNo"]').val('${para.pageNo}');
	        		$(document).find('[name="key"]').val('${para.key}');
	        		$(document).find('[name="word"]').val('${para.word}');
	        		$(document).find('[name="seq"]').val('${article.seq}');
	        		var paraForm = $('#paraForm');
	        		paraForm.attr('action', '${root}/album/modify.cafe').attr('method', 'get');
	        		paraForm.submit();
        		}
        	});
        	
        	//글삭제
        	$('#delBtn').click(function() {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else {
	        		if(confirm("글을 삭제하시겠습니까?")) {
		        		$(document).find('[name="bcode"]').val('${para.bcode}');
		        		$(document).find('[name="pageNo"]').val('${para.pageNo}');
		        		$(document).find('[name="key"]').val('${para.key}');
		        		$(document).find('[name="word"]').val('${para.word}');
		        		$(document).find('[name="seq"]').val('${article.seq}');
		        		var paraForm = $('#paraForm');
		        		paraForm.attr('action', '${root}/album/delete.cafe').attr('method', 'get');
		        		paraForm.submit();
	        		}
        		}
        	});
        	
        	//최신목록
        	$('#firstBtn').click(function() {
        		$(document).find('[name="bcode"]').val('${para.bcode}');
        		$(document).find('[name="pageNo"]').val('1');
        		$(document).find('[name="key"]').val('');
        		$(document).find('[name="word"]').val('');
        		var paraForm = $('#paraForm');
        		paraForm.attr('action', '${root}/album/list.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//이전목록
        	$('#preBtn').click(function() {
        		$(document).find('[name="bcode"]').val('${para.bcode}');
        		$(document).find('[name="pageNo"]').val('${para.pageNo}');
        		$(document).find('[name="key"]').val('${para.key}');
        		$(document).find('[name="word"]').val('${para.word}');
        		var paraForm = $('#paraForm');
        		paraForm.attr('action', '${root}/album/list.cafe').attr('method', 'get');
        		paraForm.submit();
        	});
        	
        	//좋아요
        	$('#sweetBtn').click(function() {
        		boardSweetOrHate('Y');
        	});
        	
        	//싫어요
        	$('#hateBtn').click(function() {
        		boardSweetOrHate('N');
        	});
        	
        	function boardSweetOrHate(flag) {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else if('${userInfo.userid}' == '${article.userid}') {
        			alert("자신의 글에는 추천/비추천할 수 없습니다.");
        			return;
        		} else {
        			var params = {'seq' : '${article.seq}', mseq : 0, 'flag' : flag};
        			$.ajax({
           				url:'${root}/board/sweethate.cafe',  
           				type:'GET',
           				contentType:'application/json;charset=utf-8',
           				dataType:'json',
       					data : params,
           				success:function(response) {
           					if(response.result == 0) {
	           					$('#bsweetcnt').text(response.sweet);
	           					$('#bhatecnt').text(response.hate);
           					} else if(response.result == 100) {
           						$('#loginModal').modal();
           					} else {
           						alert("좋아요 또는 싫어요 중 한곳만 선택가능 합니다.");
           						return;
           					}
           				},
           				error:function(xhr,status,msg){
           					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
           				}
           			});
        		}
        	}
        	
        	//댓글목록
        	memoview('latest');
        	
        	//댓글 쓰기
        	$('#memoBtn').click(function() {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else {
	        		var seq = '${article.seq}';
	        		var content = $('#mcontent').val();
	        		var params = JSON.stringify({'seq' : seq, 'mcontent' : content});
	        		if(content.trim().length != 0) {
	        			$.ajax({
	           				url:'${root}/memo/write.cafe',  
	           				type:'POST',
	           				contentType:'application/json;charset=utf-8',
	           				dataType:'json',
	       					data : params,
	           				success:function(response) {
	           					makeMemoList(response);
	           					$('#mcontent').val('');
	           				},
	           				error:function(xhr,status,msg){
	           					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
	           				}
	           			});
	        		}
        		}
        	});
        	
        	$('#bestBtn').click(function() {
        		memoview('best');
        	});
        	
        	$('#latestBtn').click(function() {
        		memoview('latest');
        	});
        	
        	$(document).on('click', '#memolist>div .mmodiBtn', function() {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else {
	        		var mseq = $(this).parent().parent().attr('data-seq');
	        		$('#memocontent'+mseq).css('display', 'none');
	        		$('#memomodify'+mseq).css('display', '');
        		}
        	});
        	
        	//댓글수정취소
        	$(document).on('click', '#memolist>div .memoModifyCancelBtn', function() {
        		var mseq = $(this).parent().parent().attr('data-seq');
        		$('#memocontent'+mseq).css('display', '');
        		$('#memomodify'+mseq).css('display', 'none');
        	});
        	
        	//댓글수정
        	$(document).on('click', '#memolist>div .memoModifyBtn', function() {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else {
	        		var mseq = $(this).parent().parent().attr('data-seq');
	        		var seq = '${article.seq}';
	        		var content = $('#mcontent' + mseq).val();
	        		var params = JSON.stringify({'seq' : seq, 'mseq' : mseq, 'mcontent' : content});
	        		if(content.trim().length != 0) {
	        			$.ajax({
	           				url:'${root}/memo/modify.cafe',  
	           				type:'POST',
	           				contentType:'application/json;charset=utf-8',
	           				dataType:'json',
	       					data : params,
	           				success:function(response) {
	           					makeMemoList(response);
	           					$('#mcontent').val('');
	           				},
	           				error:function(xhr,status,msg){
	           					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
	           				}
	           			});
	        		}
        		}
        	});
        	
        	$(document).on('click', '#memolist>div .mdelBtn', function() {
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else {
	        		$.ajax({
	       				url:'${root}/memo/delete.cafe',  
	       				type:'GET',
	       				contentType:'application/json;charset=utf-8',
	       				dataType:'json',
	    				data : {'seq' : '${article.seq}', 'mseq' : $(this).parent().parent().attr('data-seq')},
	       				success:function(response) {
	       					makeMemoList(response);
	       				},
	       				error:function(xhr,status,msg){
	       					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
	       				}
	       			});
        		}
        	});
        	
        	$(document).on('click', '#memolist>div .msweetBtn', function() {
        		//var mseq = $(this).parent().parent().attr('data-seq');
        		//var userid = $(this).parent().parent().attr('data-userid');
        		memoSweetOrHate($(this), 'Y');
        	});
        	
        	$(document).on('click', '#memolist>div .mhateBtn', function() {
        		memoSweetOrHate($(this), 'N');
        	});
        	
        	function memoSweetOrHate(btn, flag) {
        		var mseq = btn.parent().parent().attr('data-seq');
        		var userid = btn.parent().parent().attr('data-userid');
        		if('${userInfo == null}' == 'true') {
        			$('#loginModal').modal();
        		} else if('${userInfo.userid}' == userid) {
        			alert("자신의 글에는 추천/비추천할 수 없습니다.");
        			return;
        		} else {
        			var params = {seq : '${article.seq}', 'mseq' : mseq, 'flag' : flag};
        			$.ajax({
           				url:'${root}/board/sweethate.cafe',  
           				type:'GET',
           				contentType:'application/json;charset=utf-8',
           				dataType:'json',
       					data : params,
           				success:function(response) {
           					if(response.result == 0) {
	           					btn.children('#msweetcnt').text(response.sweet);
	           					btn.children('#mhatecnt').text(response.hate);
           					} else if(response.result == 100) {
           						$('#loginModal').modal();
           					} else {
           						alert("좋아요 또는 싫어요 중 한곳만 선택가능 합니다.");
           						return;
           					}
           				},
           				error:function(xhr,status,msg){
           					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
           				}
           			});
        		}
        	}
        });
        
        function memoview(sort) {
        	var jsondata = '';
        	if(sort == 'best') {
        		jsondata = {'seq' : '${article.seq}', 'sort' : 'best'};
        	} else {
        		jsondata = {'seq' : '${article.seq}', 'sort' : 'latest'};
        	}
        	$.ajax({
   				url:'${root}/memo/list.cafe',  
   				type:'GET',
   				contentType:'application/json;charset=utf-8',
   				dataType:'json',
				data : jsondata,
   				success:function(response) {
   					makeMemoList(response);
   					$('#mcontent').val('');
   				},
   				error:function(xhr,status,msg){
   					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
   				}
   			});
        }
        
        function makeMemoList(memos) {
        	var memocnt = memos.memolist.length;
        	$('#memolist').children('div').remove();
        	var memostr = '';
        	for(var i=0;i<memocnt;i++) {
        		var memo = memos.memolist[i];
        		memostr += '<div class="col-sm-12" data-seq="' + memo.mseq + '" data-userid="' + memo.userid + '" style="border-bottom: 2px solid #ecf0f1; margin-top: 15px; margin-bottom: 15px;">';
        		memostr += '	<div class="pull-right">';
        		if('${userInfo.userid}' == memo.userid) {
	        		memostr += '		<button type="button" class="mmodiBtn btn btn-xs btn-link" data-backdrop="static">수정</button>';
	        		memostr += '    	<button type="button" class="mdelBtn btn btn-xs btn-link" data-backdrop="static">삭제</button>';
        		}
        		memostr += '	</div>';
        		memostr += '	<label><b>' + memo.userid + '</b>(' + memo.ipaddress + ')</label><br>';
        		
        		memostr += '	<div id="memocontent' + memo.mseq + '"><br/><br/>' + memo.mcontent.replace(/\n/g, '<br/>') + '<br/><br/><br/></div>';
        		
        		memostr += '	<div id="memomodify' + memo.mseq + '" style="display: none;">';
        		memostr += '	<form class="form-horizontal" action="#">';
        		memostr += '	<fieldset>';
        		memostr += '    	<div class="form-group" data-seq="' + memo.mseq + '">';
        		memostr += '        	<div class="col-sm-10">';
        		memostr += '            	<textarea id="mcontent' + memo.mseq + '" class="form-control" rows="3">' + memo.mcontent + '</textarea>';
        		memostr += '        	</div>';
        		memostr += '        	<div class="col-sm-2" style="text-align: left;">';
        		memostr += '        		<button type="button" class="memoModifyBtn btn btn-sm btn-default" style="height: 72px">수정</button>';
        		memostr += '        		<button type="button" class="memoModifyCancelBtn btn btn-sm btn-default" style="height: 72px">취소</button>';
        		memostr += '        	</div>';
        		memostr += '    	</div>';
        		memostr += '	</fieldset>';
        		memostr += '	</form>';
        		memostr += '	</div>';
        		
        		memostr += '	<label style="color: #a6a6a6;">' + memo.mlogtime + '</label>';
        		memostr += '	<div class="pull-right">';
        		memostr += '		<button type="button" class="msweetBtn btn btn-xs btn-danger" data-backdrop="static">좋아요(<span id="msweetcnt">' + memo.sweet + '</span>)</button>';
        		memostr += '    	<button type="button" class="mhateBtn btn btn-xs btn-primary" data-backdrop="static">싫어요(<span id="mhatecnt">' + memo.hate + '</span>)</button>';
        		memostr += '	</div>';
        		
        		
        		
        		memostr += '</div>';
        	}
        	$('#memolist').append(memostr);
        	$('#mcnt').text(memocnt);
        }
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
	            <c:if test="${userInfo.userid == article.userid || userInfo.role == 0}">
	            <button type="button" id="modiBtn" class="btn btn-xs btn-default" data-backdrop="static">수정</button>
	            <button type="button" id="delBtn" class="btn btn-xs btn-default" data-backdrop="static">삭제</button>
            	</c:if>
        	</div>
        	<div class="pull-right">
	        	<button type="button" id="firstBtn" class="btn btn-xs btn-info" data-backdrop="static">최신목록</button>
	            <button type="button" id="preBtn" class="btn btn-xs btn-info" data-backdrop="static">이전목록</button>
        	</div>
			<div style="height: 40px;"></div>
            <div class="table-responsive">
                <table class="table table-bordered">
                    <colgroup>
                        <col width="100">
                        <col width="*">
                        <col width="100">
                        <col width="*">
                        <col width="100">
                        <col width="*">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th class="text-center">제목</th>
                        <td class="text-left" colspan="5"><strong>${article.seq}. ${article.subject}</strong></td>
                    </tr>
                    <tr>
                    	<th class="text-center">작성자</th>
                        <td class="text-center">${article.username}(${article.userid})</td>
                        <th class="text-center">조회수</th>
                        <td class="text-center">${article.hit}</td>
                        <th class="text-center">작성일</th>
                        <td class="text-center">${article.logtime}</td>
                    </tr>
                    <c:if test="${article.savePicture != null}">
                    <tr>
                        <td class="text-center" colspan="6"><br/><img src="${root}/upload/album/${article.saveFolder}/${article.savePicture}"><br/></td>
                    </tr>
                    </c:if>
                    <tr>
                        <td class="text-left" colspan="6"><br/>${article.content}<br/><br/></td>
                    </tr>
                    </tbody>
                </table>
                <div class="pull" style="text-align: center;">
	        		<button type="button" id="sweetBtn" class="btn btn-md btn-danger" data-backdrop="static">좋아요(<span id="bsweetcnt">${article.sweet}</span>)</button>
	        		<button type="button" id="hateBtn" class="btn btn-md btn-primary" data-backdrop="static">싫어요(<span id="bhatecnt">${article.hate}</span>)</button>
        		</div>
            </div>
            
            <div class="col-sm-12">
            	<div class="page-header">
	                <h5 id="container">댓글 <span id="mcnt">${article.memocount}</span></h5>
	                <button type="button" id="bestBtn" class="btn btn-sm btn-link" data-backdrop="static">Best댓글</button>
		            <button type="button" id="latestBtn" class="btn btn-sm btn-link" data-backdrop="static">최신글</button>
	            </div>
		        	<form class="form-horizontal" action="#">
	                    <fieldset>
	                        <div class="form-group">
	                            <div class="col-sm-10">
	                                <textarea id="mcontent" class="form-control" rows="3" placeholder="주제와 무관한 댓글, 악플은 삭제될 수 있습니다."></textarea>
	                            </div>
	                            <div class="col-sm-2" style="text-align: left;">
	                            	<button type="button" id="memoBtn" class="btn btn-lg btn-info" style="height: 70px">작성</button>
	                            </div>
	                        </div>
	                    </fieldset>
	                </form>
	                <div class="col-sm-12" style="border-top: 2px solid #ecf0f1"></div>
	        	
	        	<!-- 댓글리스트 start -->
	        	<div id="memolist">
	        	</div>
	        	<!-- 댓글리스트 end -->
            </div>
        </div>

<%@ include file="/WEB-INF/views/common/template/bottom.jsp"%>