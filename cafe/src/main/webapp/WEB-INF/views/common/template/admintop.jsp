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
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.4.0/Chart.min.js"></script>
	<!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
    <script src="https://oss.maxcdn.com/libs/respond.${root}/js/1.4.2/respond.min.js"></script>
    <![endif]-->

	<script>
        $(document).ready(function() {

        	//회원목록
        	$('.userlist').click(function() {
        		$(location).attr('href', '${root}/memberadmin/list.cafe?pageNo=1');
        	});

        	//공지사항목록
        	$('.noticelist').click(function() {
        		$(location).attr('href', '${root}/');
        	});

        	//카테고리생성
        	$('.mkcategory').click(function() {
        		$(location).attr('href', '${root}/boardadmin/makecategory.cafe');
        	});

        	//게시판생성
        	$('.mkboard').click(function() {
        		$(location).attr('href', '${root}/boardadmin/makeboard.cafe');
        	});

        	//이전 poll
        	$('.prepoll').click(function() {
        		$(location).attr('href', '${root}/polladmin/list.cafe?pageNo=1');
        	});

        	//poll 생성
        	$('.mkpoll').click(function() {
        		$(location).attr('href', '${root}/');
        	});

        	//회원통계
        	$('.userstats').click(function() {
        		$(location).attr('href', '${root}/');
        	});

        	//게시판통계
        	$('.boardstats').click(function() {
        		$(location).attr('href', '${root}/');
        	});

        	//댓글통계
        	$('.memostats').click(function() {
        		$(location).attr('href', '${root}/');
        	});

        	//로그아웃
        	$('.logout').click(function() {
        		$(location).attr('href', '${root}/member/logout.cafe');
        	});

        	
        });
        </script>
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
                <li id="amember">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown">회원</a>
                	<ul class="dropdown-menu">
                        <li class="userlist"><a href="#">회원 리스트</a></li>
                    </ul>
                </li>
                <li id="anotice">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown">공지사항</a>
                	<ul class="dropdown-menu">
                        <li class="noticelist"><a href="${root}/admin/notice/list.jsp">공지사항 리스트</a></li>
                    </ul>
                </li>
                <li id="aboard">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown">게시판</a>
                	<ul class="dropdown-menu">
                        <li class="mkcategory"><a href="#">카테고리생성</a></li>
                        <li class="mkboard"><a href="#">게시판생성</a></li>
                    </ul>
                </li>
                <li id="apoll">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown">POLL</a>
                	<ul class="dropdown-menu">
                        <li class="prepoll"><a href="#">이전 poll 리스트</a></li>
                        <li class="mkpoll"><a href="${root}/admin/poll/list.jsp">poll 생성</a></li>
                    </ul>
                </li>
                <li id="astats">
                	<a href="#" class="dropdown-toggle" data-toggle="dropdown">통계</a>
                	<ul class="dropdown-menu">
                        <li class="userstats"><a href="${root}/admin/stats/list.jsp">회원 거주지 분포</a></li>
                        <li class="boardstats"><a href="${root}/admin/stats/list.jsp">게시판별 등록글</a></li>
                        <li class="memostats"><a href="${root}/admin/stats/list.jsp">등록글별 댓글</a></li>
                    </ul>
                </li>
            </ul>
            <ul class="nav navbar-nav navbar-right">
                <li class="logout"><a href="${root}/">로그아웃 (${userInfo.userid})</a></li>
            </ul>
        </div>
    </div>
</div>


<!-- Container ======================================================================================= -->
<div class="container">
    <div class="row">