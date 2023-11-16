<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<script>

//댓글 작성 시 비동기처리로 댓글 작성 + 댓글 목록 비동기처리
$(function(){
	
	window.socket = new SockJS("${pageContext.request.contextPath}/ws/notify");
	
    loadList();
    //댓글 작성
    $(".reply-insert-form").submit(function(e){
        e.preventDefault();
        if($(".reply-write").val().length == 0) return;
        var clubBoardReplyContent = $(".reply-write").val();
        var params = new URLSearchParams(location.search);
        var clubBoardNo = params.get("clubBoardNo");
        //var clubBoardReplyParent = null;

        $.ajax({
            url: window.contextPath + "/rest/reply/insert",
            method: "post",
            data: {
                clubBoardReplyContent: clubBoardReplyContent,
                clubBoardNo: clubBoardNo,
                //clubBoardReplyParent : clubBoardReplyParent,
            },
            success: function(response){
                $(".reply-write").val("");
                loadList();

//                 소켓 전송
                    var notifyType = "reply";
                    var replyWriterMember = response.replyWriterMember;
                    var boardWriterMember = response.boardWriterMember;
                    var boardNo = response.boardNo;
                    var boardTitle = response.boardTitle;
                    var replyWriterName = response.replyWriterName;

                    if(boardWriterMember != replyWriterMember){
                        let socketMsg = JSON.stringify({
                            notifyType: notifyType,
                            replyWriterMember: replyWriterMember,
                            boardWriterMember: boardWriterMember,
                            boardNo: boardNo,
                            boardTitle: boardTitle,
                            replyWriterName : replyWriterName
                        });

                        socket.send(socketMsg);                 
                }
            }
    });
});

		
		//화면이 로딩되거나 댓글이 작성되었을경우 댓글목록을 다시 찍어주는 비동기처리
		function loadList(){
			var params = new URLSearchParams(location.search);
			var clubBoardNo = params.get("clubBoardNo");
			
			$.ajax({
				url:window.contextPath+"/rest/reply/list",
				method:"post",
				data:{clubBoardNo : clubBoardNo},
				//response를 댓글 목록으로 받아옴
				success:function(response){
					$(".reply-list").empty();
					//console.log(response);

					for(var i = 0; i < response.length; i++){
						var reply = response[i];
						
						var htmlTemplate ="";
						htmlTemplate += '<div class="col-12 for-reply-edit mt-2">';
			            htmlTemplate += '<div class="row">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<h6 class="clubBoardReplyWriter">' + (reply.clubBoardReplyWriter || "탈퇴한 유저") + '</h6>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<span class="clubBoardReplyDate">' + reply.clubBoardReplyDate + '</span>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="col edit-delete">';
			            htmlTemplate += '<button type="button" class="btn btn-info btn-reply-edit" data-bs-toggle="modal" data-bs-target="#replyEditModal">수정</button>';
			            htmlTemplate += '<button type="button" class="btn btn-danger btn-reply-delete">삭제</button>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="row mt-2">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<pre class="clubBoardReplyContent fs-6">' + (reply.clubBoardReplyContent || "삭제된 댓글입니다") + '</pre>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="row mt-2">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<i class="fa-regular fa-thumbs-up"></i> 좋아요 | ';
			            htmlTemplate += '<button type="button" class="subReplyModal" data-bs-toggle="modal" data-bs-target="#subReplyModal"><i class="fa-solid fa-pen-to-square"></i>답글 달기</button>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="row mt-2">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '&nbsp;&nbsp; <i class="fa-solid fa-reply fa-rotate-180 for-subReply-edit"></i>'; //이 뒤에 추가
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
						
						//var template = $("#reply-template").html();
						//var htmlTemplate = $.parseHTML(template);
						
						//기존의 번호를 버튼에 저장하여 대댓글에 사용
						/* $(".subReplyModal").setAttribute('data-board-reply-no', response[i].clubBoardReplyNo);
						console.log(".subReplyModal", "data-board-reply-no"); */
						
						//작성자는 사이트를 탈퇴했다면 탈퇴한 유저 아니라면 작성자
						//$(htmlTemplate).find(".clubBoardReplyWriter").text(response[i].clubBoardReplyWriter || "탈퇴한 유저");
						//$(htmlTemplate).find(".clubBoardReplyDate").text(response[i].clubBoardReplyDate);
						//$(htmlTemplate).find(".clubBoardReplyContent").text(response[i].clubBoardReplyContent || "삭제된 댓글입니다");
						//$(htmlTemplate).find(".subReplyModal").attr("data-board-reply-no", response[i].clubBoardReplyno);
						
						//로그인 한 유저가 작성한 댓글이 아니라면 수정 삭제 버튼을 보여주면 안됨
						/* if(memberId == null || ){
							$(htmlTemplate).find(".edit-delete").empty();
						} */
						
						//console.log(response[i].clubBoardReplyNo);
						//삭제 버튼을 찾아서 클릭하면
						
						console.log($(this));
						$(this).find(".btn-reply-delete").attr("data-board-reply-no", response[i].clubBoardReplyNo)
						.click(function(e){
							var clubBoardReplyNo = $(this).attr("data-board-reply-no");
							$.ajax({
								url: window.contextPath + "/rest/reply/delete",
								method:"post",
								data:{clubBoardReplyNo : clubBoardReplyNo},
								//삭제 성공하면
								success:function(response){
									loadList(); //목록을 갱신 
								},
							});
						});
						
						//수정 버튼을 클릭하면 Modal을 띄우고 기존 내용이 적혀있어야 한다
						$(".for-reply-edit").find(".btn-reply-edit").attr("data-board-reply-no", response[i].clubBoardReplyNo)
						.click(function(){
							//console.log($(".btn-reply-edit").data("board-reply-no"));
							$("#replyEditModal").show();
							var clubBoardReplyNo = $(this).attr("data-board-reply-no");
							var clubBoardReplyContent = $(this).parent().parent().find(".clubBoardReplyContent").text();
							//console.log(clubBoardReplyContent);
							
							$("[name=clubBoardReplyContent]").val(clubBoardReplyContent);
							$("[name=clubBoardReplyNo]").val(clubBoardReplyNo); //히든으로 날려보낼 번호
							
							//Modal의 저장 버튼을 클릭했을 때, modal의 input에 있는 내용으로 바꾸기
							$(".update-success-reply").unbind().click(function(){
								$.ajax({
									url:window.contextPath + "/rest/reply/edit",
									method:"post",
									data: {
										clubBoardReplyNo : clubBoardReplyNo,
										clubBoardReplyContent : $("[name=clubBoardReplyContent]").val()
									},
									//내용을 바꾸는게 성공했다면
									success:function(response){
										//console.log("성공");
										console.log();
										loadList(); //목록을 갱신
										$("#replyEditModal").hide(); //내용 변경 후 modal을 닫는다
									}
								});
							});
							//Modal의 취소 버튼을 클릭했을 때, 기존 내용으로
							$(".update-cancel-reply").unbind().click(function(){
								$("#replyEditModal").hide(); //내용 변경 없이 Modal을 닫으면 된다
							});
						});
						
						//대댓글 작성
						$(".reply-list").find(".subReplyModal").attr("data-board-reply-no", response[i].clubBoardReplyNo).
						click(function(){
							var clubBoardReplyNo = $(this).attr("data-board-reply-no");
						
							$(".update-success-subReply").click(function(e){
								//e.preventDefault();
	
								var clubBoardSubReplyContent = $("[name=clubBoardSubReplyContent]").val();
								if(clubBoardSubReplyContent.length == 0) return;
								var params = new URLSearchParams(location.search);
								var clubBoardNo = params.get("clubBoardNo");
								
								$.ajax({
									url:window.contextPath+"/rest/reply/insert",
									method:"post",
									data:	
									{
										//$(e.target).serialize(),
										clubBoardReplyContent: clubBoardSubReplyContent,
										clubBoardNo: clubBoardNo,
										clubBoardReplyParent: clubBoardReplyNo,
										clubBoardReplyGroup: clubBoardReplyNo,
									},	
									success:function(response){
										console.log("성공");
										$("[name=clubBoardSubReplyContent]").val("");
										loadList();
										$(".for-subReply-edit").append(htmlTemplate);
									}
								});
							});
						});
						
						/* htmlTemplate += '<div class="col-12 for-reply-edit mt-2">';
			            htmlTemplate += '<div class="row">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<h6 class="clubBoardReplyWriter">' + (reply.clubBoardReplyWriter || "탈퇴한 유저") + '</h6>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<span class="clubBoardReplyDate">' + reply.clubBoardReplyDate + '</span>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="col edit-delete">';
			            htmlTemplate += '<button type="button" class="btn btn-info btn-reply-edit" data-bs-toggle="modal" data-bs-target="#replyEditModal">수정</button>';
			            htmlTemplate += '<button type="button" class="btn btn-danger btn-reply-delete">삭제</button>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="row mt-2">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<pre class="clubBoardReplyContent fs-6" name="[name=clubBoardReplyContent]">' + (reply.clubBoardReplyContent || "삭제된 댓글입니다") + '</pre>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="row mt-2">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '<i class="fa-regular fa-thumbs-up"></i> 좋아요 | ';
			            htmlTemplate += '<button type="button" class="subReplyModal" data-bs-toggle="modal" data-bs-target="#subReplyModal"><i class="fa-solid fa-pen-to-square"></i>답글 달기</button>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '<div class="row mt-2">';
			            htmlTemplate += '<div class="col">';
			            htmlTemplate += '&nbsp;&nbsp; <i class="fa-solid fa-reply fa-rotate-180 for-subReply-edit"></i>'; //이 뒤에 추가
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>';
			            htmlTemplate += '</div>'; */
						
						
			            $(".reply-list").append(htmlTemplate);
					}
				}
			});
		}
		
		$("#subReplyModal").on("hidden.bs.modal", function(){
			$("[name=clubBoardSubReplyContent]").val("");
		});
		
	});
