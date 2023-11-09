<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>

<h1>채팅리스트</h1>
	<c:forEach var="chatRoomDto" items="${chatRoomList}">
			${chatRoomDto.chatRoomNo}
			<br>
	</c:forEach>

</body>
</html>