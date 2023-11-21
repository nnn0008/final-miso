<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<style>
.fa-ellipsis-vertical:hover{
	cursor:pointer;
}

</style>
<script>

//댓글 작성 시 비동기처리로 댓글 작성 + 댓글 목록 비동기처리
$(function(){
	
	window.notifySocket = new SockJS("${pageContext.request.contextPath}/ws/notify");
	
    loadList();
    //댓글 작성
    
    $(".reply-insert-form").submit(function(e){
    	var params = new URLSearchParams(location.search);
        var clubBoardNo = params.get("clubBoardNo");
        e.preventDefault();
        if($(".reply-write").val().length == 0) return;
        var clubBoardReplyContent = $(".reply-write").val();
        //var params = new URLSearchParams(location.search);
        //var clubBoardNo = params.get("clubBoardNo");
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

					//소켓 전송
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

                        notifySocket.send(socketMsg);                 
		     	} 
		      }
		    });
		});

		//로그인 한 아이디
		var memberId = "${sessionScope.name}";
		
		//화면이 로딩되거나 댓글이 작성되었을경우 댓글목록을 다시 찍어주는 비동기처리
		function loadList(){
			var params = new URLSearchParams(location.search);
			var clubBoardNo = params.get("clubBoardNo");
			//var memberId = "${sessionScope.name}";
			$.ajax({
				url: window.contextPath+"/rest/reply/list",
				method:"post",
				data:{clubBoardNo : clubBoardNo},
				//response를 댓글 목록으로 받아옴
				success:function(response){
					$(".reply-list").empty();
					console.log(response);

					for(var i = 0; i < response.length; i++){
						//console.log(response);
						var template = $("#reply-template").html();
						var htmlTemplate = $.parseHTML(template);
						
						$(htmlTemplate).find(".clubBoardReplyWriter").text(response[i].clubBoardReplyWriter);
						$(htmlTemplate).find(".clubBoardReplyContent").text(response[i].clubBoardReplyContent);
						$(htmlTemplate).find(".clubBoardReplyDate").text(response[i].clubBoardReplyDate);
						
						//내가 작성한 댓글인지 확인하여 수정/삭제 버튼을 안보이게
						//if(memberId.length == 0 || memberId != response[i].clubBoard){
						//	$(htmlTemplate).find(".edit-delete").empty();
						//}
						
						
						//대댓글 이라면
                      	if(response[i].clubBoardReplyParent != null){
                            $(htmlTemplate).addClass("ms-4");
                            $(htmlTemplate).find(".only-attach-reply").remove();
                        }
						
						$(htmlTemplate).find(".btn-reply-delete").attr("data-reply-no", response[i].clubBoardReplyNo).click(function(e){
							var clubBoardReplyNo = $(this).attr("data-reply-no");
							$.ajax({
								url: window.contextPath + "/rest/reply/delete",
								method:"post",
								data:{clubBoardReplyNo: clubBoardReplyNo},
								//삭제 성공하면
								success:function(response){
									loadList(); //목록을 갱신 
								},
							});
						});
						

						$(htmlTemplate).find(".btn-open-reply-edit").attr("data-reply-no", response[i].clubBoardReplyNo).click(function(){
							var editTemplate = $("#reply-edit-template").html();
							var editHtmlTemplate = $.parseHTML(editTemplate);
							
							var clubBoardReplyNo = $(this).attr("data-reply-no");
							var clubBoardReplyContent = $(this).parents(".for-reply-edit").find(".clubBoardReplyContent").text();
							//console.log(clubBoardReplyContent);
							$(editHtmlTemplate).find("[name=clubBoardReplyNo]").val(clubBoardReplyNo);
							$(editHtmlTemplate).find("[name=clubBoardReplyContent]").val(clubBoardReplyContent);
							
							//취소버튼을 클릭한다면
							$(editHtmlTemplate).find(".btn-cancel").click(function(e){
								$(this).parents(".edit-container").prev(".for-reply-edit").show();
								$(this).parents(".edit-container").remove();
							});
							
							//완료(등록)버튼 처리
							$(editHtmlTemplate).submit(function(e){
								e.preventDefault();
								
								$.ajax({
									url: window.contextPath + "/rest/reply/edit",
									method: "post",
									data: $(e.target).serialize(),
									success: function(response){
										loadList();
									}
								});
							});
							
							//화면 배치
							$(this).parents(".for-reply-edit").hide().after(editHtmlTemplate);
						});
						
						$(htmlTemplate).find(".btn-subReply").attr("data-reply-no", response[i].clubBoardReplyNo).click(function(){
							var button = $(this);
							button.hide();
							var reReplyTemplate = $("#reReply-template").html();
							var reReplyHtmlTemplate = $.parseHTML(reReplyTemplate);	
							
							var clubBoardReplyNo = $(this).attr("data-reply-no");
							
							//취소버튼을 클릭하면 기존의 버튼을 다시 복구해야됨
							//$(reReplyHtmlTemplate).find(".btn-reReply-cancel").click(function(e){
							$(document).on("click", ".btn-reReply-cancel", function(e){
								//console.log("작동중");
								$(this).closest(".reReply-edit-form").remove();
								button.show();
							});
							//console.log($(reReplyHtmlTemplate).find(".btn-reReply-cancel").length);
							
							/* var params = new URLSearchParams(location.search);
					        var clubBoardNo = params.get("clubBoardNo"); */
							
							//$(reReplyTemplate).submit(function(e){
							$(reReplyTemplate).find(".btn-reReply-send").on("click", function(){	
								e.preventDefault();
								
								
								var params = new URLSearchParams(location.search);
						        var clubBoardNo = params.get("clubBoardNo");
						        var clubBoardReplyNo = $(this).closest(".for-reply-edit").find(".btn-reply-delete").attr("data-reply-no"); 
								var clubBoardReplyContent = $(reReplyHtmlTemplate).find(".clubBoardReReplyContent").text();
								
								console.log(clubBoardNo);
								console.log(clubBoardReplyNo);
								console.log(clubBoardReplyContent);
								
								$.ajax({
									url: window.contextPath + "/rest/reply/insert",
									method: "post",
									data: {
										clubBoardReplyParent: clubBoardReplyNo,
										clubBoardNo: clubBoardNo,
										clubBoardReplyContent: clubBoardReplyContent,
									},
									success: function(response){
										loadList();
									},
									error: function(error){
										e.preventDefault();
									}
								});
							});	
							$(this).parents(".for-reply-edit").after(reReplyTemplate);
							
						});  
						
						//댓글을 붙여
						$(".reply-list").append(htmlTemplate);
							
						
					}
					
				}
				
					
				});//여기가 loadList의 최상위 ajax 끝낸 자리임
			
			
		}	
	});

