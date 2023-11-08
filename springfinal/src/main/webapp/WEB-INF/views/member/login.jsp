<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h1>로그인창</h1>
	
	<form action="./login" method="post">
		<input type="text" name="memberId" placeholder="아이다">
		<input type="text" name="memberPw" placeholder="비밀번호">
		<button>로그인</button>
	</form>
</body>
</html>