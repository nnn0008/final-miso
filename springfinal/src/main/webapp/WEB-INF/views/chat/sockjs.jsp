<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!doctype html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Bootstrap demo</title>

    <!-- 아이콘 사용을 위한 Font Awesome 6 CDN -->
    <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
   <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css" rel="stylesheet">
    <link href="test.css" rel="stylesheet">
 
 <style>
 .bg-gray{
 	background: #FCFCFD;
 	 color: #2d3436;
 }
 	.bg-miso {
    color: #2d3436;
    background-color: #ACCEFF;

}
.btn-outline-secondary{
	width: 60px;
	height: 50px;
	margin-top: 0.5em;
	margin-left: 1em;
} 
 	
 	.message-list{
 		height: 70vh;
 		overflow-y: scroll;
 		 width: 600PX;
		border-radius: 15px !important;
		background-color: #ACCEFF !important;
 	}
 	
 	::-webkit-scrollbar {
    	width: 0px; /* 스크롤바 너비 */
	}
	.alert-success,.btn-success{
	   color: #2d3436;
   	 background-color: #ACCEFF;
   	 border-color:  #ACCEFF;
	--bs-btn-color: #fff;
    --bs-btn-bg: ##ACCEFF;;
    --bs-btn-border-color: #ACCEFF;
    --bs-btn-hover-color: #fff;
    --bs-btn-hover-bg: #99BCED;
    --bs-btn-hover-border-color: #99BCED;
    --bs-btn-focus-shadow-rgb: 78,190,147;
    --bs-btn-active-color: #fff;
    --bs-btn-active-bg: #99BCED;
    --bs-btn-active-border-color: #99BCED;
    --bs-btn-active-shadow: 0 1px 2px rgba(0, 0, 0, 0.05);
    --bs-btn-disabled-color: #fff;
    --bs-btn-disabled-bg: #ACCEFF;
    --bs-btn-disabled-border-color: #ACCEFF;
	}

 	.msg_cotainer{
		margin-top: auto;
		margin-bottom: auto;
		margin-left: 10px;
		border-radius: 25px;
		background-color: #FFBCF0;
		padding: 10px;
		position: relative;
	}
	.msg_cotainer_send{
		margin-top: auto;
		margin-bottom: auto;
		margin-right: 10px;
		border-radius: 25px;
		background-color: #66DFD2;
		padding: 10px;
		position: relative;
	}

.dm_style {
    background-color:#FCFCFD;;
}
	.msg_nickname{
	margin-left: 1em;
	font-size: 13px;
	}
	.time-right{
	margin-top: 2.5em;
	margin-right: 0.5em;
	font-size: 12px;
	}
	
	.time-left{
	margin-top: 4em;
	margin-left: 0.5em;
	font-size: 12px;
	}

	.circle-name{
	margin: 1em;
	font-size: 17px;
	text-align: center;
	font-weight: bold;
	}
	.user_info{
	display: flex; 
    justify-content: center; 
	}

	.list-group-item, .list-group{
	width: 300px;
	}

	#offcanvasExample{
	width: 340px;
	}
	
	.container-fluid{
	width: 600px;
	}
	

 </style>   
    
