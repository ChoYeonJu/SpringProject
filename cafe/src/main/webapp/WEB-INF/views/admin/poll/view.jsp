<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="pollResultModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 80%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">투표결과</h4>
	      	</div>
	      	<div class="modal-body">
		    	<div class="row">
		    		<div class="col-sm-6">
				    	<div class="col-sm-12" style="margin: 10px;">
					    	<label class="col-sm-3 control-label">질문</label>
		
		                    <div class="col-sm-9">
		                        <label id="subject" class="col-sm-12 control-label">질문이 나올거에요</label>
		                    </div>
		                </div>
				        <div class="col-sm-12" style="margin: 10px;">
					    	<label class="col-sm-3 control-label">설문기간</label>
		
		                    <div class="col-sm-9">
		                        <label id="content" class="col-sm-12 control-label">2017.07.01 ~ 2017.07.30</label>
		                    </div>
		                </div>
		                <div class="col-sm-12" style="margin: 10px;">
					    	<label class="col-sm-3 control-label">응답수</label>
		
		                    <div class="col-sm-9">
		                        <label id="content" class="col-sm-12 control-label">5214명</label>
		                    </div>
		                </div>
		                <!-- 여기부터 for문돌려라 -->
		                <div class="col-sm-12" style="margin: 10px;">
					    	<label class="col-sm-3 control-label">문항별 선택</label>
		
		                    <div class="col-sm-9">
		                        <label id="content" class="col-sm-12 control-label">Red : 300</label>
		                    </div>
		                </div>
		                <div class="col-sm-12" style="margin: 10px;">
					    	<label class="col-sm-3 control-label"></label>
		
		                    <div class="col-sm-9">
		                        <label id="content" class="col-sm-12 control-label">Blue : 50</label>
		                    </div>
		                </div>
		                <div class="col-sm-12" style="margin: 10px;">
					    	<label class="col-sm-3 control-label"></label>
		
		                    <div class="col-sm-9">
		                        <label id="content" class="col-sm-12 control-label">Yellow : 100</label>
		                    </div>
		                </div>
		                <div class="col-sm-12" style="margin: 10px;">
					    	<label class="col-sm-3 control-label"></label>
		
		                    <div class="col-sm-9">
		                        <label id="content" class="col-sm-12 control-label">Green : 160</label>
		                    </div>
		                </div>
		                <!-- 여기까지 for문돌려라 -->
	                </div>
	                <div class="col-sm-6">
				    	<div class="col-sm-12">
				    		<div class="col-sm-12">
				    			<select id="charttype1" class="form-control">
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
	                        <canvas id="pollChart1"></canvas>
	                    </div>
<!--  
	                    <div class="col-sm-6">
	                    	<div class="col-sm-12">
				    			<select id="charttype2" class="form-control">
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
	                        <canvas id="pollChart2"></canvas>
	                    </div>
-->
	                </div>
                </div>
			</div>
	      	<div class="modal-footer">
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>
<script>
$('#charttype1').change(function() {
	makeChart('pollChart1', 'charttype1');
});

$('#charttype2').change(function() {
	makeChart('pollChart2', 'charttype2');
});

function makeChart(can, ct) {
	clearCanvas(can);
	
	//alert(pollChart);
	//pollChart.destroy();
	
	//var ctx = $(can);
	var pollChart = new Chart($('#'+can), {
		type: $('#'+ct).val(),
		data: {
	    	labels: ["Red",
	              	"Blue",
	              	"Yellow",
	              	"Green"],
	    	datasets: [{
	        	label: '# of Votes',
	        	data: [300, 150, 100, 160],
	        	backgroundColor: [
	            	'rgba(255, 99, 132, 0.2)',
	            	'rgba(54, 162, 235, 0.2)',
	            	'rgba(255, 206, 86, 0.2)',
	            	'rgba(5, 255, 24, 0.2)'
	        	],
	        	borderColor: [
	            	'rgba(255,99,132,1)',
	            	'rgba(54, 162, 235, 1)',
	            	'rgba(255, 206, 86, 1)',
	            	'rgba(5, 255, 24, 0.2)'
	        	],
	    	}]
		},
		options: {
			/*scales: {
				yAxes: [{
					ticks: {
						beginAtZero:true
					}
				}]
			}*/
		}
	});
}

function clearCanvas(can){
	//alert(can);
	//$('#' + can).css('border', '3px solid red');
	//$('#' + can).parent('div').css('border', '3px solid blue');
	var canparent = $('#' + can).parent();
    $('#' + can).remove(); 
    canparent.append('<canvas id="' + can + '"></canvas>');
}
</script>