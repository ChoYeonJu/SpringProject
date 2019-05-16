<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function() {
	
	$('#userpwd').focusin(function() {
		$('#pwdresult').text('');
	});
	
	$('#pwdcheck').focusin(function() {
		$('#pcresult').text('');
	});
	
	$('#modifyBtn').click(function() {
		var flag = true;
		
		if($.trim($('#muserpwd').val()).length == 0) {
			$('#mpwdresult').css('color', 'red');
			$('#mpwdresult').text('비밀번호는 필수입력입니다.');
			flag = false;
		}
		
		if($('#muserpwd').val() !== $('#mpwdcheck').val()) {
			$('#mpcresult').css('color', 'red');
			$('#mpcresult').text('비밀번호가 일치하지 않습니다.');
			flag = false;
		}
		
		if(flag) {
			var userid = $('#muserid').text();
			var userpwd = $('#muserpwd').val();
			var tel1 = $('#mtel1').val();
			var tel2 = $('#mtel2').val();
			var tel3 = $('#mtel3').val();
			var zipcode = $('#mzipcode').val();
			var address = $('#maddress').val();
			var addressdetail = $('#maddressdetail').val();	
			var emailid = $('#memailid').val();	
			var emaildomain = $('#memaildomain').val();	
			var data = JSON.stringify({ 'userid' : userid, 'userpwd' : userpwd, 'tel1' : tel1, 'tel2' : tel2, 'tel3' : tel3, 'zipcode' : zipcode, 'address' : address, 'addressdetail' : addressdetail, 'emailid' : emailid, 'emaildomain' : emaildomain });
			//alert(data);
			$.ajax({ 
			    url: "${root}/member/users",  
			    type: 'PUT',  
			    dataType: 'json', 
			    data: data,
			    contentType: 'application/json;charset=UTF-8', 
			    mimeType: 'application/json',
			    success: function(response) {
			    	//alert("aa");
			    	$('#registerModal').modal('hide');
			    	$(location).attr('href', '${root}/memberadmin/list.cafe?pageNo=1');
			    }, 
			    error:function(xhr, status, message) { 
			        alert("status : " + status + " error : " + message);
			    } 
			});
		}
	});
	
	$('#mzipcode').focusin(function() {
		$('#zipModal').modal();
	});
});
</script>
<div id="modifyModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 60%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">회원 정보 수정</h4>
	      	</div>
	      	<div class="modal-body">
                <form id="registerform" class="form-horizontal" action="#">
                    <fieldset>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">아이디</label>

                            <div class="col-lg-6">
                            	<label id="muserid"></label>
                            </div>
                            
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">이름</label>

                            <div class="col-lg-6">
                                <label id="musername"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">비밀번호</label>

                            <div class="col-lg-6">
                                <input type="password" id="muserpwd" name="userpwd" class="form-control" placeholder="비밀번호">
                                <label id="mpwdresult"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">비밀번호확인</label>

                            <div class="col-lg-6">
                                <input type="password" id="mpwdcheck" class="form-control" placeholder="비밀번호 확인">
                                <label id="mpcresult"></label>
                            </div>
                        </div>
                        <!-- <div class="form-group">
                            <label class="col-lg-2 control-label">생년월일</label>

                            <div class="col-lg-10">
                                <input type="text" class="form-control" placeholder="생년월일 (입력 예: 2000-12-01)">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">성별</label>

                            <div class="col-lg-10">
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios1" value="option1" checked="">
                                        남자
                                    </label>
                                </div>
                                <div class="radio">
                                    <label>
                                        <input type="radio" name="optionsRadios" id="optionsRadios2" value="option2">
                                        여자
                                    </label>
                                </div>
                            </div>
                        </div> -->
                        <div class="form-group">
                            <label class="col-lg-2 control-label">전화번호</label>

                            <div class="col-lg-3">
                                <select id="mtel1" name="tel1" class="form-control">
                                	<option value="010">010</option>
                                	<option value="02">02</option>
                                	<option value="031">031</option>
                                </select>
							</div>
							<div class="col-lg-3">
                                <input type="text" id="mtel2" name="tel2" class="form-control" placeholder="1234">
                            </div>
                            <div class="col-lg-3">
                                <input type="text" id="mtel3" name="tel3" class="form-control" placeholder="5678">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">우편번호</label>
                            
                            <div class="col-lg-4">
                                <input type="text" id="mzipcode" name="zipcode" class="form-control" placeholder="우편번호" readonly="readonly">
                            </div>
	                    </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">주소</label>
                            <div class="col-lg-9">
                                <input type="text" id="maddress" name="address" class="form-control address" placeholder="주소" readonly="readonly">
                                <input type="text" id="maddressdetail" name="addressdetail" class="form-control" placeholder="상세주소">
                            </div>
                        </div>
                        <div class="form-group">
                        	<label class="col-lg-2 control-label">이메일</label>

                           	<div class="col-lg-4">
								<input type="text" id="memailid" name="emailid" class="form-control" placeholder="이메일">
 							</div>
							<div class="col-lg-5">
                                <select id="memaildomain" name="emaildomain" class="form-control">
                                	<option value="naver.com">naver.com</option>
                                	<option value="daum.net">daum.net</option>
                                	<option value="nate.com">nate.com</option>
                                </select>
							</div>
                        </div>
                    </fieldset>
                </form>
	        </div>
	      	<div class="modal-footer">
	      		<button type="button" id="modifyBtn" class="btn btn-info">수정</button>
			    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>
<%@ include file="/WEB-INF/views/user/zipsearch.jsp"%>