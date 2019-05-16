<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="categoryModifyModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 50%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">카테고리이름변경</h4>
	      	</div>
	      	<div class="modal-body">
			    <form class="form-horizontal" action="#">
			    	<input type="hidden" name="ccode" id="ccode">
			    	<fieldset>
			    	<div class="form-group">
				    	<label class="col-lg-3 control-label">기존카테고리이름</label>
	
	                    <label id="oldcname" class="col-lg-8 control-label"></label>
	                </div>
			        <div class="form-group">
				    	<label class="col-lg-3 control-label">변경할카테고리이름</label>
	
	                    <div class="col-lg-8">
	                        <input type="text" id="newcname" class="form-control" placeholder="카테고리새이름">
	                    </div>
	                </div>
			        </fieldset>
			    </form>
			</div>
	      	<div class="modal-footer">
	      		<button type="button" id="cnameModifyBtn" class="btn btn-info">카테고리변경</button>
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>