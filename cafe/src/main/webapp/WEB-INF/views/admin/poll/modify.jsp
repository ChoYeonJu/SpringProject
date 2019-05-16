<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function() {
	$(document).on('click', '#modifyBtn', function() {
		if($('#startDay').val() > $('#endDay').val()) {
			alert("투표기간 오류!!");
			return;
		} else {
			alert("투표수정!!!");
		}
	});
});
</script>
<div id="pollModifyModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 50%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">투표수정</h4>
	      	</div>
	      	<div class="modal-body">
			    <form class="form-horizontal" action="#">
			    	<fieldset>
			    	<div class="form-group">
				    	<label class="col-sm-3 control-label">투표기간</label>
	
	                    <div class="col-sm-8">
	                        <input type="date" id="startDay" class="form-control" placeholder="시작일">
	                        <input type="date" id="endDay" class="form-control" placeholder="종료일">
	                    </div>
	                </div>
	                <div class="form-group">
				    	<label class="col-sm-3 control-label">그래프형식</label>
	
	                    <div class="col-sm-8">
	                        <select id="charttype" class="form-control">
	                        	<option value="b">바차트
	                        	<option value="p">파이차트
	                        	<option value="g">꺽은선차트
	                        	<option value="l">라인차트
	                        	<option value="b">버블차트
	                        </select>
	                    </div>
	                </div>
			    	<div class="form-group">
				    	<label class="col-sm-3 control-label">주제</label>
	
	                    <div class="col-sm-8">
	                        <input type="text" id="question" class="form-control" placeholder="주제" readonly="readonly">
	                    </div>
	                </div>
			        <div class="form-group">
				    	<label class="col-sm-3 control-label">문항</label>
	                </div>
	                <div id="answerDivM" class="form-group"></div>
			        </fieldset>
			    </form>
			</div>
	      	<div class="modal-footer">
	      		<button type="button" id="modifyBtn" class="btn btn-info">투표수정</button>
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>