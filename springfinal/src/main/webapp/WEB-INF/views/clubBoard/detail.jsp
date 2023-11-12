<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<div class="container-fluid">
	<div class="row">
		<div class="col">
			
			<div class="row">
				<div class="col-3">
					프로필사진
				</div>
				<div class="col-3">
					${clubBoardAllDto.clubBoardName}
				</div>
				<div class="col-6 text-end">
					${clubBoardAllDto.clubBoardCategory}
					<fmt:formatDate value="${clubBoardAllDto.clubBoardDate}" pattern="M월 d일 a h시 m분"/>
				</div>
			</div>
			
			<div class="row mt-4">
				<div class="col">
					${clubBoardAllDto.clubBoardTitle}
				</div>
			</div>
			<div class="row mt-4">
				<div class="col" style="min-height: 200px;">
					${clubBoardAllDto.clubBoardContent}
				</div>
			</div>
			
			<div class="row">
				<div class="col">
					좋아요 하트버튼 + ${clubBoardAllDto.clubBoardLikecount}	
				</div>
			</div>
			
			<div class="row">
				<div class="col">
					<input type="text" class="form-control" placeholder="댓글을 달아주세요">
				</div>
			</div>
			
			<div class="row">
				<div class="col">
					댓글 목록 쭉
				</div>
			</div>
		
			
		</div>
	</div>
</div>





<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>