</script>
<script>
	//좋아요 관련 처리
</script>



<!-- <div class="row mt-2">
	<div class="col">
		이름 오늘이라면 오전/오후 00:00// 날짜 바뀌었다면 ~~월 ~일 오전/오후 00:00
		댓글 내용 // 여기까지 말풍선
		좋아요 | 답글 달기
	</div>
</div> -->





<div class="container-fluid">
	<div class="row">
		<div class="col">
			
			<div class="row">
				<div class="col-3">
					<c:if test="${clubBoardAllDto.attachNoMp == null }">
						<img src="${pageContext.request.contextPath}/images/user.png" style="max-width: 25px;" alt="User Image">				
					</c:if>
					<c:if test="${clubBoardAllDto.attachNoMp != null}">
						<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${clubBoardAllDto.attachNoMp}">
					</c:if>
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
				<div class="col-6">
					좋아요 버튼
				</div>
				<div class="col-6">
					댓글달기 버튼
				</div>
			</div>
			
			<hr>
			
			<div class="row">
				<div class="col">
					좋아요 하트버튼
				</div>
				<div class="col">
					${clubBoardAllDto.clubBoardLikecount}
				</div>
			</div>
			
			<hr>
		<c:if test="${sessionScope.name != null }">
			<form class="reply-insert-form">
				<input type="hidden" name="clubBoardNo" value="${clubBoardAllDto.clubBoardNo}">
				<div class="row mt-5">
					<div class="col-10">
						<input type="text" class="form-control w-100 reply-write" placeholder="댓글을 달아주세요">
					</div>
					<div class="col">
						<button type="submit" class="btn btn-reply-send btn-success">전송</button>
					</div>
				</div>
			</form>
		</c:if>
			
			<%-- 댓글 목록 표시 --%>
		
			<div class="row mt-2 reply-list">
			
			</div>
		
			
		</div>
	</div>
</div>

<%-- 수정을 위한 Modal --%>
<!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button> -->
<!-- Modal -->
<div class="modal fade" id="replyEditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">댓글 수정</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        <input type="hidden" name="clubBoardReplyNo">	
        	
        <div class="row">
        	<div class="col">   		
        		<input type="text" class="form-control" name="clubBoardReplyContent">
        	</div>
        </div>      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary update-cancel-reply" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary update-success-reply" data-bs-dismiss="modal">저장</button>
      </div>
    </div>
  </div>
</div>

<%-- 답글을 위한 Modal --%>
<!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button> -->
<!-- Modal -->
<div class="modal fade" id="subReplyModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">답글 작성</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        <input type="hidden" name="clubBoardReplyNo">	
        	
        <div class="row">
        	<div class="col">
        		<input type="text" class="form-control" name="clubBoardSubReplyContent">
        	</div>
        </div>      
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary update-cancel-subReply" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary update-success-subReply" data-bs-dismiss="modal">저장</button>
      </div>
    </div>
  </div>
</div>






<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>