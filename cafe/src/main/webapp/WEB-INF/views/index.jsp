<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="root" value="${pageContext.request.contextPath}"/>
<c:if test="${loginMsg != null}">
	<script>
	<c:if test="${loginMsg == '100'}">
		if(confirm('재가입하시겠습니까?')) {
			document.location.href = '${root}/member/reregister.cafe?userid=${userid}';
		} else {
			document.location.href = '${root}/commons/index.cafe';
		}
	</c:if>
	<c:if test="${loginMsg != '100'}">
		alert('${loginMsg}');
		document.location.href = '${root}/commons/index.cafe';
	</c:if>
	</script>
</c:if>
<c:if test="${loginMsg == null}">
	<c:redirect url="${root}/commons/index.cafe"></c:redirect>
</c:if>