<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>




                <div class="row">
                    <div class="col">

                        <div class="mt-4 p-4 bg-miso rounded">
                            <h1>단건 상품</h1>
                        </div>

                        <!-- Club 선택 드롭다운 -->
                        <div class="form-group">
                            <label for="clubSelect">동호회 선택:</label>
                            <select class="form-control" id="clubSelect">
                                <option disabled selected>동호회를 선택해주세요.</option>
                                <c:forEach var="club" items="${clubs}">
                                    <option value="${club.clubNo}">${club.clubName}</option>
                                </c:forEach>
                            </select>
                        </div>
                        
                        <c:forEach var="productDto" items="${singleList2}">
						<div class="row mt-2 product-item">
						   <div class="col-2 checkbox-wrapper">
						      <input type="checkbox" name="productNo" value="${productDto.productNo}">
						   </div>
						   <div class="col-4">
						      ${productDto.productName}
						   </div>
						   <div class="col-2 text-end price-wrapper">
						      ${productDto.productPrice}원   
						   </div>
						   <div class="col-2">
						      <input class="form-control text-end" type="number" name="qty" value="1" min="1">
						   </div>
						   <div class="col-2 text-end total-wrapper"></div>
						</div>
							</c:forEach>

                        <hr>
                        <!-- 버튼 부분만 남겨두기 -->
                        <button class="btn btn-success purchase-btn" type="button" data-club-no="${clubNo}" data-product-no="${productDto.productNo}">
                            <img src="/images/payment.png">
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