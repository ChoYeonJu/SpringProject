<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/template/top.jsp"%>
<%@ include file="/WEB-INF/views/common/template/left.jsp"%>

		<script src="${root}/SE2/js/HuskyEZCreator.js"></script>
		<script type="text/javascript">
		var oEditors = []; // 개발되어 있는 소스에 맞추느라, 전역변수로 사용하였지만, 지역변수로 사용해도 전혀 무관 함.
		
		$(document).ready(function() {
			// Editor Setting
			nhn.husky.EZCreator.createInIFrame({
				oAppRef : oEditors, // 전역변수 명과 동일해야 함.
				elPlaceHolder : "content", // 에디터가 그려질 textarea ID 값과 동일 해야 함.
				sSkinURI : "${root}/SE2/SmartEditor2Skin.html", // Editor HTML
				fCreator : "createSEditor2", // SE2BasicCreator.js 메소드명이니 변경 금지 X
				htParams : {
					// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseToolbar : true,
					// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : true,
					// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true, 
				}
			});
			
			$('#writeBtn').click(function() {
				oEditors.getById["content"].exec("UPDATE_CONTENTS_FIELD", []);
		
				var contents = $.trim(oEditors[0].getContents());
				// 이부분에 에디터 validation 검증
				if($.trim($('#subject').val()) == '') {
					alert('제목을 입력하세요');
					return;
				} else if(contents === '<p>&nbsp;</p>' || contents === ''){ // 기본적으로 아무것도 입력하지 않아도 <p>&nbsp;</p> 값이 입력되어 있음. 
					alert("내용을 입력하세요.");
					oEditors.getById['content'].exec('FOCUS');
					return;
				} else {
					//alert("글쓰기");
					$(document).find('[name="bcode"]').val('${para.bcode}');
	        		$(document).find('[name="pageNo"]').val('1');
	        		$(document).find('[name="key"]').val('');
	        		$(document).find('[name="word"]').val('');
	        		var writeForm = $('#writeForm');
	        		writeForm.attr('action', '${root}/album/write.cafe').attr('method', 'post');
	        		writeForm.submit();
				}
			});
			
			$('#resetBtn').click(function() {
				history.go(-1);
			});
		});
		
		function bs_input_file() {
			$(".input-file").before(
				function() {
					if ( ! $(this).prev().hasClass('input-ghost') ) {
						var element = $("<input type='file' class='input-ghost' style='visibility:hidden; height:0'>");
						element.attr("name",$(this).attr("name"));
						element.change(function(){
							element.next(element).find('input').val((element.val()).split('\\').pop());
						});
						$(this).find("button.btn-choose").click(function(){
							element.click();
						});
						$(this).find('input').css("cursor","pointer");
						$(this).find('input').mousedown(function() {
							$(this).parents('.input-file').prev().click();
							return false;
						});
						return element;
					}
				}
			);
		}
		$(function() {
			bs_input_file();
		});
		</script>
<!-- Center ======================================================================================= -->
		<c:if test="${msg != null}">
		<script>
		alert('${msg}');
		</script>
		</c:if>
        <div class="col-sm-9">
        	<div class="page-header">
                <h4 id="container"><%=application.getAttribute("board" + request.getParameter("bcode")) %></h4>
            </div>
            <div class="form-group">
	        	<form id="writeForm" class="form-horizontal" enctype="multipart/form-data" action="#">
	        		<input type="hidden" id="bcode" name="bcode"/>
		        	<input type="hidden" id="pageNo" name="pageNo"/>
		        	<input type="hidden" id="key" name="key"/>
		        	<input type="hidden" id="word" name="word"/>
                    <fieldset>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">제목</label>

                            <div class="col-sm-10">
                                <input type="text" id="subject" name="subject" class="form-control" placeholder="제목" value="${subject}">
                            </div>
                            
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">내용</label>
						</div>
						<div class="col-sm-1"></div>
                        <div class="col-sm-11">
                        	<textarea id="content" name="content" rows="10" cols="100" style="width:100%; height:412px;" placeholder="내용">${content}</textarea>
                        </div>
                        <div class="form-group">
                            <label class="col-sm-2 control-label">사진</label>

                            <div class="col-sm-5 input-group input-file" name="picture">
					    		<input type="text" class="form-control" placeholder='사진추가...' />			
					            <span class="input-group-btn">
					        		<button class="btn btn-default btn-choose" type="button">선택</button>
					    		</span>
							</div>
                            
                        </div>
                    </fieldset>
                </form>
        	</div>
            <div class="pull-right">
            	<button type="button" id="writeBtn" class="btn btn-sm btn-default" data-backdrop="static">글쓰기</button>
                <button type="button" id="resetBtn" class="btn btn-sm btn-default" data-backdrop="static">초기화</button>
            </div>

        </div>

<%@ include file="/WEB-INF/views/common/template/bottom.jsp"%>