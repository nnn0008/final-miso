<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
.pay-font{
font-size: 25px;
}

.btn.btn-kakao{
background-color: #FFED00;
}
</style>
<div class="container">
        <div class="row">

<div class="mt-4 p-4 bg-miso rounded">
   <h1>단건 상품</h1>
</div>

<!-- Club 선택 드롭다운 -->
<div class="form-group mt-3">
    <select class="form-control" id="clubSelect">
      <option value="">동호회를 선택하세요</option>
        <c:forEach var="club" items="${clubs}">
            <option value="${club.clubNo}">${club.clubName}</option>
        </c:forEach>
    </select>
</div>

<!-- 선택한 Club에 해당하는 Product 목록 -->
<c:forEach var="productDto" items="${singleList2}">
<div class="row mt-4 product-item">
   <div class="col-2 checkbox-wrapper mt-2">
      <input type="checkbox" name="productNo" value="${productDto.productNo}">
   </div>
   <div class="col-6">
      ${productDto.productName}
   </div>
<div class="col-3 text-end price-wrapper">
    <fmt:formatNumber value="${productDto.productPrice}" pattern="#,###원" />
</div>

   <div class="col-1">
      <input class="form-control text-end" type="hidden" name="qty" value="1" min="1">
   </div>
<!--    <div class="col-2 text-end total-wrapper"></div> -->
</div>
</c:forEach>

  <button class="btn btn-kakao btn-lg purchase-btn mt-3" type="button" data-club-no="${clubNo}" data-product-no="${productDto.productNo}">
        <i class="fa-solid fa-comment fa-2xl"></i><span class="pay-font">
        <strong>pay 결제</strong></span>
      </button>

</div>
</div>

<script>
$(function () {
    // 클럽 선택 드롭다운 변경 시
    $("#clubSelect").click(function () {
        var clubNo = $(this).val();
        // 선택한 클럽의 clubNo 값을 저장
        $(this).data("clubNo", clubNo);
    });

    $(".purchase-btn").click(function () {

        if (confirm("선택한 항목을 구매하시겠습니까?") == false) {
            return;
        }

        var form = $("<form>").attr("action", "singlePurchase").attr("method", "get");

        var count = 0;


        // 이전에 선택한 클럽의 clubNo 가져오기
        var clubNo = $("#clubSelect").data("clubNo");

        // 선택한 클럽의 clubNo를 form에 추가
        $("<input>")
            .attr("name", "clubNo")
            .attr("type", "hidden")
            .val(clubNo)
            .appendTo(form);

        $("body").append(form);
        form.submit(); // form 전송
    });
});

</script>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>