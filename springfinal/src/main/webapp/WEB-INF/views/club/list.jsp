<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
      <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <script src="https://unpkg.com/hangul-js" type="text/javascript"></script>
    
    
    


	<div class="container text-center">
  <div class="row align-items-start">
  <c:forEach var="majorCategory" items="${categoryList}" varStatus="loopStatus">
    <div class="col-3">
      <img src="../images/${majorCategory.imageName}" width="30%">
      ${majorCategory.majorCategoryName}
    </div>
  </c:forEach>
    </div>
</div>
<hr>




 
    
    
    
    
    
    
      <jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>