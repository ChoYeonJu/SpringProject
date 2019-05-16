<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/admintop.jsp"%>

<!-- Center ======================================================================================= -->
        <div class="col-sm-12">
			<div class="page-header">
			    <h2 id="container">카테고리생성 및 변경</h2>
			</div>
           	
           	<script type="text/javascript">
            $(document).ready(function() {
            	var ccode;
            	$(document).on('click', '#cmodifyBtn', function() {
            		ccode = $(this).parents('li').attr('data-ccode');
            		var oldname = $(this).parents('li').children('.cname').text();
            		$('#categoryModifyModal').on('show.bs.modal', function(event) {
                		var modal = $(this);
                		modal.find('#oldcname').text(oldname);
                		modal.find('#newcname').val('');
                		modal.find('#ccode').val(ccode);
              		});          	
              		$('#categoryModifyModal').modal();
            	});
            	
            	//카테고리이름 변경
            	$('#cnameModifyBtn').click(function() {
            		var cname = $('#newcname').val();
            		alert(ccode + '번 카테고리를 ' + cname + '로 변경합니다!!!');
            		$.ajax({
        				url:'${root}/boardadmin/changecategory.cafe',  
        				type:'GET',
        				contentType:'application/json;charset=utf-8',
        				dataType:'json',
    					data : {'ccode' : ccode, 'cname' : cname},
        				success:function(response) {
        					//alert("카테고리변경성공");
        					$(document).find('[data-ccode="' + ccode + '"]').children('.cname').text(cname);
                    		$('#categoryModifyModal').modal('hide');
        				},
        				error:function(xhr,status,msg){
        					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
        				}
        			});
            	});
            	
            	//카테고리삭제
            	$(document).on('click', '#cdeleteBtn', function() {
            		//alert($(this).parents('li').attr('data-ccode'));
            		var ccode = $(this).parents('li').attr('data-ccode');
            		if(confirm(ccode + '카테고리 정말 삭제?')) {
	            		var mcForm = $('#mcForm');
	            		mcForm.find('[name="ccode"]').val(ccode);
	        			mcForm.attr('action', '${root}/boardadmin/deletecategory.cafe').attr('method', 'post');
	        			mcForm.submit();
            		}
            	});
            	
            	//카테고리생성
            	$('#createBtn').click(function() {
            		var cname = $('#cname').val();
            		if($.trim(cname) == '') {
            			alert('카테고리 이름을 입력하세요');
            			return;
            		} else {
            			//alert(cname + '으로 카테고리생성!!!');
            			var mcForm = $('#mcForm');
            			mcForm.attr('action', '${root}/boardadmin/makecategory.cafe').attr('method', 'post');
            			mcForm.submit();
            		}
            	});
            });
            </script>
            
			<div class="col-sm-12">
 				<form id="mcForm" class="form-horizontal" action="#">
 					<input type="hidden" id="ccode" name="ccode">
			    	<fieldset>
			    	<div class="form-group col-sm-12">
				    	<label class="col-sm-12 control-label">현재  카테고리 목록</label>
	
	                    <div class="col-sm-12" style="margin-left: 15px; padding: 10px; border: 1px solid #bcbcbc; border-radius: 5px;">
	                        <ul class="nav nav-pills nav-stacked">
	                        	<c:forEach var="category" items="${categorylist}">
	                        	<li data-ccode="${category.ccode}">
		                        	<div class="cname col-sm-10">${category.cname}</div>
		                        	<div class="col-sm-2">
	                        			<button type="button" id="cmodifyBtn" class="btn btn-xs btn-link" data-backdrop="static">이름변경</button>
				            			<button type="button" id="cdeleteBtn" class="btn btn-xs btn-link" data-backdrop="static">삭제</button>
	                        		</div>
	                        	</li>
	                        	</c:forEach>
	                        </ul>
	                    </div>
	                </div>
	                <div class="form-group col-sm-12">
				    	<label class="col-sm-12 control-label">생성할 카테고리이름</label>
	
	                    <div class="col-sm-12" style="margin-left: 15px; padding: 10px; border: 1px solid #bcbcbc; border-radius: 5px;">
	                        <div class="col-sm-10">
	                        	<input type="text" id="cname" name="cname" class="form-control" placeholder="카테고리이름">
	                        </div>
	                        <div class="col-sm-2">
	                        	<button type="button" id="createBtn" class="btn btn-info">카테고리생성</button>
	                        </div>
	                    </div>
	                </div>
			        </fieldset>
			    </form>
 			</div>
       	</div>
<!-- 카테고리이름변경 Modal -->
<%@ include file="/WEB-INF/views/admin/board/categorymodify.jsp"%>