</script>
<script>
	$(function(){
		
		$(".board-like-count").val()
		
		//좋아요 관련 처리
		var params = new URLSearchParams(location.search);
		var clubBoardNo = params.get("clubBoardNo");
		//좋아요 여부를 체크
		$.ajax({
			url: window.contextPath + "/rest/clubBoard/check",
			method: "post",
			data: {
				clubBoardNo: clubBoardNo,
			},
			success: function(response){
				//console.log(response)
				if(response.check){
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
				}
				else{
					$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
				}
			},
		});
		
		/* $(".fa-heart").click(function(){
			$.ajax({
				url: window.contextPath + "/rest/clubBoard/action",
				method: "post",
				data: {
					clubBoardNo: clubBoardNo,
				},
				success: function(response){
					if(response.check){
						$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
					}
					else{
						$(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");
					}
					$(".board-like-count").empty().append(response.count);
				},
			}); */

			
			$(".fa-heart").click(function () {
			    $.ajax({
			        url: window.contextPath + "/rest/clubBoard/action",
			        method: "post",
			        data: {
			            clubBoardNo: clubBoardNo,
			        },
			        success: function (response) {
			            if (response.vo.check) {
			                $(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-regular");
			            } else {
			                $(".fa-heart").removeClass("fa-solid fa-regular").addClass("fa-solid");

			                // 소켓 전송
			                var notifyType = "like";
			                var replyWriterMember = response.replyWriterMember;
			                var boardWriterMember = response.boardWriterMember;
			                var clubBoardNo = response.clubBoardNo;
			                var boardTitle = response.boardTitle;
			                var replyWriterName = response.replyWriterName;

			                if (boardWriterMember != replyWriterMember) {
			                    let socketMsg = JSON.stringify({
			                        notifyType: notifyType,
			                        replyWriterMember: replyWriterMember,
			                        boardWriterMember: boardWriterMember,
			                        clubBoardNo: clubBoardNo,
			                        boardTitle: boardTitle,
			                        replyWriterName: replyWriterName
			                    });

			                    notifySocket.send(socketMsg);
			                }
			            }
			            $(".board-like-count").empty().append(response.vo.count);
			        },
			        error: function () {
			            console.error("An error occurred during the like action.");
			        }
			    });
			});
		});

	
</script>
<script>
	//로그인 한 유저와 비교
	$(function(){
		var loginUser = "${sessionScope.name}";
		var params = new URLSearchParams(location.search);
		var clubBoardNo = params.get("clubBoardNo");
		
		$(".board-match").hide();
		
		$.ajax({
			url: window.contextPath + "/rest/clubBoard/match",
			method:"post",
			data: {
				clubBoardNo: clubBoardNo,
			},
			success: function(response){
				if(response == "t" || loginUser == null){ //일치하면 수정/삭제 버튼 보여주기
					$(".board-match").show();
				}
				else{ //가리기
					$(".board-match").hide();
				}
			},
		
		});
		
	});

	
	

</script>

<script id="reply-template" type="text/template">
 <div class="col-12 for-reply-edit mt-2">
	<div class="row">
		<div class="col">
			<h6 class="clubBoardReplyWriter">작성자</h6>
		</div>
		<div class="col">
			<span class="clubBoardReplyDate">MM-dd E HH:mm</span>
		</div>
		<div class="col edit-delete">
			<button type="button" class="btn btn-info btn-open-reply-edit">수정</button>
			<button type="button" class="btn btn-danger btn-reply-delete">삭제</button>
		</div>
	</div>
	<div class="row mt-2">
		<div class="col">
			<pre class="clubBoardReplyContent fs-6">내용</pre>
		</div>
	</div>
<hr>
	<div class="row mt-2 only-attach-reply">
		<div class="col">
			<button type="button" class="btn-subReply"><i class="fa-solid fa-pen-to-square"></i>답글 달기</button>
		</div>
	</div>
 </div>
</script>
<script id="reply-edit-template" type="text/template">
		<form class="reply-edit-form edit-container">
		<input type="hidden" name="clubBoardReplyNo" value="?">
		<div class="row flex-container">
			<div class="col">
				<input type="text" name="clubBoardReplyContent" class="form-control"></textarea>
			</div>
			<div class="col">
				<button type="submit" class="btn btn-success btn-reply-edit">
					<i class="fa-solid fa-check"></i>
					수정
				</button>
			</div>
			<div class="col">
				<button type="button" class="btn btn-danger btn-cancel">
					<i class="fa-solid fa-xmark"></i>
					취소
				</button>
			</div>
		</div>
		</form>
</script>
<script id="reReply-template" type="text/template">
	<form class="reReply-edit-form">
		<input type="hidden" name="clubBoardReplyNo" value="?">
		<div class="row flex-container">
			<div class="col-6">
				<input type="text" name="clubBoardReReplyContent" class="form-control"></textarea>
			</div>
			<div class="col">
				<button type="submit" class="btn btn-success btn-reReply-send">
					<i class="fa-solid fa-check"></i>
					작성
				</button>
			</div>
			<div class="col">
				<button type="button" class="btn btn-danger btn-reReply-cancel">
					<i class="fa-solid fa-xmark"></i>
					취소
				</button>
			</div>
		</div>
		</form>
</script>

<div class="container-fluid">
	<div class="row">
		<div class="col">
			
			<div class="row">
				<div class="col-3">
					<c:if test="${attachDto.attachNo == null }">
						<img src="${pageContext.request.contextPath}/images/user.png" style="max-width: 25px;" alt="User Image">				
					</c:if>
					<c:if test="${attachDto.attachNo != null}">
						<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${attachDto.attachNo}">
					</c:if>
				</div>
				<div class="col-3">
					${clubBoardDto.clubBoardName}
				</div>
				<div class="col-6 text-end">
					${clubBoardDto.clubBoardCategory}
					<%-- <fmt:formatDate value="${clubBoardDto.clubBoardDate}" pattern="M월 d일 a h시 m분"/> --%>
					${clubBoardDto.clubBoardDate}
				</div>
			</div>
			
			<div class="row mt-4">
				<div class="col">
					${clubBoardDto.clubBoardTitle}
				</div>
				<div class="col">
					<i class="fa-solid fa-ellipsis-vertical"></i>
					<a href="${pageContext.request.contextPath}/clubBoard/list?clubNo=${clubBoardDto.clubNo}">목록</a>
					<div class="row board-match">
						<div class="col">
							<a href="${pageContext.request.contextPath}/clubBoard/edit?clubBoardNo=${clubBoardDto.clubBoardNo}">수정</a>
							<a href="${pageContext.request.contextPath}/clubBoard/delete?clubBoardNo=${clubBoardDto.clubBoardNo}">삭제</a>
						</div>
					</div>
					<button type="button" class="btn btn-report">신고</button>					
				</div>
			</div>
			<div class="row mt-4">
				<div class="col" style="min-height: 200px;">
					${clubBoardDto.clubBoardContent}
				</div>
			</div>
			
			<%-- 사진 등록이 되어있다면 보여주자 --%>
			<c:if test="${clubBoardImageDto != null}">
				<div class="row mt-3">
					<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${clubBoardImageDto.attachNo}">
				</div>
			</c:if>
			<c:if test="${clubBoardImage2Dto != null}">
				<div class="row mt-3">
					<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${clubBoardImage2Dto.attachNo}">
				</div>
			</c:if>
			<c:if test="${clubBoardImage3Dto != null}">
				<div class="row mt-3">
					<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${clubBoardImage3Dto.attachNo}">
				</div>
			</c:if>

			
			
			<div class="row">
				<div class="col">
					<i class="fa-regular fa-heart photo-like" style="color: red"></i>
					<p class="board-like-count">
						<%--좋아요 개수를 넣어줄려고 해 --%>
						${clubBoardDto.clubBoardLikecount}
					</p>
				</div>
			</div>
			<hr>
		<%-- <c:if test="${sessionScope.name != null }"> --%>
			<form class="reply-insert-form">
				<input type="hidden" name="clubBoardNo" value="${clubBoardDto.clubBoardNo}">
				<div class="row mt-5">
					<div class="col-10">
						<input type="text" class="form-control w-100 reply-write" placeholder="댓글을 달아주세요">
					</div>
					<div class="col">
						<button type="submit" class="btn btn-reply-send btn-success">전송</button>
					</div>
				</div>
			</form>
		<%-- </c:if> --%>
			
		
			<div class="row mt-2 reply-list">
			
			</div>
		
			
		</div>
	</div>
</div>

<!-- Button trigger modal -->
<!-- <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
  Launch demo modal
</button> -->
<!-- Modal -->
<!-- <div class="modal fade" id="replyEditModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
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

</div> -->

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>