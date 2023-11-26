<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

 <div class="row d-flex align-items-center mt-5">
                <div class="col-3 text-start">
                    <img src="${pageContext.request.contextPath}/images/open-door.png" width="100%">
                </div>
                <div class="col">
                	<div class="col">
                    <h5>해당 기능에 대한 권한이 없습니다</h5>
                	</div>
                	<div class="col">
                    <h3>다시 확인하고 이용해주세요!</h3>
                	</div>
                </div>
            </div>
<br><br>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>