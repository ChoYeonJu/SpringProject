<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- left ======================================================================================= -->
    	<div class="col-sm-3">
    		<div style="height: 10px;"></div>
    		
            <!-- user info ======================================================================================= -->
    		<div>
    			<div style="height: 180px; text-align: center;">
    			<img src="${root}/img/main/main_0.jpg" class="img-rounded" alt="Cinque Terre" width="180" align="middle">
    			</div>
    		</div>
    		
    		<div style="height: 10px;"></div>
    		
            <!-- board menu ======================================================================================= -->
            <%@ include file="/WEB-INF/views/admin/board/boardlist.jsp"%>
            
            <div style="height: 10px;"></div>
            
            <!-- board menu ======================================================================================= -->
            <%@ include file="/WEB-INF/views/poll/polling.jsp"%>
		</div>