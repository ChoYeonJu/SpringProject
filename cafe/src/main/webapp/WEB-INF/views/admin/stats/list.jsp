<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/admintop.jsp"%>

<!-- Center ======================================================================================= -->
		<script type="text/javascript">
        $(document).ready(function() {
        	//네비바 체크
        	$('#astats').addClass('active');
        	
        	//통계메뉴
        	$('.sort').click(function() {
        		$(this).addClass('active');
        		$(this).siblings().removeClass('active');
        		alert($(this).attr('data-sort') + '로 통계뽑자!!!!');
        	});
        });
        </script>
        <div class="col-sm-12">
			<div class="page-header">
			    <h2 id="container">통계</h2>
			</div>
			
			<div class="col-sm-12">
				<ul class="nav nav-tabs">
					<li class="sort active" data-sort="members"><a href="#">회원</a></li>
					<li class="sort" data-sort="articles"><a href="#">게시글</a></li>
					<li class="sort" data-sort="memos"><a href="#">댓글수</a></li>
				</ul>
			</div>
			
			<div class="col-sm-12" style="height: 15px;"></div>
			
			<div class="col-sm-12">
 				
 			</div>
 		</div>
