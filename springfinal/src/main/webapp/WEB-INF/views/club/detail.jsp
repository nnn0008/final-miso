<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://unpkg.com/hangul-js" type="text/javascript"></script>

<script>
$(function(){
    $(".join").click(function(e){
        var clubNo = $(".clubNo").data("no");
        var memberId = $(".memberId").data("id");

        $.ajax({
            url: "http://localhost:8080/rest/existMember",
            method: "get",
            data: { clubNo: clubNo, memberId: memberId },
            success: function (response) {
                if (response == true){
                    alert('이미 가입한 모임입니다');
                } else {
                    $(".exampleModal").modal('show');
                }
            }
        });
    });

    $(".commit").click(function(){
        var clubNo = $(".clubNo").data("no");
        var memberId = $(".memberId").data("id");
        var joinMessage = $(".joinMessage").val();

        $.ajax({
            url: "http://localhost:8080/rest/clubMember",
            method: "post",
            data: { clubNo: clubNo, clubMemberId: memberId, joinMessage: joinMessage },
            success: function (response) {
                $(".exampleModal").modal("hide");
                location.reload();
            }
        });
    });
});

	
	


</script>


<h1>클럽디테일</h1>




<img src="${pageContext.request.contextPath}/club/image?clubNo=${clubDto.clubNo}" width="550" height="250">



<div class="container-fluid mt-4">
    <div class="row">
        <div class="col">
        <input type="hidden" class="clubNo" data-no="${clubDto.clubNo}">
        <input type="hidden" class="memberId" data-id="${sessionScope.name}">
        
           <span class="badge text-bg-primary">${zipDto.sigungu}</span>
           <span class="badge text-bg-primary">${major.majorCategoryName}</span>
        </div>
    </div>
    <div class="row mt-4">
        <div class="col-md-6">
            <p>클럽 제목: ${clubDto.clubName}</p>
        </div>
    </div>

    <div class="row mt-4">
        <div class="col-md-6">
            <p>클럽 설명: ${clubDto.clubExplain} 설명</p>
        </div>
    </div>
    <c:if test="${joinButton==true}">
   <button type="button" class="btn btn-secondary mt-4 join" data-bs-toggle="modal">가입하기</button>
   <a href="/club/edit?clubNo=${clubDto.clubNo}">
   <button type="button" class="btn btn-primary mt-4">수정하기</button>
   </a> 
	</c:if>
	
	<hr>
	<div class="row">
		<div class="col">
			<h5>모임 멤버(인원수)</h5>
		</div>
	</div>
	<c:forEach var="clubMember" items="${clubMemberDto}">
	
	<div class="row">
	<div class="col">
	<img src="${pageContext.request.contextPath}/rest/member/profileShow?memberId=${clubMember.memberId}" width="100" height="100" class="rounded-circle">
	${clubMember.memberName}
	${clubMember.clubMemberRank}
	${clubMember.joinMessage}
	</div>
	</div>
	</c:forEach>
	
    
</div>
    
      <div class="modal fade exampleModal"
                data-bs-backdrop="static" tabIndex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">가입인사를 작성해주세요</h5>
                <button type="button" class="close" data-bs-dismiss="modal" aria-label="Close">
                <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <div class="row">
                  <div class="col">
                    <input type="text" class="form-control joinMessage">
                  </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button class="btn btn-success commit">확인</button>
            </div>
            </div>
        </div>
      </div>
    
    
    

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
