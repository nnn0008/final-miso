<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<!-- 부트스트랩 CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Popper.js, Bootstrap JS, jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>


<style>
.fa-ellipsis-vertical:hover{
	cursor:pointer;
}

.text-title{
font-size: 18px;
}

.board-like-count{
color: #43adff;
}

.card.bg-miso{
width:500px;
}

</style>
<script>

//댓글 작성 시 비동기처리로 댓글 작성 + 댓글 목록 비동기처리

$(function(){
	
	window.notifySocket = new SockJS("${pageContext.request.contextPath}/ws/notify");
	//전역변수로 설정
	var replyHtmlTemplate = $.parseHTML($("#reply-insert-form").html());
	
    //댓글 작성
    //$(".div-for-insert-reply").append(replyHtmlTemplate);
    $(".reply-insert-form").submit(function(e){
    	var params = new URLSearchParams(location.search);
        var clubBoardNo = params.get("clubBoardNo");
        
        e.preventDefault();
        
        var clubBoardReplyContent = $(this).find(".reply-write").val();
        console.log(clubBoardReplyContent);
        if(clubBoardReplyContent.length == 0) return;
		
        $.ajax({
            url: window.contextPath + "/rest/reply/insert",
            method: "post",
            data: {
                clubBoardReplyContent: clubBoardReplyContent,
                clubBoardNo: clubBoardNo,
                //clubBoardReplyParent : clubBoardReplyParent,
            },
            success: function(response){
                console.log("성공");
            	$(".reply-write").val("");
            	loadList()
            	loadMore(currentPage);

					//소켓 전송
                    var notifyType = "reply";
                    var replyWriterMember = response.replyWriterMember;
                    var boardWriterMember = response.boardWriterMember;
                    var clubBoardNo = response.boardNo;
                    var boardTitle = response.boardTitle;
                    var replyWriterName = response.replyWriterName;

                    if(boardWriterMember != replyWriterMember){
                        let socketMsg = JSON.stringify({
                            notifyType: notifyType,
                            replyWriterMember: replyWriterMember,
                            boardWriterMember: boardWriterMember,
                            clubBoardNo: clubBoardNo,
                            boardTitle: boardTitle,
                            replyWriterName : replyWriterName
                        });

                        notifySocket.send(socketMsg);                 
		     		} 
		      },
		    });
	});
    
    //대댓글 작성
    //$(replyHtmlTemplate).find(".btn-miso").click(function(e){
    $(document).on("click", ".btn-misos", function(e){
// 	    $(".btn-open-reply-edit").hide();
		var params = new URLSearchParams(location.search);
        var clubBoardNo = params.get("clubBoardNo");
        var originReplyNo = $(this).parents(".for-reply-edit").find(".btn-subReply").data("reply-no");
        e.preventDefault();
//         console.log(originReplyNo);
        
        var clubBoardReplyContent = $(this).parents(".for-reply-edit").find(".reply-write").val();
        console.log(clubBoardReplyContent);
        if(clubBoardReplyContent.length == 0) return;
		
        $.ajax({
            url: window.contextPath + "/rest/reply/insert",
            method: "post",
            data: {
                clubBoardReplyContent: clubBoardReplyContent,
                clubBoardNo: clubBoardNo,
                clubBoardReplyParent : originReplyNo,
            },
            success: function(response){
                console.log("성공");
            	$(".reply-write").val("");
            	$(this).remove();
            	loadList()
            	loadMore(currentPage);
//                 $(".div-for-insert-reply").show();
                $(".btn-open-reply-edit").show();

              //소켓 전송
                var notifyType = "reply";
                var replyWriterMember = response.replyWriterMember;
                var boardWriterMember = response.boardWriterMember;
                var clubBoardNo = response.boardNo;
                var boardTitle = response.boardTitle;
                var replyWriterName = response.replyWriterName;

                if(boardWriterMember != replyWriterMember){
                    let socketMsg = JSON.stringify({
                        notifyType: notifyType,
                        replyWriterMember: replyWriterMember,
                        boardWriterMember: boardWriterMember,
                        clubBoardNo: clubBoardNo,
                        boardTitle: boardTitle,
                        replyWriterName : replyWriterName
                    });

	                        notifySocket.send(socketMsg);                 
			     		} 
		      },
		      error:function(error){
		    	  console.error("문제발생");
		      }
		    });
	});

		//로그인 한 아이디
		var memberId = "${sessionScope.name}";
		

	});

