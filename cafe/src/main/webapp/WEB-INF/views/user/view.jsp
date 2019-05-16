<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/top.jsp"%>
<%@ include file="/WEB-INF/views/common/template/left.jsp"%>
<c:if test="${user == null}">
	<c:redirect url="/commons/index.cafe"/>
</c:if>
<c:if test="${user != null}">
<!-- Center ======================================================================================= -->
        <div class="col-sm-9">
        	<div class="page-header">
                <h2 id="container">회원 정보</h2>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered">
                    <colgroup>
                        <col width="120">
                        <col width="*">
                        <col width="120">
                        <col width="*">
                    </colgroup>
                    <tbody>
                    <tr>
                        <th class="text-center">ID(이메일)</th>
                        <td class="text-left">${user.userid}(${user.emailid}@${user.emaildomain})</td>
                        <th class="text-center">회원명</th>
                        <td class="text-left">${user.username}</td>
                    </tr>
                    <tr>
                    	<th class="text-center">전화번호</th>
                        <td class="text-left">${user.tel1}-${user.tel2}-${user.tel3}</td>
                        <th class="text-center">가입일</th>
                        <td class="text-left">${user.joindate}</td>
                    </tr>
                    <tr>
                        <th class="text-center">주소</th>
                        <td class="text-left" colspan="3">${user.zipcode} ${user.address} ${user.addressdetail}</td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <script type="text/javascript">
            $(document).ready(function() {
            	$('#modiBtn').click(function() {
            		$('#modifyModal').on('show.bs.modal', function(event) {
                		var modal = $(this)
              		  	modal.find('#muserid').text('${user.userid}');
              		  	modal.find('#musername').text('${user.username}');
                		modal.find('#memailid').val('${user.emailid}');
                		modal.find('#memaildomain').val('${user.emaildomain}');
                		modal.find('#mtel1').val('${user.tel1}');
                		modal.find('#mtel2').val('${user.tel2}');
              		  	modal.find('#mtel3').val('${user.tel3}');
              		 	modal.find('#mzipcode').val('${user.zipcode}');
              		  	modal.find('#maddress').val('${user.address}');
              		  	modal.find('#maddressdetail').val('${user.addressdetail}');
              		});          	
              		$('#modifyModal').modal();
            	});
            	
            	$('#delBtn').click(function() {
            		if(confirm('정말로 탈퇴하시겠습니까?')) {
            			$.ajax({
        					url:'${root}/member/users/${user.userid}',  
        					type:'DELETE',
        					contentType:'application/json;charset=utf-8',
        					dataType:'json',
        					success:function(response) {
        						console.log(response.result);
        						$(location).attr('href', '${root}/member/logout.cafe');
        					},
        					error:function(xhr,status,msg){
        						console.log("상태값 : " + status + " Http에러메시지 : "+msg);
        					}
        				});
            		}
            	});
            });
            </script>
            <div class="pull-right">
            	<button type="button" id="modiBtn" class="btn btn-success" data-backdrop="static">수정</button>
            	<!-- button type="button" class="btn btn-success" data-toggle="modal" data-target="#modifyModal" data-backdrop="static">수정</button -->
                <!-- a href="./modify.html" class="btn btn-success btn-default">수정</a-->
                <a href="#" id="delBtn" class="btn btn-large btn-default">탈퇴</a>
            </div>

        </div>
        <!-- 회원정보 수정 Modal -->
        <%@ include file="/WEB-INF/views/user/modify.jsp"%>
</c:if>
<%@ include file="/WEB-INF/views/common/template/bottom.jsp"%>