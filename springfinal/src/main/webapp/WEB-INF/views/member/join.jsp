<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
<form action="./join" method="post">
	<input type="text" name="memberId" placeholder="아이디">
	<input type="text" name="memberPw" placeholder="비밀번호">
	<input type="text" name="memberName" placeholder="닉네임">
	<select name="memberLevel">
		<option value="일반유저">일반유저</option>
		<option value="프리미엄">프리미엄</option>
		<option value="파워유저">파워유저</option>
		<option value="마스터">마스터</option>
	</select>
	<button>가입</button>
</form>
</body>
</html>