</script>
<script>
	$(function(){
		
		$(".board-like-count").val();
		
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

		$(".fa-heart").click(function () {
			console.log("클릭이벤트발생");			
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

	$(function(){
		//로그인 한 유저와 비교(게시글)
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
<script>
//스크롤 템플릿
// $(window).scroll(function() {
// 	// 현재 스크롤 위치
// 	var scrollTop = $(window).scrollTop();
// 	// 문서의 전체 높이
// 	var docHeight = $(document).height();
// 	// 창의 높이
// 	var windowHeight = $(window).height();
// 	// 스크롤의 위치를 퍼센트로 계산
// 	var scrollPercent = (scrollTop / (docHeight - windowHeight)) * 100;
// 	// 퍼센트를 콘솔에 출력
// 	//console.log("스크롤 퍼센트: " + scrollPercent.toFixed(2) + "%");
	
// 	if(!loading && scrollPercent >= 65){
// 		$(".go-upside").show();
// 		loading = true;
// 		console.log(currentPage);
		
// 	}
// });

// // 스크롤 이벤트를 감지하여 처리합니다.
// $(window).scroll(function () {
//     // 스크롤 위치를 계산합니다.
//     var scrollPercentage = getScrollPercentage();
//     console.log("스크롤 위치: " + scrollPercentage + "%");
    
//     // 여기에 추가적인 무한 스크롤 처리를 추가하세요.
// });

// // 스크롤 위치를 계산하는 함수
// function getScrollPercentage() {
//     var scrollPosition = $(window).scrollTop();
//     var windowHeight = $(window).height();
//     var bodyHeight = $(document).height();

//     var scrollPercentage = (scrollPosition / (bodyHeight - windowHeight)) * 100;
//     return scrollPercentage.toFixed(2); // 소수점 두 자리까지만 표시
// }
//전역변수로 설정
var loading = false;
var currentPage = 1;
//스크롤 관련
$(function(){
	loadList()

	loadMore(currentPage);
});


//화면이 로딩되거나 댓글이 작성되었을경우 댓글목록을 다시 찍어주는 비동기처리
function loadMore(currentPage){
	var params = new URLSearchParams(location.search);
	var clubBoardNo = params.get("clubBoardNo");
	//var memberId = "${sessionScope.name}";
	$(window).scroll(function() {
		// 현재 스크롤 위치
		var scrollTop = $(window).scrollTop();
		// 문서의 전체 높이
		var docHeight = $(document).height();
		// 창의 높이
		var windowHeight = $(window).height();
		// 스크롤의 위치를 퍼센트로 계산
		var scrollPercent = (scrollTop / (docHeight - windowHeight)) * 100;
		// 퍼센트를 콘솔에 출력
		console.log("스크롤 퍼센트: " + scrollPercent.toFixed(2) + "%");
		
		if(!loading && scrollPercent >= 65){
// 			$(".go-upside").show();
			loading = true;
			console.log(currentPage);
			
			$.ajax({
				url: window.contextPath+"/rest/reply/list",
				method:"post",
				data:{
					clubBoardNo : clubBoardNo,
					page : currentPage,
				},
				//response를 댓글 목록으로 받아옴
				success:function(response){
					$(".reply-list").empty();
					console.log(response);
					currentPage++;
					for(var i = 0; i < response.length; i++){
						//console.log(response);
						var template = $("#reply-template").html();
						var htmlTemplate = $.parseHTML(template);
						
						$(htmlTemplate).find(".clubBoardReplyWriter").text(response[i].clubBoardReplyWriter);
						$(htmlTemplate).find(".clubBoardReplyContent").text(response[i].clubBoardReplyContent);
						$(htmlTemplate).find(".clubBoardReplyDate").text(response[i].formattedClubBoardReplyDate);
						$(htmlTemplate).find(".btn-subReply").attr("data-reply-no", response[i].clubBoardReplyNo);
						//내가 작성한 댓글인지 확인하여 수정/삭제 버튼을 안보이게
						if(response[i].match == false){
							$(htmlTemplate).find(".edit-delete").empty();
						}
						
						//대댓글 이라면
		              	if(response[i].clubBoardReplyParent != null){
		                    $(htmlTemplate).addClass("ms-5");
		                    $(htmlTemplate).find(".only-attach-reply").remove();
		                    $(htmlTemplate).find("hr").remove();
		                }
						
						$(htmlTemplate).find(".btn-reply-delete").attr("data-reply-no", response[i].clubBoardReplyNo).click(function(e){
							var clubBoardReplyNo = $(this).attr("data-reply-no");
							$.ajax({
								url: window.contextPath + "/rest/reply/delete",
								method:"post",
								data:{clubBoardReplyNo: clubBoardReplyNo},
								//삭제 성공하면
								success:function(response){
									loadList();
						
									loadMore(currentPage); //목록을 갱신 
								},
							});
						});

						$(htmlTemplate).find(".btn-open-reply-edit").attr("data-reply-no", response[i].clubBoardReplyNo).click(function(){
							var editTemplate = $("#reply-edit-template").html();
							var editHtmlTemplate = $.parseHTML(editTemplate);
							
							//기존 댓글 창을 숨기자
							$(".div-for-insert-reply").hide();
							//다른 수정 버튼을 안보이게
							$(".btn-open-reply-edit").hide();
							//수정 버튼 누르고 답글 달기 버튼 누르면 2개가 동시에 보임
							$(".btn-subReply").hide();
							
							var clubBoardReplyNo = $(this).attr("data-reply-no");
							var clubBoardReplyContent = $(this).parents(".for-reply-edit").find(".clubBoardReplyContent").text();
							//console.log(clubBoardReplyContent);
							$(editHtmlTemplate).find("[name=clubBoardReplyNo]").val(clubBoardReplyNo);
							$(editHtmlTemplate).find("[name=clubBoardReplyContent]").val(clubBoardReplyContent);
							
							//취소버튼을 클릭한다면
							$(editHtmlTemplate).find(".btn-cancel").click(function(e){
								$(this).parents(".edit-container").prev(".for-reply-edit").show();
								$(this).parents(".edit-container").remove();
								$(".div-for-insert-reply").show();
								//숨긴 수정 버튼 다시 보여주기
									$(".btn-open-reply-edit").show();
									$(".btn-subReply").show();
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
										loadMore(currentPage);
										$(".div-for-insert-reply").show();
										$(".btn-subReply").show();
									}
								});
							});
							
							//화면 배치
							$(this).parents(".for-reply-edit").hide().after(editHtmlTemplate);
						});
						
						$(htmlTemplate).find(".btn-subReply").attr("data-reply-no", response[i].clubBoardReplyNo).click(function(e){
							$(this).hide();
							$(".btn-open-reply-edit").hide();
							var parent = $(this).parents(".for-reply-edit");
							if(!parent.is(replyHtmlTemplate)){
								$(this).parents(".for-reply-edit").append(replyHtmlTemplate);
								$(".div-for-insert-reply").hide();
								//console.log("생성");
							 }
							//console.log("취소준비");
							parent.find(".btn-reReply-cancel").on("click", function(e){
								$(this).parents(".for-reply-edit").find(".btn-subReply").show();
								$(replyHtmlTemplate).remove();
								$(".div-for-insert-reply").show();
								$(".btn-open-reply-edit").show();
								//console.log("취소");
							});
						});
						
						//댓글을 붙여
						$(".reply-list").append(htmlTemplate);
							
						
					}
					loading = false;	
					//여기에 댓글 입력창 붙이면 됨
					//$(".div-for-insert-reply").append(replyHtmlTemplate);		
				}
				
				
				});//여기가 loadList의 최상위 ajax 끝낸 자리임
		}
	});
}

//화면이 로딩되거나 댓글이 작성되었을경우 댓글목록을 다시 찍어주는 비동기처리
//최초 10개
function loadList(){
	var params = new URLSearchParams(location.search);
	var clubBoardNo = params.get("clubBoardNo");
	//var memberId = "${sessionScope.name}";\
	var currentPage = 1;
	$.ajax({
		url: window.contextPath+"/rest/reply/list",
		method:"post",
		data:{
			clubBoardNo : clubBoardNo,
			page : currentPage,
		},

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
				$(htmlTemplate).find(".clubBoardReplyDate").text(response[i].formattedClubBoardReplyDate);
				$(htmlTemplate).find(".btn-subReply").attr("data-reply-no", response[i].clubBoardReplyNo);
				//내가 작성한 댓글인지 확인하여 수정/삭제 버튼을 안보이게
				if(response[i].match == false){
					$(htmlTemplate).find(".edit-delete").empty();
				}
				
				//대댓글 이라면
              	if(response[i].clubBoardReplyParent != null){
                    $(htmlTemplate).addClass("ms-5");
                    $(htmlTemplate).find(".only-attach-reply").remove();
                    $(htmlTemplate).find("hr").remove();
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
					
					//기존 댓글 창을 숨기자
					$(".div-for-insert-reply").hide();
					//다른 수정 버튼을 안보이게
					$(".btn-open-reply-edit").hide();
					//수정 버튼 누르고 답글 달기 버튼 누르면 2개가 동시에 보임
					$(".btn-subReply").hide();
					
					var clubBoardReplyNo = $(this).attr("data-reply-no");
					var clubBoardReplyContent = $(this).parents(".for-reply-edit").find(".clubBoardReplyContent").text();
					//console.log(clubBoardReplyContent);
					$(editHtmlTemplate).find("[name=clubBoardReplyNo]").val(clubBoardReplyNo);
					$(editHtmlTemplate).find("[name=clubBoardReplyContent]").val(clubBoardReplyContent);
					
					//취소버튼을 클릭한다면
					$(editHtmlTemplate).find(".btn-cancel").click(function(e){
						$(this).parents(".edit-container").prev(".for-reply-edit").show();
						$(this).parents(".edit-container").remove();
						$(".div-for-insert-reply").show();
						//숨긴 수정 버튼 다시 보여주기
							$(".btn-open-reply-edit").show();
							$(".btn-subReply").show();
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
								$(".div-for-insert-reply").show();
								$(".btn-subReply").show();
							}
						});
					});
					
					//화면 배치
					$(this).parents(".for-reply-edit").hide().after(editHtmlTemplate);
				});
				
				$(htmlTemplate).find(".btn-subReply").attr("data-reply-no", response[i].clubBoardReplyNo).click(function(e){
					$(this).hide();
					$(".btn-open-reply-edit").hide();
					var parent = $(this).parents(".for-reply-edit");
					if(!parent.is(replyHtmlTemplate)){
						$(this).parents(".for-reply-edit").append(replyHtmlTemplate);
						$(".div-for-insert-reply").hide();
						//console.log("생성");
					 }
					//console.log("취소준비");
					parent.find(".btn-reReply-cancel").on("click", function(e){
						$(this).parents(".for-reply-edit").find(".btn-subReply").show();
						$(replyHtmlTemplate).remove();
						$(".div-for-insert-reply").show();
						$(".btn-open-reply-edit").show();
						//console.log("취소");
					});
				});
				
				//댓글을 붙여
				$(".reply-list").append(htmlTemplate);
					
				
			}
			
			//여기에 댓글 입력창 붙이면 됨
			//$(".div-for-insert-reply").append(replyHtmlTemplate);		
		}
		
		
		});//여기가 loadList의 최상위 ajax 끝낸 자리임

}

