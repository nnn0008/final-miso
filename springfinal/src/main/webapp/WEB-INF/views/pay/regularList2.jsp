<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>



 <div class="container-fluid mb-5 pb-5">
    <div class="row">
        <div class="col-md-10 offset-md-1">
            <div class="container-fluid mb-5 pb-5">
                <div class="row">
                    <div class="col-md-10 offset-md-1">

                        <div class="mt-4 p-4 text-light bg-dark rounded">
                            <h1>정기 상품</h1>
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

                        <!-- 버튼 부분만 남겨두기 -->
                        <button class="btn btn-success purchase-btn" type="button" data-club-no="${clubNo}" data-product-no="${productDto.productNo}">
                            <img src="/images/payment.png">
                        </button>

                        <hr>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
$(function () {
    // 클럽 선택 드롭다운 변경 시
  $("#clubSelect").change(function () {
    var clubNo = $(this).val();
    console.log(clubNo); // 디버깅을 위한 로그
    // 선택한 클럽의 clubNo 값을 저장
    $(this).data("clubNo", clubNo);
});


    $("[name=productNo]").change(function () {
        var checked = $(this).prop("checked");
        if (checked) {
            $("[name=productNo]").not(this).prop("checked", false);
        }
        $(this).parents(".product-item").find("[name=qty]").prop("disabled", !checked);
        calculateUnit($(this).parents(".product-item"));
    });
    $("[name=qty]").on("input", function () {
        calculateUnit($(this).parents(".product-item"));
    });

    function calculateUnit(row) {
        if (row.find("[name=productNo]").prop("checked")) {
            var price = parseInt(row.find(".price-wrapper").text().replace(",", ""));
            var qty = parseInt(row.find("[name=qty]").val());
            row.find(".total-wrapper").text(numberWithCommas(price * qty) + "원");
        } else {
            row.find(".total-wrapper").text("-");
        }
    }

    function numberWithCommas(x) {
        return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    }

    $(".purchase-btn").click(function () {
        if ($("[name=productNo]:checked").length == 0) {
            alert("한 개 이상 선택하셔야 구매가 가능합니다");
            return;
        }

        if (confirm("선택한 항목을 구매하시겠습니까?") == false) {
            return;
        }

        var form = $("<form>").attr("action", "regularPurchase").attr("method", "get");

        var count = 0;

        $(".product-item").each(function (index, tag) {
            var checked = $(this).find("[name=productNo]").prop("checked");
            if (checked == false) return;

            var productNo = $(this).find("[name=productNo]").val();
            var qty = $(this).find("[name=qty]").val();

            $("<input>")
                .attr("name", "product[" + count + "].productNo")
                .attr("type", "hidden")
                .val(productNo)
                .appendTo(form);
            $("<input>")
                .attr("name", "product[" + count + "].qty")
                .attr("type", "hidden")
                .val(qty)
                .appendTo(form);
            count++;
        });

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