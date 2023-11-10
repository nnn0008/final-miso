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

    <c:forEach var="chatRoom" items="${list}">
        룸번호 ${chatRoom.chatRoomNo}
        <br/>
    </c:forEach>

    <c:forEach var="roomList" items="${roomList}">
        ${roomList.chatRoomNo} ${roomList.clubName} ${roomList.clubExplain} 
        <a href="/chat/enterRoom/${roomList.chatRoomNo}">
            <button>입장</button>
        </a>
        <br/>
    </c:forEach>
</body>
</html>

<jsp:include page="/WEB-INF/views/template/rightSidebar.jsp"></jsp:include>