</script>
<script>
	//신고와 관련된 스크립트
	$(function(){
		
		//$(".btn-report-send").prop("disabled", true);
		$(".btn-report-send").click(function(e){
		//$(".report-send-form").submit(function(e){
			e.preventDefault();
			
			var reportCategory = $("[name=reportCategory]").val();

		    if (!reportCategory) {
		        // 선택되지 않은 경우
		        $('[name="reportCategory"]').addClass('is-invalid');
		        console.log("제출");
		    }
		    else {
		    	
		   		console.log("됐냐");
		        // 선택된 경우
		        $('[name=reportCategory]').removeClass('is-invalid');
		        var reportType = $("[name=reportType]").val();
		        var reportLocal = $("[name=reportLocal]").val(); 
		        var reportReporter = $("[name=reportReporter]").val();
		        var reportReported = $("[name=reportReported]").val();
		        var reportCategory = $("[name=reportCategory]").val();
		        
		        $.ajax({
					url: window.contextPath + "/rest/report/clubBoard/insert",
					method: "post",
					data:{
						reportType: reportType,
						reportLocal: reportLocal,
						reportReporter: reportReporter,
						reportReported: reportReported,
						reportCategory, reportCategory
					}, 
					success: function(response){
				        // 모달 닫기
				        setTimeout(function(){
							alert("신고가 접수되었습니다");
				        }, 500);
					},
					error: function (error) {
	                    // 여기에 에러 처리 코드 추가
	                    alert("에러가 발생했습니다. 다시 시도해주세요.");
	                }
				});		
		    }
		    console.log("됐냐고요");
		});
		
		$("[name=reportCategory]").change(function(){
			console.log("값을 변경시킴", $(this).val());
			if($(this).val()){
				console.log("변경 성공");
			
				$(this).removeClass("is-invalid");
				$(".btn-report-send").prop("disabled", false).attr("data-bs-dismiss", "modal");
			}
			else{
				console.log("변경 실패");
				$(this).addClass("is-invalid");
				$(".btn-report-send").prop("disabled", true);
			}
		});
		
		// 모달이 닫힐 때 이벤트 처리
		$('#exampleModal').on('hidden.bs.modal', function (e) {
		  // 입력 필드 초기화
		  $('[name=reportCategory]').val('');
		  $('[name=reportCategory]').removeClass('is-invalid');
		});
		
	});
	
