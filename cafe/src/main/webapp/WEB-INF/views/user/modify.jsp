<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
		
		<script type="text/javascript">
		$(document).ready(function() {
			$('#modifyBtn').click(function() {
				var userpwd = $('#muserpwd').val();
				var tel1 = $('#mtel1').val();
				var tel2 = $('#mtel2').val();
				var tel3 = $('#mtel3').val();
				var zipcode = $('#mzipcode').val();
				var address = $('#maddress').val();
				var addressdetail = $('#maddressdetail').val();	
				var emailid = $('#memailid').val();	
				var emaildomain = $('#memaildomain').val();	
				var data = JSON.stringify({ 'userid' : '${userInfo.userid}', 'userpwd' : userpwd, 'tel1' : tel1, 'tel2' : tel2, 'tel3' : tel3, 'zipcode' : zipcode, 'address' : address, 'addressdetail' : addressdetail, 'emailid' : emailid, 'emaildomain' : emaildomain });
				$.ajax({ 
				    url: "${root}/member/users",  
				    type: 'PUT',  
				    dataType: 'json', 
				    data: data,
				    contentType: 'application/json;charset=UTF-8', 
				    mimeType: 'application/json',
				    success: function(response) {
				    	$('#registerModal').modal('hide');
				    	$(location).attr('href', '${root}/member/view.cafe');
				    }, 
				    error:function(xhr, status, message) { 
				        alert("status : " + status + " error : " + message);
				    } 
				});
			});
		});
		
		$('#mzipcode').focusin(function() {
			$('#zipModal').modal();
		});
        </script>
		<div id="modifyModal" class="modal fade" role="dialog">
			<div class="modal-dialog">
			    <!-- Modal content-->
			    <div class="modal-content">
			    	<div class="modal-header">
			        	<button type="button" class="close" data-dismiss="modal">&times;</button>
			        	<h4 class="modal-title">회원 정보 수정</h4>
			      	</div>
			      	<div class="modal-body">
			        	<div class="table-responsive">
			        	<form class="form-horizontal" action="#">
			                <table class="table table-bordered">
			                    <colgroup>
			                        <col width="120">
			                        <col width="*">
			                        <col width="120">
			                        <col width="*">
			                    </colgroup>
			                    <tbody>
			                    <tr>
			                        <th class="text-center">ID</th>
			                        <td id="muserid" class="text-left"></td>
			                        <th class="text-center">회원명</th>
			                        <td id="musername" class="text-left"></td>
			                    </tr>
			                    <tr>
			                    	<th class="text-center">비밀번호</th>
			                        <td class="text-left" colspan="3">
			                            <div class="col-lg-12">
			                                <input type="password" id="muserpwd" name="userpwd" class="form-control" placeholder="비밀번호">
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="text-center">이메일</th>
			                        <td class="text-left" colspan="3">
				                        <div class="col-lg-5">
											<input type="text" id="memailid" name="emailid" class="form-control" placeholder="이메일">
			 							</div>
										<div class="col-lg-7">
			                                <select id="memaildomain" name="emaildomain" class="form-control">
			                                	<option value="naver.com">naver.com</option>
			                                	<option value="daum.net">daum.net</option>
			                                	<option value="nate.com">nate.com</option>
			                                </select>
										</div>
			                        </td>
			                    </tr>
			                    <tr>
			                    	<th class="text-center">전화번호</th>
			                        <td class="text-left" colspan="3">
			                        	<div class="col-lg-4">
			                                <select id="mtel1" name="tel1" class="form-control">
			                                	<option value="010">010</option>
			                                	<option value="02">02</option>
			                                	<option value="031">031</option>
			                                </select>
										</div>
										<div class="col-lg-4">
			                                <input type="text" id="mtel2" name="tel2" class="form-control" placeholder="1234">
			                            </div>
			                            <div class="col-lg-4">
			                                <input type="text" id="mtel3" name="tel3" class="form-control" placeholder="5678">
			                            </div>
			                        </td>
			                    </tr>
			                    <tr>
			                        <th class="text-center">주소</th>
			                        <td class="text-left" colspan="3">
			                        	<div class="col-lg-4">
			                                <input type="text" id="mzipcode" name="zipcode" class="form-control zipcode" placeholder="우편번호" readonly="readonly">
			                            </div>
				                       	<div class="col-lg-12">
			                                <input type="text" id="maddress" name="address" class="form-control address" placeholder="주소" readonly="readonly">
			                                <input type="text" id="maddressdetail" name="addressdetail" class="form-control" placeholder="상세주소">
			                            </div>
			                        </td>
			                    </tr>
			                    </tbody>
			                </table>
			            </form>
			            </div>
			      	</div>
			      	<div class="modal-footer">
			      		<button type="button" id="modifyBtn" class="btn btn-info">수정</button>
			        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			      	</div>
			    </div>
			</div>
		</div>
<%@ include file="/WEB-INF/views/user/zipsearch.jsp"%>