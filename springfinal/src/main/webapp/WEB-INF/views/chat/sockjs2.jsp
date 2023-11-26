<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css" rel="stylesheet">

<link href="${pageContext.request.contextPath}/css/chat.css"
	rel="stylesheet">

<style>
 input[type="file"] {
    display: none;
  }

  /* 스타일을 적용할 버튼 */
  .custom-file-upload {
    border: 1px solid #ccc;
    display: inline-block;
    padding: 6px 12px;
    cursor: pointer;
  }
  
  .user_img_msg{
  background-color: #ffffff;
  height: 45px;
  }
  
  .modal-profile-image{
  width: 70px;
  height: 70px;
  }
  
  .online-icon {
    width: 10px;
    height: 10px;
    background-color: #00ff4e;
    border-radius: 50%;
    margin-right: 5px;
}

.offline-icon {
    width: 10px;
    height: 10px;
    background-color: #cfcdcd; 
    border-radius: 50%;
    margin-right: 5px;
}


</style>

</head>


<body>

<c:if test="${not empty clubDto}">
    <div class="row">
        <div class="col-3 pe-0">
            <a id="homeLink" href="${pageContext.request.contextPath}/club/detail?clubNo=${clubDto.clubNo}" class="btn btn-success bg-miso w-100 active">홈</a>
        </div>
        <div class="col-3 pe-0">
            <a id="boardLink" href="${pageContext.request.contextPath}/clubBoard/list?clubNo=${clubDto.clubNo}" class="btn btn-success bg-miso w-100">게시판</a>
        </div>
        <div class="col-3 pe-0">
            <a id="photoLink" href="${pageContext.request.contextPath}/photo/list?clubNo=${clubDto.clubNo}" class="btn btn-success bg-miso w-100">사진첩</a>
        </div>
        <c:if test="${not empty clubDto.chatRoomNo}">
            <div class="col-3">
                <a id="chatLink" href="${pageContext.request.contextPath}/chat/enterRoom/${clubDto.chatRoomNo}" class="btn btn-success bg-miso w-100">채팅</a>
            </div>
        </c:if>
    </div>
</c:if>
		<div class="row"> 



				<!-- 메세지 헤더 -->
				<div class="row card-header msg_head me-2">
				<div class="d-flex bd-highlight justify-content-between">
                            <div class="img_cont">
                               <img src="${pageContext.request.contextPath}/club/image?clubNo=${clubInfo.clubNo}" class="rounded-circle" width="60" height="60">
                            </div>
                            <div class="user_info">
                                <span class="circle-name">
                                   ${circleName}
                                </span>
                            </div>
                            <button class="btn btn-outline-secondary" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasExample" aria-controls="offcanvasExample">
                                <i class="fa-solid fa-users"></i>
                            </button>
                        </div>
                        </div>

					<div class="col">
						<div class="offcanvas offcanvas-end" tabindex="-1"
							id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
							<div class="offcanvas-header">
								<h5 class="offcanvas-title" id="offcanvasExampleLabel"></h5>
								<button type="button" class="btn-close text-reset"
									data-bs-dismiss="offcanvas" aria-label="Close"></button>
							</div>
							<div class="offcanvas-body">
								<div class="col-md-4 client-list">
								
								 <ul class="list-group">
								 <c:forEach var="member" items="${members}">
					    <li class="list-group-item d-flex justify-content-between align-items-center">
					     <span class="offline-icon"  id="clubMemberId_${member.clubMemberId}" value="${member.clubMemberId}"></span>
					        <img src="/rest/member/profileShow?memberId=${member.clubMemberId}" class="rounded-circle" width="50" height="50">
					        <span>${member.memberName}</span>
				        
					        <c:choose>
				            <c:when test="${member.clubMemberRank eq '운영진'}">
				                <span class="badge bg-primary rounded-pill">운영진</span>
				            </c:when>
				            <c:otherwise>
				                <span class="badge rounded-pill bg-miso">일반</span>
				            </c:otherwise>
				        </c:choose>
				        
				        <c:choose>
				        <c:when test="${member.clubMemberId eq sessionScope.name}">
			            <span class="badge rounded-pill bg-warning">나</span>
				        </c:when>
							<c:otherwise>
							<span class="badge rounded-pill bg-null"> </span>
							</c:otherwise>
				        </c:choose>					     
					    </li>
					</c:forEach>
					
					<c:if test="${not empty oneMembers}">
    <!-- chatSender 정보 -->
    <li class="list-group-item d-flex justify-content-between align-items-center">
        <img src="/rest/member/profileShow?memberId=${oneMembers.chatSender}" class="rounded-circle" width="50" height="50">
        <span>${oneMembers.senderName}</span>
        <c:choose>
            <c:when test="${oneMembers.senderLevel eq '운영진'}">
                <span class="badge bg-primary rounded-pill">운영진</span>
            </c:when>
            <c:otherwise>
                <span class="badge rounded-pill bg-miso">일반</span>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${oneMembers.chatSender eq sessionScope.name}">
                <span class="badge rounded-pill bg-warning">나</span>
            </c:when>
            <c:otherwise>
                <span class="badge rounded-pill bg-null"> </span>
            </c:otherwise>
        </c:choose>
    </li>

    <!-- chatReceiver 정보 -->
    <li class="list-group-item d-flex justify-content-between align-items-center">
        <img src="/rest/member/profileShow?memberId=${oneMembers.chatReceiver}" class="rounded-circle" width="50" height="50">
        <span>${oneMembers.receiverName}</span>
        <c:choose>
            <c:when test="${oneMembers.receiverLevel eq '운영진'}">
                <span class="badge bg-primary rounded-pill">운영진</span>
            </c:when>
            <c:otherwise>
                <span class="badge rounded-pill bg-miso">일반</span>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${oneMembers.chatReceiver eq sessionScope.name}">
                <span class="badge rounded-pill bg-warning">나</span>
            </c:when>
            <c:otherwise>
                <span class="badge rounded-pill bg-null"> </span>
            </c:otherwise>
        </c:choose>
    </li>
