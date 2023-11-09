<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<div class="row m-2 mt-4">
	
	<c:forEach var="clubBoardAllDto" items="${list}">
	
		<div class="row mt-4">
			<div class="col-3">
				프로필사진
			</div>
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
			<div class="col-4 thumbnail">
				${clubBoardAllDto.attachNoCbi}
			</div>
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
				댓글 수
			</div>
			<div class="col-6 text-end">
				${clubBoardAllDto.clubBoardCategory}
			</div>
		</div>
		
	</c:forEach>
	
	
	
</div>




<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>