<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>miso</title>


 <!-- 아이콘 사용을 위한 Font Awesome 6 CDN-->
 <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
   

<!-- 부트스트랩 CDN -->
   <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootswatch/5.3.2/zephyr/bootstrap.min.css" rel="stylesheet">

<!-- 스타일시트 로딩 코드 -->
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/reset.css">
    <link href="${pageContext.request.contextPath}/css/misolayout.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/css/miso.css" rel="stylesheet">
<!-- <link rel="stylesheet" type="text/css" href="/css/test.css"> -->


<!-- jquery cdn -->
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<!-- websocket -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>

<style>
.circle {
        width: 100px;
        height: 100px;
        border-radius: 30%;
    }

    .circle-name {
        font-size: 12px;
        text-align: center;
    }

    .circle-time {
        height: 40px;
        border-radius: 15%;
    }

    .card-body{
        background-color:#FCFCFD;
        color: #495057;
    }
    
    .text-inc{
    font-size: 12px;
    }
    
    .iconContainer{
    margin-right: 1em;
    }
    
    .card {
    width: 250px;
    }

.container {
    position: relative;
}

.notifyLayer {
    display: none;
    position: absolute;
    top: 70px;
    left: 145px;
    transform: translateX(-50%);
    z-index: 9999;
    width:300px;
}

.notifyLayer.show {
    display: block;
}

#notifyContainer {
    position: relative;
    z-index: 1;
}

.showNotifyButton {
    position: relative;
    z-index: 2; /* 이 부분을 추가하여 .showNotifyButton을 가장 위에 표시하도록 함 */
}

.club-image2 {
        width: 50px; /* 원하는 크기로 조절하세요 */
        height: 50px; /* 원하는 크기로 조절하세요 */
        border-radius: 50%; /* 50%로 설정하여 동그란 형태로 만듭니다 */
        background-color: #D9D9D9;
    }
    .clubname-text{
    font-size: 15px;
    }
	.explain-text{
	color: A69D9D;
	font-size: 12px;
	}
	.club-box2:hover {
        background-color: #f0f0f0; /* 호버 효과 배경색 설정 */
        cursor: pointer; /* 호버 시 커서 모양 변경 */
    }


</style>

<%-- 
	절대경로를 설정하기 위한 스크립트 작성
	- 절대경로라는 개념은 백엔드에만 있다
	- 자바스크립트에서 절대경로를 알 수 있는 방법이 없다
	- window에 절대경로 값을 탑재시켜 사용
--%>
    
<script>
	window.contextPath = "${pageContext.request.contextPath}";
</script>

<script>

//모달을 열 때 데이터 갱신하는 함수
function updateDataAndOpenModal(modalId, updateFunction) {
    $(".notifyLayer").not("#" + modalId).removeClass("show");
    $("#" + modalId).toggleClass("show");

    updateFunction();
}

$(document).ready(function () {
    $(".showNotifyButton").click(function () {
        var modalId = $(this).data("modal");

        if (modalId === "chatModal") {
            updateDataAndOpenModal(modalId, getChatRoomList);
        } else {
            updateDataAndOpenModal(modalId, getNotifyList);
        }
    });

    // 모달창 클릭 시 데이터 갱신
    $("#notifyModal").click(function () {
        getNotifyList();
    });

    // 모달창 클릭 시 데이터 갱신
    $("#chatModal").click(function () {
        getChatRoomList();
    });

    // 다른 부분 클릭 시 모달창 닫기
$(document).click(function (event) {
    if (!$(event.target).closest('.notifyLayer, .showNotifyButton').length) {
        $(".notifyLayer.show").removeClass("show");
    }
});

    // 알림 아이콘 클릭 시 이벤트 처리
    $("#notificationIcon").click(function(event) {
        // 기본 동작 막기
        event.preventDefault();
    
        // 알림 창 열기 등의 추가 동작 수행
        openNotificationModal();
    });
    
    // 채팅 아이콘 클릭 시 이벤트 처리
    $("#chatIcon").click(function(event) {
        // 기본 동작 막기
        event.preventDefault();
    
        // 채팅 모달 열기 등의 추가 동작 수행
        openChatModal();
    });
});

	
function enterRoom(chatRoomNo) {
    window.location.href = "/chat/enterRoom/" + chatRoomNo;
}

function getNotifyList() {
    var notifyReceiver = "${sessionScope.name}";

    $.ajax({
        url: window.contextPath + "/rest/notify/list",
        method: "GET",
        data: {
            notifyReceiver: notifyReceiver
        },
        success: function (data) {
            populateModal(data);
        },
        error: function (xhr, status, error) {
            console.error('Failed to get notifications:', error);
        }
    });
}