</c:if>

<c:if test="${not empty meetingMembers}">
 <c:forEach var="member" items="${meetingMembers}">
    <li class="list-group-item d-flex justify-content-between align-items-center">
        <img src="/rest/member/profileShow?memberId=${member.clubMemberId}" class="rounded-circle" width="50" height="50">
        <span>${member.memberName}</span>
        <c:choose>
            <c:when test="${member.clubMemberRank eq '운영진'}">
                <span class="badge bg-primary rounded-pill">운영진</span>
            </c:when>
            <c:otherwise>
                <span class="badge rounded-pill bg-miso">일반</span>
            </c:otherwise>
        </c:choose>
        <c:choose>
            <c:when test="${member.clubMemberId eq sessionScope.name}">
                <span class="badge rounded-pill bg-warning">나</span>
            </c:when>
            <c:otherwise>
                <span class="badge rounded-pill bg-null"> </span>
            </c:otherwise>
        </c:choose>
    </li>
</c:forEach>

</c:if>

                              </ul>
								
								</div>
							</div>
						</div>
					</div>
					
<!-- 					<div class="col text-end"> -->
<!-- 					<i class="fa-solid fa-ellipsis fa-xl chat-more"></i> -->
<!-- 					</div> -->
					
				</div>
				

				<!-- 메세지 표시 영역 -->
				<div class="row">
					<div class="col message-list"></div>
				</div>

				<div class="row mt-4">
					<div class="col p-0">
						<div class="input-group">
						
<!-- 						<button class="send-file-btn">전송</button> -->

<!-- 						<input type="file" name="attach" multiple> -->

				  <!-- input file 엘리먼트 -->
				  <input type="file" name="attach" id="fileInput" multiple>

								  <!-- 대체 버튼 및 "전송" 버튼으로 통합된 버튼 -->
								  <label for="fileInput" class="custom-file-upload">
								    <i class="fa-solid fa-camera blue"></i> 
								  </label>
								  
								<input type="text" class="form-control message-input"
									placeholder="메세지를 입력하세요">
								<button type="button" class="btn send-btn btn-success bg-miso send-file-btn">
									<i class="fa-regular fa-paper-plane"></i> 보내기
								</button>
							</div>

					</div>
				</div>

			</div>
		</div>


		<!-- 모달 -->
		<div class="modal fade" id="profileModal" tabindex="-1"
			aria-labelledby="profileModalLabel" aria-hidden="true"
			data-bs-backdrop="static">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="profileModalLabel">프로필</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="닫기"></button>
					</div>
					<div class="modal-body">
						<!-- 프로필 카드 내용 -->
						<div class="modal-card" style="border-radius: 15px;">
							<div class="modal-card-body text-center">
								<div class="mt-3 mb-4">
									<img
										src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava2-bg.webp"
										class="rounded-circle img-fluid modal-profile-image"
										style="width: 100px; height: 100px;" />
								</div>
								<h4 class="mb-2 modal-profile-name">줄리 L. 아르소노</h4>
								<p class="text-muted mb-4 modal-profile-id"></p>
								<div class="mb-4 pb-2">
									<button type="button" class="btn btn-success bg-miso dm-send">메세지
										보내기</button>
								</div>
							</div>
						</div>
					</div>
				</div>
				</div>
</div>
<!-- 		<!-- 모달 -->
<!-- 		<div class="modal" id="chatMoreModal"> -->
<!-- 		    <div class="modal-dialog"> -->
<!-- 		        <div class="modal-content"> -->
<!-- 		            모달 내용 -->
<!-- 		            <div class="modal-body"> -->
<!-- 		                <p>채팅방을 지우거나 나가시겠습니까?</p> -->
<!-- 		            </div> -->
		
<!-- 		            모달 하단 버튼 -->
<!-- 		            <div class="modal-footer"> -->
<!-- 		                <button type="button" class="btn btn-danger" id="deleteChatRoomBtn">채팅방 지우기</button> -->
<!-- 		                <button type="button" class="btn btn-secondary" id="leaveChatRoomBtn">채팅방 나가기</button> -->
<!-- 		                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button> -->
<!-- 		            </div> -->
<!-- 		        </div> -->
<!-- 		    </div> -->
<!-- 		</div> -->