</script>

<script id="reply-template" type="text/template">
<div class="col-12 for-reply-edit mt-2">
    <div class="card bg-miso mb-3"">
        <div class="card-header d-flex align-items-center reply-box">
            <div class="col-5 me-2">
                <h6 class="clubBoardReplyWriter">작성자</h6>
            </div>
            <div class="col text-end">
                <small><span class="clubBoardReplyDate">MM-dd E HH:mm</span></small>
            </div>
            <div class="col edit-delete text-end">
                <i class="fa-solid fa-eraser ms-auto p-2 fa-gray btn-open-reply-edit"></i>
                <i class="fa-solid fa-trash-can p-2 fa-gray btn-reply-delete"></i>
            </div>
        </div>
        <div class="card-body">
            <div class="row mt-2 mb-2">
                <div class="col reply-content">
                    <span class="clubBoardReplyContent fs-6">내용</span>
                </div>
            </div>
            <hr>
            <div class="row mt-2 only-attach-reply">
                <div class="col mb-2">
                    <i class="fa-regular fa-message btn-subReply"><span class="ms-2">답글 달기</span></i>
                </div>
            </div>
        </div>
    </div>
</div>

</script>
<script id="reply-edit-template" type="text/template">
<form class="reply-edit-form edit-container">
    <input type="hidden" name="clubBoardReplyNo" value="?">
    <div class="row mt-2">
        <div class="col-12">
            <div class="input-group">
            <textarea name="clubBoardReplyContent" class="form-control" rows="3"></textarea>
                <button type="submit" class="btn btn-miso btn-reply-edit">
                    수정
                </button>
                <button type="button" class="btn btn-cancel">
                    취소
                </button>
        </div>
            </div>
    </div>
