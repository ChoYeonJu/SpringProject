<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript">
$(document).ready(function() {
	var answerCount = 1;
	$('#answerPlusBtn').click(function() {
		var inp = $('<div class="col-sm-11">').append('<input type="text" name="answer" class="answerInp form-control" placeholder="문항">');
		var btn = $('<div class="col-sm-1">').append('<button type="button" class="answerMinusBtn btn btn-md btn-warning">문항제거</button>');
		$('<div id="answerD" class="col-sm-10">').append(inp).append(btn).appendTo('#answerDiv');
		answerCount++;
	});
	
	$(document).on('click', '.answerMinusBtn', function() {
		//$(this).parents('#answerD').css('border', '2px solid blue');
		$(this).parents('#answerD').remove();
		answerCount--;
	});
	
	$(document).on('click', '#writeBtn', function() {
		//http://naradesign.net/wp/2011/07/20/1663/ << 유효성검사
		alert(">>>> " + $('.answerInp').length);
		if($('#startDay').val() > $('#endDay').val()) {
			alert("투표기간 오류!!");
			return;
		} else if(answerCount < 2) {
			alert("설문 문항 오류!!");
			return;
		} else {
			alert("투표생성!!!");
		}
	});
});
</script>
<div id="pollWriteModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 50%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">투표생성</h4>
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
	                        <div class="col-sm-12">
				    			<select id="charttype" class="form-control">
		                        	<option value="line">line
		                        	<option value="bar">bar
		                        	<option value="horizontalBar">horizontalBar
		                        	<option value="pie">pie
		                        	<option value="doughnut">doughnut
		                        	<option value="polarArea">polarArea
		                        	<option value="bubble">bubble
		                        	<option value="radar">radar
		                        </select>
				    		</div>
	                    </div>
	                </div>
			    	<div class="form-group">
				    	<label class="col-sm-3 control-label">주제</label>
	
	                    <div class="col-sm-8">
	                        <input type="text" id="question" class="form-control" placeholder="주제">
	                    </div>
	                </div>
			        <div class="form-group">
				    	<label class="col-sm-3 control-label">문항</label>
				    	
	
	                    <div class="col-sm-8">
	                    	<button type="button" id="answerPlusBtn" class="btn btn-md btn-warning">문항추가</button>
	                    </div>
	                </div>
	                <div id="answerDiv" class="form-group">
                    	<div id="answerD" class="col-sm-10">
	                    	<div class="col-sm-11">
	                        	<input type="text" name="answer" class="answerInp form-control" placeholder="문항">
	                        </div>
	                        <div class="col-sm-1">
								<button type="button" class="answerMinusBtn btn btn-md btn-warning">문항제거</button>
							</div>
                        </div>
	                </div>
			        </fieldset>
			    </form>
			</div>
	      	<div class="modal-footer">
	      		<button type="button" id="writeBtn" class="btn btn-info">투표생성</button>
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>