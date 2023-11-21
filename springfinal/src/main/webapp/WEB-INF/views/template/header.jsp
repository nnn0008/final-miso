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
    z-index: 2;
}

.badge-counter {
    position: absolute;
    top: 0;
    left: 50%;
    transform: translateX(-50%);
    display: inline-block;
    opacity: 1;
    z-index: 3;
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

.fa-bell {
    position: absolute;
    top: 0;
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
        url: "/rest/notify/list",
        type: "GET",
        dataType: "json",
        contentType: 'application/json',
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

//알림 메시지 생성 함수
function createNotificationMessage(item) {
    if (item.notifyType === 'reply') {
        // 댓글 알림 메시지
        return (
            '<div class="row">' +
            '<div class="col">' +
            item.notifySender + ' | ' + item.notifyDate +
            '</div>' +
            '</div>' +
            '<div class="row">' +
            '<div class="col-10">' +
            '<a href="/clubBoard/detail?clubBoardNo=' + item.notifyClubBoardNo + '" class="link-body-emphasis link-underline link-underline-opacity-0" style="color: black;">' +
            item.notifySender + '님이 ' + item.notifyClubBoardTitle + ' 글에 댓글을 달았습니다</a>' +
            '</div>' +
            '<div class="col-2">' +
            '<i class="fa-solid fa-xmark delete-button" data-notify-no="' + item.notifyNo + '"></i>' +
            '</div>' +
            '</div>'
        );
    } else if (item.notifyType === 'like') {
        // 좋아요 알림 메시지
        return (
            '<div class="row">' +
            '<div class="col">' +
            item.notifySender + ' | ' + item.notifyDate +
            '</div>' +
            '</div>' +
            '<div class="row">' +
            '<div class="col-10">' +
            '<a href="/clubBoard/detail?clubBoardNo=' + item.notifyClubBoardNo + '" class="link-body-emphasis link-underline link-underline-opacity-0" style="color: black;">' +
            item.notifySender + '님이 ' + item.notifyClubBoardTitle + ' 글을 좋아합니다</a>' +
            '</div>' +
            '<div class="col-2">' +
            '<i class="fa-solid fa-xmark delete-button" data-notify-no="' + item.notifyNo + '"></i>' +
            '</div>' +
            '</div>'
        );
    } else {
        // 그 외의 알림 타입에 대한 처리
        return '<p>알 수 없는 알림 타입입니다</p>';
    }
}

// 삭제 버튼 클릭 이벤트 처리
$(document).on('click', '.delete-button', function () {
    var notifyNo = $(this).data('notify-no');
    var itemIndex = $(this).data('item-index');
    // 해당 알림 아이템을 숨기기
    hideItem(itemIndex);

    // 서버에 삭제 요청 보내기
    $.ajax({
    	type: 'GET',
        url: '/rest/notify/delete',
        contentType: 'application/json',
        data: { notifyNo: notifyNo },
        success: function (response) {

        },
        error: function (error) {
            // 서버에서 삭제가 실패한 경우에는 숨겼던 아이템을 다시 보이게 만들기
            showItem(itemIndex);
        }
    });
});

//페이지 로딩 시 알림 목록 가져와서 표시
$(document).ready(function () {
    getNotifyList(); // 알림 목록 가져오기
});

// 알림 메시지 표시
function populateModal(data) {
    var modalContent = $("#notifyModal .notifyAlert .row");
    modalContent.empty(); // 기존 내용 제거

    // 최신순으로 정렬 후 최대 10개까지만 표시
    var sortedData = data.sort(function (a, b) {
        return new Date(b.notifyDate) - new Date(a.notifyDate);
    }).slice(0, 10);

    // 알림 갯수 표시
    var notificationCount = sortedData.length;
    showNotificationCount(notificationCount); // 알림 개수 업데이트

    var notificationCountMessage = $("<div class='col-12 mb-2 text-center'>" + notificationCount + "개의 알림이 있습니다</div>");
    modalContent.append(notificationCountMessage);

    if (notificationCount === 0) {
        // 데이터가 없으면 '알림이 없습니다' 메시지를 추가
        var noNotificationMessage = $("<div class='col-12 mb-2 text-center'>알림이 없습니다</div>");
        modalContent.append(noNotificationMessage);
    } else {
        // 데이터가 있으면 각 알림 메시지를 추가
        sortedData.forEach(function (item, index) {
            var message = createNotificationMessage(item);
            var listItem = $("<div class='col-12 mb-2'>" + message + "</div>");
            modalContent.append(listItem);
        });
    }
}

// 알림 개수 표시
function showNotificationCount(notificationCount) {
    $(".badge-counter").text(notificationCount);
}


// 알림 아이템 숨기기
function hideItem(index) {
    var item = $('.notify-item').eq(index);
    item.hide();
}

// 알림 아이템 보이기
function showItem(index) {
    var item = $('.notify-item').eq(index);
    item.show();
}

// 삭제 버튼 클릭 시 호출되는 함수
function deleteNotification(notifyNo) {
    // 이 부분에 삭제 처리 로직을 추가
    console.log('Delete notification with notifyNo:', notifyNo);
}


// // 날짜 포맷팅 함수
// function formatDate(dateString) {
//     var options = { year: 'numeric', month: 'short', day: 'numeric', hour: 'numeric', minute: 'numeric' };
//     return new Date(dateString).toLocaleDateString('ko-KR', options);
// }


function getChatRoomList() {
    var memberId = "${sessionScope.name}";

    $.ajax({
        url: "/rest/notify/roomList",
        type: "GET",
        data: {
            memberId: memberId
        },
        dataType: 'json',
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
//     console.error("oneChatRoomList is not an array:", data.oneChatRoomList);
}

}


</script>


</head>
<body>


<main>
 <header>
            <div class="col mt-2">
	
		<a href="#" class="link logo"><img src="${pageContext.request.contextPath}/images/miso_logo.png" width="200px"></a>

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
       
       <div class="col">
  <span class="badge rounded-pill bg-danger badge-counter"></span>
       </div>
       
    </div>
    
    <div class="col-4 ms-1">
 
            <i class="fa-regular fa-comments fa-2xl showNotifyButton" data-modal="chatModal" ></i>

    </div>
		    <div class="col-4 ms-2">
		        <a href="${pageContext.request.contextPath}/member/logout" class="link-body-emphasis link-underline link-underline-opacity-0 showNotifyButton">
		            <i class="fa-solid fa-power-off fa-2xl"></i>
		        </a>
		    </div>

	   <!-- 각 모달창 -->
	<div id="notifyModal" class="notifyLayer">
	    <div class="alert alert-dismissible alert-light notifyAlert">
	        <div class="row d-flex justify-content-center">
	        </div>
	    </div>
	</div>
	
	<div id="chatModal" class="notifyLayer">
	    <div class="alert alert-dismissible alert-light notifyAlert">
	        <div class="row d-flex justify-content-center">
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
