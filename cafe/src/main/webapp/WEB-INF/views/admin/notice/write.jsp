<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div id="noticeWriteModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 50%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">공지사항</h4>
	      	</div>
	      	<div class="modal-body">
			    <form class="form-horizontal" action="#">
			    	<fieldset>
			    	<div class="form-group">
				    	<label class="col-lg-3 control-label">제목</label>
	
	                    <div class="col-lg-8">
	                        <input type="text" id="subject" class="form-control" placeholder="제목">
	                    </div>
	                </div>
			        <div class="form-group">
				    	<label class="col-lg-3 control-label">내용</label>
	
	                    <div class="col-lg-8">
	                        <textarea id="content" class="form-control" rows="10" placeholder="내용"></textarea>
	                    </div>
	                </div>
			        </fieldset>
			    </form>
			</div>
	      	<div class="modal-footer">
	      		<button type="button" id="writeBtn" class="btn btn-info">글작성</button>
	        	<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>