<!-- 	</div> -->

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
	<!-- 웹소켓 서버가 SockJS일 경우 페이지에서도 SockJS를 사용해야 한다 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	
	<script>
    // 세션 정보를 JavaScript 변수에 저장
    var loggedInUserId = "${sessionScope.name}";
    window.contextPath = "${pageContext.request.contextPath}";
</script>
	
	
	<script>
	//연결 생성
	//연결 후 해야할 일들을 콜백함수로 지정(onopen, onclose, onerror, onmessage)
	
	// jQuery를 사용하는 경우
$(document).ready(function () {
    // clubNo가 비어있는 경우 상단 메뉴를 숨김
    if (!"${not empty clubDto.clubNo}") {
        $("#homeLink, #boardLink, #photoLink, #chatLink").hide();
    }
});

	function connect() {
	// 클라이언트에서 SockJS로 서버에 접속하는 부분
	window.socket = new SockJS("http://localhost:8080/ws/chat");

	var chatRoomNo = getRoomNoFromURL();  // 채팅방 번호를 얻어옴
	var chatSender = "${sessionScope.name}"; //발신자
	var memberName;
	//console.log(memberName);
	var oneChatMemberName;
	var prevMessageDate;

// 	var mapToSend = ${mapToSend}
//     console.log("mapToSend:", mapToSend);
	 
// 	// 클릭 이벤트 처리
// 	$(".chat-more").click(function() {
// 	    // 모달 표시
// 	    $("#chatMoreModal").modal("show");
// 	});

// 	// 채팅방 지우기 버튼 클릭 이벤트
// 	$("#deleteChatRoomBtn").click(function() {
// 	    // 여기에 채팅방 지우기 로직 추가
// 	    var resetMessage = {
// 	        messageType: "chatReset",
// 	        chatRoomNo: chatRoomNo,
// 	        chatSender: chatSender
// 	    };

// 	    window.socket.send(JSON.stringify(resetMessage));
	  
// 	    // 모달 닫기
// 	    $("#chatMoreModal").modal("hide");
// 	});

// 	// 채팅방 나가기 버튼 클릭 이벤트
// 	$("#leaveChatRoomBtn").click(function() {
// 	    // 여기에 채팅방 나가기 로직 추가
// 	    // 모달 닫기
// 	    $("#chatMoreModal").modal("hide");
// 	});

	// 방 이동 시
	function moveToRoom(selectedRoomNo) {
	    window.location.href = "/chat/enterRoom/" + selectedRoomNo;
	}

	// JavaScript에서 룸번호 읽어오기
	function getRoomNoFromURL() {
	    var url = window.location.href;
	    var match = url.match(/\/chat\/enterRoom\/(\d+)/);
	    return match ? parseInt(match[1]) : null;
	}	
	
	window.socket.onopen = function (e) {
// 	     console.log('Info: connection opened.');

	    // 서버에 join 메시지 전송
	    var joinMessage = {
	        messageType: "join",
	        chatRoomNo: chatRoomNo,
	        chatSender: chatSender,
	        memberName: memberName
	    };

	    window.socket.send(JSON.stringify(joinMessage));
	  
	};

	//파일
	  document.getElementById('fileInput').addEventListener('change', function() {
	      // 파일을 선택한 경우, 파일을 자동으로 메시지 전송
	      document.querySelector('.send-file-btn').click();
	    });
 
	//파일크기 경고
	$("[name=attach]").change(function(e){
		const files = this.files;
		if(files.length === 0) return;
		
		let total = 0;
		for(let i=0; i < files.length; i++) {
			total += files[i].size;
		}
		
		//console.log("total", total);
		if(total > 1 * 1024 * 1024) {//1MB
			alert("파일은 1MB를 초과할 수 없습니다");
			$(this).val("");//선택된 파일초기화
		}
	});
	
	$(".send-file-btn").click(function(){
			var files = $("[name=attach]")[0].files;
			if(files.length === 0) return;
			
			for(let i=0; i < files.length; i++) {
				var reader = new FileReader();
				reader.onload = (e)=>{
					var data = e.target.result;
					var fileName = files[i].name; // 파일 이름 가져오기
					var fileSize = files[i].size; // 파일 크기 가져오기
					var fileType = files[i].type; // 파일 타입 가져오기
					var json = JSON.stringify({
						messageType : "file",
						chatSender: "${sessionScope.name}",
						chatRoomNo : ${chatRoomNo},
						chatContent : data,
						fileName: fileName, // 파일 이름 추가
						fileSize : fileSize,
						fileType : fileType, 
					});
					socket.send(json);
				};
				reader.readAsDataURL(files[i]);
			}
		});
	

	
		//메세지 처리
		window.socket.onmessage = function(e){
		
		
		var data = JSON.parse(e.data);
		console.log(data);
		
		var clubMemberRank;

		
		if (data.messageType === 'join') {
		    var chatSender = data.chatSender;
		    
		    var onlineMemberElement = document.getElementById("clubMemberId_" + chatSender);
		    console.log(onlineMemberElement);

		    if (onlineMemberElement) {
		        // 온라인 상태인 경우
		        if (onlineMemberElement.classList.contains('offline-icon')) {
		            onlineMemberElement.classList.remove('offline-icon');
		            onlineMemberElement.classList.add('online-icon');
		            console.log('온라인 상태입니다.');
		        } else {
		            console.log('이미 온라인 상태입니다.');
		        }
		    } else {
		        // 오프라인 상태인 경우
		        console.log('오프라인 상태입니다.');
		    }
		}



if (data.messageType === "delete") {
    console.log("Received delete event:", data);

    // 여기서 data.chatNo를 사용하도록 수정
    var chatNo = data.chatNo;
    console.log("chatNo:", chatNo);

    // 내가 보낸 메시지인 경우
    var messageContainerSend = $(".message-list").find(".msg_cotainer_send[data-chatNo='" + chatNo + "']");
    console.log("Found message container (send):", messageContainerSend);

    // 상대방이 보낸 메시지인 경우
    var messageContainerReceive = $(".message-list").find(".msg_cotainer[data-chatNo='" + chatNo + "']");
    console.log("Found message container (receive):", messageContainerReceive);

    if (messageContainerSend.length > 0) {
        console.log("Before updating text (send):", messageContainerSend.text());
        messageContainerSend.text("삭제된 메시지입니다");
        console.log("After updating text (send):", messageContainerSend.text());
    } else if (messageContainerReceive.length > 0) {
        console.log("Before updating text (receive):", messageContainerReceive.text());
        messageContainerReceive.text("삭제된 메시지입니다");
        console.log("After updating text (receive):", messageContainerReceive.text());
    } else {
        console.log("Message container not found for chatNo:", chatNo);
    }
}


	
		//메세지 타입이 디엠이라면 해당 룸번호로 이동
		if(data.messageType === "dm" && data.chatRoomNo){
			moveToRoom(data.chatRoomNo);
		}
		
		 // 만약 메세지 타입이 dm이면서 receiver가 있는 경우
	    if (data.messageType === "dm" && data.chatReceiver) {    	
	    	 console.log("Before moveToRoom: ", data); // 이 줄 추가
	    	 
	        // 방 이동 처리
	        moveToRoom(data.chatRoomNo);
	        
	        var chatContent = $(".message-input").val().trim(); // 값이 없을 경우 공백으로 처리

	        // 메시지 내용이 비어있으면 전송하지 않음
		    if (!chatContent) {
		        console.log("Content is empty. Message not sent.");
		        return;
		    }
	        
	        // 메세지 전송 처리
	        var sendMessage = {
	            messageType: "dm",
	            memberId: data.memberId,
	            chatRoomNo: data.chatRoomNo,
	            content: chatContent, 
	        };
	        
	        console.log("Before sending message: ", sendMessage); // 이 줄 추가

	        window.socket.send(JSON.stringify(sendMessage));
	    }
		 
		// 시간을 표시할 패턴 설정
		var dateOptions = {
		    year: "numeric",
		    month: "long",
		    day: "numeric",
		    weekday: "long",
		};

		var chatTimeAsString = data.chatTime; // JSON에서 문자열로 가져온 chatTime
		var chatTime = new Date(chatTimeAsString); // 문자열을 Date 객체로 변환

		// 날짜를 원하는 형식으로 포맷팅
		var formattedDate = chatTime.toLocaleDateString("ko-KR", dateOptions);

		// 시간을 원하는 형식으로 포맷팅
		var options = {
		    hour: "numeric",
		    minute: "numeric",
		    hour12: true // 오전/오후 표시를 사용
		};

		var formattedTime = chatTime.toLocaleTimeString("ko-KR", options);

		// 메시지를 구성할 때 날짜와 시간을 함께 사용
		var fullMessage = formattedDate + " " + formattedTime + " " + data.content;


		
		if (data.content) { // 메세지 처리 
			
			
		    var memberId = "${sessionScope.name}";
		   // console.log(memberId);
		    var chatSender = data.memberId;
		   // console.log("sender",chatSender)

		    var memberName = data.memberName;
		    var oneChatMemberName = data.oneChatMemberName;
// 			console.log("oneChatMemberName",oneChatMemberName);
		   // console.log(memberName);
		    
		 // 새로운 메시지의 날짜 정보 가져오기
		    var chatTimeAsString = data.chatTime; // JSON에서 문자열로 가져온 chatTime
		    var chatTime = new Date(chatTimeAsString); // 문자열을 Date 객체로 변환
		    var messageDate = chatTime.toDateString(); // 날짜 정보만 추출
		    	    
		    var profileImageUrl = data.profileImageUrl
// 		    console.log(data.profileImageUrl);

		 // 날짜가 변경된 경우에만 표시
		    if (messageDate !== prevMessageDate) {
		        // 날짜 표시 부분 스타일 추가
		        var dateDiv = $("<div>")
		            .addClass("date-divider")
		            .text(formattedDate)
				             .css({
		            'font-weight': 'bold',
		            'margin-top': '10px',
		            'margin-bottom': '10px',
		            'text-align': 'center',
		        });
		        $(".message-list").append(dateDiv);
		        prevMessageDate = messageDate; // 이전 날짜 갱신
		    }
		            
		    var content = $("<div>").text(data.content);

		    
		    if (memberId === chatSender) {
		        // 본인 메시지 (오른쪽에 표시)
		        var messageDiv = $("<div>").addClass("d-flex justify-content-end mb-4 mt-2");
		        var messageContainer = $("<div>").addClass("msg_cotainer_send").attr("data-chatNo", data.chatNo);
// 		 		console.log(messageContainer);
		        
		        // 파일인 경우 이미지 태그를 추가
		        if (data.messageType === "file") {
// 		            console.log("file data: ", data);
		            var img = $("<img>")
		                .attr("src", "${pageContext.request.contextPath}" + data.content) // 이미지 소스 설정
		                .css("width", "300px"); // 이미지 크기 조절
		            messageContainer.append(img);
		        } else {
		            // 텍스트인 경우 텍스트 추가
		        	 messageContainer.text(data.content);
		        }
		        
		        var imageContainer = $("<div>").addClass("img_cont_msg");
		        var profileImage = $("<img>").css("width", "45px").addClass("rounded-circle user_img_msg");

		        // 프로필 이미지 URL이 존재하는 경우
		        if (profileImageUrl) {
		            profileImage.attr("src", profileImageUrl);
		        } else {
		            // 프로필 이미지 URL이 없는 경우
		            var defaultImageUrl = "${pageContext.request.contextPath}/images/basic-profile.png"; // 여기에 기본 이미지의 경로를 넣어주세요.
		            profileImage.attr("src", defaultImageUrl);

		            // 이미지 로딩 에러(프로필 이미지가 없을 때) 시 기본 이미지로 교체
		            profileImage.on("error", function () {
		                $(this).attr("src", defaultImageUrl);
		            });
		        }
		        

		        imageContainer.append(profileImage);

		        var timeSpan = $("<div>").addClass("time-right")
		            .append($("<span>").addClass("msg_time_send").text(formattedTime));

		        var contentDiv = $("<div>").addClass("d-flex flex-column");
		        contentDiv.append(messageContainer);
				
		        if (data.chatBlind === 'N') {
		            var deleteIcon = $("<span>")
		                .addClass("delete-icon delete-right")
		                .html('<i class="fas fa-times"></i>')
		                .hide() // 일단 숨겨둠
		                .on("click", function () {
		                    var messageDiv = $(this).closest(".d-flex");
		                    var messageContent = $(".msg_cotainer_send", messageDiv);
		                    var chatNo = messageContainer.attr("data-chatNo");
		                    console.log("chatNo", chatNo);
							
		                    var memberId = "${sessionScope.name}";
		                    var memberLevel = "${sessionScope.level}";
		                    console.log("memberLevel",memberLevel);
		                    
		                    $.ajax({
		                    	type:"GET",
		                    	url: window.contextPath +'/getClubMemberRank',
		                    	 data: {
		                    	        memberId: memberId,
		                    	        chatRoomNo: chatRoomNo
		                    	    },
		                    	    success: function (response) {
		                                // 서버에서 받은 응답 처리
		                                var clubMemberRank = response;

		                                // data.clubMemberRank 값이 '운영진'일 때만 삭제 동작
		                                if (clubMemberRank === '운영진' || memberLevel === '파워유저') {
		                                    var confirmDelete = confirm("메시지를 정말 삭제하시겠습니까?");

		                                    if (confirmDelete) {
		                                        // 서버에 업데이트 요청을 보냄
		                                        var deleteMessage = {
		                                            messageType: "delete",
		                                            chatNo: chatNo,
		                                            chatRoomNo: chatRoomNo,
		                                        };

		                                        window.socket.send(JSON.stringify(deleteMessage));
		                                        $(this).hide();
		                                        messageContent.text("삭제된 메시지입니다");
		                                    }
		                                } else {
		                                	// 경고창을 띄워서 권한이 없음을 알림
		                                	var alertDiv = $("<div>").addClass("alert alert-dismissible alert-light alert-container")
											    .css({
											        textAlign: "center", // 텍스트를 가운데 정렬
											    })
											    .append('<button type="button" class="btn-close" data-bs-dismiss="alert"></button>')
											    .append('<strong>권한이 없습니다. </strong><br>')
											    .append('<span class="badge bg-success rounded-pill bg-miso">파워유저</span>가 되어보세요! <br>')
											    .append('<a href="/pay/product" class="alert-link btn btn-success bg-miso w-100 mt-2">구매하기</a>');


		                                	// 경고창을 body에 표시
		                                	$("body").append(alertDiv);

		                                	// 메세지 리스트 위로 띄우기
		                                	var messageList = $(".message-list");
		                                	alertDiv.insertBefore(messageList); // 메세지 리스트 앞에 추가

		                                	alertDiv.css({
		                                	    position: "absolute",
		                                	    width:"350px",
		                                	    top:"340px",
		                                	    left:"320px",
		                                	    "z-index": 3, 
		                                	});

		                                }
		                            },
		                            error: function (error) {
		                                // 오류 처리
		                                console.error("Error fetching clubMemberRank:", error);
		                            }
		                        });
		                    });

		                // 삭제 아이콘을 메시지 박스에 추가하고 숨겨둠
		                messageContainer.append(deleteIcon);

		                // 마우스가 메시지 박스 위로 올라갈 때 삭제 아이콘을 표시
		                messageContainer.on("mouseenter", function () {
		                    deleteIcon.show();
		                });

		                // 마우스가 메시지 박스 바깥으로 나갈 때 삭제 아이콘을 숨김
		                messageContainer.on("mouseleave", function () {
		                    deleteIcon.hide();
		                });
		            }

		            messageDiv.append(timeSpan).append(contentDiv).append(imageContainer);

		            $(".message-list").append(messageDiv);
		            
		    } else {
		    	
		    	// 상대방 메시지 (왼쪽에 표시)
		    	var messageDiv = $("<div>").addClass("d-flex mb-4 align-items-start mt-2");

		    	   var imageContainer = $("<div>").addClass("img_cont_msg");
			        var profileImage = $("<img>").css("width", "45px").addClass("rounded-circle user_img_msg");
			        

			        // 프로필 이미지 URL이 존재하는 경우
			        if (profileImageUrl) {
			            profileImage.attr("src", profileImageUrl);
			        } else {
			            // 프로필 이미지 URL이 없는 경우
			            var defaultImageUrl = "${pageContext.request.contextPath}/images/basic-profile.png"; // 여기에 기본 이미지의 경로를 넣어주세요.
			            profileImage.attr("src", defaultImageUrl);

			            // 이미지 로딩 에러(프로필 이미지가 없을 때) 시 기본 이미지로 교체
			            profileImage.on("error", function () {
			                $(this).attr("src", defaultImageUrl);
			            });
			        }
			        imageContainer.append(profileImage);

		    	// 클릭 이벤트 추가
		    	imageContainer.on("click", function() {
		    	    $.ajax({
		    	        url: window.contextPath +'/getProfile',
		    	        type: 'GET',
		    	        success: function(data) {
		    	            // 성공적으로 데이터를 받아왔을 때 처리
		    	            console.log(data); // 여기서 data는 List<MemberDto> 형태
							
		    	            // data 배열에서 클릭된 멤버의 정보 찾기
		    	            var selectedMember = data.find(function(member) {
		    	                // nicknameDiv에서 텍스트 정보 가져오기
		    	                var nicknameText = $(".msg_nickname", messageDiv).text();
		    	                return nicknameText === member.memberName;
		    	            });

		    	            // selectedMember가 존재할 때만 모달을 업데이트
		    	            if (selectedMember) {
		    	            	// 모달 내용 업데이트
		    	            	$("#profileModalLabel").text(selectedMember.memberName + " 님의 프로필"); // 모달 제목 업데이트
		    	            	var modalBody = $("#profileModal .modal-body");
								
		    	            	// 프로필 사진이 있는 경우에만 이미지 업데이트
		    	            	if (selectedMember.profileImageUrl) {
		    	            	    modalBody.find(".modal-profile-image").attr("src", selectedMember.profileImageUrl);
		    	            	} else {
		    	            	    // 프로필 사진이 없는 경우 기본 이미지를 사용하거나 표시할 내용을 결정할 수 있습니다.
		    	            	    modalBody.find(".modal-profile-image").attr("src", "${pageContext.request.contextPath}/images/basic-profile.png");
		    	            	}

		    	            	modalBody.find(".modal-profile-name").text(selectedMember.memberName); // 이름 업데이트
		    	            	modalBody.find(".modal-profile-id").text("@" + selectedMember.memberId); // 아이디 업데이트

		    	            	// 모달 표시
		    	            	$("#profileModal").modal("show");

		    	            }
		    	        },
		    	        error: function(error) {
		    	            // 오류 발생 시 처리
		    	            console.error(error);
		    	        }
		    	    });
		    	});
		    	
// 				   console.log(data.memberId); 
// 				   console.log(data.memberName);
				
				   var contentDiv = $("<div>").addClass("d-flex flex-column");

				   var nicknameDiv = $("<div>").addClass("msg_nickname")
				       .text(data.memberId === data.memberName ? oneChatMemberName : memberName);

				   var messageContainer = $("<div>").addClass("msg_cotainer").attr("data-chatNo", data.chatNo);
				   console.log(messageContainer);
					
				   // 파일인 경우 이미지 태그를 추가
				   if (data.messageType === "file") {
// 				       console.log("file data: ", data);
				       var img = $("<img>")
				           .attr("src", "${pageContext.request.contextPath}" + data.content) // 이미지 소스 설정
				           .css("width", "300px");// 이미지 크기 조절
				       messageContainer.append(img);
				   } else {
				       // 텍스트인 경우 텍스트 추가
				       messageContainer.text(data.content);
				   }
				   
// 				   if(data.messageType === "delete"){
// 					   console.log("Received delete event:", data);
// 					   var messageContainer = $(".message-list").find(".msg_cotainer[data-chatNo='" + chatNo + "']");
// 					   console.log("Found message container:", messageContainer);
// 					    console.log("Before updating text:", messageContainer.text());
// 					   messageContainer.text("삭제된 메시지라고");
// 				   }
				   
				   contentDiv.append(nicknameDiv).append(messageContainer);
				   
				   if (data.chatBlind === 'N') {
			            var deleteIcon = $("<span>")
			                .addClass("delete-icon delete-right")
			                .html('<i class="fas fa-times"></i>')
			                .hide() // 일단 숨겨둠
			                .on("click", function () {
			                    var messageDiv = $(this).closest(".d-flex");
			                    var messageContent = $(".msg_cotainer_send", messageDiv);
			                    var chatNo = messageContainer.attr("data-chatNo");
			                    console.log("chatNo", chatNo);
								
			                    var memberId = "${sessionScope.name}";
			                    
			                    $.ajax({
			                    	type:"GET",
			                    	url: window.contextPath +'/getClubMemberRank',
			                    	 data: {
			                    	        memberId: memberId,
			                    	        chatRoomNo: chatRoomNo
			                    	    },
			                    	    success: function (response) {
			                                // 서버에서 받은 응답 처리
			                                var clubMemberRank = response;

			                                // data.clubMemberRank 값이 '운영진'일 때만 삭제 동작
			                                if (clubMemberRank === '운영진') {
			                                    var confirmDelete = confirm("메시지를 정말 삭제하시겠습니까?");

			                                    if (confirmDelete) {
			                                        // 서버에 업데이트 요청을 보냄
			                                        var deleteMessage = {
			                                            messageType: "delete",
			                                            chatNo: chatNo,
			                                            chatRoomNo: chatRoomNo,
			                                        };

			                                        window.socket.send(JSON.stringify(deleteMessage));
			                                        $(this).hide();
			                                        messageContent.text("삭제된 메시지입니다");
			                                    }
			                                } else {
			                                	// 경고창을 띄워서 권한이 없음을 알림
			                                	var alertDiv = $("<div>").addClass("alert alert-dismissible alert-light alert-container")
												    .css({
												        textAlign: "center", // 텍스트를 가운데 정렬
												    })
												    .append('<button type="button" class="btn-close" data-bs-dismiss="alert"></button>')
												    .append('<strong>권한이 없습니다. </strong><br>')
												    .append('<span class="badge bg-primary rounded-pill">운영진</span>만 가능해요! <br>')

			                                	// 경고창을 body에 표시
			                                	$("body").append(alertDiv);

			                                	// 메세지 리스트 위로 띄우기
			                                	var messageList = $(".message-list");
			                                	alertDiv.insertBefore(messageList); // 메세지 리스트 앞에 추가

			                                	alertDiv.css({
			                                	    position: "absolute",
			                                	    width:"350px",
			                                	    top:"340px",
			                                	    left:"320px",
			                                	    "z-index": 3, 
			                                	});
			                                }
			                            },
			                            error: function (error) {
			                                // 오류 처리
			                                console.error("Error fetching clubMemberRank:", error);
			                            }
			                        });
			                    });
				      

				        // 삭제 아이콘을 메시지 박스에 추가하고 숨겨둠
				        messageContainer.append(deleteIcon);

				        // 마우스가 메시지 박스 위로 올라갈 때 삭제 아이콘을 표시
				        messageContainer.on("mouseenter", function () {
				            deleteIcon.show();
				        });

				        // 마우스가 메시지 박스 바깥으로 나갈 때 삭제 아이콘을 숨김
				        messageContainer.on("mouseleave", function () {
				            deleteIcon.hide();
				        });
				   }
				 
				   
				   
				   var timeSpan = $("<div>").addClass("time-left")
				       .append($("<span>").addClass("msg_time").text(formattedTime));
				   
				   messageDiv.append(imageContainer).append(contentDiv).append(timeSpan);

				   $(".message-list").append(messageDiv);

		}
		// 스크롤바 이동
		$(".message-list").scrollTop($(".message-list")[0].scrollHeight);		
		    }
	}

		
		//메세지를 전송하는 코드
		//-메세지가 @로 시작하면 DM으로 처리(아이디 유무 검사정도 하면 좋음)
		//- @아이디 메세지		
		//엔터키로 메세지 전송
		$(".message-input").keydown(function (e) {
	    if (e.keyCode === 13) { // Enter 키 눌림
	        sendMessage();
	    }
			});
		
		$(".send-btn").click(function () {
		    sendMessage();
		});


		
// dm 요청 함수
$(".dm-send").on("click", function () {
    // 모달에서 상대방 정보 가져오기
    var chatReceiver = $("#profileModal .modal-profile-id").text().trim();
    var memberLevel = "${sessionScope.level}";

    if (memberLevel === '파워유저') {
        // "@" 이후의 문자열 추출
        var atSymbolIndex = chatReceiver.indexOf("@");
        var relativeUserId = atSymbolIndex !== -1 ? chatReceiver.slice(atSymbolIndex + 1) : null;

        // 채팅 메시지 객체 생성
        var dm = {
            messageType: "dm",
            chatSender: "${sessionScope.name}", // 사용자 이름 또는 아이디 등
            chatReceiver: relativeUserId, // "@" 이후의 문자열을 상대방 아이디로 사용
        };

        // WebSocket을 통해 서버로 메시지 전송
        window.socket.send(JSON.stringify(dm));

        console.log("DM 메시지 전송 완료");
        console.log(dm);
    } else {
        // '파워유저'가 아닌 경우에는 경고창 표시
    	var alertDiv = $("<div>").addClass("alert alert-dismissible alert-light alert-container")
	    .css({
	        textAlign: "center", // 텍스트를 가운데 정렬
	    })
	    .append('<button type="button" class="btn-close" data-bs-dismiss="alert"></button>')
	    .append('<strong>권한이 없습니다. </strong><br>')
	    .append('<span class="badge bg-success rounded-pill bg-miso">파워유저</span>가 되어보세요! <br>')
	    .append('<a href="/pay/product" class="alert-link btn btn-success bg-miso w-100 mt-2">구매하기</a>');


	// 경고창을 body에 표시
	$("body").append(alertDiv);

	// 메세지 리스트 위로 띄우기
	var messageList = $(".message-list");
	alertDiv.insertBefore(messageList); // 메세지 리스트 앞에 추가

	// 모달창의 z-index 값 확인
	var modalZIndex = $('#profileModal').css('z-index');

	// 경고창의 z-index 설정
	alertDiv.css({
	    position: "absolute",
	    width: "350px",
	    top: "340px",
	    left: "320px",
	    "z-index": parseInt(modalZIndex) + 1, // 모달창의 z-index보다 큰 값으로 설정
	});

    }
});


		
		// 메시지 전송 함수
		function sendMessage() {
		    var chatContent = $(".message-input").val().trim(); // 값이 없을 경우 공백으로 처리
		    var messageType = "message";
		    var sessionName = "${sessionScope.name}";
		    var chatRoomNo = ${chatRoomNo};
		    
		    // 메시지 내용이 비어있으면 전송하지 않음
		    if (!chatContent) {
		        console.log("Content is empty. Message not sent.");
		        return;
		    }

		    var message = {
		        messageType: messageType,
		        chatSender: sessionName,
		        chatContent: chatContent,
		        chatRoomNo: chatRoomNo
		    };

		    // 서버로 메시지 전송
		    window.socket.send(JSON.stringify(message));

		    // 메시지 입력창 초기화
		    $(".message-input").val("");
		}
		

		// 메시지 전송 이벤트 처리
		function handleSendMessage() {
		    var inputElement = document.querySelector(".message-input");
		    var messageContent = inputElement.value;

		    // 메시지가 비어있지 않은 경우에만 전송
		    if (messageContent.trim() !== "") {
		        sendMessage(messageContent);

		        // 전송 후 입력창 비우기
		        inputElement.value = "";
		    }
		}

		// 이벤트 리스너 등록
		document.querySelector(".send-btn").addEventListener("click", handleSendMessage);


// 		// 메세지 헤더 생성
// 		var headerContent = $("<div>").addClass("d-flex bd-highlight justify-content-between");
// 		var imageContainer = $("<div>").addClass("img_cont");
// 		var userImage = $("<img>").attr("src", "/images/circle.jpg").css("width", "60px").addClass("rounded-circle user_img");
// 		var userInfo = $("<div>").addClass("user_info");
// 		var roomName = $("<span>").addClass("circle-name").text("");

// 		// 버튼 엘리먼트 생성
// 		var button = $("<button>").addClass("btn btn-outline-secondary");
// 		button.attr("type", "button");
// 		button.attr("data-bs-toggle", "offcanvas");
// 		button.attr("data-bs-target", "#offcanvasExample");
// 		button.attr("aria-controls", "offcanvasExample");
// 		var buttonIcon = $("<i>").addClass("fa-solid fa-users");
// 		button.append(buttonIcon);

// 		userInfo.append(roomName);
// 		imageContainer.append(userImage);
// 		headerContent.append(imageContainer).append(userInfo).append(button); 
// 		var headerElement = $("<div>").addClass("card-header msg_head").append(headerContent);

// 		// .card-header 요소에 메세지 헤더 추가
// 		$(".card-header").append(headerElement);


		//.btn-userlist를 누르면 사용자 목록에 active를 붙였다 떼었다 하도록 처리
		$(".btn-userlist").click(function(){
			$(".client-list").toggleClass("active");
		});
		
// 		window.socket.onclose = function(e) {
// 			 setTimeout(function() {
// 			      connect();
// 			    }, 1000); // 웹소켓을 재연결하는 코드 삽입
// 		};
		
	}

	connect();

	</script>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>