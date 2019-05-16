<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
			<div class="col-sm-12" style="border: 2px solid #bcbcbc; border-radius: 10px;">
				<div style="text-align: center;">
	                <h5 style="color: #000066;"><strong>[ 투표해요 !!! ]</strong></h5>
	            </div><br>
			    <form class="form-horizontal" action="#">
			    	<fieldset>
			        <div class="form-group">
	                    <div class="col-sm-12">
	                    	<label id="question">가장 좋아하는 과목은?</label>
	                        <div class="radio">
							  	<label><input type="radio" name="answer" value="">JAVA</label>
							</div>
							<div class="radio">
							  	<label><input type="radio" name="answer">JSP</label>
							</div>
							<div class="radio">
							  	<label><input type="radio" name="answer">Spring</label>
							</div>
							<div class="radio">
							  	<label><input type="radio" name="answer">Android</label>
							</div>
	                    </div>
	                </div>
	                <div class="form-group pull-right">
		                <div class="col-sm-12">
				      		<button type="button" id="pollBtn" class="btn btn-xs btn-info">투표하기</button>
				        	<button type="button" id="resultBtn" class="btn btn-xs btn-default">결과보기</button>
				      	</div>
				    </div>
				    <div class="pull-right">
                   		<label id="period">투표기간 : 2017.07.01 ~ 2017.07.30</label>
                   	</div>
			        </fieldset>
			    </form>
			</div>