<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>파일 1개 업로드 하기</title>
</head>
<body>
	<form method="POST" enctype="multipart/form-data" action="cos_upload1.jsp">
  		이름 : <input type="text" name="name"><br/>
  		설명 : <input type="text" name="note"><br/>
  		파일 : <input type="file" name="upfile"><br/>
  		<br/>
  		<input type="submit" value="전송">
	</form>
</body>
</html>