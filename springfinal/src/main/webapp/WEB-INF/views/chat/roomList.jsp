<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="/WEB-INF/views/template/header.jsp"></jsp:include>
<jsp:include page="/WEB-INF/views/template/leftSidebar.jsp"></jsp:include>

<!DOCTYPE html>
<html>
<head>
    <base>
    <title>Chat Room List</title>
</head>
<body>
    <h5>${sessionScope.name}</h5>
    <h2>Chat Room List</h2>

<hr>
 <h2>동호회 채팅</h2>
    <c:forEach var="roomList" items="${roomList}">
        ${roomList.chatRoomNo} ${roomList.clubName} ${roomList.clubExplain} 
        <a href="/chat/enterRoom/${roomList.chatRoomNo}">
            <button>입장</button>
        </a>
        <br/>
    </c:forEach>
    
<hr>
 <h2>개인 채팅</h2>
 <c:forEach var="oneChatRoom" items="${oneChatRoomList}">
    ${oneChatRoom.chatRoomNo} 

    <c:choose>
        <c:when test="${sessionScope.name eq oneChatRoom.chatSender}">
            ${oneChatRoom.chatReceiver}님과의 채팅방 
        </c:when>
        <c:otherwise>
            ${oneChatRoom.chatSender}님과의 채팅방 
        </c:otherwise>
    </c:choose>

    <a href="/chat/enterRoom/${oneChatRoom.chatRoomNo}">
        <button>입장</button>
    </a>
    <br/>
</c:forEach>


    
</body>
</html>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
