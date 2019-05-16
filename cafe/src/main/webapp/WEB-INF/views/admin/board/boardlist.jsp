<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<script type="text/javascript">
            $(document).ready(function() {
            	//게시판 펼치기
            	$('#categoryOpen').click(function() {
            		$(this).parent().siblings('li').children('div.tab-content').slideDown(100);
            		$(this).css('display', 'none');
            		$('#categoryClose').css('display', '');
            	});
            	//게시판 접기
            	$('#categoryClose').click(function() {
            		$(this).parent().siblings('li').children('div.tab-content').slideUp(100);
            		$(this).css('display', 'none');
            		$('#categoryOpen').css('display', '');
            	});
            	
            	$('#board_menu a.category_name').click(function() {
            		//$(this).siblings('div.tab-content').css({'color' : 'red', 'border' : '2px solid pink'}).parent().siblings('li').children('div.tab-content').css({'color' : 'red', 'border' : '2px solid blue'});
            		$(this).siblings('div.tab-content').slideDown(100).parent().siblings('li').children('div.tab-content').slideUp(100);
            	});
            	
            	$('.movelist').click(function() {
            		var bcode = $(this).attr('data-bcode');
            		var control = $(this).attr('data-control');
            		var url = '${root}/' + control + '/list.cafe?bcode=' + bcode + "&pageNo=1&key=&word=";
            		//alert(bcode + "(" + control + ")" + "번 게시판으로 이동!!!!");
            		$(location).attr('href', url);
            	});
            });
            </script>
            <div>
            	<ul id="board_menu" class="nav nav-pills nav-stacked">
            		<li>
				    	<a id="categoryOpen" data-toggle="pill" style="background: #bdc1d5; display: none;">모든게시판펼치기</a>
				    	<a id="categoryClose" data-toggle="pill" style="background: #bdc1d5;">모든게시판접기</a>
				    </li>
				    
			    <c:set var="cflag" value="0"/>
			    <c:forEach varStatus="i" var="board" items="${boardmenu}">
			    	<c:if test="${cflag != board.ccode}">
			    	<c:set var="cflag" value="${board.ccode}"/>
				    <li>
				    	<a class="category_name" data-toggle="pill" href="#home" style="background: #bcbcbc;">${board.cname}</a>
				    	<div class="tab-content">
				    		<div id="menu1">
				    			<ul class="nav nav-pills nav-stacked">
				   	</c:if>
				    				<li style="margin-left: 5%"><a class="movelist" data-toggle="collapse" data-bcode="${board.bcode}" data-control="${board.control}">${board.bname}</a></li>
				    <c:if test="${i.index < boardmenu.size() - 1}">
						<c:if test="${boardmenu.get(i.index + 1).ccode != cflag}">
				    			</ul>
						    </div>
						</div>
				    </li>
				    	</c:if>
				    </c:if>
				    </c:forEach>
				    			</ul>
							</div>
						</div>
					</li>
			  	</ul>
			</div>
