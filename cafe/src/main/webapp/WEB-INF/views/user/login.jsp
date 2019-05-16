<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<script type="text/javascript">
$(document).ready(function() {
	$('#loginBtn').click(function() {
		if($.trim($('#loginModal #luserid').val()).length != 0 && $.trim($('#loginModal #luserpwd').val()).length != 0) { //id pw 입력
			$('#loginform').attr('method', 'POST').attr('action', '${root}/member/login.cafe').submit();
		}
	});
});

</script>
        
<div id="loginModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 30%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">로그인</h4>
	      	</div>
	      	<div class="modal-body">
			    <form id="loginform" class="form-horizontal" action="#">
			    	<fieldset>
			    	<div class="form-group">
				    	<label class="col-lg-3 control-label">아이디</label>
	
	                    <div class="col-lg-8">
	                        <input type="text" name="userid" id="luserid" class="form-control" placeholder="아이디">
	                    </div>
	                </div>
			        <div class="form-group">
				    	<label class="col-lg-3 control-label">비밀번호</label>
	
	                    <div class="col-lg-8">
	                        <input type="password" name="userpwd" id="luserpwd" class="form-control" placeholder="비밀번호">
	                    </div>
	                </div>
			        </fieldset>
			    </form>
			</div>
	      	<div class="modal-footer">
	      		<button type="button" id="loginBtn" class="btn btn-info">로그인</button>
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>
