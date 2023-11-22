<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>
<style>
    .btn-no-style {
        border: 1px solid #ddd; /* 테두리 연하게 설정 */
        background-color: transparent;
        cursor: pointer;
        text-decoration: none;
        color: inherit;
        padding: 10px; /* 여백 추가 */
        transition: border-color 0.3s, box-shadow 0.3s; /* 트랜지션 효과 추가 */
    }

    .btn-no-style:hover {
        border-color: #ccc; /* 마우스 오버 시 테두리 색 변경 */
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* 마우스 오버 시 그림자 추가 */
        /* text-decoration: underline; /* 선택적으로 밑줄 추가할 수 있음 */ */
    }
</style>
<script>
	function redirect(url){
		window.location.href = "detail?clubBoardNo="+url;
	}
</script>
<div class="row m-2 mt-4">
<a href="${pageContext.request.contextPath}/clubBoard/write?clubNo=${clubNo}">글쓰기</a>

<c:forEach var="clubBoardAllDto" items="${list}">
	<button type="button" class="btn-no-style" onclick="redirect('${clubBoardAllDto.clubBoardNo}')">
		<div class="row mt-4">
			<c:if test="${clubBoardAllDto.attachNoMp != null}">
				<div class="col-3">
					<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${clubBoardAllDto.attachNoMp}">
				</div>			
			</c:if>
			<c:if test="${clubBoardAllDto.attachNoMp == null}">
				<img src="${pageContext.request.contextPath}/images/user.png" style="max-width: 100px;" alt="User Image">		
			</c:if>
			<div class="col-3 text-start">
				${clubBoardAllDto.clubBoardName}
			</div>
			<div class="col-6 text-end">
				${clubBoardAllDto.clubBoardDate}
			</div>
		</div>
		<div class="row mt-2">
			<div class="col">
				${clubBoardAllDto.clubBoardTitle}
			</div>
		</div>
		<div class="row mt-2">
			<div class="col-8">
				${clubBoardAllDto.clubBoardContent}
			</div>
			<c:if test="${clubBoardAllDto.attachNoCbi != null}">
				<div class="col-4 thumbnail">
					<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${clubBoardAllDto.attachNoCbi}">
				</div>
			</c:if>
		</div>
		<div class="row">
			<div class="col">
				<hr/>
			</div>
		</div>
		<div class="row">
			<div class="col-3">
				${clubBoardAllDto.clubBoardLikecount}
			</div>
			<div class="col-3">
				댓글 수 ${clubBoardAllDto.clubBoardReplyCount}
			</div>
			<div class="col-6 text-end">
				${clubBoardAllDto.clubBoardCategory}
			</div>
		</div>
	</button>
</c:forEach>
	
	
	
</div>




<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>