//삭제한 알림의 인덱스를 저장하는 배열
var hiddenNotifications = [];

function populateModal(data) {
    var modalContent = $("#notifyModal .notifyAlert .row");
    modalContent.empty(); // 이전 내용 제거

    // 최신순으로 정렬 후 최대 6개까지만 표시
    var sortedData = data.sort(function (a, b) {
        return new Date(b.notifyDate) - new Date(a.notifyDate);
    }).slice(0, 6);

    // 알림 갯수 표시
    var notificationCount = sortedData.length;
    var notificationBadge = $("<span class='badge bg-danger'>" + notificationCount + "</span>");
    $("#notifyIcon").append(notificationBadge);

    if (notificationCount === 0) {
        // 데이터가 없으면 '알림이 없습니다' 메시지를 추가
        var noNotificationMessage = $("<div class='col-12 mb-2 text-center'>알림이 없습니다</div>");
        modalContent.append(noNotificationMessage);
    } else {
        // 데이터가 있으면 각 알림 메시지를 추가
        sortedData.forEach(function (item, index) {

            var message =
                '<div class="row">' +
                '<div class="col">' +
                item.notifySender + ' | ' + item.notifyDate +
                '</div>' +
                '</div>' +
                '<div class="row">' +
                '<div class="col">' +
                '<a href="/clubBoard/detail?clubBoardNo=' + item.notifyClubBoardNo + '" class="link-body-emphasis link-underline link-underline-opacity-0" style="color: black;">' +
                item.notifySender + '님이 ' + item.notifyClubBoardTitle + ' 글에 댓글을 달았습니다</a>' +
                '</div>' +
                '<div class="col">' +
                '<button class="btn btn-danger btn-sm delete-button" data-index="' + index + '">삭제</button>' +
                '</div>' +
                '</div>';

            var listItem = $("<div class='col-12 mb-2 notify-item' data-index='" + index + "'>" + message + "</div>");
            modalContent.append(listItem);
        });

        // 삭제 버튼 클릭 이벤트
        $(".delete-button").on("click", function () {
        	  console.log("Delete button clicked");
        	  var index = $(this).data("index");
        	    console.log("Deleting item at index:", index);
        	    hiddenNotifications.push(index);
        	    localStorage.setItem("hiddenNotifications", JSON.stringify(hiddenNotifications));
        });
    }
}

	// 페이지 로드 시에 hiddenNotifications 배열을 로컬 스토리지에서 가져와 초기화
	$(document).ready(function () {
	    var storedHiddenNotifications = localStorage.getItem("hiddenNotifications");
	    if (storedHiddenNotifications) {
	        hiddenNotifications = JSON.parse(storedHiddenNotifications);
	
	        // 숨겨진 알림 상태로 설정
	        hiddenNotifications.forEach(function (index) {
	            $(".notify-item[data-index='" + index + "']").hide();
	        });
	    }
	});



function getChatRoomList() {
    // 세션에서 로그인한 사용자의 아이디를 가져옴
    var memberId = "${sessionScope.name}";

    $.ajax({
        url: window.contextPath + "/rest/notify/roomList",
        method: "GET",
        data: {
            memberId: memberId
        },
        dataType: 'json', // JSON 데이터 형식으로 처리
        success: function (data) {
            // 채팅 모달에 데이터 추가
            populateChatModal(data);
            console.log("Successful response:", data);
        },
        error: function (error) {
            console.error('Failed to get chat room list:', error);
        }
    });

}

