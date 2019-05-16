<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<div id="infoModal" class="modal fade" role="dialog">
	<div class="modal-dialog" style="width: 60%;">
	    <!-- Modal content-->
	    <div class="modal-content">
	    	<div class="modal-header">
	        	<button type="button" class="close" data-dismiss="modal">&times;</button>
	        	<h4 class="modal-title">회원 정보</h4>
	      	</div>
	      	<div class="modal-body">
	      	<form class="form-horizontal" action="#">
                    <fieldset>
	            <div class="form-group">
	                <label class="col-lg-2 control-label">아이디</label>
	
	                <div class="col-lg-8">
	                	<label id="iuserid"></label>
	                </div>
	                
	            </div>
	            <div class="form-group">
	                <label class="col-lg-2 control-label">이름</label>
	
	                <div class="col-lg-8">
	                    <label id="iusername"></label>
	                </div>
	            </div>
	            <div class="form-group">
	                <label class="col-lg-2 control-label">이메일</label>
	
	                <div class="col-lg-8">
	                    <label id="iemail"></label>
	                </div>
	            </div>
	            <div class="form-group">
	                <label class="col-lg-2 control-label">전화번호</label>
	
	                <div class="col-lg-8">
	                    <label id="itelephone"></label>
	                </div>
	            </div>
	            <div class="form-group">
	                <label class="col-lg-2 control-label">주소</label>
	
	                <div class="col-lg-8">
	                    <label id="iaddress"></label>
	                </div>
	            </div>
	            <div class="form-group">
	                <label class="col-lg-2 control-label">가입일</label>
	
	                <div class="col-lg-8">
	                    <label id="ijoindate"></label>
	                </div>
	            </div>
	            </fieldset>
	            </form>
	        </div>
	      	<div class="modal-footer">
			    <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
	      	</div>
	    </div>
	</div>
</div>
