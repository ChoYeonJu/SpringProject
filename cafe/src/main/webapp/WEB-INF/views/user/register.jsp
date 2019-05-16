<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">

$(document).ready(function() {
	var idcheck = false;
	$(document).on('keyup', '#registerid', function() {
		var userid = $.trim($(this).val()); // input 에 잆는 
		if(userid.length < 6 || userid.length > 16) {
			$('#idresult').css('color', 'black');
			$('#idresult').text('아이디는 6자이상 16자 이하입니다.');
		} else {
			$.ajax({
				type : 'GET',			
				dataType : 'json',		
				url : '${root}/member/idcheck.cafe',
				data : {'userid' : userid},
				success : function (data) {
					$('#idresult').empty();
					if(parseInt(data.idcount) == 0) {
						$('#idresult').css('color', 'skyblue');
						$('#idresult').text(userid + '는 사용 가능합니다.');
						idcheck = true;
					} else {
						$('#idresult').css('color', 'red');
						$('#idresult').text(userid + '는 사용중 입니다.');
					}
				},
				error : function (e) {
					alert("에러");
				}
			});
		}
	});
	
	$('#registerBtn').click(function() {
		var flag = true;
		if(!idcheck) {
			$('#idresult').css('color', 'red');
			$('#idresult').text('아이디 중복을 확인하세요.');
			flag = false;
		}
		
		if($.trim($('#username').val()).length == 0) {
			$('#nameresult').css('color', 'red');
			$('#nameresult').text('이름은 필수입력입니다.');
			flag = false;
		}
		
		if($.trim($('#userpwd').val()).length == 0) {
			$('#pwdresult').css('color', 'red');
			$('#pwdresult').text('비밀번호는 필수입력입니다.');
			flag = false;
		}
		
		if($('#userpwd').val() !== $('#pwdcheck').val()) {
			$('#pcresult').css('color', 'red');
			$('#pcresult').text('비밀번호가 일치하지 않습니다.');
			flag = false;
		}
		
		if(flag) {
			//RESTfull API이용
			var userid = $('input:text[name="userid"]').val();
			var username = $('input:text[name="username"]').val();
			var userpwd = $('input:password[name="userpwd"]').val();
			var tel1 = $('select[name="tel1"]').val();
			var tel2 = $('input:text[name="tel2"]').val();
			var tel3 = $('input:text[name="tel3"]').val();
			var zipcode = $('input:text[name="zipcode"]').val();
			var address = $('input:text[name="address"]').val();
			var addressdetail = $('input:text[name="addressdetail"]').val();	
			var emailid = $('input:text[name="emailid"]').val();	
			var emaildomain = $('select[name="emaildomain"]').val();	
			var data = JSON.stringify({ 'userid' : userid, 'username' : username, 'userpwd' : userpwd, 'tel1' : tel1, 'tel2' : tel2, 'tel3' : tel3, 'zipcode' : zipcode, 'address' : address, 'addressdetail' : addressdetail, 'emailid' : emailid, 'emaildomain' : emaildomain });
			$.ajax({ 
			    url: "${root}/member/users",  
			    type: 'POST',  			//insert를 위해서 
			    dataType: 'json', 
			    data: data',
			    contentType: 'application/json;charset=UTF-8', 
			    mimeType: 'application/json',
			    success: function(response) {
			    	$('#registerModal').modal('hide');
			    	if(response.result == 'ok') {
			    		$('#loginModal').modal();
			    	}
			    }, 
			    error:function(xhr, status, message) { 
			        alert(" status: " + status + " error:" + message);
			    } 
			 });
		}
	});
	
	$('#username').focusin(function() {
		$('#nameresult').text('');
	});
	
	$('#userpwd').focusin(function() {
		$('#pwdresult').text('');
	});
	
	$('#pwdcheck').focusin(function() {
		$('#pcresult').text('');
	});
	
	$('#zipcode').focusin(function() {
		$('#zipModal').modal();
	});
});
</script>
<div id="registerModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 60%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">회원 정보 입력</h4>
	      	</div>
	      	<div class="modal-body">
                <form id="registerform" class="form-horizontal" action="#">
                    <fieldset>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">아이디</label>

                            <div class="col-lg-6">
                                <input type="text" id="registerid" name="userid" class="form-control" placeholder="아이디" maxlength="16">
                            	<label id="idresult"></label>
                            </div>
                            
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">이름</label>

                            <div class="col-lg-6">
                                <input type="text" id="username" name="username" class="form-control" placeholder="이름">
                                <label id="nameresult"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">비밀번호</label>

                            <div class="col-lg-6">
                                <input type="password" id="userpwd" name="userpwd" class="form-control" placeholder="비밀번호" maxlength="20">
                                <label id="pwdresult"></label>
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">비밀번호확인</label>

                            <div class="col-lg-6">
                                <input type="password" id="pwdcheck" class="form-control" placeholder="비밀번호 확인" maxlength="20">
                                <label id="pcresult"></label>
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
                                <select id="tel1" name="tel1" class="form-control">
                                	<option value="010">010</option>
                                	<option value="02">02</option>
                                	<option value="031">031</option>
                                </select>
							</div>
							<div class="col-lg-3">
                                <input type="text" id="tel2" name="tel2" class="form-control" placeholder="1234" maxlength="4">
                            </div>
                            <div class="col-lg-3">
                                <input type="text" id="tel3" name="tel3" class="form-control" placeholder="5678" maxlength="4">
                            </div>
                        </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">우편번호</label>
                            
                            <div class="col-lg-4">
                                <input type="text" id="zipcode" name="zipcode" class="form-control zipcode" placeholder="우편번호" maxlength="5" readonly="readonly">
                            </div>
	                    </div>
                        <div class="form-group">
                            <label class="col-lg-2 control-label">주소</label>
                            <div class="col-lg-9">
                                <input type="text" id="address" name="address" class="form-control address" placeholder="주소" readonly="readonly">
                                <input type="text" id="addressdetail" name="addressdetail" class="form-control" placeholder="상세주소">
                            </div>
                        </div>
                        <div class="form-group">
                        	<label class="col-lg-2 control-label">이메일</label>

                           	<div class="col-lg-4">
								<input type="text" id="emailid" name="emailid" class="form-control" placeholder="이메일">
 							</div>
							<div class="col-lg-5">
                                <select id="emaildomain" name="emaildomain" class="form-control">
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
	      		<button type="button" id="registerBtn" class="btn btn-info">가입</button>
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>
<%@ include file="/WEB-INF/views/user/zipsearch.jsp"%>