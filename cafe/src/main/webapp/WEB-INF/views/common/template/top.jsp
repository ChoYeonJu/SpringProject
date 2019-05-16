<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/public.jsp" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Cafe</title>
    <link href="${root}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${root}/css/bootswatch.min.css" rel="stylesheet">
    <script src="${root}/js/jquery-2.1.0.js"></script>
    <script src="${root}/js/bootstrap.min.js"></script>
    <script src="${root}/js/bootswatch.js"></script>
	<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.${root}/js/1.4.2/respond.min.js"></script>
    <![endif]-->

</head>
<body>

<!-- Main Navigation ========================================================================================== -->
<div class="navbar navbar-default navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${root}">My Cafe</a>
        </div>
        <div class="navbar-collapse collapse navbar-responsive-collapse">
            <ul class="nav navbar-nav">
                <li><a href="#">공지사항</a></li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
			<c:if test="${userInfo == null}">
<!-- 비로그인 상태 start -->
				<li><a class="pill" data-toggle="modal" data-target="#loginModal" data-backdrop="static">로그인</a></li>
				<li><a class="pill" data-toggle="modal" data-target="#registerModal" data-backdrop="static">회원가입</a></li>
<!-- 비로그인 상태 end -->
			</c:if>
			<c:if test="${userInfo != null}">
<!-- 로그인 상태 start -->
                <li><a href="${root}/member/logout.cafe">로그아웃 (${userInfo.userid})</a></li>
                <c:if test="${userInfo.role == 1}">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">마이페이지<b class="caret"></b></a>
                    <ul class="dropdown-menu">
                        <li><a href="${root}/member/view.cafe">개인정보</a></li>
                        <li><a href="#">내글정보</a></li>
                    </ul>
                </li>
                </c:if>
                <c:if test="${userInfo.role == 0}">
                <li><a href="${root}/admin/index.cafe">관리자페이지</a></li>
                </c:if>
<!-- 로그인 상태 end -->
			</c:if>
            </ul>
            <!-- <form class="navbar-form navbar-right">
		      <div class="form-group">
		        <input type="text" class="form-control" placeholder="Search">
		      </div>
		      <button type="submit" class="btn btn-default">검색</button>
		    </form> -->
		    
		    <script>
			$(document).ready(function(){
				$('#search').keyup(function(){
					console.log($("#search").val());
			        show();
			    });
				
				$(document).click(function(){
					if($("#search").val().length != 0) {
				        hide();
					}
			    });
			    
				$('#totalSearchBtn').click(function(){
					//console.log($("#search").val());
			        $("#totalSearchForm").attr("action", "${root}/commons/searcharticle.cafe").attr('method', 'get');
			        $("#totalSearchForm").submit();
			    });
				
			    function show() {
			    	var pos = $('#search').position();
			    	//alert(pos.top + "   " + pos.left);
			    	$('#searchresult').css('left', pos.left + 'px');
			    	$('#searchresult').css('top', pos.top + $('#search').height() + 15 + 'px');
			    	$('#searchresult').css('width', $('#search').width() + 25 + 'px');
			    	$('#searchresult').css('height', 150 + 'px');
			    	$('#searchresult').css('background', '#ffffff');
			    	$('#searchresult').css('opacity', '1');
			    	$('#searchresult').css('border-radius', '3px');
			    	$('#searchresult').css('border', '1px solid #2c3e50');
			    	$('#searchlist').css('margin', '5px');
			    	$('#searchresult').css('display', '');
			    	$('#searchresult').css('overflow-y', 'scroll');
			    	/*
			    	var el = $('#searchresult');
			    	if(el != null) {
			    		var keyel = $('#search');
			    		var kh = keyel.outerHeight();
			    		var kwidth = keyel.outerWidth();
			    		//alert(kh + "    " + kwidth);
			    		//keyel.style.border="5px solid blue";
			    		tempX = 0;
			    		tempY = 0;
			    		if(keyel.offsetParent()) {
			    			do {
			    				tempX += keyel.offset().left;
			    				tempY += keyel.offset().top - (keyel.scrollTop !== 0 ? keyel.scrollTop : 0);
			    				alert(tempX + "   " + tempY);
			    			} while(keyel = keyel.offsetParent());
			    			tempY += kh;
			    		}
			    		alert(tempX + "   " + tempY);
			    		el.style.left = tempX + "px";
			    		el.style.top = tempY + 3 + "px";
			    		el.style.width = kwidth + "px";
			    		el.style.background = "#ffffff";
			    		el.style.display = "block";
			    	}
			    	*/
			    }
			    
			    function hide() {
			    	$('#searchresult').css('display', 'none');
			    }
			});
			</script>
			<form id="totalSearchForm" class="navbar-form navbar-right">
			<input type="hidden" name="pageNo" value="1">
		    <table>
		    <tr>
		    	<td>
				<div class="form-group">
					<input type="text" name="searchword" id="search" class="form-control" size="30" placeholder="Search">
				</div>
				<button id="totalSearchBtn" class="btn btn-default">
				<i class="glyphicon glyphicon-search"></i>
				</button>
				</td>
			</tr>
			<tr>
				<td>
				<div id="searchresult" style="position: absolute; display: none;">
					<div id="searchlist">검색결과1<br><a href="javascript:alert('aaaaaaaaaa');">검색결과2</a><br>검색결과3<br>검색결과4<br>검색결과2<br>검색결과3<br>검색결과4<br>검색결과2<br>검색결과3<br>검색결과4<br>검색결과2<br>검색결과3<br>검색결과4</div>
				</div>
				</td>
			</tr>
			</table>
			</form>
        </div>
    </div>
</div>
<c:if test="${userInfo == null}">
<!-- 회원가입 Modal -->
<%@ include file="/WEB-INF/views/user/register.jsp"%>
	      	

<!-- 로그인 Modal -->
<%@ include file="/WEB-INF/views/user/login.jsp"%>
</c:if>
<!-- Container ======================================================================================= -->
<div class="container">
    <div class="row">