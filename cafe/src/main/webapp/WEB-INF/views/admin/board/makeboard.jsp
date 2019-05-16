<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/admintop.jsp"%>

<!-- Center ======================================================================================= -->
        <div class="col-sm-12">
			<div class="page-header">
			    <h2 id="container">게시판생성 및 변경</h2>
			</div>
           	
           	<script type="text/javascript">
            $(document).ready(function() {
            	var selectcategory = '';
            	var selecttype = '';
            	var jsonobject = ${jsonobject};
            	var boardlength = jsonobject.jsonboard.length;
            	
            	$(document).on('change', '#ccode', function() {
            		selectcategory = $('#ccode option:selected').text();
            		$('#boardnames').text(selectcategory);
            		$('#mcategory').text(selectcategory);
            		
            		$('#blist').children('li').remove();
            		var li = '';
            		for(var i=0;i<boardlength;i++) {
            			var board = jsonobject.jsonboard[i];
            			//alert($('#ccode').val() + "     :::::    " + board.ccode + "     :::::    " + board.btype);
            			if($('#ccode').val() == board.ccode) {
		            		li += '<li data-bcode="' + board.bcode + '" data-btype="' + board.btype + '">';
		            		li += '	<div class="bname col-sm-10">' + board.bname + '</div>';
		            		li += '	<div class="col-sm-2">';
		            		li += '		<button type="button" id="bmodifyBtn" class="btn btn-xs btn-link" data-backdrop="static">이름변경</button>';
		            		li += '		<button type="button" id="bdeleteBtn" class="btn btn-xs btn-link" data-backdrop="static">삭제</button>';
		            		li += '	</div>';
		            		li += '</li>';
            			}
            		}
	            	$('#blist').append(li);
            	});
            	
            	$(document).on('change', '#btype', function() {
            		selecttype = $('#btype option:selected').text();
            		$('#mtype').text(selecttype);
            	});
            	
            	//게시판이름변경 모달창
            	var bcode;
            	var btype;
            	$(document).on('click', '#bmodifyBtn', function() {
            		bcode = $(this).parents('li').attr('data-bcode');
            		btype = $(this).parents('li').attr('data-btype');
            		var oldname = $(this).parents('li').children('.bname').text();
            		$('#boardModifyModal').on('show.bs.modal', function(event) {
                		var modal = $(this);
                		modal.find('#oldbname').text(oldname);
                		modal.find('#newbname').val('');
                		modal.find('#newbtype').val(btype);
                		//modal.find('#bcode').val(bcode);
              		});          	
              		$('#boardModifyModal').modal();
            	});
            	
            	//게시판이름변경
               	$('#bnameModifyBtn').click(function() {
               		var bname = $('#newbname').val();
               		var btype = $('#newbtype').val();
               		//alert(bcode + '번 게시판이름을 ' + bname + '(' + btype + ')로 변경합니다.');
               		$.ajax({
           				url:'${root}/boardadmin/changeboard.cafe',  
           				type:'GET',
           				contentType:'application/json;charset=utf-8',
           				dataType:'json',
       					data : {'bcode' : bcode, 'bname' : bname, 'btype' : btype},
           				success:function(response) {
           					//alert("카테고리변경성공");
           					$(document).find('[data-bcode="' + bcode + '"]').children('.bname').text(bname);
                       		$('#boardModifyModal').modal('hide');
           				},
           				error:function(xhr,status,msg){
           					console.log("상태값 : " + status + " Http에러메시지 : "+msg);
           				}
           			});
               	});
            	
            	//게시판삭제
            	$(document).on('click', '#bdeleteBtn', function() {
            		//alert($(this).parents('li').attr('data-bcode'));
            		var bcode = $(this).parents('li').attr('data-bcode');
            		if(confirm(bcode + '게시판 정말 삭제?')) {
	            		var mbForm = $('#mbForm');
	            		mbForm.find('[name="delbcode"]').val(bcode);
	            		mbForm.attr('action', '${root}/boardadmin/deleteboard.cafe').attr('method', 'post');
	            		mbForm.submit();
            		}
            	});
            	
            	//게시판생성
            	$(document).on('click', '#createBtn', function() {
            		if($('#ccode option:selected').length != 1) {
            			alert('한개의 카테고리를 선택하세요');
            			return;
            		} else if($('#btype option:selected').length != 1) {
            			alert('한개의 게시판형식을 선택하세요');
            			return;
            		} else if($.trim($('#bname').val()) == '') {
            			alert('게시판 이름 입력하세요');
            			return;
            		} else {
            			//alert($('#ccode').val() + " ::: " + $('#btype').val() + "   :::   " + $('#bname').val());
            			//alert(selectcategory + '카테고리에 ' + selecttype + '형식의 ' + $('#bname').val() + '이름으로 게시판생성!!!');
            			var mbForm = $('#mbForm');
            			mbForm.attr('action', '${root}/boardadmin/makeboard.cafe').attr('method', 'post');
            			mbForm.submit();
            		}
            	});
            });
            </script>
            
			<div class="col-sm-12">
 				<form id="mbForm" class="form-horizontal">
 					<input type="hidden" id="delbcode" name="delbcode">
			    	<fieldset>
			    	<div class="form-group col-sm-12">
				    	<label class="col-sm-12 control-label">카테고리 선택</label>
	
	                    <div class="col-sm-12">
	                        <select multiple class="form-control" id="ccode" name="ccode">
                        	<c:forEach var="category" items="${categorylist}">
                        		<option value="${category.ccode}" data-bn="${category.cname}">${category.cname}</option>
                        	</c:forEach>
							</select>
	                    </div>
	                </div>
			    	<div class="form-group col-sm-12">
				    	<label class="col-sm-12 control-label">게시판형식 선택</label>
	
	                    <div class="col-sm-12">
	                        <select multiple class="form-control" id="btype" name="btype">
	                        <c:forEach var="boardtype" items="${boardtypelist}">
                        		<option value="${boardtype.btype}">${boardtype.btypeName}</option>
                        	</c:forEach>
							</select>
	                    </div>
	                </div>
			    	<div class="form-group col-sm-12">
				    	<label class="col-sm-12 control-label">현재  <span id="boardnames"></span> 게시판</label>
	
	                    <div class="col-sm-12" style="margin-left: 15px; padding: 10px; border: 1px solid #bcbcbc; border-radius: 5px;">
	                        <ul id="blist" class="nav nav-pills nav-stacked">
	                        <c:forEach var="board" items="${boardlist}">
	                        	<li data-bcode="${board.bcode}" data-btype="${board.btype}">
	                        		<div class="bname col-sm-10">${board.bname}</div>
	                        		<div class="col-sm-2">
	                        			<button type="button" id="bmodifyBtn" class="btn btn-xs btn-link" data-backdrop="static">이름변경</button>
				            			<button type="button" id="bdeleteBtn" class="btn btn-xs btn-link" data-backdrop="static">삭제</button>
	                        		</div>
	                        	</li>
	                        </c:forEach>
	                        </ul>
	                    </div>
	                </div>
	                <div class="form-group col-sm-12">
				    	<label class="col-sm-12 control-label">생성할 게시판이름</label>
	
	                    <div class="col-sm-12" style="margin-left: 15px; padding: 10px; border: 1px solid #bcbcbc; border-radius: 5px;">
	                        <div class="col-sm-10">
	                        	<label class="col-sm-12"><span id="mcategory"></span> &gt;&gt; <span id="mtype"></span></label>
	                        </div>
	                        <div class="col-sm-10">
	                        	<input type="text" id="bname" name="bname" class="form-control" placeholder="게시판이름">
	                        </div>
	                        <div class="col-sm-2">
	                        	<button type="button" id="createBtn" class="btn btn-info">게시판생성</button>
	                        </div>
	                    </div>
	                </div>
			        </fieldset>
			    </form>
 			</div>
       	</div>
<!-- 게시판이름변경 Modal -->
<%@ include file="/WEB-INF/views/admin/board/boardmodify.jsp"%>