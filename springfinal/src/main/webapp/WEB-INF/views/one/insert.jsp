<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<script>
$(function(){
    $("#attach-selector").change(function(){
        if(this.files.length == 0) {
            //초기화
            return;
        }

        //파일 미리보기는 서버 업로드와 관련이 없다
        //- 서버에 올릴거면 따로 처리를 또 해야 한다

        //[1] 자동으로 생성되는 미리보기 주소를 연결
        for(let i=0; i < this.files.length; i++) {
            $("<img>").attr("src", URL.createObjectURL(this.files[i]))
                            .css("max-width", "300px")
                            .appendTo(".preview-wrapper1");
        }
        
       
    });
});

</script>

	<form method="post" action="insert" autocomplete="off" enctype="multipart/form-data">
	<%-- 답글일 때만 추가 정보를 전송 --%>
	<c:if test="${isReply}">
	<input type="hidden" name="oneParent" value="${originDto.oneNo}">
	</c:if>
	<div class="container">
		<div class="row mt-4">
			<div class="col">
				<c:choose>
	            <c:when test="${isReply}">
					<div class="col text-start d-flex align-items-center ms-3 mt-3">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">답글 작성</strong>
                        </div>
				</c:when>
				<c:otherwise>
                            <div class="col text-start d-flex align-items-center ms-3 mt-3">
                                <img src="${pageContext.request.contextPath}/images/logo-door.png" width="5%">
                                <strong class="ms-2">게시글 작성</strong>
                        </div>
				</c:otherwise>
            </c:choose>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<select name="oneCategory" required class="form-select">
					<option  disabled selected hidden>종류를 선택해주세요.</option>
					<option>회원</option>
					<option>동호회</option>
					<option>신고</option>
					<option>고소</option>
					<option>결제</option>
					<option>기타문의</option>
				</select>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
			<c:choose>
				<c:when test="${isReply}">
				<input type="text" name="oneTitle" class="form-control" placeholder="제목" value="RE:${orginDto.oneTitle}">
				</c:when>
				<c:otherwise>
				<input type="text" name="oneTitle" class="form-control" placeholder="제목" >
				</c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<textarea name="oneContent" class="form-control" placeholder="내용" rows="10" cols="80"></textarea>
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<input type="file" name="attach" multiple id="attach-selector">
			</div>
		</div>
		
		<div class="row mt-3">
			<div class="col">
				<label>
				    <div class="preview-wrapper1"></div>
				</label>
			</div>
		</div>
		
		
		
		<div class="row mt-3">
			<div class="col">
				<button type="submit" class="btn  bg-miso w-100 mt-3">
				<i class= "fa-solid fa-pen"></i>
				등록
				</button>
			</div>
		</div>
		
		
		
	</div>
	</form>













<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>

