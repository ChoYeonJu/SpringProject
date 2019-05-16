<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
</div>

<!-- Footer ========================================================================================== -->
     <footer>
        <div class="row">
            <div class="col-lg-12">
                <ul class="list-unstyled">
                    <li class="pull-right"><a href="#top">위로 이동</a></li>                    
	                <li><a href="${root}">MyCafe 홈</a></li>                    
                    <li><a href="#">이용약관</a></li>
                    <li><a href="#">도움말</a></li>
                    <c:if test="${userInfo != null}">
                    <li><a href="#">회원탈퇴</a></li> 
                    </c:if>                 
                </ul>
                <p>© MyCafe 2020.</p>
            </div>
        </div>
    </footer>
</div>
</body>
</html>