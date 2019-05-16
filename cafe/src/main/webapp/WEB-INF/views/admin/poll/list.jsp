<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/admintop.jsp"%>

<!-- Center ======================================================================================= -->
        <div class="col-sm-12">
			<div class="page-header">
			    <h2 id="container">온라인투표</h2>
			</div>
			
			<div class="pull-right">
				<a class="pill" data-toggle="modal" data-target="#pollWriteModal" data-backdrop="static">
           		<button type="button" id="newBtn" class="btn btn-sm btn-default" data-backdrop="static">투표생성</button>
           		</a>
           	</div>
           	
           	<script type="text/javascript">
            $(document).ready(function() {
            	//네비바 체크
            	$('#apoll').addClass('active');
            	
            	//결과보기
            	$('.btn.btn-xs.btn-primary').click(function() {
            		var seq = $(this).parents('td').siblings().eq(0).text();
            		alert(seq + "번 투표 결과보기 이동!!!");
            		$('#pollResultModal').on('show.bs.modal', function(event) {
            			var modal = $(this)
              		  	modal.find('#charttype1').val('pie');
              		  	modal.find('#charttype2').val('doughnut');
              		});          	
              		$('#pollResultModal').modal();
            	});
            	
            	//투표수정
            	$('.btn.btn-xs.btn-info').click(function() {
            		var seq = $(this).parents('td').siblings().eq(0).text();
            		alert(seq + "번 투표 기간변경 이동!!!");
            		var sday = $('#sd' + seq).text().replace(/\./g, '-');
            		var eday = $('#ed' + seq).text().replace(/\./g, '-');
            		alert("시작일 : " + sday + "    종료일 : " + eday);
            		$('#pollModifyModal').on('show.bs.modal', function(event) {
            			var modal = $(this)
              		  	modal.find('#startDay').val('20' + sday);
                		modal.find('#endDay').val('20' + eday);
                		modal.find('#charttype').val('p');
                		modal.find('#question').val('질문이 나와요!!!!');
                		for(var i=1;i<5;i++) {
                			var lab = $('<label class="col-sm-3"></label>');
	                		var inp = $('<div class="col-sm-8">')
	                					.append('<input type="text" name="answer" class="answerInp form-control" value="답변문항' + i + '입니다." readonly="readonly">');
	                		modal.find('#answerDivM').append(lab).append(inp);
            			}
              		});          	
              		$('#pollModifyModal').modal();
            	});
            	
            	//투표종료
            	$('.btn.btn-xs.btn-danger').click(function() {
            		var seq = $(this).parents('td').siblings().eq(0).text();
            		alert(seq + "번 투표 종료!!!");
            	});
            	
            });
            </script>
            
			<div class="col-sm-12">
 				<div class="table-responsive">
            		<table class="table table-hover">
                    	<colgroup>
                        <col width="80">
                        <col width="*">
                        <col width="80">
                        <col width="220">
                        <col width="220">
                    </colgroup>
                    <thead>
                    <tr><th colspan="5"></th></tr>
                    <tr>
                        <th class="text-center">번호</th>
                        <th class="text-center">질문</th>
                        <th class="text-center">참여수</th>
                        <th class="text-center">투표기간</th>
                        <th class="text-center">비고</th>
                    </tr>
                    </thead>
                    <tbody class="notice_list">
                        <!--<tr><td colspan="5" class="text-center">가입한 회원이 없습니다.</td></tr>-->
                        <tr data-seq="2">
                            <td class="text-center">2</td>
                            <td class="subject">이번 여름 휴가지로 가고싶은곳은?</td>
                            <td class="text-center">3258</td>
                            <td class="text-center"><span id="sd2">17.07.01</span> ~ <span id="ed2">17.07.30</span></td>
                            <td class="etc text-center">
                            	<button type="button" id="pollResultBtn" class="btn btn-xs btn-primary" data-backdrop="static">결과보기</button>
            					<button type="button" id="pollModifyBtn" class="btn btn-xs btn-info" data-backdrop="static">기간변경</button>
            					<button type="button" id="pollStopBtn" class="btn btn-xs btn-danger" data-backdrop="static">투표종료</button>
                            </td>
                        </tr>
                        <tr data-seq="1">
                            <td class="text-center">1</td>
                            <td class="subject">가장 좋아하는 과목은 무엇입니까??</td>
                            <td class="text-center">1867</td>
                            <td class="text-center"><span id="sd1">17.06.01</span> ~ <span id="ed1">17.06.15</span></td>
                            <td class="etc text-center">
                            	<button type="button" id="pollResultBtn" class="btn btn-xs btn-primary" data-backdrop="static">결과보기</button>
            					<button type="button" id="pollModifyBtn" class="btn btn-xs btn-info" data-backdrop="static">기간변경</button>
            					<button type="button" id="pollStopBtn" class="btn btn-xs btn-danger" data-backdrop="static">투표종료</button>
                            </td>
                        </tr>
                        </tbody>
                    </table>
                </div>
			</div>
        </div>
        
        <div class="col-sm-12" style="height: 5px;"></div>
        
        <div class="col-sm-12">
	        <form class="form-search">
	            <div class="input-group">
	                <input type="text" class="form-control" placeholder="제목">
	                <span class="input-group-btn">
	                    <button type="submit" class="btn btn-primary">검색</button>
	                </span>
	            </div>
	        </form>
		</div>
		
        <div class="col-sm-12" style="text-align: center;">
          	<ul class="pagination">
          		<li class="firstpage">
          			<a href="#" aria-label="Previous">
          				<span aria-hidden="true">최신</span>
          			</a>
		    	</li>
          		<li class="page" data-page="0">
          			<a href="#" aria-label="Previous">
          				<span aria-hidden="true">이전</span>
          			</a>
			    </li>
				<li class="page" data-page="1"><a href="#">1</a></li>
				<li class="page active" data-page="2"><a href="#">2</a></li>
				<li class="page" data-page="3"><a href="#">3</a></li>
				<li class="page" data-page="4"><a href="#">4</a></li>
				<li class="page" data-page="5"><a href="#">5</a></li>
				<li class="page" data-page="6"><a href="#">6</a></li>
				<li class="page" data-page="7"><a href="#">7</a></li>
				<li class="page" data-page="8"><a href="#">8</a></li>
				<li class="page" data-page="9"><a href="#">9</a></li>
				<li class="page" data-page="10"><a href="#">10</a></li>
				<li class="page" data-page="11">
	          		<a href="#" aria-label="Next">
	          			<span aria-hidden="true">다음</span>
	          		</a>
			    </li>
			    <li class="page" data-page="100">
	          		<a href="#" aria-label="Next">
	          			<span aria-hidden="true">마지막</span>
	          		</a>
			    </li>
			</ul>
       	</div>

<!-- 공지사항 작성 Modal -->
<%@ include file="/WEB-INF/views/admin/poll/write.jsp"%>

<!-- 공지사항 보기 Modal -->
<%@ include file="/WEB-INF/views/admin/poll/view.jsp"%>

<!-- 공지사항 수정 Modal -->
<%@ include file="/WEB-INF/views/admin/poll/modify.jsp"%>