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
   <h1>단기상품</h1>
</div>

<div class="row mt-4">
   <div class="col">
      <div class="form-check">
           <input class="form-check-input check-all" type="checkbox" value="" id="flexCheckDefault">
           <label class="form-check-label" for="flexCheckDefault">
                전체 선택
           </label>
       </div>
   </div>
   <div class="col text-end">
      <button class="btn btn-primary purchase-btn" type="button">
         <i class="fa-solid fa-cart-shopping"></i>
         구매하기
      </button> 
   </div>
</div>

<hr>

<c:forEach var="productDto" items="${singleList}">
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

<div class="row">
   <div class="col text-end">
      <button class="btn btn-primary purchase-btn" type="button">
         <i class="fa-solid fa-cart-shopping"></i>
         구매하기
      </button>
   </div>
</div> 

</div>
</div>
</div>

<script>
$(function(){
   $(".check-all").change(function(){
      var check = $(this).prop("checked");
      $("[name=productNo]").prop("checked", check);
      $("[name=productNo]").change();
   });
   $("[name=productNo]").change(function(){
      $(this).parents(".product-item").find("[name=qty]").prop("disabled", !$(this).prop("checked"));
      calculateUnit($(this).parents(".product-item"));
   });
   $("[name=qty]").on("input", function(){
      calculateUnit($(this).parents(".product-item"));
   });
   function calculateUnit(row) {
      if(row.find("[name=productNo]").prop("checked")) {
         var price = parseInt(row.find(".price-wrapper").text().replace(",",""));
         var qty = parseInt(row.find("[name=qty]").val());
         row.find(".total-wrapper").text(numberWithCommas(price*qty)+"원");
      }
      else {
         row.find(".total-wrapper").text("-");
      }
   }
   function numberWithCommas(x) {
       return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
   }
   
   //버튼 누르면 폼을 만들어서 체크된 항목의 "상품번호"와 "구매수량"을 입력창으로 만들어 추가
   $(".purchase-btn").click(function(){
      if($("[name=productNo]:checked").length == 0) {
         alert("한 개 이상 선택하셔야 구매가 가능합니다");
         return;
      }
      
      if(confirm("선택한 항목을 구매하시겠습니까?") == false) {
         return;
      }
      
      var form = $("<form>").attr("action", "purchase").attr("method", "get");
      
      var count = 0;
      
      $(".product-item").each(function(index, tag){
         //현재 위치의 체크박스가 체크되어 있다면 상품번호와 상품수량을 불러와서 form에 추가하겠다
         var checked = $(this).find("[name=productNo]").prop("checked");
         if(checked == false) return;
         
         var productNo = $(this).find("[name=productNo]").val();
         var qty = $(this).find("[name=qty]").val();
         
         $("<input>").attr("name", "product["+count+"].productNo")
                        .attr("type", "hidden")
                        .val(productNo)
                        .appendTo(form);
         $("<input>").attr("name", "product["+count+"].qty")
                        .attr("type", "hidden")
                        .val(qty)
                        .appendTo(form);
         count++;
      });
      
      $("body").append(form);
      form.submit();//form 전송해라!
   });
});
</script>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>