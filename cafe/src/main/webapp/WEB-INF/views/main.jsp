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
        		alert("새글쓰기");
        	});
        	
        	//글보기 페이지 이동
        	$('.article_list>tr').click(function() {
        		viewArticle(this);
     		});
        	
        	//글보기 페이지 이동
        	$('.album_list>div').click(function() {
        		viewArticle(this);
     		});
        	
        	function viewArticle(obj) {
        		var control = $(obj).attr('data-control');
        		var seq = $(obj).attr('data-seq');
        		var bcode = $(obj).attr('data-bcode');
     			$(document).find('[name="bcode"]').val(bcode);
        		$(document).find('[name="pageNo"]').val('1');
        		$(document).find('[name="key"]').val('');
        		$(document).find('[name="word"]').val('');
        		$(document).find('[name="seq"]').val(seq);
        		var paraForm = $('#paraForm');
        		paraForm.attr('action', '${root}/' + control + '/view.cafe').attr('method', 'get');
        		paraForm.submit();
        	}
     		
        	//pagenavigation 페이지 이동
        	$('.firstpage').click(function() {
        		alert("최신목록");
        	});
        	
        	$('.page').click(function() {
        		alert($(this).attr('data-page') + '로 이동');
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
        	
        	<div class="col-sm-12">			
				<div class="col-sm-6">
		        	<div>
		                <h4 id="container">[인기글]</h4>
		            </div>
		            <div class="table-responsive">
		                <!-- <table class="table table-bordered"> -->
		                <table class="table table-hover">
		                    <colgroup>
		                        <col width="*">
		                        <!-- <col width="60"> -->
		                        <col width="60">
		                    </colgroup>
		                    <thead>
		                    <tr><th colspan="3"></th></tr>
		                    <tr>
		                        <th class="text-center">제목</th>
		                        <!-- <th class="text-center">작성자</th> -->
		                        <th class="text-center">조회수</th>
		                    </tr>
		                    </thead>
		                    <tbody class="article_list">
		                    <!-- 글목록 start -->
		                    <c:forEach var="poparticle" items="${pblist}">
		                    <tr data-seq="${poparticle.seq}" data-bcode="${poparticle.bcode}" data-control="${poparticle.control}">
		                        <td class="text-left">${poparticle.seq}. ${poparticle.subject}
		                        <c:if test="${poparticle.memocount != 0}">
	                        		<span class="badge" style="background: orange;">${poparticle.memocount}</span>
	                        	</c:if>
		                        </td>
		                        <!-- <td class="text-center">${poparticle.username}</td> -->
		                        <td class="text-center">${poparticle.hit}</td>
		                    </tr>
		                    </c:forEach>
		                    <!-- 글목록 end -->
		                    </tbody>
						</table>
					</div>
				</div>
				<div class="col-sm-6">
		        	<div>
		                <h4 id="container">[최신글]</h4>
		            </div>
		            <div class="table-responsive">
		                <!-- <table class="table table-bordered"> -->
		                <table class="table table-hover">
		                    <colgroup>
		                        <col width="*">
		                        <!-- <col width="60"> -->
		                        <col width="60">
		                    </colgroup>
		                    <thead>
		                    <tr><th colspan="3"></th></tr>
		                    <tr>
		                        <th class="text-center">제목</th>
		                        <!-- <th class="text-center">작성자</th> -->
		                        <th class="text-center">조회수</th>
		                    </tr>
		                    </thead>
		                    <tbody class="article_list">
		                    <!-- 글목록 start -->
		                    <c:forEach var="newarticle" items="${nblist}">
		                    <tr data-seq="${newarticle.seq}" data-bcode="${newarticle.bcode}" data-control="${newarticle.control}">
		                        <td class="text-left">${newarticle.seq}. ${newarticle.subject}
		                        <c:if test="${newarticle.memocount != 0}">
	                        		<span class="badge" style="background: orange;">${newarticle.memocount}</span>
	                        	</c:if>
		                        </td>
		                        <!-- <td class="text-center">${newarticle.username}</td> -->
		                        <td class="text-center">${newarticle.hit}</td>
		                    </tr>
		                    </c:forEach>
		                    <!-- 글목록 end -->
		                    </tbody>
						</table>
					</div>
				</div>
			</div>
        
        	<div>
                <h4 id="container">[인기앨범]</h4>
            </div>
        	<div class="album_list row">
				<c:forEach varStatus="idx" var="popalbum" items="${palist}">
				<div class="col-md-3" data-seq="${popalbum.seq}" data-bcode="${popalbum.bcode}" data-control="${popalbum.control}">
					<div class="thumbnail">
						<c:if test="${popalbum.savePicture != null}">
								<img src="${root}/upload/album/${popalbum.saveFolder}/thumb/${popalbum.savePicture}" class="img-rounded" alt="Lights" style="width:100%">
								</c:if>
								<c:if test="${popalbum.savePicture == null}">
								<img src="${root}/img/board/noimage.png" class="img-rounded" alt="Lights" style="width:100%">
								</c:if>
						<div class="caption">
							<p>${popalbum.subject}
							<c:if test="${popalbum.memocount != 0}">
                        	<span class="badge" style="background: magenta;">${popalbum.memocount}</span>
                        	</c:if>
							</p>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
			
			<div>
                <h4 id="container">[최신앨범]</h4>
            </div>
        	<div class="album_list row">
				<c:forEach varStatus="idx" var="newalbum" items="${nalist}">
				<div class="col-md-3" data-seq="${newalbum.seq}" data-bcode="${newalbum.bcode}" data-control="${newalbum.control}">
					<div class="thumbnail">
						<c:if test="${newalbum.savePicture != null}">
								<img src="${root}/upload/album/${newalbum.saveFolder}/thumb/${newalbum.savePicture}" class="img-rounded" alt="Lights" style="width:100%">
								</c:if>
								<c:if test="${newalbum.savePicture == null}">
								<img src="${root}/img/board/noimage.png" class="img-rounded" alt="Lights" style="width:100%">
								</c:if>
						<div class="caption">
							<p>${newalbum.subject}
							<c:if test="${newalbum.memocount != 0}">
                        	<span class="badge" style="background: magenta;">${newalbum.memocount}</span>
                        	</c:if>
							</p>
						</div>
					</div>
				</div>
				</c:forEach>
			</div>
			
        </div>

<%@ include file="/WEB-INF/views/common/template/bottom.jsp"%>
