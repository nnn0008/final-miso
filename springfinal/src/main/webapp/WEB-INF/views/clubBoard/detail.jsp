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
		//로그인 한 아이디
		var memberId = "${sessionScope.name}";
		
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
					console.log(response);

					for(var i = 0; i < response.length; i++){
						console.log("몇 번 반복했니");

                        if(response[i].clubBoardReplyParent == null){
                            var wrapper = createReplyWrapper(response[i]);
                            $(".reply-list").append(wrapper);
                        }
						else{
                            var wrapper = createSubReplyWrapper(response[i]);
                            $(".reply-list").append(wrapper);
                        }
                        //여기에 써야됨
						
						 $(".for-reply-edit").find(".btn-reply-delete").click(function(e){
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
						$(".for-reply-edit").find(".btn-reply-edit").click(function(){
							//console.log($(".btn-reply-edit").data("board-reply-no"));
							$("#replyEditModal").show();
							var clubBoardReplyNo = $(this).attr("data-board-reply-no");
							var clubBoardReplyContent = $(this).parents().find(".clubBoardReplyContent").text();
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
						$(".btn-subReply-send").click(function(e){
							e.preventDefault();
							var clubBoardReplyNo = $(this).attr("data-board-reply-no");
							var clubBoardSubReplyContent = $(this).parent(".receive-subReplyContent").find("[name=clubBoardSubReplyContent]").val();
							//console.log(clubBoardSubReplyContent);
							if(clubBoardSubReplyContent.val() == 0) return;
							var params = new URLSearchParams(location.search);
							var clubBoardNo = params.get("clubBoardNo");
								
								$.ajax({
									url:window.contextPath+"/rest/reply/insert",
									method:"post",
									data:	
									{
										clubBoardReplyContent: clubBoardSubReplyContent,
										clubBoardNo: clubBoardNo,
										clubBoardReplyParent: clubBoardReplyNo,
										clubBoardReplyGroup: clubBoardReplyNo,
									},	
									success:function(response){
										console.log("성공");
										$("[name=clubBoardSubReplyContent]").val("");
										loadList();
									}
								});			
						});
						
					}
				}
			});
			
			//좋아요 관련 처리
			
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
			
			$(".fa-heart").click(function(){
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
				});
			});
			
			
			
		}
		
		$("#subReplyModal").on("hidden.bs.modal", function(){
			$("[name=clubBoardSubReplyContent]").val("");
		});

	});

	/* //댓글을 붙이는 함수
	function createReplyWrapper(response){
	    return $("<div>").addClass("row for-reply-edit mt-2 reply-wrapper")
	                                .append(createWriterDateButtonsWrapper(response))
	                                //.append(createButtonsWrapper(response))
	                                .append(createContentWrapper(response))
	                                .append(createSubReplyWrapper(response))
	                                .append(createSubReplyFormWrapper());                              
	}
	
	function createSubReplyWrapper(response){
	    return $("<div>").addClass("row for-reply-edit mt-2 reply-wrapper ms-3")
	                                .append(createWriterDateButtonsWrapper(response))
	                                .append(createButtonWrapper())
	                                .append(createContentWrapper(response))
	}
	
	function createWriterDateButtonsWrapper(response){
	    return $("<div>").addClass("col").text(response.clubBoardReplyWriter)
	        .$("<div>").addClass("col").text(response.clubBoardReplyDate)
	        .append($("<div>").addClass("col"))
	        .append(createDeleteButton(response.clubBoardReplyNo))
	        .append(createEditButton(response.clubBoardReplyNo));
	}
	
	// function createButtonsWrapper(response){
	//     return $("<div>").addClass("row mt-2")
	//         .append(createDeleteButton(response.clubBoardReplyNo))
	//         .append(createEditButton(response.clubBoardReplyNo));
	// }
	
	function createEditButton(response){
	    return $("<button>").attr("type", "button").attr("data-board-reply-no", response.clubBoardReplyNo).addClass("btn btn-info btn-reply-edit").text("수정").click(function(){
	        $("수정모달을 열어라");
	    });
	}
	function createDeleteButton(response){
	    return $("<button>").attr("type", "button").attr("data-board-reply-no", response.clubBoardReplyNo).addClass("btn btn-success btn-reply-delete").text("삭제").click(function(){
	        $(this).closest(".reply-wrapper").remove();
	    });
	}
	function createContentWrapper(response){
	    return $("<div>").addClass("row mt-2")
	        .append($("<div>").addClass("col clubBoardReplyContent").text(response.clubBoardReplyContent));
	}
	function createSubReplyWrapper(response){
	    return $("<div>").addClass("row mt-2 hc-clubBoardSubReplyContent")
	        .append($("<div>").addClass("col")
	        .append($("<i>").addClass("fa-solid fa-pen fa-pen-to-square").text("답글달기").click(function(){
	          $(this).closet(".댓글창을 열어").show();       
	        })));
	}
	function createSubReplyFormWrapper(){
	    return $("<form>").addClass("subReply-insert-form")
	        .append($("<div>").addClass("row mt-2")
	        .append($("<div>").addClass("col"))
	        .append($("<input>").attr("type", "text").attr("name", "clubBoardSubReplyContent").addClass("form-control"))
	        .append($("<div>").addClass("col"))
	        .append($("<button>").attr("type", "submit").addClass("btn btn-subReply-send btn-success").text("전송")))
	} */
</script>

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
					<i class="fa-regular fa-heart photo-like" style="color: red"></i><p class="board-like-count">${clubBoardAllDto.clubBoardLikecount}</p>
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
		<%-- <c:if test="${sessionScope.name != null }"> --%>
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

</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>