</form>
</script>
<!-- 댓글 작성용 템플릿 -->
<script id="reply-insert-form" type="text/template">
<div class="row">
    <div class="col-12">
        <div class="input-group">
            <textarea type="text" class="form-control reply-write" rows="3" placeholder="댓글을 달아주세요"></textarea>
            <button type="button" class="btn btn-reply-send btn-miso btn-misos">전송</button>
            <button type="button" class="btn btn-reply-cancel btn-reReply-cancel">취소</button>
        </div>
    </div>
</div>

</script>
<script id="reReply-template" type="text/template">
	<form class="reReply-edit-form">
		<input type="hidden" name="clubBoardReplyNo" value="?">
		<div class="row flex-container">
			<div class="col-6">
				<textarea name="clubBoardReReplyContent" class="form-control"rows="3"></textarea>
			</div>
			<div class="col">
				<button type="submit" class="btn btn-miso btn-reReply-send">
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


	<div class="row mt-2">
		<div class="col">
			
			<div class="row d-flex align-items-center">
				<div class="col-1">
					<c:if test="${attachDto.attachNo == null }">
						<img src="${pageContext.request.contextPath}/images/basic-profile.png" class="rounded-circle" width="60" height="60">				
					</c:if>
					<c:if test="${attachDto.attachNo != null}">
						<img src="${pageContext.request.contextPath}/clubBoard/download?attachNo=${clubBoardAllDto.attachNoMp}" class="rounded-circle" width="60" height="60">
					</c:if>
				</div>
				<div class="col ms-4">
					${clubBoardDto.clubBoardName}
				</div>
				<div class="col-5 text-end">
				<span class="badge bg-success">${clubBoardDto.clubBoardCategory}</span>
					<small><fmt:formatDate value="${clubBoardDto.clubBoardDate}" pattern="M월 d일 a h시 m분"/></small>
