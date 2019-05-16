<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/admintop.jsp"%>

<!-- Center ======================================================================================= -->
		<script type="text/javascript">
        $(document).ready(function() {
        	//네비바 체크
        	$('#amember').addClass('active');
        	var sort = '${listparam.sort}'.length == 0 ? 'new' : '${listparam.sort}';
        	//alert(">>>" + sort);
        	$(document).find('[data-sort="' + sort + '"]').addClass('active');
        	
        	//회원정보보기
        	$('.user_list>tr .sel').click(function() {
        		var userid = $(this).parents('tr').find('#user_id').val();
     			//alert(userid + " 회원 정보보기!!!!");
     			$.ajax({
    				url:'${root}/member/users/' + userid,  
    				type:'GET',
    				contentType:'application/json;charset=utf-8',
    				dataType:'json',

    				success:function(response) {
    					var userinfo = JSON.stringify(response);
    					console.log(userinfo);
    					//alert(userinfo);
    					//alert(response.username);
    					$('#infoModal').on('show.bs.modal', function(event) {
    	            		var modal = $(this);
    	            		//alert(">>>" + row.find('.userid').text());
    	            		//alert(">>>" + modal.find('#muserid'));
    	            		modal.find('#iuserid').text(response.userid);
    	            		modal.find('#iusername').text(response.username);
    	            		modal.find('#iemail').text(response.email);
    	            		modal.find('#itelephone').text(response.telephone);
    	            		modal.find('#iaddress').html(response.address);
    	            		modal.find('#ijoindate').text(response.joindate);
    	          		});
    					$('#infoModal').modal();
    				},
    				error:function(xhr,status,msg){
    					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
    				}
    			});
     		});
        	
        	/*$('#modiBtn').click(function() {
        		$('#modifyModal').on('show.bs.modal', function(event) {
            		var modal = $(this)
          		  	modal.find('#userpwd').val('1234');
            		modal.find('#eid').val('java2');
            		modal.find('#edomain').val('nate.com');
            		modal.find('#tel1').val('031');
            		modal.find('#tel2').val('1234');
          		  	modal.find('#tel3').val('5678');
          		 	modal.find('#nzipcode').val('58965');
          		  	modal.find('#naddress').val('경기도 성남시 중원구');
          		  	modal.find('#naddress_detail').val('545');
          		});          	
          		$('#modifyModal').modal();
        	});*/
        	
        	//회원정보수정
        	$('.btn.btn-xs.btn-primary').click(function() {
        		var row = $(this).parent('td').parent('tr');
        		//row.css('border', '2px solid lightblue');
        		var id = $(this).parents('td').siblings().eq(1).text();
        		//alert(id + " 회원 수정 이동.");
        		$('#modifyModal').on('show.bs.modal', function(event) {
            		var modal = $(this);
            		//alert(">>>" + row.find('.userid').text());
            		//alert(">>>" + modal.find('#muserid'));
            		modal.find('#muserid').text(row.find('.userid').text());
            		modal.find('#musername').text(row.find('.username').text());
            		modal.find('#memailid').val(row.find('.email1').text());
            		modal.find('#memaildomain').val(row.find('.email2').text());
            		modal.find('#mtel1').val(row.find('.tel1').text());
            		modal.find('#mtel2').val(row.find('.tel2').text());
          		  	modal.find('#mtel3').val(row.find('.tel3').text());
          		 	modal.find('#mzipcode').val(row.find('.zip').text());
          		  	modal.find('#maddress').val(row.find('.addr1').text());
          		  	modal.find('#maddressdetail').val(row.find('.addr2').text());
          		});   
        		$('#modifyModal').modal();
        	});
        	
        	//Blind
        	$('.btn.btn-xs.btn-danger').click(function() {
        		var id = $(this).parents('td').siblings().eq(1).text();
        		//alert(id + " 회원 블라인드처리.");
        		var selblind = $(this);
        		$.ajax({
    				url:'${root}/memberadmin/blind.cafe',  
    				type:'GET',
    				contentType:'application/json;charset=utf-8',
    				dataType:'json',
					data : {'userid' : id, 'role' : 2},
    				success:function(response) {
    					//alert("블라인드성공"));
    					selblind.siblings('.btn.btn-xs.btn-info').css('display', '');
    					selblind.css('display', 'none');
    				},
    				error:function(xhr,status,msg){
    					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
    				}
    			});
        	});
        	
        	//UnBlind
        	$('.btn.btn-xs.btn-info').click(function() {
        		var id = $(this).parents('td').siblings().eq(1).text();
        		//alert(id + " 회원 블라인드 해제.");
        		var selunblind = $(this);
        		$.ajax({
    				url:'${root}/memberadmin/blind.cafe',  
    				type:'GET',
    				contentType:'application/json;charset=utf-8',
    				dataType:'json',
					data : {'userid' : id, 'role' : 1},
    				success:function(response) {
    					//alert("해제성공");
    					selunblind.siblings('.btn.btn-xs.btn-danger').css('display', '');
    					selunblind.css('display', 'none');
    				},
    				error:function(xhr,status,msg){
    					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
    				}
    			});
        	});
        	
        	//정렬
        	$('.sort').click(function() {
        		$(this).addClass('active');
        		$(this).siblings().removeClass('active');
        		//alert($(this).attr('data-sort') + '로 정렬하자!!!!');
        		var pgForm = $('#pgForm');
        		pgForm.find('[name="sort"]').val($(this).attr('data-sort'));
        		pgForm.find('[name="pageNo"]').val('1');
        		pgForm.find('[name="word"]').val('');
        		pgForm.attr('action', '${root}/memberadmin/list.cafe').attr('method', 'get');
        		pgForm.submit();
        	});
        	
        	//최신목록으로 이동
        	$('.firstpage').click(function() {
        		//alert('최신목록으로 이동하자!!!!');
        		var pgForm = $('#pgForm');
        		pgForm.find('[name="pageNo"]').val('1');
        		pgForm.find('[name="word"]').val('');
        		pgForm.attr('action', '${root}/memberadmin/list.cafe').attr('method', 'get');
        		pgForm.submit();
        	});
        	
        	//페이지 번호로 이동
        	$('.page').click(function() {
        		//alert($(this).attr('data-page') + '로 이동하자!!!!');
        		var pgForm = $('#pgForm');
        		pgForm.find('[name="pageNo"]').val($(this).attr('data-page'));
        		pgForm.attr('action', '${root}/memberadmin/list.cafe').attr('method', 'get');
        		pgForm.submit();
        	});
        });
        </script>
        <form id="pgForm">
        	<input type="hidden" name="pageNo" value="${listparam.pageNo}">
        	<input type="hidden" name="sort" value="${listparam.sort}">
        	<input type="hidden" name="word" value="${listparam.word}">
        </form>
        <div class="col-sm-12">
			<div class="page-header">
			    <h2 id="container">회원목록</h2>
			</div>
			
			<div class="col-sm-12">
				<ul class="nav nav-tabs">
					<li class="sort" data-sort="new"><a href="#">최신가입</a></li>
					<li class="sort" data-sort="old"><a href="#">최장가입</a></li>
					<li class="sort" data-sort="name"><a href="#">이름</a></li>
					<li class="sort" data-sort="id"><a href="#">아이디</a></li>
					<li class="sort" data-sort="blind"><a href="#">블라인드회원</a></li>
				</ul>
			</div>
			
			<div class="col-sm-12" style="height: 15px;"></div>
			
			<div class="col-sm-12">
 				<div class="table-responsive">
            		<table class="table table-hover">
	            		<colgroup>
	                        <col width="40">
	                        <col width="80">
	                        <col width="80">
	                        <col width="80">
	                        <col width="*">
	                        <col width="80">
	                        <col width="80">
	                        <col width="120">
	                    </colgroup>
                    	<thead>
                        <tr>
	                        <th class="text-center">no</th>
	                        <th class="text-center">ID</th>
	                        <th class="text-center">회원명</th>
	                        <th class="text-center">EMAIL</th>
	                        <th class="text-center">주소</th>
	                        <th class="text-center">전화번호</th>
	                        <th class="text-center">가입일</th>
	                        <th class="text-center">비고</th>
	                    </tr>
	                    </thead>
	                    <tbody class="user_list">	                    
	                    <c:if test="${userlist.size() == 0}">
                        <tr>
                        	<td colspan="5" class="text-center">가입한 회원이 없습니다.</td>
                        </tr>
                        </c:if>
                        <c:if test="${userlist.size() != 0}">
                        <c:forEach varStatus="idx" var="user" items="${userlist}">
                        <tr>
                            <td class="sel text-center">${idx.count}</td>
                            <td class="sel"><span class="userid">${user.userid}</span></td>
                            <td class="sel"><span class="username">${user.username}</span></td>
                            <td class="sel"><span class="email1">${user.emailid}</span>@<span class="email2">${user.emaildomain}</span></td>
                            <td class="sel"><span class="zip">${user.zipcode}</span> <span class="addr1">${user.address}</span> <span class="addr2">${user.addressdetail}</span></td>
                            <td class="sel text-center"><span class="tel1">${user.tel1}</span>-<span class="tel2">${user.tel2}</span>-<span class="tel3">${user.tel3}</span></td>
                            <td class="sel text-center">${user.joindate}</td>
                            <td class="text-center">
                            	<button type="button" id="modiBtn" class="btn btn-xs btn-primary" data-backdrop="static">수정</button>
            					<button type="button" id="blockBtn" class="btn btn-xs btn-danger" data-backdrop="static" style="display: ${user.role == 2 ? 'none' : ''};">Block</button>
            					<button type="button" id="blockBtn" class="btn btn-xs btn-info" data-backdrop="static" style="display: ${user.role == 2 ? '' : 'none'};">UnBlock</button>
                            </td>
                            <input type="hidden" id="user_id" value="${user.userid}">
                        </tr>
                        </c:forEach>
                        </c:if>

                        </tbody>
                    </table>
                </div>
			</div>
        </div>
        
        <div class="col-sm-12" style="height: 5px;"></div>
        
        <div class="col-sm-12">
	        <form class="form-search">
	        	<input type="hidden" name="pageNo" value="1">
	            <div class="input-group">
	                <input type="text" name="word" class="form-control" placeholder="회원명 또는 ID">
	                <span class="input-group-btn">
	                    <button type="submit" class="btn btn-primary">검색</button>
	                </span>
	            </div>
	        </form>
		</div>
		
		<!-- 페이징처리 -->
        ${navi.navigator}
        
       	<!-- 회원정보 수정 Modal -->
        <%@ include file="/WEB-INF/views/admin/user/modify.jsp"%>
        <!-- 회원정보 보기 Modal -->
        <%@ include file="/WEB-INF/views/admin/user/info.jsp"%>
