<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
     <div class="row">
                            <div class="col text-start d-flex align-items-center">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2 main-text">구매내역 확인</strong>
                            </div>
                        </div>

 <div class="row d-flex align-items-center mt-3">
                <div class="col-3 text-start">
                    <img src="${pageContext.request.contextPath}/images/logo-door.png" width="100%">
                </div>
                	 <div class="col">
                                	<div class="col">
                                    
                                	</div>
                                	<div class="col">
                                    <c:forEach var="confirmVO" items="${list}">
    <div class="purchase-item">
        ${confirmVO.productDto.productName}
        
    </div>
<hr>
<c:if test="${clubDto.clubName != null}">
    <h5>동호회명 : <strong>${clubDto.clubName}</strong></h5>
</c:if>
<h6 class="mt-2">결제금액 : <fmt:formatNumber value="${confirmVO.productDto.productPrice}" pattern="#,###원" /></h6>
</c:forEach>
                                	</div>
                                </div>
            </div>
            
    
    <!-- 전송되는 부분 -->
    <form method="post" action="/pay/purchase">
     <input type="hidden" name="clubNo" value="${clubDto.clubNo}">
    <c:forEach var="confirmVO" items="${list}" varStatus="stat">
        <input type="hidden" name="product[${stat.index}].productNo" value="${confirmVO.purchaseVO.productNo}">
        <input type="hidden" name="product[${stat.index}].qty" value="${confirmVO.purchaseVO.qty}">
    </c:forEach>
    <button class="btn btn-miso w-100 mt-4" type="submit">구매하기</button>
</form>
    <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>