<%-- 					${clubBoardDto.clubBoardDate} --%>
				</div>
				
    <div class="col-1 text-end">
            <div class="btn-group" role="group">
                <i class="fas fa-ellipsis-vertical"  id="btnGroupDrop1"  class="btn dropdown-toggle show" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="true"></i>
                <div class="dropdown-menu" aria-labelledby="btnGroupDrop1" data-popper-placement="bottom-start" style="position: absolute; inset: 0px auto auto 0px; margin: 0px; transform: translate(0px, 41px);">
                    <a class="dropdown-item" href="${pageContext.request.contextPath}/clubBoard/list?clubNo=${clubBoardDto.clubNo}"">목록</a>
                    <c:if test="${sessionScope.name == clubMemberDto.clubMemberId}">
	                    <a class="dropdown-item" href="${pageContext.request.contextPath}/clubBoard/edit?clubBoardNo=${clubBoardDto.clubBoardNo}">수정</a>
	                    <a class="dropdown-item" href="${pageContext.request.contextPath}/clubBoard/delete?clubBoardNo=${clubBoardDto.clubBoardNo}"">삭제</a>    
	                </c:if>                
                    <c:if test="${sessionScope.name != clubMemberDto.clubMemberId}">
	                    <a class="dropdown-item" href="#exampleModal" data-bs-toggle="modal" data-bs-target="#exampleModal">신고</a>
                    </c:if>
                </div>
        </div>
</div>

	</div>
	</div>
</div>
			
			<div class="row mt-4">
				<div class="col text-title">
				<strong>
					${clubBoardDto.clubBoardTitle}
				</strong>
				</div>
				
						
			<div class="row mt-4">
				<div class="col" style="min-height: 200px;">
					${clubBoardDto.clubBoardContent}
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
			

							
			</div>
			<%--좋아요 --%>
			<div class="row mt-4 mb-3">
				<div class="col">
					<c:if test="${isLiked}">
						<i class="fa-regular fa-heart me-1 fa-2x" style="color: red"></i>
					</c:if>
					<c:if test="${!isLiked}">
						<i class="fa-solid fa-heart me-1 fa-2x" style="color: red"></i>
					</c:if>					
					좋아요<span class="board-like-count ms-1">	${clubBoardDto.clubBoardLikecount}</span>
				</div>
			</div>
			<hr>
			
			<%--댓글이 있는 곳 --%>
			<div class="row mt-2 reply-list"></div>
			
			<%-- 댓글 작성할 곳이 있는 곳 --%>
<div class="row mt-2 div-for-insert-reply">
    <form class="reply-insert-form">
        <input type="hidden" name="clubBoardNo" value="${clubBoardDto.clubBoardNo}">
        <div class="row mt-3 mb-4">
            <div class="col-12">
                <div class="input-group">
                    <textarea class="form-control reply-write" rows="3" placeholder="댓글을 달아주세요"></textarea>
                    <button type="submit" class="btn btn-reply-send btn-miso">전송</button>
                </div>
            </div>
        </div>
    </form>
</div>


		
			
		</div>
	</div>
</div>

<!-- Modal -->
<div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h1 class="modal-title fs-5" id="exampleModalLabel">${clubBoardDto.clubBoardNo}번 글 신고하기</h1>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        
        <div class="container-fluid">
        	
        	<form class="report-send-form">
        	<input type="hidden" readonly name="reportType" value="게시글">
        	<input type="hidden" readonly name="reportLocal" value="${clubBoardDto.clubBoardNo}">
			<input type="hidden" readonly name="reportReporter" value="${sessionScope.name}">
			       			
	        	<div class="row">
	        		<div class="col">
						신고 하려는 유저	        					
	        		</div>
	        		<div class="col">
						<input type="text" readonly value="${clubMemberDto.clubMemberId}" name="reportReported" class="form-control">		
	        		</div>
	        	</div>
	        	<div class="row mt-2">
	        		<div class="col">
						신고 사유        			
	        		</div>
	        		<div class="col">
	        			<select name="reportCategory" class="form-select">
	        				<option value="">선택하세요</option>
	        				<option value="광고">광고</option>
	        				<option value="음란">음란</option>
	        				<option value="욕설">욕설</option>
	        				<option value="차별">차별</option>	        				
	        				<option value="개인정보">개인정보 유출</option>	        				
	        			</select>
	        		</div>
	        	</div>
        	</form>
        	
        </div>
        
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
        <button type="button" class="btn btn-primary btn-report-send">제출</button>
      </div>
    </div>
  </div>
</div>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>