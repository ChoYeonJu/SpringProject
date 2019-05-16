<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="noticeViewModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 40%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">공지사항</h4>
	      	</div>
	      	<div class="modal-body">
		    	<div class="row">
			    	<div class="col-sm-12" style="margin: 10px;">
				    	<label class="col-sm-2 control-label">제목</label>
	
	                    <div class="col-sm-10">
	                        <label id="subject" class="col-sm-12 control-label"></label>
	                    </div>
	                </div>
			        <div class="col-sm-12" style="margin: 10px;">
				    	<label class="col-sm-2 control-label">내용</label>
	
	                    <div class="col-sm-10">
	                        <label id="content" class="col-sm-12 control-label"></label>
	                    </div>
	                </div>
                </div>
			</div>
	      	<div class="modal-footer">
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>