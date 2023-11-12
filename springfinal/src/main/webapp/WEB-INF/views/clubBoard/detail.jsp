<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<div class="container-fluid">
	<div class="row">
		<div class="col">
			
			<div class="row">
				<div class="col-3">
					프로필사진
				</div>
				<div class="col-4">
					${clubBoardAllDto.clubBoardName};
				</div>
				<div class="col-5 text-end">
					${clubBoardAllDto.clubBoardCategory}
					${clubBoardAllDto.clubBoardDate}
				</div>
			</div>
			
			<div class="row">
				<div class="col">
					${clubBoardAllDto.clubBoardTitle}
				</div>
			</div>
			<div class="row">
				<div class="col">
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