</head>


  <body>
    <div class="container-fluid">
        <div class="row">
            <div class="col">
				
				<div class="row mt-4">
					<div class="col">

					</div>
				</div>
			
						
						<!-- 메세지 헤더 -->
						<div class="row card-header msg_head m-2">


						    <div class="col">					    	
									<div class="offcanvas offcanvas-end" tabindex="-1" id="offcanvasExample" aria-labelledby="offcanvasExampleLabel">
									  <div class="offcanvas-header">
									    <h5 class="offcanvas-title" id="offcanvasExampleLabel"></h5>
									    <button type="button" class="btn-close text-reset" data-bs-dismiss="offcanvas" aria-label="Close"></button>
									  </div>
									  <div class="offcanvas-body">
									      <div class="col-md-4 client-list"></div>
									    <div>
									    </div>
									  </div>
									</div>
						    </div>
						</div>
						
						<!-- 메세지 표시 영역 -->
						<div class="row">
							<div class="col message-list"></div>
						</div>
						
						<div class="row mt-4">
							<div class="col p-0">
								<div class="input-group">
									<input type="text" class="form-control message-input" placeholder="메세지를 입력하세요">
									<button type="button" class="btn btn-success send-btn">
										<i class="fa-regular fa-paper-plane"></i>
										보내기
									</button>
								</div>
							</div>
						</div>
						
					</div>
				</div>
				
            </div>
 
   
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
      <!-- 웹소켓 서버가 SockJS일 경우 페이지에서도 SockJS를 사용해야 한다 -->
	<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
	<script>
	
	//연결 생성
	//연결 후 해야할 일들을 콜백함수로 지정(onopen, onclose, onerror, onmessage)
	
	window.socket = new SockJS("${pageContext.request.contextPath}/ws/chat"); //http로 시작하는 주소
	
		window.socket.onmessage = function(e){
		
		var data = JSON.parse(e.data);
		console.log(data);
		
		var chatTimeAsString = data.chatTime; // JSON에서 문자열로 가져온 chatTime
		var chatTime = new Date(chatTimeAsString); // 문자열을 Date 객체로 변환
		
		var options = {
				  hour: "numeric",
				  minute: "numeric",
				  hour12: true // 오전/오후 표시를 사용
				};
	
		var formattedTime = chatTime.toLocaleTimeString("ko-KR", options);

		
		
		//사용자가 접속하거나 종료했을 때 서버에서 오는 데이터로 목록을 갱신
		//사용자가 메세지를 보냈을 때 서버에서 이를 전체에게 전달한다
		//data.clients에 회원 목록이 있다
		if (data.clubMembers) { // 목록 처리
		    $(".client-list").empty();
	
		    var ul = $("<ul>").addClass("list-group");
		    var loggedInUserId = "${sessionScope.name}";
		    var loggedInUserItem = null;
		    
		    var clubNumber = "${sessionScope.clubNo}";
		    console.log("ClubNumber: " + clubNumber);

		    for (var i = 0; i < data.clubMembers.length; i++) {
		        var memberId = data.clubMembers[i].memberId;
		        var memberLevel = data.clubMembers[i].memberLevel;
		        var memberNickname = data.clubMembers[i].memberNickname;
		        var clubNo = data.clubMembers[i].clubNo;
		        console.log("clubNo: " + clubNo);

		        // 레벨에 따라 배지 스타일 변경
		     	     var badgeClass = "bg-miso";
			        if (memberLevel === "관리자") {
			            badgeClass = "bg-danger";
			        } else if (memberLevel === "VIP") {
			            badgeClass = "bg-warning";
			        }
		        
			        
			        var listItem = $("<li>")
			            .addClass("list-group-item d-flex justify-content-between align-items-center")
			            .append(
			                $("<img>").addClass("rounded-circle user_img").attr("src", "images/member.png").css("width", "50px")
			            )
			            .append(
			                $("<span>").text(memberNickname)
			            )
			            .append(
			                $("<span>").addClass("badge rounded-pill").addClass(badgeClass)
			                    .text(memberLevel)
			            );
		        
		        
				        if (memberId === loggedInUserId) {
				            // 본인의 아이디를 찾았을 때 별도로 저장
				            loggedInUserItem = listItem;
				            listItem.append($("<span>").addClass("badge rounded-pill bg-warning").text("나"));
				        } else {
				            ul.append(listItem);
				        }
		        
				}

			    if (loggedInUserItem) {
			        // 본인의 아이디를 목록의 맨 위에 추가
			        ul.prepend(loggedInUserItem);
		    } 
		    
		    
		    // 목록이 client-list에 표시됩니다.
		    ul.appendTo(".client-list");
		}
		    
		
		
		else if(data.content){ //메세지 처리   
			
			var memberId = "${sessionScope.name}";
			var memberNickname = data.memberNickname;
					
			   var content = $("<div>").text(data.content);
				var memberLevel = $("<span>").text(data.memberLevel).addClass("badge rounded-pill ms-2");

			    // 메세지 레벨에 따라 배지 스타일 변경
			    if (data.memberLevel == "일반") {
			        memberLevel.addClass("bg-gray");
			    } else if (data.memberLevel == "관리자") {
			        memberLevel.addClass("bg-danger");
			    } else if (data.memberLevel == "VIP") {
			        memberLevel.addClass("bg-warning");
			    }
			   
			   var isDM = data.dm == true;
			   
			   if (isDM) {
				    // 디엠 메시지 (귓속말 표시)
				    memberNickname = data.memberNickname + "(귓속말)";
				}
			   				   
				if (data.memberId === memberId) {			
					    
					
				    // 본인 메시지 (오른쪽에 표시)
				    var messageDiv = $("<div>").addClass("d-flex justify-content-end mb-4 mt-2");

				    var messageContainer = $("<div>").addClass("msg_cotainer_send")
				        .append(content);
				       
				    var imageContainer = $("<div>").addClass("img_cont_msg")
				        .append($("<img>").attr("src", "images/profile.jpg").css("width", "45px").addClass("rounded-circle user_img_msg"));

				    var timeSpan = $("<div>").addClass("time-right")
				     .append($("<span>").addClass("msg_time_send").text(formattedTime));
				    
				    messageDiv.append(timeSpan).append(messageContainer).append(imageContainer);
				    $(".message-list").append(messageDiv);
			        
				    if (isDM) {
				        messageContainer.css("background-color", "black"); // 배경색 블랙
				        messageContainer.css("color", "white"); // 문자색상 화이트
				    }

				} else {
					
				    // 상대방 메시지 (왼쪽에 표시)
				    var messageDiv = $("<div>").addClass("d-flex mb-4 align-items-start mt-2");

				    var imageContainer = $("<div>").addClass("img_cont_msg")
				        .append($("<img>").attr("src", "images/profile2.jpg").css("width", "45px").addClass("rounded-circle user_img_msg"));

				    var contentDiv = $("<div>").addClass("d-flex flex-column");
				    
				    var nicknameDiv = $("<div>").addClass("msg_nickname")
				        .text(memberNickname); // 닉네임을 표시

				    var messageContainer = $("<div>").addClass("msg_cotainer")
				        .append(content);

				    var timeSpan = $("<div>").addClass("time-left")
				        .append($("<span>").addClass("msg_time").text(formattedTime));

				    contentDiv.append(nicknameDiv).append(messageContainer);
				    messageDiv.append(imageContainer).append(contentDiv).append(timeSpan);
				    $(".message-list").append(messageDiv);
				    
				    if (isDM) {
				        messageContainer.css("background-color", "black"); // 배경색 블랙
				        messageContainer.css("color", "white"); // 문자색상 화이트
				    }
				}
			}
				
			//스크롤바 이동
			$(".message-list").scrollTop($(".message-list")[0].scrollHeight);
	
	};

	
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
		
		function sendMessage() {
		    var text = $(".message-input").val();
		    if (text.length === 0) return;
		
		    if (text.startsWith("@")) {
		        var space = text.indexOf(" ");
		        if (space === -1) return;
		
		        var obj = {
		            target: text.substring(1, space),
		            content: text.substring(space + 1)
		        };
		        var str = JSON.stringify(obj);
		        window.socket.send(str);
		        $(".message-input").val("");
		    } else {
		        var obj = {
		            content: text
		        };
		        var str = JSON.stringify(obj);
		        window.socket.send(str);
		        $(".message-input").val("");
		    }
		}

		
		// 메세지 헤더 생성
		var headerContent = $("<div>").addClass("d-flex bd-highlight justify-content-between");
		var imageContainer = $("<div>").addClass("img_cont");
		var userImage = $("<img>").attr("src", "/images/circle.jpg").css("width", "60px").addClass("rounded-circle user_img");
		var userInfo = $("<div>").addClass("user_info");
		var roomName = $("<span>").addClass("circle-name").text("java 개발자 스터디");

		// 버튼 엘리먼트 생성
		var button = $("<button>").addClass("btn btn-outline-secondary");
		button.attr("type", "button");
		button.attr("data-bs-toggle", "offcanvas");
		button.attr("data-bs-target", "#offcanvasExample");
		button.attr("aria-controls", "offcanvasExample");
		var buttonIcon = $("<i>").addClass("fa-solid fa-users");
		button.append(buttonIcon);

		userInfo.append(roomName);
		imageContainer.append(userImage);
		headerContent.append(imageContainer).append(userInfo).append(button); 
		var headerElement = $("<div>").addClass("card-header msg_head").append(headerContent);

		// .card-header 요소에 메세지 헤더 추가
		$(".card-header").append(headerElement);


		//.btn-userlist를 누르면 사용자 목록에 active를 붙였다 떼었다 하도록 처리
		$(".btn-userlist").click(function(){
			$(".client-list").toggleClass("active");
		});
		
	</script>
</body>

</html>