function populateChatModal(data) {
    var modalContent = $("#chatModal .notifyAlert .row");
    modalContent.empty(); // 기존 내용 제거

    // 채팅 모달 내용을 추가하는 코드 작성
    // 예시: 채팅 모달에는 사용자의 채팅방 리스트를 표시
// roomList 스타일 적용
if (Array.isArray(data.roomList)) {
    	var sectionHeader =
    	    '<div class="row">' +
    	    '<div class="col text-start d-flex align-items-center ms-3 mt-3">' +
    	    '<img src="' + contextPath + '/images/logo-door.png" width="10%">' +
    	    '<strong class="ms-2">모임채팅</strong>' +
    	    '</div>' +
    	    '</div>';

    	var sectionHeaderItem = $("<div class='col-12 mb-2'>" + sectionHeader + "</div>");
    	modalContent.append(sectionHeaderItem);	
    	
    data.roomList.forEach(function (chatRoom) {

        var message =
            '<div class="row mt-3 ms-2 d-flex align-items-center club-box2" onclick="enterRoom(' + chatRoom.chatRoomNo + ')">' +
            '<div class="col-2">' +
            '<img src="' + contextPath + '/images/dog.png" class="club-image2">' +
            '</div>' +
            '<div class="col-10">' +
            '<div class="col ms-3">' +
            '<span class="clubname-text2">' + chatRoom.clubName + '</span>' +
            '</div>' +
            '<div class="col ms-3">' +
            '<span class="explain-text2">' + chatRoom.clubExplain + '</span>' +
            '</div>' +
            '</div>' +
            '</div>';

        var listItem = $("<div class='col-12 mb-2'>" + message + "</div>");
        modalContent.append(listItem);
    });
} else {
    console.error("roomList is not an array:", data.roomList);
}

// oneChatRoomList 스타일 적용
if (Array.isArray(data.oneChatRoomList)) {
	
	var sectionHeader =
	    '<div class="row">' +
	    '<div class="col text-start d-flex align-items-center ms-3 mt-3">' +
	    '<img src="' + contextPath + '/images/logo-door.png" width="10%">' +
	    '<strong class="ms-2">개인채팅</strong>' +
	    '</div>' +
	    '</div>';

	var sectionHeaderItem = $("<div class='col-12 mb-2'>" + sectionHeader + "</div>");
	modalContent.append(sectionHeaderItem);	
	
    data.oneChatRoomList.forEach(function (oneChatRoom) {
        var otherUser = (oneChatRoom.chatSender === "${sessionScope.name}") ? oneChatRoom.chatReceiver : oneChatRoom.chatSender;

        var oneRoomMessage =
            '<div class="row mt-3 ms-2 d-flex align-items-center club-box2" onclick="enterRoom(' + oneChatRoom.chatRoomNo + ')">' +
            '<div class="col-2">' +
            '<img src="' + contextPath + '/images/dog.png" class="club-image2">' +
            '</div>' +
            '<div class="col-10">' +
            '<div class="col ms-3">' +
            '<span class="clubname-text2">' + otherUser + ' 님과의 채팅' + '</span>' +
            '</div>' +
            '</div>' +
            '</div>';

        var oneRoomListItem = $("<div class='col-12 mb-2'>" + oneRoomMessage + "</div>");
        modalContent.append(oneRoomListItem);
    });
} else {
    console.error("oneChatRoomList is not an array:", data.oneChatRoomList);
}

}


</script>


</head>
<body>


<main>
 <header>
            <div class="col mt-2">
	
	
		<a href="#" class="link"><img src="${pageContext.request.contextPath}/images/miso_logo.png" width="200px"></a>

            </div>
            <div class="title">
                <div class="input-group d-flex justify-content-center">  
                    <input type=" search" class="form-control rounded-pill" placeholder="Search" aria-label="Search"  
                 
                    aria-describedby="search-addon" />  
                    <button type="button" class="btn btn-outline-primary rounded-pill"><i class="fa-solid fa-magnifying-glass"></i></button>  
                 
                  
                   </div>  
            </div>
           <div class="etc container">
		    <div class="col-4 ms-4" id="notifyContainer">
        <i class="fa-regular fa-bell fa-2xl notifyContainer showNotifyButton" data-modal="notifyModal"></i>
    </div>
    <div class="col-4">
  
            <i class="fa-regular fa-comments fa-2xl showNotifyButton" data-modal="chatModal" ></i>

    </div>
		    <div class="col-4">
		        <a href="${pageContext.request.contextPath}/member/login" class="link-body-emphasis link-underline link-underline-opacity-0 showNotifyButton">
		            <i class="fa-solid fa-power-off fa-2xl"></i>
		        </a>
		    </div>

	   <!-- 각 모달창 -->
	<div id="notifyModal" class="notifyLayer">
	    <div class="alert alert-dismissible alert-light notifyAlert">
	        <div class="row d-flex justify-content-center">
	            알림이 없습니다
	        </div>
	    </div>
	</div>
	
	<div id="chatModal" class="notifyLayer">
	    <div class="alert alert-dismissible alert-light notifyAlert">
	        <div class="row d-flex justify-content-center">
	            ㅎㅎ (채팅 모달 내용)
	        </div>
	    </div>
	</div>
    
    
</div>

            
            </div>
        </header>
        <nav>
        </nav>
        <section>


            <!-- 헤더 -->
